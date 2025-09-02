-- Banco: gkevents
CREATE DATABASE IF NOT EXISTS gkevents CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE gkevents;

-- Usuários
CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(80) NOT NULL,
  email VARCHAR(120) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  role ENUM('admin','user') NOT NULL DEFAULT 'user',
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Eventos
CREATE TABLE IF NOT EXISTS events (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(120) NOT NULL,
  date DATE NOT NULL,
  location VARCHAR(120) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY idx_events_date (date)
) ENGINE=InnoDB;

-- Presenças / Inscrições
CREATE TABLE IF NOT EXISTS attendances (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  event_id INT NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY uq_user_event (user_id, event_id),
  CONSTRAINT fk_att_user  FOREIGN KEY (user_id)  REFERENCES users(id)  ON DELETE CASCADE,
  CONSTRAINT fk_att_event FOREIGN KEY (event_id) REFERENCES events(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Sessões (express-mysql-session)
CREATE TABLE IF NOT EXISTS sessions (
  session_id varchar(128) NOT NULL PRIMARY KEY,
  expires int unsigned NOT NULL,
  data mediumtext
) ENGINE=InnoDB;

-- (Opcional) seeds mínimos:
-- INSERT INTO users (name,email,password_hash,role)
-- VALUES ('Admin','admin@gkevents.com', LOWER(SHA2('admin123',256)),'admin');
