CREATE DATABASE IF NOT EXISTS taskflow_db;
USE taskflow_db;

CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin', 'employee') DEFAULT 'employee',
    full_name VARCHAR(100) NOT NULL,
    avatar_color VARCHAR(7) DEFAULT '#667eea',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS tasks (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    created_by INT NOT NULL,
    status ENUM('pending', 'in_progress', 'completed') DEFAULT 'pending',
    priority ENUM('low', 'medium', 'high', 'urgent') DEFAULT 'medium',
    category VARCHAR(50),
    due_date DATE,
    progress INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS task_assignments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    task_id INT NOT NULL,
    user_id INT NOT NULL,
    assigned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    UNIQUE KEY unique_assignment (task_id, user_id)
);

INSERT INTO users (username, email, password, role, full_name, avatar_color) VALUES
('admin', 'admin@taskflow.com', 'admin123', 'admin', 'Administrateur Principal', '#667eea'),
('john', 'john@taskflow.com', 'john123', 'employee', 'John Doe', '#f5576c'),
('jane', 'jane@taskflow.com', 'jane123', 'employee', 'Jane Smith', '#4facfe');

INSERT INTO tasks (title, description, created_by, status, priority, category, due_date, progress) VALUES
('Rapport trimestriel Q4', 'Préparer le rapport financier détaillé du quatrième trimestre', 1, 'pending', 'high', 'Finance', '2024-02-15', 25),
('Refonte du site web', 'Mettre à jour le design et améliorer l''UX', 1, 'in_progress', 'medium', 'Développement', '2024-02-20', 60),
('Présentation client', 'Préparer la présentation du nouveau produit', 1, 'pending', 'urgent', 'Marketing', '2024-02-12', 10),
('Migration de données', 'Migrer les données vers le nouveau serveur', 1, 'completed', 'medium', 'Technique', '2024-02-05', 100),
('Formation équipe', 'Organiser la formation sur le nouveau logiciel', 1, 'in_progress', 'low', 'Ressources Humaines', '2024-02-25', 40);

INSERT INTO task_assignments (task_id, user_id) VALUES
(1, 2),
(2, 3),
(3, 2),
(3, 3),
(4, 2),
(5, 3);