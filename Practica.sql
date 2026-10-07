-- ===========================================================================
-- ===========================CREAR_TABLAS====================================
-- ===========================================================================


CREATE TABLE Clientes (
    id_cliente INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL,
    apellidos TEXT NOT NULL,
    telefono TEXT,
    correo TEXT,
    ciudad TEXT
)


CREATE TABLE Proveedores (
    id_proveedor INTEGER PRIMARY KEY,
    nombre_proveedor TEXT NOT NULL,
    telefono TEXT,
    correo TEXT,
    ciudad TEXT
)


CREATE TABLE Categorias (
    id_categoria INTEGER PRIMARY KEY,
    nombre_categoria TEXT NOT NULL,
    descripcion TEXT
)


CREATE TABLE Productos (
    id_producto INTEGER PRIMARY KEY,
    nombre_producto TEXT NOT NULL,
    precio REAL NOT NULL,
    existencia INTEGER NOT NULL,
    id_categoria INTEGER,
    id_proveedor INTEGER,
    FOREIGN KEY (id_categoria) REFERENCES Categorias(id_categoria),
    FOREIGN KEY (id_proveedor) REFERENCES Proveedores(id_proveedor)
)


CREATE TABLE Ventas (
    id_venta INTEGER PRIMARY KEY,
    fecha TEXT NOT NULL,
    id_cliente INTEGER NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
)


CREATE TABLE Detalle_Venta (
    id_detalle INTEGER PRIMARY KEY,
    id_venta INTEGER NOT NULL,
    id_producto INTEGER NOT NULL,
    cantidad INTEGER NOT NULL,
    precio_unitario REAL NOT NULL,
    FOREIGN KEY (id_venta) REFERENCES Ventas(id_venta),
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)
)



-- ===========================================================================
-- =========================INSERTAR_DATOS====================================
-- ===========================================================================



INSERT INTO Clientes (id_cliente, nombre, apellidos, telefono, correo, ciudad) VALUES
(1,'Ana','López García','4431111111','ana@gmail.com','Morelia'),
(2,'Carlos','Martínez Pérez','4432222222','carlos@gmail.com','Morelia'),
(3,'María','González Torres','4433333333','maria@gmail.com','Pátzcuaro'),
(4,'José','Ramírez Hernández','4434444444','jose@gmail.com','Uruapan'),
(5,'Laura','Sánchez Mora','4435555555','laura@gmail.com','Morelia');


INSERT INTO Proveedores (id_proveedor, nombre_proveedor, telefono, correo, ciudad) VALUES
(1,'Tecnología del Centro','4435001000','ventas@tecnologiacentro.com','Morelia'),
(2,'Computadoras Michoacán','4435002000','contacto@computadorasmichoacan.com','Morelia'),
(3,'Accesorios Digitales','4435003000','ventas@accesoriosdigitales.com','Uruapan');


INSERT INTO Categorias (id_categoria, nombre_categoria, descripcion) VALUES
(1,'Computadoras','Equipos de cómputo'),
(2,'Accesorios','Accesorios para computadora'),
(3,'Almacenamiento','Dispositivos de almacenamiento'),
(4,'Monitores','Pantallas y monitores');


INSERT INTO Productos (id_producto, nombre_producto, precio, existencia, id_categoria, id_proveedor) VALUES
(1,'Laptop Lenovo',15000,8,1,1),
(2,'Mouse inalámbrico',350,20,2,3),
(3,'Teclado mecánico',750,15,2,3),
(4,'Monitor 24 pulgadas',4200,10,4,2),
(5,'Memoria USB 64 GB',250,25,3,3),
(6,'Disco SSD 1 TB',1800,12,3,2);


INSERT INTO Ventas (id_venta, fecha, id_cliente) VALUES
(1,'2026-09-01',1),
(2,'2026-09-02',2),
(3,'2026-09-03',3),
(4,'2026-09-04',1),
(5,'2026-09-05',4);


