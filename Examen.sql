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


INSERT INTO Estudiantes (nombre, apellido, grado) VALUES
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
SELECT * FROM Estudiantes
WHERE nombre_curso = 'Matematicas'

-- 2. Lista los cursos impartidos por un profesor específico.


-- 3. Cuenta el número total de estudiantes en cada curso.


=======
=======
========

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
    precio_unitario REAL NOT NULL,
);

DROP TABLE IF EXISTS Libros; 
DROP TABLE IF EXISTS Proveedores; 
DROP TABLE IF EXISTS Compras; 

INSERT INTO Libros(titulo, autor,año_publicacion,categoria) VALUES
('Viaje al mundo en 80 dias', 'Julio Verne','2001','Ciencia Ficcion'),
('Coraline', 'Tim Burton','2006','Terror'),
('El Increible mundo', 'Tim Burton','2009','Terror'),
('20 mil leguas', 'Julio Verne','2000','Aventura'),
('1984', 'Miguel Cervantes','2002','Aventura');

INSERT INTO Proveedores(nombre_proveedor, telefono, email) VALUES
('Saul','932 234 2354', 'saul34@gmail.com'),
('Nacho','954 234 2434','nacho13@gmail.com'),
('Maria','087 237 7262','maria45@gmail.com'),
('Dom','343 232 234','dom56@gmail.com'),
('Andrea','921 123 2335','andre31@gmail.com');

INSERT INTO Compras (fecha_compra, cantidad, precio_unitario) VALUES
('2026-01-21', 1, 190),
('2025-09-11', 2, 204),
('2026-05-01', 1, 234),
('2025-07-21', 3, 199),
('2026-09-21', 2, 342);

SELECT * FROM Libros;
SELECT * FROM Proveedores;
SELECT * FROM Compras;