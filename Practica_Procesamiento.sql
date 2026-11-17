-- ===========================================================================
-- ===============================CREAR TABLAS================================
-- ===========================================================================


CREATE TABLE clientes (
    id_cliente INTEGER PRIMARY KEY, 
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(120) NOT NULL UNIQUE
);


CREATE TABLE productos (
    id_producto INTEGER PRIMARY KEY, 
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL CHECK(precio > 0),
    stock INTEGER NOT NULL CHECK(stock >= 0),
    version INTEGER NOT NULL DEFAULT 0
);


CREATE TABLE ventas (
    id_venta INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente INTEGER NOT NULL, 
    fecha TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY(id_cliente) REFERENCES clientes(id_cliente)
);


CREATE TABLE detalle_venta (
    id_detalle INTEGER PRIMARY KEY AUTOINCREMENT,
    id_venta INTEGER NOT NULL, 
    id_producto INTEGER NOT NULL,
    cantidad INTEGER NOT NULL CHECK(cantidad > 0),
    subtotal DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY(id_venta) REFERENCES ventas(id_venta),
    FOREIGN KEY(id_producto) REFERENCES productos(id_producto)
);



-- ===========================================================================
-- =============================INSERTAR DATOS================================
-- ===========================================================================




INSERT INTO clientes VALUES
    (1, 'Ana López', 'ana@ejemplo.com'),
    (2, 'Luis Pérez', 'luis@ejemplo.com'),
    (3, 'María Ruiz', 'maria@ejemplo.com');

INSERT INTO productos VALUES
    (1, 'Laptop', 15000, 10, 0), 
    (2, 'Mouse', 250, 20, 0),
    (3, 'Teclado', 650, 15, 0), 
    (4, 'Monitor', 3500, 5, 0),
    (5, 'USB 64 GB', 180, 1, 0);



DROP TABLE clientes;
DROP TABLE productos;
DROP TABLE ventas;
DROP TABLE detalle_venta;


SELECT * FROM clientes;
SELECT * FROM productos;


-- ===========================================================================
-- =================================PRUEBAS===================================
-- ===========================================================================


-- VENTA EXITOSA --

BEGIN TRANSACTION;

INSERT INTO ventas(id_cliente, total) VALUES (1, 30000);

INSERT INTO detalle_venta(id_venta, id_producto, cantidad, subtotal)

VALUES (last_insert_rowid(), 1, 2, 30000);

UPDATE productos SET stock = stock - 2, version = version + 1
WHERE id_producto = 1 AND stock >= 2;
COMMIT;


SELECT * FROM ventas;

SELECT nombre, stock FROM productos WHERE id_producto = 1;



-- VENTA CANCELADA VOLUNTARIAMENTE --

BEGIN TRANSACTION;

INSERT INTO ventas(id_cliente, total) VALUES (2, 45000);

INSERT INTO detalle_venta(id_venta, id_producto, cantidad, subtotal)

VALUES (last_insert_rowid(), 1, 3, 45000);
UPDATE productos SET stock = stock - 3, version = version + 1
WHERE id_producto = 1 AND stock >= 3;
ROLLBACK;

SELECT * FROM ventas;
SELECT nombre, stock FROM productos WHERE id_producto = 1;



-- DOS LECTURAS DE LA MISMA VERSION, INTERCALADAS --

BEGIN TRANSACTION;

UPDATE productos SET stock = stock - 1, version = version + 1
WHERE id_producto = 5 AND stock >= 1 AND version = 0;

SELECT changes() AS filas_B; 
COMMIT;


BEGIN TRANSACTION;

UPDATE productos SET stock = stock - 1, version = version + 1
WHERE id_producto = 5 AND stock >= 1 AND version = 0;

SELECT changes() AS filas_A; 
ROLLBACK;

SELECT nombre, stock, version FROM productos WHERE id_producto = 5;


-- VISTA DE CONSULTA --

CREATE VIEW vista_inventario AS
SELECT nombre, precio, stock FROM productos;

SELECT * FROM vista_inventario;



-- ===========================================================================
-- =================================RETOS=====================================
-- ===========================================================================

-- SOLICITUD DE ANA 



BEGIN IMMEDIATE;

INSERT INTO ventas(id_cliente, total) VALUES (1, 7000);
INSERT INTO detalle_venta(id_venta, id_producto, cantidad, subtotal) VALUES (1, 4, 2, 7000);

UPDATE productos SET stock = stock - 2, version = version + 1 WHERE id_producto = 4;
COMMIT;

SELECT * FROM productos;


-- SOLICITUD DE LUIS

BEGIN IMMEDIATE;

INSERT INTO ventas(id_cliente, total) VALUES (2, 10500);
INSERT INTO detalle_venta(id_venta, id_producto, cantidad, subtotal) VALUES (2, 4, 3, 10500);

UPDATE productos SET stock = stock - 3, version = version + 1 WHERE id_producto = 4;

COMMIT;

SELECT * FROM productos;


-- SOLICITUDD DE MARIA

BEGIN IMMEDIATE;

INSERT INTO ventas(id_cliente, total) VALUES (3, 7000);
INSERT INTO detalle_venta(id_venta, id_producto, cantidad, subtotal) VALUES (3, 4, 2, 7000);

UPDATE productos SET stock = stock - 2, version = version + 1 WHERE id_producto = 4;

ROLLBACK;

SELECT * FROM productos;


-- VERIFICACION --

SELECT * FROM productos WHERE id_producto = 4;

