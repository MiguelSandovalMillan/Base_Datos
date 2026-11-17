-- ===============================================================
--                      CREAR BASE DE DATOS
-- ===============================================================


CREATE TABLE Clientes (
    id_cliente INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE Polizas (
    id_poliza INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente INTEGER NOT NULL,
    prima_total DECIMAL(12,2) NOT NULL,
    saldo_pendiente DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
    CHECK (saldo_pendiente >= 0)
);

CREATE TABLE Pagos (
    id_pago INTEGER PRIMARY KEY AUTOINCREMENT,
    id_poliza INTEGER NOT NULL,
    monto DECIMAL(12,2) NOT NULL,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_poliza) REFERENCES Polizas(id_poliza),
    CHECK (monto > 0)
);



INSERT INTO Clientes VALUES
    (1,'Ana Martinez'),(2,'Carlos Lopez'),(3,'Maria Fernandez');

INSERT INTO Polizas VALUES
    (101,1,12000.00,12000.00),
    (102,2,18000.00,18000.00),
    (103,3,24000.00,24000.00);


DROP TABLE Clientes;
DROP TABLE Polizas;
DROP TABLE Pagos;

SELECT * FROM Clientes;
SELECT * FROM Polizas;
SELECT * FROM Pagos;


-- ===============================================================
--                  COMMIT Y PAGO AUTORIZADO
-- ===============================================================

BEGIN TRANSACTION;

INSERT INTO Pagos (id_poliza, monto) VALUES (101, 1500.00);
UPDATE Polizas
SET saldo_pendiente = saldo_pendiente - 1500.00
WHERE id_poliza = 101 AND saldo_pendiente >= 1500.00;

COMMIT;

SELECT * FROM Polizas WHERE id_poliza = 101;
SELECT * FROM Pagos WHERE id_poliza = 101;



-- ===============================================================
--              ROLLBACK DE OPERACION NO AUTORIZADA
-- ===============================================================

BEGIN TRANSACTION;

INSERT INTO Pagos (id_poliza, monto) VALUES (102, 9000.00);
UPDATE Polizas
SET saldo_pendiente = saldo_pendiente - 9000.00
WHERE id_poliza = 102 AND saldo_pendiente >= 9000.00;

ROLLBACK;

SELECT * FROM Polizas WHERE id_poliza = 102;
SELECT * FROM Pagos WHERE id_poliza = 102;



-- ===============================================================
--              SAVEPOINT REVERSION PARCIAL
-- ===============================================================

BEGIN TRANSACTION;

UPDATE Polizas
SET saldo_pendiente = saldo_pendiente - 1000.00
WHERE id_poliza = 103;

SAVEPOINT punto_seguro;

UPDATE Polizas
SET saldo_pendiente = saldo_pendiente - 500.00
WHERE id_poliza = 103;

ROLLBACK TO punto_seguro;
COMMIT;

SELECT * FROM Polizas WHERE id_poliza = 103;



-- ===============================================================
--                  CONTROL DE CONCURRENCIA
-- ===============================================================

BEGIN IMMEDIATE;

UPDATE Polizas
SET saldo_pendiente = saldo_pendiente - 3000.00
WHERE id_poliza = 102 AND saldo_pendiente >= 3000.00;

COMMIT;


BEGIN IMMEDIATE;

UPDATE Polizas
SET saldo_pendiente = saldo_pendiente - 5000.00
WHERE id_poliza = 102 AND saldo_pendiente >= 5000.00;

COMMIT;

SELECT * FROM Polizas WHERE id_poliza = 102;


-- ===============================================================
--                 EJERCICIO INTEGRADOR AUTONOMO
-- ===============================================================

DELETE FROM Pagos;

UPDATE Polizas SET saldo_pendiente = 12000.00 WHERE id_poliza = 101;
UPDATE Polizas SET saldo_pendiente = 18000.00 WHERE id_poliza = 102;
UPDATE Polizas SET saldo_pendiente = 24000.00 WHERE id_poliza = 103;


SELECT * FROM Polizas WHERE id_poliza = 103;

-- Pago A: $2,500 
BEGIN IMMEDIATE;
INSERT INTO Pagos (id_poliza, monto) VALUES (103, 2500.00);
UPDATE Polizas SET saldo_pendiente = saldo_pendiente - 2500.00 
WHERE id_poliza = 103 AND saldo_pendiente >= 2500.00;
SELECT changes() AS filas_afectadas_A; 
COMMIT;

-- Pago B: $1,800 
BEGIN IMMEDIATE;
INSERT INTO Pagos (id_poliza, monto) VALUES (103, 1800.00);
UPDATE Polizas SET saldo_pendiente = saldo_pendiente - 1800.00 
WHERE id_poliza = 103 AND saldo_pendiente >= 1800.00;
SELECT changes() AS filas_afectadas_B; 
COMMIT;

-- Pago C: $25,000 
BEGIN IMMEDIATE;
INSERT INTO Pagos (id_poliza, monto) VALUES (103, 25000.00);
UPDATE Polizas SET saldo_pendiente = saldo_pendiente - 25000.00 
WHERE id_poliza = 103 AND saldo_pendiente >= 25000.00;
SELECT changes() AS filas_afectadas_C; 

ROLLBACK;


SELECT * FROM Polizas;
SELECT * FROM Pagos;