INSERT INTO Detalle_Venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario) VALUES
(1,1,1,1,15000),
(2,1,2,2,350),
(3,2,3,2,750),
(4,2,5,3,250),
(5,3,4,1,4200),
(6,3,2,1,350),
(7,4,6,1,1800),
(8,5,5,4,250);


-- ===========================================================================
-- ================================CONSULTAS==================================
-- ===========================================================================


-- CONSULTA 1 - Mostrar todos los clientes --
SELECT * FROM Clientes;


-- CONSULTA 2 - Mostrar todos los productos --
SELECT * FROM Productos;


-- CONSULTA 3 - Nombre, precio y existencia --
SELECT nombre_producto, precio, existencia
FROM Productos;


-- CONSULTA 4 - Productos con precio mayor de $1,000 --
SELECT nombre_producto, precio
FROM Productos
WHERE precio > 1000;


-- CONSULTA 5 - Clientes de Morelia --
SELECT nombre, apellidos, ciudad
FROM Clientes
WHERE ciudad = 'Morelia';


-- CONSULTA 6 - Productos del más caro al más barato --
SELECT nombre_producto, precio
FROM Productos
ORDER BY precio DESC;


-- CONSULTA 7 - Producto con categoria --
SELECT Productos.nombre_producto, Categorias.nombre_categoria, Productos.precio
FROM Productos
INNER JOIN Categorias
ON Productos.id_categoria = Categorias.id_categoria;


-- CONSULTA 8 - Producto con proveedor --
SELECT Productos.nombre_producto, Proveedores.nombre_proveedor, Productos.precio
FROM Productos
INNER JOIN Proveedores
ON Productos.id_proveedor = Proveedores.id_proveedor;


-- CONSULTA 9 - Ventas con cliente --
SELECT Ventas.id_venta, Ventas.fecha, Clientes.nombre, Clientes.apellidos
FROM Ventas
INNER JOIN Clientes
ON Ventas.id_cliente = Clientes.id_cliente;


-- CONSULTA 10 - Detalle completo de ventas --  
SELECT Ventas.id_venta, Ventas.fecha,
    Clientes.nombre || ' ' || Clientes.apellidos AS cliente,
    Productos.nombre_producto,
    Detalle_Venta.cantidad,
    Detalle_Venta.precio_unitario,
    Detalle_Venta.cantidad * Detalle_Venta.precio_unitario AS subtotal
FROM Detalle_Venta
INNER JOIN Ventas ON Detalle_Venta.id_venta = Ventas.id_venta
INNER JOIN Clientes ON Ventas.id_cliente = Clientes.id_cliente
INNER JOIN Productos ON Detalle_Venta.id_producto = Productos.id_producto;


-- CONSULTA 11 - Total de cada venta --
SELECT id_venta, SUM(cantidad * precio_unitario) AS total_venta
FROM Detalle_Venta
GROUP BY id_venta;


--- CONSULTA 12 - Total comprado por cliente --
SELECT Clientes.nombre, Clientes.apellidos,
    SUM(Detalle_Venta.cantidad * Detalle_Venta.precio_unitario) AS total_comprado
FROM Clientes
INNER JOIN Ventas ON Clientes.id_cliente = Ventas.id_cliente
INNER JOIN Detalle_Venta ON Ventas.id_venta = Detalle_Venta.id_venta
GROUP BY Clientes.id_cliente, Clientes.nombre, Clientes.apellidos;


-- CONSULTA 13 -  Productos con existencia menor de 15 --
SELECT nombre_producto, existencia
FROM Productos
WHERE existencia < 15;


-- CONSULTA 14 - Precio promedio --
SELECT ROUND(AVG(precio),2) AS precio_promedio
FROM Productos;


-- CONSULTA 15 - Producto más caro --
SELECT nombre_producto, precio
FROM Productos
ORDER BY precio DESC
LIMIT 1;




