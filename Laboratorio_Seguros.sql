DROP TABLE IF EXISTS Polizas;
DROP TABLE IF EXISTS Clientes;
DROP TABLE IF EXISTS Agentes;
DROP TABLE IF EXISTS Siniestros;


-- ===========================================================================
-- ===========================CREAR_TABLAS====================================
-- ===========================================================================


CREATE TABLE Agentes (
    id_agente INTEGER PRIMARY KEY, 
    nombre TEXT NOT NULL, 
    sucursal TEXT NOT NULL
);


CREATE TABLE Clientes (
    id_cliente INTEGER PRIMARY KEY, 
    nombre TEXT NOT NULL, 
    ciudad TEXT NOT NULL, 
    edad INTEGER NOT NULL CHECK(edad>=18), 
    segmento TEXT NOT NULL
);


CREATE TABLE Polizas (
    id_poliza INTEGER PRIMARY KEY, 
    id_cliente INTEGER NOT NULL REFERENCES Clientes(id_cliente), 
    id_agente INTEGER NOT NULL REFERENCES Agentes(id_agente), 
    tipo TEXT NOT NULL, 
    prima_anual REAL NOT NULL, 
    suma_asegurada REAL NOT NULL, 
    estado TEXT NOT NULL CHECK(estado IN ('Activa','Cancelada'))
);


CREATE TABLE Siniestros (
    id_siniestro INTEGER PRIMARY KEY, 
    id_poliza INTEGER NOT NULL REFERENCES Polizas(id_poliza), 
    fecha TEXT NOT NULL, 
    monto_reclamado REAL NOT NULL, 
    estatus TEXT NOT NULL CHECK(estatus IN ('Aprobado','Rechazado','En revision'))
);


CREATE TABLE Pagos (
    id_pago INTEGER PRIMARY KEY, 
    id_poliza INTEGER NOT NULL REFERENCES Polizas(id_poliza), 
    fecha TEXT NOT NULL, 
    monto REAL NOT NULL
);



-- ===========================================================================
-- =========================INSERTAR_DATOS====================================
-- ===========================================================================


INSERT INTO Agentes VALUES 
(1,'Ana Ruiz','Morelia'),
(2,'Luis Vega','CDMX'),
(3,'Elena Mora','Guadalajara'),
(4,'Pablo Soto','Morelia');


INSERT INTO Clientes VALUES 
(1,'Laura Pérez','Morelia',29,'Individual'),
(2,'Carlos Díaz','CDMX',44,'Familiar'),
(3,'María Luna','Morelia',37,'Individual'),
(4,'Jorge Silva','Guadalajara',53,'Empresarial'),
(5,'Sofía Torres','CDMX',26,'Individual'),
(6,'Roberto Gil','Morelia',61,'Familiar'),
(7,'Daniela Cruz','Puebla',34,'Empresarial'),
(8,'Pedro León','Guadalajara',48,'Familiar'),
(9,'Valeria Núñez','Morelia',41,'Empresarial'),
(10,'Miguel Ríos','Querétaro',32,'Individual'),
(11,'Julia Ramos','CDMX',55,'Familiar'),
(12,'Andrés Flores','Puebla',39,'Individual');


INSERT INTO Polizas VALUES 
(101,1,1,'Auto',8500,200000,'Activa'),
(102,2,2,'Vida',12000,500000,'Activa'),
(103,3,1,'Salud',14500,300000,'Activa'),
(104,4,3,'Auto',11000,250000,'Cancelada'),
(105,5,2,'Auto',7600,180000,'Activa'),
(106,6,4,'Vida',17500,700000,'Activa'),
(107,7,3,'Salud',22000,600000,'Activa'),
(108,8,3,'Auto',9900,220000,'Activa'),
(109,9,1,'Vida',19000,800000,'Activa'),
(110,10,4,'Salud',13000,350000,'Cancelada'),
(111,11,2,'Vida',15500,650000,'Activa'),
(112,12,4,'Auto',8900,210000,'Activa'),
(113,1,1,'Salud',15500,450000,'Activa'),
(114,4,3,'Vida',24000,900000,'Activa'),
(115,7,3,'Auto',10500,260000,'Activa'),
(116,9,1,'Salud',21000,550000,'Activa');


