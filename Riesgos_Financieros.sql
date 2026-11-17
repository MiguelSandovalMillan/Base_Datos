-- ===============================================================
--         CREAR TABLAS PARA SISTEMA DE RIESGOS FINANCIEROS
-- ===============================================================

PRAGMA foreign_keys = ON;

CREATE TABLE Clientes (
    id_cliente INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL,
    rfc TEXT NOT NULL UNIQUE,
    limite_credito REAL NOT NULL CHECK (limite_credito >= 0),
);

CREATE TABLE Portafolios (
    id_portafolio INTEGER PRIMARY KEY,
    id_cliente INTEGER NOT NULL,
    nombre TEXT NOT NULL,
    capital_invertido REAL NOT NULL CHECK (capital_invertido >= 0),
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

CREATE TABLE Activos (
    id_activo INTEGER PRIMARY KEY,
    id_portafolio INTEGER NOT NULL,
    tipo TEXT NOT NULL,
    monto REAL NOT NULL CHECK (monto >= 0),
    FOREIGN KEY (id_portafolio) REFERENCES Portafolios(id_portafolio)
);

CREATE TABLE Riesgos (
    id_riesgo INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente INTEGER NOT NULL,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    valor_riesgo REAL NOT NULL CHECK (valor_riesgo >= 0),
    estatus TEXT NOT NULL CHECK (estatus IN ('Normal', 'Preventiva', 'Critica')),
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);



-- ===============================================================
--                      INSERTAR LOS DATOS
-- ===============================================================


INSERT INTO Clientes (id_cliente, nombre, rfc, limite_credito) VALUES
(1, 'Juan Carrillo', 'JUAC123456789', 50000.00),
(2, 'Maria Lopez', 'MALO987654321', 75000.00),
(3, 'Carlos Sanchez', 'CARS456789123', 100000.00),
(4, 'Ana Martinez', 'ANMA321654987', 125000.00),
(5, 'Luis Fernandez', 'LUFE654987321', 150000.00),
(6, 'Sofia Ramirez', 'SOFA987321654', 200000.00),
(7, 'Diego Torres', 'DIET123987456', 250000.00),
(8, 'Valeria Gonzalez', 'VAGO456123789', 300000.00):


INSERT INTO Portafolios (id_portafolio, id_cliente, nombre, capital_invertido) VALUES
(101, 1, 'Portafolio A', 8000.00),
(102, 2, 'Portafolio B', 15000.00),
(103, 3, 'Portafolio C', 5000.00),
(104, 4, 'Portafolio D', 4000.00),
(105, 5, 'Portafolio E', 11000.00),
(106, 6, 'Portafolio F', 7000.00),
(107, 7, 'Portafolio G', 12000.00),
(108, 8, 'Portafolio H', 2000.00);


INSERT INTO Activos (id_activo, id_portafolio, tipo, monto) VALUES
(201, 101, 'Acciones', 5000.00),
(204, 102, 'Bonos', 5000.00),
(205, 103, 'Acciones', 2000.00),
(208, 104, 'Bonos', 3000.00),
(209, 105, 'Acciones', 6000.00),
(212, 106, 'Bonos', 3000.00),
(213, 107, 'Acciones', 7000.00),
(216, 108, 'Bonos', 1000.00);


INSERT INTO Riesgos (id_cliente, valor_riesgo, estatus) VALUES
(1, 10000.00, 'Normal'),
(2, 20000.00, 'Preventiva'),
(3, 15000.00, 'Critica'),
(4, 5000.00, 'Normal'),
(5, 25000.00, 'Preventiva'),
(6, 30000.00, 'Critica'),
(7, 40000.00, 'Normal'),
(8, 1000.00, 'Preventiva');


DROP TABLE Clientes;
DROP TABLE Portafolios;
DROP TABLE Activos;
DROP TABLE Riesgos;

-- ===============================================================
--                      CONSULTAS
-- ===============================================================

-- 1
SELECT * FROM Clientes;
-- 2
SELECT * FROM Portafolios;
-- 3
SELECT * FROM Activos;
-- 4
SELECT * FROM Riesgos;


-- 5
SELECT nombre, limite_credito FROM Clientes WHERE limite_credito > 100000.00;

-- 6
SELECT nombre, capital_invertido FROM Portafolios WHERE capital_invertido < 10000.00;

-- 7
SELECT tipo, monto FROM Activos WHERE monto BETWEEN 2000.00 AND 6000.00;

-- 8
SELECT nombre, limite_credito FROM Clientes ORDER BY limite_credito DESC;

-- 9
SELECT nombre, capital_invertido FROM Portafolios ORDER BY capital_invertido DESC;

-- 10 (Corregida: se quitó 'nombre' porque no existe en Riesgos)
SELECT id_cliente, valor_riesgo, estatus FROM Riesgos WHERE estatus = 'Critica';

-- 11
SELECT id_cliente, valor_riesgo, estatus FROM Riesgos WHERE estatus = 'Normal';

-- 12
SELECT id_cliente, valor_riesgo, estatus FROM Riesgos WHERE estatus = 'Preventiva';



-- 13
SELECT SUM(valor_riesgo) AS total_riesgo FROM Riesgos;

-- 14
SELECT AVG(valor_riesgo) AS promedio_riesgo FROM Riesgos;

-- 15
SELECT MAX(valor_riesgo) AS riesgo_maximo FROM Riesgos;

-- 16
SELECT MIN(valor_riesgo) AS riesgo_minimo FROM Riesgos;

-- 17 
SELECT SUM(capital_invertido) AS capital_total_portafolios FROM Portafolios;

-- 18 
SELECT estatus, COUNT(*) AS cantidad_clientes, SUM(valor_riesgo) AS riesgo_por_estatus FROM Riesgos GROUP BY estatus;

-- 19 
SELECT tipo, COUNT(*) AS total_activos, SUM(monto) AS monto_total FROM Activos GROUP BY tipo;

-- 20 
SELECT AVG(limite_credito) AS promedio_credito_clientes FROM Clientes;

-- 21 
SELECT estatus, AVG(valor_riesgo) AS promedio_por_estatus FROM Riesgos GROUP BY estatus HAVING AVG(valor_riesgo) > 15000.00;

-- 22 
SELECT tipo, MAX(monto) AS inversion_maxima_activo FROM Activos GROUP BY tipo;



-- 23
SELECT c.nombre AS cliente, p.nombre AS portafolio, p.capital_invertido 
FROM Clientes c INNER JOIN Portafolios p ON c.id_cliente = p.id_cliente;

-- 24
SELECT c.nombre, a.tipo, a.monto 
FROM Clientes c 
INNER JOIN Portafolios p ON c.id_cliente = p.id_cliente
INNER JOIN Activos a ON p.id_portafolio = a.id_portafolio;

-- 25
SELECT c.nombre, r.valor_riesgo, r.estatus 
FROM Clientes c INNER JOIN Riesgos r ON c.id_cliente = r.id_cliente;

-- 26
SELECT p.nombre, a.tipo, a.monto 
FROM Portafolios p INNER JOIN Activos a ON p.id_portafolio = a.id_portafolio;

-- 27
SELECT p.nombre, p.capital_invertido, a.monto AS monto_en_activos, (p.capital_invertido - a.monto) AS liquidez_disponible
FROM Portafolios p INNER JOIN Activos a ON p.id_portafolio = a.id_portafolio;

-- 28 
SELECT c.nombre, c.limite_credito, r.valor_riesgo, (c.limite_credito - r.valor_riesgo) AS margen_seguridad
FROM Clientes c INNER JOIN Riesgos r ON c.id_cliente = r.id_cliente;

-- 29
SELECT c.nombre, p.nombre AS portafolio, p.capital_invertido, r.valor_riesgo
FROM Clientes c 
JOIN Portafolios p ON c.id_cliente = p.id_cliente
JOIN Riesgos r ON c.id_cliente = r.id_cliente
WHERE r.estatus = 'Critica';

-- 30
SELECT c.nombre, c.rfc, a.monto
FROM Clientes c
JOIN Portafolios p ON c.id_cliente = p.id_cliente
JOIN Activos a ON p.id_portafolio = a.id_portafolio
WHERE a.tipo = 'Acciones';



-- 31
SELECT nombre, limite_credito FROM Clientes WHERE limite_credito > (SELECT AVG(limite_credito) FROM Clientes);

-- 32
SELECT nombre, capital_invertido FROM Portafolios WHERE capital_invertido < (SELECT AVG(capital_invertido) FROM Portafolios);

-- 33
SELECT tipo, monto FROM Activos WHERE monto BETWEEN (SELECT AVG(monto) - 2000.00 FROM Activos) AND (SELECT AVG(monto) + 2000.00 FROM Activos);

-- 34 
SELECT id_cliente, valor_riesgo, estatus FROM Riesgos WHERE valor_riesgo > (SELECT AVG(valor_riesgo) FROM Riesgos);

-- 35 
SELECT id_cliente, valor_riesgo, estatus FROM Riesgos WHERE estatus = 'Critica' AND valor_riesgo > (SELECT AVG(valor_riesgo) FROM Riesgos);

-- 36 
SELECT id_cliente, valor_riesgo, estatus FROM Riesgos WHERE estatus = 'Normal' AND valor_riesgo < (SELECT AVG(valor_riesgo) FROM Riesgos);

-- 37 
SELECT id_cliente, valor_riesgo, estatus FROM Riesgos WHERE estatus = 'Preventiva' AND valor_riesgo BETWEEN (SELECT AVG(valor_riesgo) - 5000.00 FROM Riesgos) AND (SELECT AVG(valor_riesgo) + 5000.00 FROM Riesgos);

-- 38 
SELECT nombre, rfc FROM Clientes WHERE id_cliente IN (SELECT id_cliente FROM Riesgos WHERE valor_riesgo > (SELECT AVG(valor_riesgo) FROM Riesgos));

-- 39 
SELECT nombre FROM Clientes WHERE id_cliente = (SELECT id_cliente FROM Portafolios ORDER BY capital_invertido DESC LIMIT 1);

-- 40
SELECT nombre, capital_invertido FROM Portafolios WHERE id_portafolio IN (SELECT id_portafolio FROM Activos WHERE tipo = 'Bonos');



-- 41
BEGIN IMMEDIATE;
UPDATE Riesgos SET valor_riesgo = valor_riesgo + 5000.00 WHERE estatus = 'Critica';
COMMIT;

-- 42
BEGIN IMMEDIATE;
UPDATE Riesgos SET valor_riesgo = valor_riesgo - 2000.00 WHERE estatus = 'Normal';
COMMIT;

-- 43
BEGIN IMMEDIATE;
UPDATE Riesgos SET valor_riesgo = valor_riesgo + 3000.00 WHERE estatus = 'Preventiva';
ROLLBACK;

-- 44
BEGIN IMMEDIATE;
UPDATE Clientes SET limite_credito = limite_credito + 10000.00, version = version + 1 WHERE id_cliente = 1 AND version = 0;
SELECT changes() AS filas_actualizadas_sesion_1;
COMMIT;

-- 45.
BEGIN IMMEDIATE;
UPDATE Clientes SET limite_credito = limite_credito + 20000.00, version = version + 1 WHERE id_cliente = 1 AND version = 0;
SELECT changes() AS filas_actualizadas_sesion_2; 
ROLLBACK;

-- 46
SELECT id_cliente, nombre, limite_credito, version FROM Clientes WHERE id_cliente = 1;



-- 47
CREATE VIEW vista_riesgo_clientes AS
SELECT c.nombre AS cliente, r.valor_riesgo, r.estatus
FROM Clientes c INNER JOIN Riesgos r ON c.id_cliente = r.id_cliente;

-- 48
SELECT * FROM vista_riesgo_clientes;

-- 49
CREATE VIEW vista_resumen_inversiones AS
SELECT c.nombre AS inversionista, p.nombre AS portafolio, a.tipo AS instrumento, a.monto
FROM Clientes c
JOIN Portafolios p ON c.id_cliente = p.id_cliente
JOIN Activos a ON p.id_portafolio = a.id_portafolio;

-- 50
SELECT * FROM vista_resumen_inversiones WHERE instrumento = 'Acciones';