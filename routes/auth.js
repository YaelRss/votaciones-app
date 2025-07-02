const express = require("express");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const verificarToken = require("../middleware/auth");

module.exports = (db) => {
  const router = express.Router();

  // Ruta: Registro
  router.post("/register", async (req, res) => {
    const { nombre, email, password } = req.body;

    if (!nombre || !email || !password) {
      return res.status(400).json({ error: "Faltan datos" });
    }

    try {
      const [existe] = await db.query("SELECT * FROM usuarios WHERE email = ?", [email]);
      if (existe.length > 0) {
        return res.status(400).json({ error: "Este email ya está registrado" });
      }

      const hashedPassword = await bcrypt.hash(password, 10);
      await db.query(
        "INSERT INTO usuarios (nombre, email, password) VALUES (?, ?, ?)",
        [nombre, email, hashedPassword]
      );

      res.json({ mensaje: "Usuario registrado con éxito" });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  });

  // Ruta: Login
  router.post("/login", async (req, res) => {
    const { email, password } = req.body;

    if (!email || !password) {
      return res.status(400).json({ error: "Faltan datos" });
    }

    try {
      const [usuarios] = await db.query("SELECT * FROM usuarios WHERE email = ?", [email]);
      if (usuarios.length === 0) {
        return res.status(401).json({ error: "Usuario no encontrado" });
      }

      const usuario = usuarios[0];

      const passwordValida = await bcrypt.compare(password, usuario.password);
      if (!passwordValida) {
        return res.status(401).json({ error: "Contraseña incorrecta" });
      }

      // Generar token JWT
      const token = jwt.sign(
        { id: usuario.id, nombre: usuario.nombre, email: usuario.email },
        process.env.JWT_SECRET,
        { expiresIn: '1h' } // ✅ agregar esto
      );
        // Devolver el token al cliente
        res.json({ mensaje: "Login exitoso", token, usuario });
      
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  });

  // Ruta protegida (requiere token)
  router.get("/protegida", verificarToken, (req, res) => {
    res.json({
      mensaje: `Hola ${req.usuario.nombre}, esta es una ruta protegida.`,
      usuario: req.usuario,
    });
  });

  return router;
};
