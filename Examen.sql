-- ========================================
-- ============= EJERCICIO 1 ==============
-- ========================================

-- * ARVHIVO ANEXADO EXAMEN.io* --



-- ========================================
-- ============= EJERCICIO 2 ==============
-- ========================================

CREATE TABLE Profesores (
    id_profesor INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL,
    especialidad TEXT NOT NULL
);

CREATE TABLE Estudiantes (
    id_estudiante INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL,
    apellido TEXT NOT NULL,
    grado INTEGER NOT NULL
);

CREATE TABLE Cursos (
    id_curso INTEGER PRIMARY KEY,
    nombre_curso TEXT NOT NULL,
    id_profesor INTEGER REFERENCES Profesores(id_profesor)
);


CREATE TABLE Inscripciones (
    id_inscripcion INTEGER PRIMARY KEY,
    fecha_inscripcion DATE NOT NULL,
    id_estudiante INTEGER NOT NULL REFERENCES Estudiantes(id_estudiante),
    id_curso INTEGER NOT NULL REFERENCES Cursos(id_curso)
);

DROP TABLE IF EXISTS Profesores;
DROP TABLE IF EXISTS Estudiantes;
DROP TABLE IF EXISTS Cursos;
DROP TABLE IF EXISTS Inscripciones;


INSERT INTO Profesores(id_profesor, nombre, especialidad) VALUES
(1,'Juan', 'Matematematicas'),
(2,'Adair', 'Filosofia'),
(3,'Angel', 'Derecho'),
(4,'Miguel', 'Programacion'),
(5,'Javier', 'Ciencias Sociales');



INSERT INTO Estudiantes (id_estudiante, nombre, apellido, grado) VALUES
(101,'Javier','Sanchez',3),
(102,'Valeria','Delgado',4),
(103,'Yoshua','Anaya',1),
(104,'Mary','Gomez',2),
(105,'Amay','Arreola',2);


INSERT INTO Cursos(id_curso ,nombre_curso, id_profesor) VALUES
(1001,'Matematematicas',1),
(1002,'Filosofia', 2),
(1003,'Programacion',4),
(1004,'Ciencias Sociales',5),
(1005,'Derecho',3);


INSERT INTO Inscripciones (id_inscripcion ,fecha_inscripcion, id_estudiante, id_curso) VALUES
(10001,'2024-07-11',101,1001),
(10002,'2023-07-13',102,1002),
(10003,'2026-07-10',103,1003),
(10004,'2025-07-12',104,1004),
(10005,'2025-07-15',105,1005);


SELECT * FROM Profesores;

SELECT * FROM Estudiantes;

SELECT * FROM Cursos;

-- 1. Muestra todos los estudiantes inscritos en un curso específico (por nombre de curso).
SELECT Estudiantes.nombre, Estudiantes.apellido, Cursos.nombre_curso as curso_inscrito
FROM Estudiantes
INNER JOIN Inscripciones ON Estudiantes.id_estudiante = Inscripciones.id_estudiante
INNER JOIN Cursos ON Inscripciones.id_curso = Cursos.id_curso
WHERE Cursos.nombre_curso = 'Matematematicas';

-- 2. Lista los cursos impartidos por un profesor específico.
SELECT Cursos.nombre_curso, Profesores.nombre AS nombre_profesor
FROM Cursos
INNER JOIN Profesores ON Cursos.id_profesor = Profesores.id_profesor
WHERE Profesores.nombre = 'Juan';

-- 3. Cuenta el número total de estudiantes en cada curso.
SELECT Cursos.nombre_curso, COUNT(Estudiantes.id_estudiante) AS total_estudiantes
FROM Cursos
LEFT JOIN Inscripciones ON Cursos.id_curso = Inscripciones.id_curso
LEFT JOIN Estudiantes ON Inscripciones.id_estudiante = Estudiantes.id_estudiante
GROUP BY Cursos.nombre_curso;



