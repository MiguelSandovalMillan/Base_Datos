CREATE TABLE departamento (
    codigo INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre VARCHAR(100) NOT NULL,
    presupuesto DOUBLE NOT NULL CHECK (presupuesto >= 0),
    gastos DOUBLE NOT NULL CHECK (gastos >= 0)
);


CREATE TABLE empleado (
    codigo INTEGER PRIMARY KEY AUTOINCREMENT,
    nif VARCHAR(9) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    apellido1 VARCHAR(100) NOT NULL,
    apellido2 VARCHAR(100),
    codigo_departamento INTEGER CHECK (codigo_departamento >= 0),
    FOREIGN KEY (codigo_departamento) REFERENCES departamento(codigo)
);


INSERT INTO departamento (nombre, presupuesto, gastos) VALUES
('Desarrollo', 120000, 6000),
('Sistemas', 150000, 21000),
('Recursos Humanos', 280000, 25000),
('Contabilidad', 110000, 3000),
('I+D', 375000, 380000),
('Proyectos', 0, 0),
('Publicidad', 0, 1000);


INSERT INTO empleado (nif, nombre, apellido1, apellido2, codigo_departamento) VALUES
('32481596F', 'Aarón', 'Rivero', 'Gómez', 1),
('Y5575632D', 'Adela', 'Salas', 'Díaz', 2),
('R6970642B', 'Adolfo', 'Rubio', 'Flores', 3),
('77705545E', 'Adrián', 'Suárez', NULL, 4),
('17087203C', 'Marcos', 'Loyola', 'Méndez', 5),
('38382980M', 'María', 'Santana', 'Moreno', 1),
('80576669X', 'Pilar', 'Ruiz', NULL, 2),
('71651431Z', 'Pepe', 'Ruiz', 'Santana', 3),
('56399183D', 'Juan', 'Gómez', 'López', 2),
('46384486H', 'Diego','Flores', 'Salas', 5),
('67389283A', 'Marta','Herrera', 'Gil', 1),
('41234836R', 'Irene','Salas', 'Flores', NULL),
('82635162B', 'Juan Antonio','Sáez', 'Guerrero', NULL);


SELECT * FROM departamento;
SELECT * FROM empleado;