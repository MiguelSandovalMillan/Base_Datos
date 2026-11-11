DROP TABLE IF EXISTS ventas_limpias;
DROP TABLE IF EXISTS inventario;
DROP TABLE IF EXISTS ventas_origen;


CREATE TABLE ventas_origen(
    id INT PRIMARY KEY, 
    producto VARCHAR(50),
    cantidad INT, precio DECIMAL(10,2)
);

CREATE TABLE ventas_limpias(
    id INT PRIMARY KEY, 
    producto VARCHAR(50) NOT NULL,
    cantidad INT NOT NULL CHECK(cantidad>0), 
    precio DECIMAL(10,2) NOT NULL CHECK(precio>0),
    total DECIMAL(12,2) NOT NULL
);


CREATE TABLE inventario(
    producto VARCHAR(50) PRIMARY KEY,
    existencias INT NOT NULL CHECK(existencias>=0)
);


INSERT INTO ventas_origen VALUES
(1,'Laptop',2,12500),(2,'Mouse',5,250),(3,'Teclado',-3,450),
(4,'Monitor',3,3200),(5,'Laptop',2,12500),(6,'USB',10,0),
(7,'Impresora',1,2800),(8,'Mouse',4,250),(9,'Webcam',2,850),(10,'Bocinas',-1,600);


INSERT INTO inventario VALUES
('Laptop',10),('Mouse',20),('Monitor',8),('Impresora',5),('Webcam',10);


SELECT * FROM ventas_origen;


-- TODO 1: detectar errores y duplicados.
SELECT * FROM ventas_origen
WHERE cantidad <= 0 OR precio <= 0;

SELECT producto, cantidad, precio, COUNT(*) AS duplicados
FROM ventas_origen
GROUP BY producto, cantidad, precio
HAVING COUNT(*) > 1;

-- TODO 2: transformar y cargar ventas validas.
INSERT INTO ventas_limpias (id, producto, cantidad, precio, total)

SELECT id, producto, cantidad, precio, cantidad * precio AS total
FROM ventas_origen
WHERE cantidad > 0 AND precio > 0
GROUP BY id, producto, cantidad, precio;


SELECT * FROM ventas_limpias;

-- TODO 3: START TRANSACTION ... COMMIT.
SELECT * FROM inventario 
WHERE producto = 'Laptop';


BEGIN TRANSACTION;

UPDATE inventario
SET existencias = existencias - 3
WHERE producto = 'Laptop';

COMMIT;

SELECT * FROM inventario 
WHERE producto = 'Laptop';


-- TODO 4: START TRANSACTION ... ROLLBACK.

SELECT * FROM inventario 
WHERE producto = 'Laptop';

BEGIN TRANSACTION;

UPDATE inventario
SET existencias = existencias - 50
WHERE producto = 'Laptop';

ROLLBACK;

SELECT * FROM inventario 
WHERE producto = 'Laptop';