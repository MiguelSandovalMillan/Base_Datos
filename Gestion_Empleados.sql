DROP TABLE IF EXISTS empleado;
DROP TABLE IF EXISTS departamento;


-- ===========================================================================
-- ===========================CREAR_TABLAS====================================
-- ===========================================================================


CREATE TABLE departamento (
codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
presupuesto DOUBLE UNSIGNED NOT NULL,
gastos DOUBLE UNSIGNED NOT NULL
);

CREATE TABLE empleado (
codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nif VARCHAR(9) NOT NULL UNIQUE,
nombre VARCHAR(100) NOT NULL,
apellido1 VARCHAR(100) NOT NULL,
apellido2 VARCHAR(100),
codigo_departamento INT UNSIGNED,
FOREIGN KEY (codigo_departamento) REFERENCES departamento(codigo)
);



-- ===========================================================================
-- =========================INSERTAR_DATOS====================================
-- ===========================================================================


INSERT INTO departamento VALUES
(1, 'Desarrollo', 120000, 6000),
(2, 'Sistemas', 150000, 21000),
(3, 'Recursos Humanos', 280000, 25000),
(4, 'Contabilidad', 110000, 3000),
(5, 'I+D', 375000, 380000),
(6, 'Proyectos', 0, 0),
(7, 'Publicidad', 0, 1000);


INSERT INTO empleado VALUES
(1, '32481596F', 'Aarón', 'Rivero', 'Gómez', 1),
(2, 'Y5575632D', 'Adela', 'Salas', 'Díaz', 2),
(3, 'R6970642B', 'Adolfo', 'Rubio', 'Flores', 3),
(4, '77705545E', 'Adrián', 'Suárez', NULL, 4),
(5, '17087203C', 'Marcos', 'Loyola', 'Méndez', 5),
(6, '38382980M', 'María', 'Santana', 'Moreno', 1),
(7, '80576669X', 'Pilar', 'Ruiz', NULL, 2),
(8, '71651431Z', 'Pepe', 'Ruiz', 'Santana', 3),
(9, '56399183D', 'Juan', 'Gómez', 'López', 2),
(10, '46384486H', 'Diego','Flores', 'Salas', 5),
(11, '67389283A', 'Marta','Herrera', 'Gil', 1),
(12, '41234836R', 'Irene','Salas', 'Flores', NULL),
(13, '82635162B', 'Juan Antonio','Sáez', 'Guerrero', NULL);



-- ===========================================================================
-- ====================CONSULTAS_SOBRE_UNA_TABLA==============================
-- ===========================================================================



-- Lista el primer apellido de todos los empleados.
SELECT apellido1 FROM empleado;


-- Lista el primer apellido de los empleados eliminando los apellidos que estén repetidos.
SELECT DISTINCT apellido1 FROM empleado;


-- Lista todas las columnas de la tabla empleado.
SELECT * FROM empleado;


-- Lista el nombre y los apellidos de todos los empleados.
SELECT nombre, apellido1, apellido2 FROM empleado;


-- Lista el código de los departamentos de los empleados que aparecen en la tabla empleado.
SELECT codigo_departamento FROM empleado;


-- Lista el código de los departamentos de los empleados que aparecen en la tabla empleado, eliminando los códigos que aparecen repetidos.
SELECT DISTINCT codigo_departamento FROM empleado;


-- Lista el nombre y apellidos de los empleados en una única columna.
SELECT nombre || ' ' || apellido1 || ' ' || apellido2 AS nombre_completo FROM empleado;


-- Lista el nombre y apellidos de los empleados en una única columna, convirtiendo todos los caracteres en mayúscula.
SELECT UPPER(nombre || ' ' || apellido1 || ' ' || apellido2) AS nombre_completo FROM empleado;


-- Lista el nombre y apellidos de los empleados en una única columna, convirtiendo todos los caracteres en minúscula.
SELECT LOWER(nombre || ' ' || apellido1 || ' ' || apellido2) AS nombre_completo FROM empleado;


-- Lista el código de los empleados junto al nif, pero el nif deberá aparecer en dos columnas, una mostrará únicamente los dígitos del nif y la otra la letra.
SELECT codigo, SUBSTR(nif, 1, 8), SUBSTR(nif, 9, 9) FROM empleado;