-- ========================================
-- ============= EJERCICIO 3 ==============
-- ========================================

CREATE TABLE Libros (
    id_libro INTEGER PRIMARY KEY,
    titulo TEXT NOT NULL,
    autor TEXT NOT NULL,
    año_publicacion INTEGER NOT NULL,
    categoria TEXT NOT NULL
);

CREATE TABLE Proveedores (
    id_proveedor INTEGER PRIMARY KEY,
    nombre_proveedor TEXT NOT NULL,
    telefono TEXT NOT NULL,
    email TEXT NOT NULL
);

CREATE TABLE Compras (
    id_compra INTEGER PRIMARY KEY,
    id_libro INTEGER NOT NULL REFERENCES Libros(id_libro),
    id_proveedor INTEGER NOT NULL REFERENCES Proveedores(id_proveedor),
    fecha_compra DATE NOT NULL,
    cantidad INTEGER NOT NULL,
    precio_unitario REAL NOT NULL
);

DROP TABLE IF EXISTS Libros; 
DROP TABLE IF EXISTS Proveedores; 
DROP TABLE IF EXISTS Compras; 



INSERT INTO Libros(id_libro, titulo, autor,año_publicacion,categoria) VALUES
(1,'Viaje al mundo en 80 dias', 'Julio Verne','2001','Ciencia Ficcion'),
(2,'Coraline', 'Tim Burton','2006','Terror'),
(3,'El Increible mundo', 'Tim Burton','2009','Terror'),
(4,'20 mil leguas', 'Julio Verne','2000','Aventura'),
(5,'1984', 'Miguel Cervantes','2002','Aventura');

INSERT INTO Proveedores(id_proveedor, nombre_proveedor, telefono, email) VALUES
(1,'Saul','932 234 2354', 'saul34@gmail.com'),
(2,'Nacho','954 234 2434','nacho13@gmail.com'),
(3,'Maria','087 237 7262','maria45@gmail.com'),
(4,'Dom','343 232 234','dom56@gmail.com'),
(5,'Andrea','921 123 2335','andre31@gmail.com');

INSERT INTO Compras (id_compra, id_libro, id_proveedor, fecha_compra, cantidad, precio_unitario) VALUES
(101, 1, 1, '2026-01-21', 1, 190),
(102, 2, 2, '2025-09-11', 1, 204),
(103, 3, 3, '2026-05-01', 1, 234),
(104, 4, 4, '2025-07-21', 1, 199),
(105, 5, 5, '2026-09-21', 1, 342);

SELECT * FROM Libros;
SELECT * FROM Proveedores;
SELECT * FROM Compras;


-- Escribe una consulta para obtener el total de libros comprados a un proveedor específico.
SELECT Proveedores.nombre_proveedor, SUM(Compras.cantidad) AS total_libros
FROM Compras
INNER JOIN Proveedores ON Compras.id_proveedor = Proveedores.id_proveedor
WHERE Proveedores.nombre_proveedor = 'Saul'
GROUP BY Proveedores.nombre_proveedor;


-- Escribe una consulta para mostrar los libros que pertenecen a una categoría específica y el número de
-- compras realizadas de cada uno.
SELECT Libros.titulo, Libros.categoria, COUNT(Compras.id_compra) AS total_compras
FROM Libros
INNER JOIN Compras ON Libros.id_libro = Compras.id_libro
WHERE Libros.categoria = 'Ciencia Ficcion'
GROUP BY Libros.titulo, Libros.categoria;



-- Escribe una consulta para calcular el total gastado en compras de un libro específico 
-- (multiplicando la cantidad por el precio_unitario).
SELECT Libros.titulo, Compras.cantidad, Compras.precio_unitario, SUM(Compras.cantidad * Compras.precio_unitario) AS total_gastado
FROM Compras
INNER JOIN Libros ON Compras.id_libro = Libros.id_libro
WHERE Libros.titulo = '1984'
GROUP BY Libros.titulo;