-- Tabla de usuarios
CREATE TABLE IF NOT EXISTS usuarios (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL
);

-- Tabla de votaciones
CREATE TABLE IF NOT EXISTS votaciones (
  id INT AUTO_INCREMENT PRIMARY KEY,
  titulo VARCHAR(255) NOT NULL,
  id_creador INT NOT NULL,
  fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_creador) REFERENCES usuarios(id)
);

-- Opciones por votación
CREATE TABLE IF NOT EXISTS opciones (
  id INT AUTO_INCREMENT PRIMARY KEY,
  id_votacion INT NOT NULL,
  texto_opcion VARCHAR(255) NOT NULL,
  votos INT DEFAULT 0,
  FOREIGN KEY (id_votacion) REFERENCES votaciones(id)
);

-- Registro de votos por usuario
CREATE TABLE IF NOT EXISTS votos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  id_usuario INT NOT NULL,
  id_opcion INT NOT NULL,
  fecha_voto TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_usuario) REFERENCES usuarios(id),
  FOREIGN KEY (id_opcion) REFERENCES opciones(id),
  UNIQUE KEY (id_usuario, id_opcion)
);
