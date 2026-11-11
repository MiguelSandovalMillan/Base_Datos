DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;



CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(60) NOT NULL,
    ciudad VARCHAR(50) NOT NULL
);

CREATE TABLE productos (
    id_producto INT PRIMARY KEY,
    nombre VARCHAR(60) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL
);

CREATE TABLE ventas (
    id_venta INT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    fecha DATE NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);


INSERT INTO clientes VALUES
(1, 'Ana López', 'Morelia'),
(2, 'Luis Pérez', 'Uruapan'),
(3, 'María García', 'Morelia'),
(4, 'Carlos Ruiz', 'Zamora'),
(5, 'Sofía Torres', 'Pátzcuaro'),
(6, 'Pedro Méndez', 'Morelia');

INSERT INTO productos VALUES
(1, 'Laptop', 12500, 10),
(2, 'Mouse', 250, 40),
(3, 'Teclado', 450, 25),
(4, 'Monitor', 3200, 15),
(5, 'Impresora', 2800, 8),
(6, 'Webcam', 850, 20),
(7, 'Bocinas', 600, 12),
(8, 'Memoria USB', 180, 50);

INSERT INTO ventas VALUES
(1, 1, 1, 1, '2026-10-01'),
(2, 2, 2, 3, '2026-10-02'),
(3, 3, 4, 2, '2026-10-03'),
(4, 1, 3, 2, '2026-10-04'),
(5, 4, 5, 1, '2026-10-05'),
(6, 5, 2, 4, '2026-10-06'),
(7, 2, 6, 2, '2026-10-07'),
(8, 3, 1, 1, '2026-10-08');

SELECT * FROM clientes;
SELECT * FROM productos;
SELECT * FROM ventas;



---===========================
--- Insercion de registros
-- ===========================


-- 1. Inserta tres clientes nuevos (IDs 7, 8 y 9) con sus respectivas ciudades.
INSERT INTO clientes (id_cliente, nombre, ciudad) VALUES 
(7, 'Miguel Sandoval', 'Morelia'),
(8, 'Adair Chavez', 'Uruapan'),
(9, 'Edgar Rodriguez', 'Patzcuaro');


-- 2. Inserta dos productos nuevos (IDs 9 y 10), incluyendo precio y existencias.
INSERT INTO productos (id_producto, nombre, precio, stock) VALUES 
(9, 'Tablet', 2500, 12),
(10, 'Audifonos', 1000, 10);


-- 3. Registra una nueva venta (ID 9) para uno de los clientes agregados y un producto existente; usa una fecha válida.
INSERT INTO ventas (id_venta, id_cliente, id_producto, cantidad, fecha) VALUES 
(9, 7, 9, 1, '2026-10-10');


-- 4. Comprueba mediante SELECT que los nuevos registros existen.
SELECT * FROM clientes;
SELECT * FROM productos;
SELECT * FROM ventas;


-- =============================
--- Actualizacion de registros
-- =============================

-- 5. Aumenta 10 % el precio de todos los productos cuyo precio sea menor que $1,000.
SELECT * FROM productos WHERE precio < 1000;

UPDATE productos SET precio = precio * 1.10 WHERE precio < 1000;
SELECT * FROM productos;


-- 6. Cambia la ciudad del cliente ID 4 a Morelia.
SELECT * FROM clientes WHERE id_cliente = 4;

UPDATE clientes SET ciudad = 'Morelia' WHERE id_cliente = 4;
SELECT * FROM clientes WHERE id_cliente = 4;

-- 7. Incrementa en cinco unidades las existencias de productos con stock inferior a 20.
SELECT * FROM productos WHERE stock < 20;

UPDATE productos SET stock = stock + 5 WHERE stock < 20;
SELECT * FROM productos WHERE stock < 20;

-- 8. Aplica un descuento de 5 % al producto más caro después de los ajustes anteriores.
SELECT * FROM productos ORDER BY precio DESC LIMIT 1;

UPDATE productos 
SET precio = precio * 0.95 
WHERE id_producto = (SELECT id_producto FROM productos ORDER BY precio DESC LIMIT 1);


-- 9. Documenta con SELECT los valores anteriores y posteriores a cada actualización.
SELECT * FROM productos ORDER BY precio DESC LIMIT 1;



-- ===================
-- Eliminacion segura
-- ===================

-- 10. Elimina uno de los nuevos clientes sin ventas asociadas; comprueba previamente que no tenga ventas.
SELECT * FROM ventas WHERE id_cliente = 8;
DELETE FROM clientes WHERE id_cliente = 8;
SELECT * FROM clientes;

-- 11. Elimina un producto que no aparezca en ventas. Antes de hacerlo, comprueba que no tenga dependencias.
SELECT * FROM ventas WHERE id_producto = 10;
DELETE FROM productos WHERE id_producto = 10;
SELECT * FROM productos;

-- 12. En un ensayo controlado, intenta eliminar un cliente que sí tenga ventas y explica el error de integridad referencial. 
--     No deshabilites las claves foráneas.
PRAGMA foreign_keys = ON;
DELETE FROM clientes WHERE id_cliente = 1;

