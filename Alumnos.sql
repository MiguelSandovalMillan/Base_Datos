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

-- ===========================================================================
-- ==============================ACTIVIDADES==================================
-- ===========================================================================


-- 1. Obtener el nombre de todos los alumnos que su primer apellido sea Martínez.
SELECT nombre, apellido1, apellido2 FROM alumno
WHERE apellido1 = 'Martínez';

-- 2. Obtener todos los datos del alumno que tiene un id igual a 9.
SELECT * FROM alumno
WHERE id = 9;

-- 3. Obtener el nombre y la fecha de nacimiento de todos los alumnos nacieron después del 1 de enero de 1997.
SELECT nombre, apellido1, apellido2, fecha_nacimiento
FROM alumno
WHERE fecha_nacimiento > '1997-01-01';

-- 4. Devuelva un listado de todos los alumnos que su primer apellido empiece por la letra S.
SELECT nombre, apellido1, apellido2 FROM alumno
WHERE apellido1 LIKE 'S%';

-- 5. Obtener la lista de alumnos que tienen un valor NULL en la columna teléfono.
SELECT nombre, apellido1, apellido2, telefono FROM alumno
WHERE telefono IS NULL;

-- 6. Obtener todos los datos de los alumnos que tengan como primer apellido Sánchez, Martínez o Domínguez.
SELECT * FROM alumno
WHERE apellido1 IN ('Sánchez', 'Martínez', 'Domínguez');


-- ===========================================================================
-- ================================CONSULTAS==================================
-- ===========================================================================

-- 1. Devuelve los datos del alumno cuyo id es igual a 1
SELECT * FROM alumno
WHERE id = 1;

-- 2. Devuelve los datos del alumno cuyo teléfono es igual a 692735409.
SELECT * FROM alumno
WHERE telefono = 692735409;

-- 3. Devuelve un listado de todos los alumnos que son repetidores.
SELECT nombre, apellido1, apellido2, es_repetidor FROM alumno
WHERE es_repetidor = 'sí';

-- 4. Devuelve un listado de todos los alumnos que no son repetidores.
SELECT nombre, apellido1, apellido2, es_repetidor FROM alumno
WHERE es_repetidor = 'no';

-- 5. Devuelve el listado de los alumnos que han nacido antes del 1 de enero de 1993.
SELECT nombre, apellido1, apellido2, fecha_nacimiento
FROM alumno
WHERE fecha_nacimiento < '1993-01-01';

-- 6. Devuelve el listado de los alumnos que han nacido después del 1 de enero de 1994.
SELECT nombre, apellido1, apellido2, fecha_nacimiento
FROM alumno
WHERE fecha_nacimiento > '1994-01-01';

-- 7. Devuelve el listado de los alumnos que han nacido después del 1 de enero de 1994 y no son repetidores.
SELECT nombre, apellido1, apellido2, fecha_nacimiento, es_repetidor
FROM alumno
WHERE fecha_nacimiento > '1994-01-01' AND es_repetidor = 'no';

-- 8. Devuelve el listado de todos los alumnos que nacieron en 1998.
SELECT nombre, apellido1, apellido2, fecha_nacimiento
FROM alumno
WHERE fecha_nacimiento BETWEEN  '1998-01-01' AND '1998-12-31';

-- 9. Devuelve el listado de todos los alumnos que no nacieron en 1998.
SELECT nombre, apellido1, apellido2, fecha_nacimiento
FROM alumno
WHERE fecha_nacimiento NOT BETWEEN  '1998-01-01' AND '1998-12-31';