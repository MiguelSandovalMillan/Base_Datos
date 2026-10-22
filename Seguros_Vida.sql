DROP TABLE IF EXISTS Clientes;
DROP TABLE IF EXISTS Polizas;
DROP TABLE IF EXISTS Beneficiarios;
DROP TABLE IF EXISTS Primas;
DROP TABLE IF EXISTS Siniestros;
DROP TABLE IF EXISTS Pago_Primas;

-- ===========================================================================
-- ===========================CREAR_TABLAS====================================
-- ===========================================================================



CREATE TABLE Clientes (
    id_cliente INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    edad INTEGER NOT NULL,
    ingreso REAL NOT NULL
);


CREATE TABLE Polizas ( 
    id_poliza INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente INTEGER NOT NULL,
    suma_asegurada REAL NOT NULL,
    año_inicio INTEGER NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);


CREATE TABLE Beneficiarios (
    id_beneficiario INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    id_poliza INTEGER NOT NULL,
    FOREIGN KEY (id_poliza) REFERENCES Polizas(id_poliza)
);


CREATE TABLE Pago_Primas (
    id_pago_prima INTEGER PRIMARY KEY AUTOINCREMENT,
    id_poliza INTEGER NOT NULL,
    monto_pagado REAL NOT NULL,
    FOREIGN KEY (id_poliza) REFERENCES Polizas(id_poliza)
);


CREATE TABLE Siniestros (
    id_siniestro INTEGER PRIMARY KEY AUTOINCREMENT,
    id_poliza INTEGER NOT NULL,
    monto_reclamado DECIMAL(12,2),
    monto_pagado DECIMAL(12,2),
    año_siniestro INTEGER NOT NULL,
    FOREIGN KEY (id_poliza) REFERENCES Polizas(id_poliza)
);


-- ===========================================================================
-- =========================INSERTAR_DATOS====================================
-- ===========================================================================



INSERT INTO Clientes (nombre, edad, ingreso) VALUES
('Ana López', 29, 28000),
('Carlos Ramírez', 45, 42000),
('María Hernández', 38, 35000),
('José Martínez', 52, 50000),
('Laura García', 33, 31000),
('Roberto Sánchez', 61, 58000),
('Patricia Torres', 27, 25000),
('Miguel Flores', 48, 47000),
('Sofía Mendoza', 41, 39000),
('Fernando Ruiz', 36, 33000);


INSERT INTO Polizas (id_cliente, suma_asegurada, año_inicio) VALUES
(1, 350000, 2022),
(2, 1000000, 2020),
(3,750000, 2021),
(4, 1500000, 2019),
(5, 420000, 2023),
(6, 900000, 2018),
(7, 280000, 2024),
(8, 1200000, 2020),
(9, 650000, 2022),
(10, 390000,2021),
(2, 500000, 2023),
(5, 800000, 2022),
(8, 850000, 2021),
(3, 450000, 2024);


INSERT INTO Siniestros (id_poliza, monto_reclamado, monto_pagado, año_siniestro) VALUES
(1, 45000, 40000, 2023),
(3, 120000, 110000, 2022),
(4, 250000, 230000, 2021),
(5, 150000, 145000, 2024),
(6, 180000, 170000, 2020),
(8, 300000, 280000, 2023),
(9, 95000, 90000, 2024),
(10, 60000, 55000, 2022),
(11, 200000, 190000, 2024),
(13, 140000, 130000, 2023),
(1, 30000, 25000, 2024),
(14, 70000, 65000, 2025);


INSERT INTO Beneficiarios (id_poliza, nombre) VALUES
(2, 'Pedro López'),
(4, 'Lucía Ramírez'),
(8, 'Marta Hernández'),
(12, 'Jorge Martínez'),
(1, 'Elena García'),
(3, 'Andrés Sánchez'),
(5, 'Carmen Torres'),
(9, 'Raúl Flores');


INSERT INTO Pago_Primas(id_poliza,monto_pagado) VALUES
(1, 12500.00),
(2, 8500.00),
(3, 15000.00),
(4, 9200.00),
(5, 14000.00),
(6, 18500.00),
(7, 11000.00),
(8, 7600.00),
(9, 13400.00),
(10, 16000.00),
(11, 19000.00),
(12, 6500.00),
(13, 17500.00),
(14, 15500.00);


SELECT * FROM Clientes;
SELECT * FROM Polizas;
SELECT * FROM Beneficiarios;
SELECT * FROM Pago_Primas;
SELECT * FROM Siniestros;



-- ===========================================================================
-- ==============================CONSULTAS====================================
-- ===========================================================================


-- 1. Obtener la información de todos los clientes que tienen una póliza de seguro
SELECT * FROM Clientes
WHERE id_cliente IN (SELECT id_cliente FROM Polizas);


-- 2. Obtener los beneficiarios de una póliza específica
SELECT * FROM Beneficiarios
WHERE id_beneficiario IN (SELECT id_beneficiario FROM Beneficiarios WHERE id_poliza = 2);


-- 3. Consultar los pagos de primas realizados para una póliza específica
SELECT * FROM Pago_Primas
WHERE id_poliza = 1;


-- 4. Obtener todas las pólizas que han tenido un siniestro
SELECT * FROM Polizas
WHERE id_poliza IN (SELECT id_poliza FROM Siniestros);


-- 5.Consultar el total de primas pagadas por un cliente específico
SELECT  (SELECT id_cliente FROM Polizas) AS id_cliente, SUM(monto_pagado) AS total_primas FROM Pago_Primas
    WHERE id_poliza IN (SELECT id_poliza FROM Polizas WHERE id_cliente = 1);