-- Lista el nombre de cada departamento y el valor del presupuesto actual del que dispone. Para
-- calcular este dato tendrá que restar al valor del presupuesto inicial (columna presupuesto) los gastos
-- que se han generado (columna gastos). Tenga en cuenta que en algunos casos pueden existir valores
-- negativos. Utilice un alias apropiado para la nueva columna que está calculando.
SELECT nombre, (presupuesto - gastos) AS 'presupuesto actual' FROM Departamento;


-- Lista el nombre de los departamentos y el valor del presupuesto actual ordenado de forma ascendente.
SELECT nombre, presupuesto - gastos AS presupuesto_actual FROM departamento
ORDER BY presupuesto_actual ASC;

SELECT nombre, presupuesto - gastos AS presupuesto_actual FROM departamento
ORDER BY presupuesto - gastos ASC;

SELECT nombre, presupuesto - gastos AS presupuesto_actual FROM departamento
ORDER BY 2;


-- Lista el nombre de todos los departamentos ordenados de forma ascendente.
SELECT nombre FROM departamento
ORDER BY nombre ASC;


-- Lista el nombre de todos los departamentos ordenados de forma descendente.
SELECT nombre FROM departamento
ORDER BY nombre DESC;


-- Lista los apellidos y el nombre de todos los empleados, ordenados de forma alfabética tendiendo en cuenta en primer lugar sus apellidos y luego su nombre.
SELECT apellido1, apellido2, nombre FROM empleado
ORDER BY apellido1, apellido2, nombre ASC;


-- Devuelve una lista con el nombre y el presupuesto, de los 3 departamentos que tienen mayor presupuesto.
SELECT nombre, presupuesto FROM departamento
ORDER BY presupuesto DESC
LIMIT 3;


-- Devuelve una lista con el nombre y el presupuesto, de los 3 departamentos que tienen menor presupuesto.
SELECT nombre, presupuesto FROM departamento
LIMIT 3;


-- Devuelve una lista con el nombre y el gasto, de los 2 departamentos que tienen mayor gasto.
SELECT nombre, gastos FROM departamento
ORDER BY gastos DESC
LIMIT 2;


-- Devuelve una lista con el nombre y el gasto, de los 2 departamentos que tienen menor gasto.
SELECT nombre, gastos FROM departamento
ORDER BY gastos ASC


-- Devuelve una lista con 5 filas a partir de la tercera fila de la tabla empleado. La tercera fila se debe
-- incluir en la respuesta. La respuesta debe incluir todas las columnas de la tabla empleado.
SELECT * FROM empleado
LIMIT 2, 5;


-- Devuelve una lista con el nombre de los departamentos y el presupuesto, de aquellos que tienen un
-- presupuesto mayor o igual a 150000 euros.
SELECT nombre, presupuesto FROM departamento
WHERE presupuesto >= 150000;


-- Devuelve una lista con el nombre de los departamentos y el gasto, de aquellos que tienen menos de 5000 euros de gastos.
SELECT nombre, gastos FROM departamento
WHERE gastos > 5000;


-- Devuelve una lista con el nombre de los departamentos y el presupesto, de aquellos que tienen un 
-- presupuesto entre 100000 y 200000 euros. Sin utilizar el operador BETWEEN.
SELECT nombre, presupuesto FROM departamento
WHERE presupuesto >= 100000 AND presupuesto <= 200000;


-- Devuelve una lista con el nombre de los departamentos que no tienen un presupuesto entre 100000 y 200000 euros. Sin utilizar el operador BETWEEN.
SELECT nombre, presupuesto FROM departamento
WHERE NOT (presupuesto >= 100000 AND presupuesto <= 200000);

SELECT nombre, presupuesto FROM departamento
WHERE presupuesto < 100000 OR presupuesto > 200000;


-- Devuelve una lista con el nombre de los departamentos que tienen un presupuesto entre 100000 y 200000 euros. Utilizando el operador BETWEEN.
SELECT nombre, presupuesto FROM departamento
WHERE presupuesto BETWEEN 100000 AND 200000;


-- Devuelve una lista con el nombre de los departamentos que no tienen un presupuesto entre 100000 y 200000 euros. Utilizando el operador BETWEEN.
SELECT nombre, presupuesto FROM departamento
WHERE presupuesto NOT BETWEEN 100000 AND 200000;


-- Devuelve una lista con el nombre de los departamentos, gastos y presupuesto, de quellos
-- departamentos donde los gastos sean mayores que el presupuesto del que disponen.
SELECT nombre, gastos, presupuesto FROM departamento
WHERE gastos > presupuesto;


