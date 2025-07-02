require("dotenv").config();
const express = require("express");
const mysql = require("mysql2/promise");
const path = require("path");

const authRoutes = require("./routes/auth");
const votacionesRoutes = require("./routes/votaciones");

const app = express();
const PORT = process.env.PORT || 3000;

// Conexión a MySQL
const db = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  port: process.env.DB_PORT || 3306,
});

// Verificar conexión a la base de datos al iniciar
db.getConnection()
  .then(() => console.log("✅ Conectado a la base de datos"))
  .catch((err) => {
    console.error("❌ Error de conexión a la base de datos:", err.message);
    process.exit(1);
  });

// Middleware para leer JSON
app.use(express.json());

// Habilitar CORS básico
app.use((req, res, next) => {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Methods", "GET, POST");
  res.header("Access-Control-Allow-Headers", "Content-Type, Authorization");
  next();
});

// Servir archivos estáticos
app.use(express.static(path.join(__dirname, "public")));

// Ruta principal
app.get("/", (req, res) => {
  res.sendFile(path.join(__dirname, "public", "index.html")); // asegúrate de tener public/index.html
});

// Rutas API
app.use("/api/auth", authRoutes(db));
app.use("/api/votaciones", votacionesRoutes(db));

// Iniciar servidor
app.listen(PORT, () => {
  console.log(`✅ Servidor corriendo en el puerto: ${PORT}`);
});
