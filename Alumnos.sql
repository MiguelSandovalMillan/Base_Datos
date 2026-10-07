DROP TABLE IF EXISTS alumno;


CREATE TABLE alumno (
id INTEGER PRIMARY KEY AUTOINCREMENT,
nombre VARCHAR(100) NOT NULL,
apellido1 VARCHAR(100) NOT NULL,
apellido2 VARCHAR(100),
fecha_nacimiento DATE NOT NULL,
es_repetidor TEXT CHECK(es_repetidor IN ('sí', 'no')) NOT NULL,
telefono VARCHAR(9)
);



INSERT INTO alumno (nombre, apellido1, apellido2, fecha_nacimiento, es_repetidor, telefono) VALUES
('María', 'Sánchez', 'Pérez', '1990-12-01', 'no', NULL),
('Juan', 'Sáez', 'Vega', '1998-04-02', 'no', 618253876),
('Pepe', 'Ramírez', 'Gea', '1988-01-03', 'no', NULL),
('Lucía', 'Sánchez', 'Ortega', '1993-06-13', 'sí', 678516294),
('Paco', 'Martínez', 'López', '1995-11-24', 'no', 692735409),
('Irene', 'Gutiérrez', 'Sánchez', '1991-03-28', 'sí', NULL),
('Cristina', 'Fernández', 'Ramírez', '1996-09-17', 'no', 628349590),
('Antonio', 'Carretero', 'Ortega', '1994-05-20', 'sí', 612345633),
('Manuel', 'Domínguez', 'Hernández', '1999-07-08', 'no', NULL),
('Daniel', 'Moreno', 'Ruiz', '1998-02-03', 'no', NULL);



SELECT * FROM alumno

