require("dotenv").config();
const express = require("express");
const mysql = require("mysql2/promise");
const path = require("path");

const authRoutes = require("./routes/auth");
const votacionesRoutes = require("./routes/votaciones");

const app = express();
const PORT = 3000;

// Conexión a MySQL
const db = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
});

// Middleware para leer JSON
app.use(express.json());

// CORS (puedes mejorar seguridad después)
app.use((req, res, next) => {
  res.header('Access-Control-Allow-Origin', '*');
  res.header('Access-Control-Allow-Methods', 'GET, POST');
  res.header('Access-Control-Allow-Headers', 'Content-Type, Authorization');
  next();
});

// Servir archivos estáticos desde /public
app.use(express.static(path.join(__dirname, "public")));

// Rutas API
app.use("/api/auth", authRoutes(db));
app.use("/api/votaciones", votacionesRoutes(db));

// Iniciar servidor
app.listen(PORT, () => {
  console.log(`✅ Servidor corriendo en http://localhost:${PORT}`);
});