-- Devuelve una lista con el nombre de los departamentos, gastos y presupuesto, de aquellos departamentos donde los gastos sean mayores que el presupuesto del que disponen.
SELECT nombre, gastos, presupuesto FROM departamento
WHERE gastos < Presupuesto;


-- Devuelve una lista con el nombre de los departamentos, gastos y presupuesto, de aquellos departamentos 
-- donde los gastos sean iguales al presupuesto del que disponen.
SELECT nombre, gastos, presupuesto FROM departamento
WHERE gastos = Presupuesto;


-- Lista todos los datos de los empleados cuyo segundo apellido sea NULL.
SELECT * FROM empleado
WHERE apellido2 IS NULL;


-- Lista todos los datos de los empleados cuyo segundo apellido no sea NULL.
SELECT * FROM empleado
WHERE apellido2 IS NOT NULL;


-- Lista todos los datos de los empleados cuyo segundo apellido sea López.
SELECT * FROM empleado 
WHERE apellido2 = 'López';


-- Lista todos los datos de los empleados cuyo segundo apellido sea Díaz o Moreno. Sin utilizar el operador IN.
SELECT * FROM empleado
WHERE apellido2 = 'Díaz' OR apellido2 = 'Moreno';


-- Lista todos los datos de los empleados cuyo segundo apellido sea Díaz o Moreno. Utilizando el operador IN.
SELECT * FROM empleado 
WHERE apellido2 IN ('Díaz','Moreno');


-- Lista los nombres, apellidos y nif de los empleados que trabajan en el departamento 3.
SELECT nombre, apellido1, apellido2, nif FROM empleado
WHERE codigo_departamento = 3;


-- Lista los nombres, apellidos y nif de los empleados que trabajan en los departamentos 2, 4 o 5.
SELECT nombre, apellido1, apellido2, nif FROM empleado
WHERE codigo_departamento = 2 OR codigo_departamento = 4 OR codigo_departamento = 5;

SELECT nombre, apellido1, apellido2, nif FROM empleado
WHERE codigo_departamento IN (2, 4, 5);



-- ===========================================================================
-- ==============CONSULTAS_MULTITABLA(composicion interna)====================
-- ===========================================================================



-- Devuelve un listado con los empleados y los datos de los departamentos donde trabaja cada uno.
SELECT * FROM empleado 
INNER JOIN departamento ON empleado.departamento = departamento.Codigo


-- Devuelve un listado con los empleados y los datos de los departamentos donde trabaja cada uno.
-- Ordena el resultado, en primer lugar por el nombre del departamento (en orden alfabético) y en
-- segundo lugar por los apellidos y el nombre de los empleados.
SELECT p.*, c.*
FROM pedido AS p 
INNER JOIN cliente AS c ON p.id_cliente = c.id
ORDER BY c.nombre ASC;


-- Devuelve un listado que muestre todos los pedidos en los que ha participado un comercial. El
-- resultado debe mostrar todos los datos de los pedidos y de los comerciales. El listado debe mostrar
-- los datos de los comerciales ordenados alfabéticamente.
SELECT p.*, co.*
FROM pedido AS p INNER JOIN comercial AS co ON p.id_comercial = co.id;


-- Devuelve un listado que muestre todos los clientes, con todos los pedidos que han realizado y con
-- los datos de los comerciales asociados a cada pedido.
SELECT c.*, p.*, co.*
FROM cliente AS c 
INNER JOIN pedido AS p ON c.id = p.id_cliente 
INNER JOIN comercial AS co ON co.id = p.id_comercial;


-- Devuelve un listado de todos los clientes que realizaron un pedido durante el año 2017, cuya
-- cantidad esté entre 300 € y 1000 €.
SELECT c.*, p.fecha
FROM pedido AS p 
INNER JOIN cliente AS c ON p.id_cliente = c.id
WHERE fecha LIKE '%2017%' AND total BETWEEN 300 AND 1000;


--  Devuelve el nombre y los apellidos de todos los comerciales que han participado en algún pedido
-- realizado por María Santana Moreno.
SELECT c.nombre, c.apellido1, c.apellido2
FROM pedido AS p 
INNER JOIN comercial AS c ON p.id_comercial = c.id 
INNER JOIN cliente cli ON p.id_cliente = cli.id 
WHERE cli.nombre = "María" AND cli.apellido1 = "Santana" AND cli.apellido2 = "Moreno";


