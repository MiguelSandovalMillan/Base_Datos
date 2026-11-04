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