INSERT INTO Siniestros VALUES 
(201,101,'2026-01-10',25000,'Aprobado'),
(202,103,'2026-02-14',18000,'Aprobado'),
(203,104,'2026-02-21',45000,'Rechazado'),
(204,106,'2026-03-05',95000,'Aprobado'),
(205,107,'2026-03-08',32000,'En revision'),
(206,108,'2026-04-12',12000,'Aprobado'),
(207,109,'2026-04-26',150000,'Aprobado'),
(208,111,'2026-05-02',27000,'Rechazado'),
(209,113,'2026-05-22',35000,'Aprobado'),
(210,114,'2026-06-15',120000,'En revision'),
(211,115,'2026-07-09',8000,'Aprobado'),
(212,116,'2026-07-19',55000,'Aprobado'),
(213,101,'2026-08-01',15000,'En revision');


INSERT INTO Pagos VALUES 
(301,101,'2026-01-05',8500),
(302,102,'2026-01-06',12000),
(303,103,'2026-01-07',14500),
(304,104,'2026-01-10',5500),
(305,105,'2026-02-05',7600),
(306,106,'2026-02-10',17500),
(307,107,'2026-02-12',22000),
(308,108,'2026-02-13',9900),
(309,109,'2026-03-05',19000),
(310,111,'2026-03-11',15500),
(311,112,'2026-03-15',8900),
(312,113,'2026-04-01',15500),
(313,114,'2026-04-03',24000),
(314,115,'2026-05-09',10500),
(315,116,'2026-05-12',21000),
(316,101,'2026-06-01',1000),
(317,103,'2026-07-01',2000),
(318,109,'2026-08-02',3000);


-- ===========================================================================
-- ==============================CONSULTAS====================================
-- ===========================================================================


-- 01. [Básica] Mostrar los nombres y ciudades de todos los clientes.
SELECT nombre, ciudad FROM Clientes;

-- 02. [Básica] Listar clientes de Morelia con edad mayor de 30 años.
SELECT nombre, ciudad, edad FROM Clientes
WHERE edad > 30;

-- 03. [Básica] Mostrar pólizas activas, tipo y prima, ordenadas de mayor a menor prima.
SELECT estado, tipo, prima_anual FROM Polizas
ORDER BY prima_anual DESC;

-- 04. [Básica] Contar cuántos clientes hay por ciudad.
SELECT nombre, COUNT(nombre) AS numero, ciudad FROM Clientes
GROUP BY ciudad;

-- 05. [Básica] Calcular promedio, mínimo y máximo de prima anual por tipo de seguro.
SELECT tipo, 
    AVG(prima_anual) AS promedio, 
    MIN(prima_anual) AS minimo, 
    MAX(prima_anual) AS maximo 
FROM Polizas 
GROUP BY tipo

-- 06. [Intermedia] Listar póliza, nombre del cliente, agente y tipo de seguro.


-- 07. [Intermedia] Calcular el total de primas anuales contratadas por sucursal, incluyendo pólizas canceladas e indicando que es suma nominal contratada, no ingreso cobrado.

-- 08. [Intermedia] Mostrar clientes y su número de pólizas, incluso quienes no tienen pólizas.

-- 09. [Intermedia] Mostrar cada póliza con total efectivamente pagado, incluyendo las que no tienen pagos.

-- 10. [Intermedia] Calcular por tipo el número y monto total de siniestros aprobados.

-- 11. [Subconsulta] Listar pólizas cuya prima anual supera la prima promedio de todas las pólizas.

-- 12. [Subconsulta] Mostrar los clientes con al menos un siniestro aprobado, usando IN.

-- 13. [Subconsulta] Encontrar pólizas que no registran siniestros usando NOT EXISTS.

-- 14. [Subconsulta] Listar clientes cuya edad es superior a la edad promedio de todos los clientes.

-- 15. [Subconsulta] Mostrar las pólizas con prima máxima dentro de su tipo, usando subconsulta correlacionada.

-- 16. [Subconsulta] Listar agentes que gestionan pólizas con prima mayor a 18000 mediante EXISTS.

-- 17. [Subconsulta] Encontrar clientes cuyo total de primas contratadas supera el promedio del total por cliente CON pólizas (una subconsulta en FROM).

-- 18. [Subconsulta] Encontrar sucursales cuyo monto nominal de primas contratadas supera el promedio de las sumas por sucursal.

-- 19. [Reto] Mostrar por cliente el total pagado y total de siniestros aprobados sin multiplicar filas por unir tablas de detalle.

-- 20. [Reto] Calcular por tipo de seguro el cociente: monto reclamado de siniestros aprobados / primas anuales contratadas. Aclarar que es un indicador ilustrativo, NO siniestralidad actuarial real.