-- 13. Muestra los registros restantes y explica por qué no debe usarse DELETE sin WHERE.
SELECT * FROM clientes;
-- Omitir "WHERE" en un "DELETE" borraria toda la tabla clientes y eso seria muy feo y peligroso para la base de datos.




-- =======================
-- SELECT: Diez Consultas
-- =======================


-- 14. Lista los productos ordenados de mayor a menor precio.
SELECT * FROM productos ORDER BY precio DESC;

-- 15. Clientes en Morelia
SELECT * FROM clientes WHERE ciudad = 'Morelia';

-- 16. Productos con precio entre $500 y $5,000
SELECT * FROM productos WHERE precio BETWEEN 500 AND 5000;

-- 17. Precio promedio de productos
SELECT AVG(precio) AS precio_promedio FROM productos;

-- 18. Producto más caro y más barato
SELECT MAX(precio) AS mas_caro, MIN(precio) AS mas_barato FROM productos;

-- 19. Valor total del inventario
SELECT SUM(precio * stock) AS valor_inventario FROM productos;

-- 20. Ventas por cliente (incluyendo sin compras)[cite: 4]
SELECT c.nombre, COUNT(v.id_venta) AS total_ventas 
FROM clientes c LEFT JOIN ventas v ON c.id_cliente = v.id_cliente 
GROUP BY c.id_cliente;

-- 21. JOIN: cliente, producto, cantidad y fecha[cite: 4]
SELECT c.nombre AS cliente, p.nombre AS producto, v.cantidad, v.fecha 
FROM ventas v 
JOIN clientes c ON v.id_cliente = c.id_cliente 
JOIN productos p ON v.id_producto = p.id_producto;

-- 22. Importe total vendido por producto[cite: 4]
SELECT p.nombre, COALESCE(SUM(v.cantidad * p.precio), 0) AS importe_total 
FROM productos p LEFT JOIN ventas v ON p.id_producto = v.id_producto 
GROUP BY p.id_producto;

-- 23. Clientes con más de una venta[cite: 4]
SELECT c.nombre, COUNT(v.id_venta) AS compras 
FROM clientes c JOIN ventas v ON c.id_cliente = v.id_cliente 
GROUP BY c.id_cliente HAVING compras > 1;



-- =============================
-- SUBCONSULTAS: Diez Consultas
-- =============================


-- 24. Productos cuyo precio supera el promedio[cite: 4]
SELECT * FROM productos WHERE precio > (SELECT AVG(precio) FROM productos);

-- 25. Producto de mayor precio (subconsulta)[cite: 4]
SELECT * FROM productos WHERE precio = (SELECT MAX(precio) FROM productos);

-- 26. Clientes con al menos una compra (IN)[cite: 4]
SELECT * FROM clientes WHERE id_cliente IN (SELECT id_cliente FROM ventas);

-- 27. Clientes sin compras (NOT EXISTS)[cite: 4]
SELECT * FROM clientes c WHERE NOT EXISTS (SELECT 1 FROM ventas v WHERE v.id_cliente = c.id_cliente);

-- 28. Productos que nunca aparecen en ventas[cite: 4]
SELECT * FROM productos WHERE id_producto NOT IN (SELECT id_producto FROM ventas);

-- 29. Productos con precio superior a cualquiera < $500 (ANY emulado en SQLite con MIN)[cite: 4]
SELECT * FROM productos WHERE precio > (SELECT MIN(precio) FROM productos WHERE precio < 500);

-- 30. Productos con precio superior a todos < $1,000 (ALL emulado en SQLite con MAX)[cite: 4]
SELECT * FROM productos WHERE precio > (SELECT MAX(precio) FROM productos WHERE precio < 1000);

-- 31. Clientes cuyo gasto supera el gasto promedio general[cite: 4]
SELECT id_cliente, SUM(p.precio * v.cantidad) as gasto_total 
FROM ventas v JOIN productos p ON v.id_producto = p.id_producto 
GROUP BY id_cliente 
HAVING gasto_total > (
    SELECT AVG(gasto) FROM (
        SELECT SUM(p2.precio * v2.cantidad) as gasto 
        FROM ventas v2 JOIN productos p2 ON v2.id_producto = p2.id_producto 
        GROUP BY v2.id_cliente
    )
);

-- 32. Producto con mayor cantidad acumulada vendida[cite: 4]
SELECT id_producto FROM ventas GROUP BY id_producto ORDER BY SUM(cantidad) DESC LIMIT 1;

-- 33. Ventas cuyo importe supera el promedio[cite: 4]
SELECT v.id_venta, (v.cantidad * p.precio) AS importe 
FROM ventas v JOIN productos p ON v.id_producto = p.id_producto 
WHERE importe > (
    SELECT AVG(v2.cantidad * p2.precio) 
    FROM ventas v2 JOIN productos p2 ON v2.id_producto = p2.id_producto
);