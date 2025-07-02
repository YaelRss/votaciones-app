const express = require("express");
const verificarToken = require("../middleware/auth");
const router = express.Router();

module.exports = (db) => {
  // Crear nueva votación
  router.post("/crear", verificarToken, async (req, res) => {
    const { titulo, opciones } = req.body;

    if (!titulo || !Array.isArray(opciones) || opciones.length < 2) {
      return res.status(400).json({ error: "Se requiere un título y al menos 2 opciones" });
    }

    try {
      const [votacionResult] = await db.query(
        "INSERT INTO votaciones (titulo, id_creador, ronda_inicio) VALUES (?, ?, NOW())",
        [titulo, req.usuario.id]
      );

      const opcionesValues = opciones.map(op => [votacionResult.insertId, op]);
      await db.query(
        "INSERT INTO opciones (id_votacion, texto) VALUES ?",
        [opcionesValues]
      );

      res.json({
        success: true,
        id_votacion: votacionResult.insertId,
        mensaje: "Votación creada exitosamente"
      });
    } catch (error) {
      console.error("Error al crear votación:", error);
      res.status(500).json({ error: "Error del servidor" });
    }
  });

  // Obtener lista de votaciones
  router.get("/", async (req, res) => {
    try {
      const [votaciones] = await db.query(`
        SELECT v.*, COUNT(o.id) as total_opciones
        FROM votaciones v
        LEFT JOIN opciones o ON v.id = o.id_votacion
        GROUP BY v.id
      `);
      res.json(votaciones);
    } catch (error) {
      res.status(500).json({ error: "Error al obtener votaciones" });
    }
  });

  // Obtener votaciones activas
  router.get("/activas", async (req, res) => {
    try {
      const [votaciones] = await db.query(`
        SELECT 
          v.id,
          v.titulo,
          DATE_FORMAT(v.fecha_creacion, '%Y-%m-%d %H:%i:%s') as fecha_creacion,
          v.ronda_inicio,
          COUNT(o.id) as total_opciones,
          SUM(o.votos) as total_votos
        FROM votaciones v
        LEFT JOIN opciones o ON v.id = o.id_votacion
        GROUP BY v.id
        ORDER BY v.fecha_creacion DESC
        LIMIT 10
      `);
      res.json(votaciones);
    } catch (error) {
      console.error("🔴 Error en /activas:", error);
      res.status(500).json({ error: "Error del servidor", detalle: error.message });
    }
  });

  // Obtener detalles de una votación específica
  router.get("/:id", async (req, res) => {
    try {
      const [votacion] = await db.query(
        "SELECT * FROM votaciones WHERE id = ?",
        [req.params.id]
      );

      if (votacion.length === 0) {
        return res.status(404).json({ error: "Votación no encontrada" });
      }

      const [opciones] = await db.query(
        "SELECT id, texto, votos, ronda FROM opciones WHERE id_votacion = ?",
        [req.params.id]
      );

      res.json({
        ...votacion[0],
        opciones
      });
    } catch (error) {
      res.status(500).json({ error: "Error al obtener la votación" });
    }
  });

  // Registrar voto
  router.post("/votar", async (req, res) => {
    const { id_usuario, id_opcion } = req.body;

    if (!id_usuario || !id_opcion) {
      return res.status(400).json({ error: "Se requiere id_usuario e id_opcion" });
    }

    try {
      const [votoExistente] = await db.query(`
        SELECT 1 FROM votos 
        WHERE id_usuario = ? 
        AND id_opcion IN (
          SELECT id FROM opciones 
          WHERE id_votacion = (
            SELECT id_votacion FROM opciones WHERE id = ?
          )
        )
      `, [id_usuario, id_opcion]);

      if (votoExistente.length > 0) {
        return res.status(400).json({ error: "Ya has votado en esta encuesta" });
      }

      await db.query("START TRANSACTION");

      await db.query(
        "INSERT INTO votos (id_usuario, id_opcion) VALUES (?, ?)",
        [id_usuario, id_opcion]
      );

      await db.query(
        "UPDATE opciones SET votos = votos + 1 WHERE id = ?",
        [id_opcion]
      );

      await db.query("COMMIT");
      res.json({ success: true, mensaje: "Voto registrado exitosamente" });
    } catch (error) {
      await db.query("ROLLBACK");
      console.error("Error al votar:", error);
      res.status(500).json({ error: "Error al procesar el voto" });
    }
  });

  // Avanzar de ronda
  router.post("/eliminar-menores/:id_votacion", async (req, res) => {
    const { id_votacion } = req.params;

    try {
      const [[{ ronda_actual }]] = await db.query(`
        SELECT MAX(ronda) AS ronda_actual 
        FROM opciones 
        WHERE id_votacion = ?
      `, [id_votacion]);

      const [opciones] = await db.query(`
        SELECT id, texto, votos 
        FROM opciones 
        WHERE id_votacion = ? AND ronda = ?
      `, [id_votacion, ronda_actual]);

      if (opciones.length === 0) {
        return res.status(400).json({ error: "No hay opciones para evaluar" });
      }

      const opcionesValidas = opciones.filter(op => op.texto.toLowerCase() !== "abstención");
      const totalVotosValidos = opcionesValidas.reduce((sum, op) => sum + op.votos, 0);

      let mensaje = "";
      let eliminadas = [];
      let conservadas = [];

      if (ronda_actual === 1) {
        const umbral = totalVotosValidos * (2 / 3);
        eliminadas = opcionesValidas.filter(op => op.votos < umbral);
        conservadas = opcionesValidas.filter(op => op.votos >= umbral);
        mensaje = "Ronda 1: Se eliminaron las opciones con menos del 66.6% de votos válidos";
      } else if (ronda_actual === 2) {
        const umbral = Math.floor(totalVotosValidos / 2) + 1;
        eliminadas = opcionesValidas.filter(op => op.votos < umbral);
        conservadas = opcionesValidas.filter(op => op.votos >= umbral);
        mensaje = "Ronda 2: Se eliminaron las opciones que no alcanzaron mayoría absoluta (50% + 1)";
      } else {
        const maxVotos = Math.max(...opcionesValidas.map(op => op.votos));
        conservadas = opcionesValidas.filter(op => op.votos === maxVotos);
        eliminadas = opcionesValidas.filter(op => op.votos !== maxVotos);
        mensaje = `Ronda 3: 🏆 Ganó "${conservadas[0]?.texto}" con ${maxVotos} votos.`;
      }

      const idsAEliminar = eliminadas.map(op => op.id);
      if (idsAEliminar.length > 0) {
        await db.query(`DELETE FROM opciones WHERE id IN (?)`, [idsAEliminar]);
      }

      if (ronda_actual < 3 && conservadas.length > 0) {
        const ronda_siguiente = ronda_actual + 1;
        const nuevasOpciones = conservadas.map(op => [id_votacion, op.texto, 0, ronda_siguiente]);

        await db.query(`
          INSERT INTO opciones (id_votacion, texto, votos, ronda)
          VALUES ?
        `, [nuevasOpciones]);

        await db.query(`
          UPDATE votaciones SET ronda_inicio = NOW() WHERE id = ?
        `, [id_votacion]);
      }

      res.json({
        mensaje,
        ronda_actual,
        eliminadas: eliminadas.map(op => op.texto),
        conservadas: conservadas.map(op => op.texto)
      });

    } catch (error) {
      console.error("🔴 Error en avance de ronda:", error);
      res.status(500).json({ error: "Error al avanzar de ronda", detalle: error.message });
    }
  });

  // Simular votos de forma segura con IDs auto_increment
router.post("/simular-votos/:id_votacion", async (req, res) => {
    const { id_votacion } = req.params;
    const { cantidad } = req.body;
  
    if (!cantidad || cantidad <= 0) {
      return res.status(400).json({ error: "Cantidad no válida" });
    }
  
    try {
      const [[{ ronda_actual }]] = await db.query(`
        SELECT MAX(ronda) AS ronda_actual 
        FROM opciones 
        WHERE id_votacion = ?
      `, [id_votacion]);
  
      const [opciones] = await db.query(`
        SELECT id FROM opciones 
        WHERE id_votacion = ? AND ronda = ?
      `, [id_votacion, ronda_actual]);
  
      if (opciones.length === 0) {
        return res.status(400).json({ error: "No hay opciones disponibles para votar" });
      }
  
      await db.query("START TRANSACTION");
  
      for (let i = 0; i < cantidad; i++) {
        const opcion = opciones[Math.floor(Math.random() * opciones.length)];
        const nombreSimulado = `Simulado_${Date.now()}_${i}`;
  
        // 1. Insertar usuario sin ID explícito
        const [usuarioResult] = await db.query(
          `INSERT INTO usuarios (nombre, email, password) VALUES (?, ?, ?)`,
          [nombreSimulado, `${nombreSimulado}@fake.com`, 'simulado']
        );
  
        const id_usuario_fake = usuarioResult.insertId;
  
        // 2. Insertar voto
        await db.query(`INSERT INTO votos (id_usuario, id_opcion) VALUES (?, ?)`, [
          id_usuario_fake,
          opcion.id
        ]);
  
        // 3. Sumar el voto
        await db.query(`UPDATE opciones SET votos = votos + 1 WHERE id = ?`, [opcion.id]);
      }
  
      await db.query("COMMIT");
  
      res.json({
        success: true,
        mensaje: `🧪 ${cantidad} votos simulados correctamente`,
        ronda: ronda_actual
      });
  
    } catch (error) {
      await db.query("ROLLBACK");
      console.error("🔴 Error en simulación de votos:", error);
      res.status(500).json({ error: "Error al simular votos", detalle: error.message });
    }
  });
  
  return router;
};