-- Devuelve el nombre de todos los clientes que han realizado algún pedido con el comercial Daniel Sáez Vega.
SELECT c.nombre, c.apellido1, c.apellido2
FROM pedido AS p 
INNER JOIN cliente AS c ON p.id_cliente = c.id 
INNER JOIN comercial AS co ON co.id = p.id_comercial
WHERE co.nombre = "Daniel" AND co.apellido1 = "Sáez" AND co.apellido2 = "Vega";



-- ===========================================================================
-- ==============CONSULTAS_MULTITABLA(composicion externa)====================
-- ===========================================================================



-- Devuelve un listado con todos los clientes junto con los datos de los pedidos que han realizado.
-- Este listado también debe incluir los clientes que no han realizado ningún pedido. El listado debe
-- estar ordenado alfabéticamente por el primer apellido, segundo apellido y nombre de los clientes.
SELECT * FROM cliente AS C 
LEFT JOIN pedido AS P On C.id=P.id_cliente
ORDER BY C.apellido1, C.apellido2, C.nombre;


-- Devuelve un listado con todos los comerciales junto con los datos de los pedidos que han
-- realizado. Este listado también debe incluir los comerciales que no han realizado ningún pedido. El
-- listado debe estar ordenado alfabéticamente por el primer apellido, segundo apellido y nombre de
-- los comerciales.
SELECT * FROM comercial AS C 
LEFT JOIN pedido AS P On C.id=P.id_comercial
ORDER BY C.apellido1, C.apellido2, C.nombre;


-- Devuelve un listado que solamente muestre los clientes que no han realizado ningún pedido.
SELECT * FROM cliente AS C 
LEFT JOIN pedido AS P ON C.id=P.id_cliente
WHERE P.id_cliente IS NULL;


-- Devuelve un listado que solamente muestre los comerciales que no han realizado ningún pedido.
SELECT * FROM comercial AS C 
LEFT JOIN pedido AS P On C.id=P.id_comercial
WHERE P.id IS NULL;


-- Devuelve un listado con los clientes que no han realizado ningún pedido y de los comerciales que
-- no han participado en ningún pedido. Ordene el listado alfabéticamente por los apellidos y el nombre
-- En el listado deberá diferenciar de algún modo los clientes y los comerciales.
SELECT * FROM cliente CL 
RIGHT JOIN pedido AS P ON CL.id = P.id_cliente 
RIGHT JOIN comercial AS C ON C.id = P.id_comercial
WHERE P.id IS NULL
ORDER BY CL.apellido1, CL.nombre, C.apellido1, C.nombre;


-- ¿Se podrían realizar las consultas anteriores con NATURAL LEFT JOIN o NATURAL RIGHT JOIN? Justifique su respuesta.
-- R= No, puesto que para poder utilizar NATURAL, los campos tienen que aparecer con los mismos nombres en ambas tablas.




-- ===========================================================================
-- =========================CONSULTAS_RESUMEN=================================
-- ===========================================================================



-- Calcula la cantidad total que suman todos los pedidos que aparecen en la tabla pedido.
SELECT COUNT(*) FROM pedido;


-- Calcula la cantidad media de todos los pedidos que aparecen en la tabla pedido.
SELECT AVG(total) FROM pedido;


-- Calcula el número total de comerciales distintos que aparecen en la tabla pedido.
SELECT DISTINCT COUNT(id) FROM pedido;


-- Calcula el número total de clientes que aparecen en la tabla cliente.
SELECT COUNT(*) FROM cliente;


-- Calcula cuál es la mayor cantidad que aparece en la tabla pedido.
SELECT MAX(total) FROM pedido;


-- Calcula cuál es la menor cantidad que aparece en la tabla pedido.
SELECT LOWER(total) FROM pedido
ORDER BY total ASC
LIMIT 1;


-- Calcula cuál es el valor máximo de categoría para cada una de las ciudades que aparece en la tabla cliente.
SELECT MAX(categoría) AS maximo ,ciudad FROM cliente
GROUP BY ciudad;


-- Calcula cuál es el máximo valor de los pedidos realizados durante el mismo día para cada uno de
-- los clientes. Es decir, el mismo cliente puede haber realizado varios pedidos de diferentes
-- cantidades el mismo día. Se pide que se calcule cuál es el pedido de máximo valor para cada uno de
-- los días en los que un cliente ha realizado un pedido. Muestra el identificador del cliente, nombre,
-- apellidos, la fecha y el valor de la cantidad.
SELECT P.id_cliente,CL.nombre,CL.apellido1,CL.apellido2,fecha,MAX(total)
FROM pedido AS P 
INNER JOIN cliente CL ON P.id_cliente=CL.id
GROUP BY fecha;


-- Calcula cuál es el máximo valor de los pedidos realizados durante el mismo día para cada uno de
-- los clientes, teniendo en cuenta que sólo queremos mostrar aquellos pedidos que superen la cantidad de 2000 €.
SELECT P.id_cliente,CL.nombre,CL.apellido1,CL.apellido2,fecha,MAX(total) FROM pedido AS P 
INNER JOIN cliente CL ON P.id_cliente=CL.id
WHERE total > 2000
GROUP BY fecha;


-- Calcula el máximo valor de los pedidos realizados para cada uno de los comerciales durante la
-- fecha 2016-08-17. Muestra el identificador del comercial, nombre, apellidos y total.
SELECT P.id_comercial,C.nombre,C.apellido1,C.apellido2,MAX(total)
FROM pedido P
INNER JOIN comercial C ON P.id_comercial=C.id
WHERE fecha='2016-08-17';


-- Devuelve un listado que muestre el identificador de cliente, nombre, primer apellido y el valor de
-- la máxima cantidad del pedido realizado por cada uno de los clientes. El resultado debe mostrar
-- aquellos clientes que no han realizado ningún pedido indicando que la máxima cantidad de sus
-- pedidos realizados es 0. Puede hacer uso de la función IFNULL.
SELECT cl.id AS id_cliente,cl.nombre,cl.apellido1,IFNULL(MAX(p.total),0) FROM pedido AS p
RIGHT JOIN cliente cl ON cl.id = p.id_cliente
GROUP BY cl.id;


-- ===========================================================================
-- ==============================SUBCONSULTAS=================================
-- ===========================================================================



-- Devuelve un listado con todos los pedidos que ha realizado Adela Salas Díaz. (Sin utilizar INNER JOIN).
SELECT pedido.* FROM pedido
WHERE id_cliente = (SELECT id FROM cliente WHERE nombre = 'Adela' AND apellido1 = 'Salas' AND apellido2 = 'Díaz');


-- Devuelve el número de pedidos en los que ha participado el comercial Daniel Sáez Vega. (Sin utilizar INNER JOIN)
SELECT count(*) FROM pedido
WHERE id_comercial = (SELECT id FROM comercial WHERE nombre = 'Daniel' AND apellido1 = 'Sáez' AND apellido2 = 'Vega');


-- Devuelve los datos del cliente que realizó el pedido más caro en el año 2019. (Sin utilizar INNER JOIN)
SELECT cliente.* FROM cliente
WHERE id = (SELECT id_cliente FROM pedido WHERE total = (SELECT MAX(total)
FROM pedido
WHERE FECHA LIKE '%2019%'));


-- Devuelve la fecha y la cantidad del pedido de menor valor realizado por el cliente Pepe Ruiz Santana.
SELECT Fecha, min(total)
FROM pedido
WHERE id_cliente = (SELECT id FROM cliente WHERE nombre = "Pepe" AND apellido1 = "Ruiz" AND apellido2 = 'Santana');


-- Devuelve un listado con los datos de los clientes y los pedidos, de todos los clientes que han
-- realizado un pedido durante el año 2017 con un valor mayor o igual al valor medio de los pedidos
-- realizados durante ese mismo año.
SELECT * FROM cliente join pedido on cliente.id = pedido.id_cliente
WHERE year(fecha) = 2017 && total >= (SELECT AVG(total) FROM pedido WHERE year(fecha) = 2017);




-- ===========================================================================
-- =========================SUBCONSULTAS(ALL y ANY============================
-- ===========================================================================



-- Devuelve el pedido más caro que existe en la tabla pedido si hacer uso de MAX, ORDER BY ni LIMIT.
SELECT * FROM pedido AS a
INNER JOIN (SELECT min(-1*precio) AS precio_maximo FROM pedido) AS b ON a.precio = b.precio_maximo


-- Devuelve un listado de los clientes que no han realizado ningún pedido. (Utilizando ANY o ALL).
SELECT * FROM oficinas
WHERE (objetivo * 0.5) <= ALL (SELECT ventas FROM empleados WHERE empleados.oficina = oficinas.oficina AND ventas IS NOT NULL);


-- Devuelve un listado de los comerciales que no han realizado ningún pedido. (Utilizando ANY o ALL).
SELECT * FROM oficinas
WHERE objetivo > ( SELECT SUM(cuota) FROM empleados WHERE empleados.oficina = oficinas.oficina);