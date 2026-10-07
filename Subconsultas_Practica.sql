DROP TABLE IF EXISTS Siniestros;
DROP TABLE IF EXISTS Polizas;
DROP TABLE IF EXISTS Clientes;


CREATE TABLE Clientes (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    edad INT NOT NULL,
    ciudad VARCHAR(50),
    ingreso_mensual DECIMAL(10,2)
);

CREATE TABLE Polizas (
    id_poliza INT PRIMARY KEY,
    id_cliente INT NOT NULL,
    tipo_seguro VARCHAR(50),
    suma_asegurada DECIMAL(12,2),
    prima_anual DECIMAL(10,2),
    anio_inicio INT,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

CREATE TABLE Siniestros (
    id_siniestro INT PRIMARY KEY,
    id_poliza INT NOT NULL,
    tipo_siniestro VARCHAR(50),
    monto_reclamado DECIMAL(12,2),
    monto_pagado DECIMAL(12,2),
    anio_siniestro INT,
    FOREIGN KEY (id_poliza) REFERENCES Polizas(id_poliza)
);


INSERT INTO Clientes VALUES
(1, 'Ana López', 29, 'Morelia', 28000),
(2, 'Carlos Ramírez', 45, 'Morelia', 42000),
(3, 'María Hernández', 38, 'Uruapan', 35000),
(4, 'José Martínez', 52, 'Pátzcuaro', 50000),
(5, 'Laura García', 33, 'Morelia', 31000),
(6, 'Roberto Sánchez', 61, 'Uruapan', 58000),
(7, 'Patricia Torres', 27, 'Zamora', 25000),
(8, 'Miguel Flores', 48, 'Morelia', 47000),
(9, 'Sofía Mendoza', 41, 'Zamora', 39000),
(10, 'Fernando Ruiz', 36, 'Pátzcuaro', 33000);


INSERT INTO Polizas VALUES
(101, 1, 'Automóvil', 350000, 8500, 2022),
(102, 2, 'Vida', 1000000, 15000, 2020),
(103, 3, 'Gastos Médicos', 750000, 18000, 2021),
(104, 4, 'Vida', 1500000, 22000, 2019),
(105, 5, 'Automóvil', 420000, 9200, 2023),
(106, 6, 'Gastos Médicos', 900000, 24500, 2018),
(107, 7, 'Automóvil', 280000, 7800, 2024),
(108, 8, 'Vida', 1200000, 19500, 2020),
(109, 9, 'Gastos Médicos', 650000, 16500, 2022),
(110, 10, 'Automóvil', 390000, 8800, 2021),
(111, 2, 'Automóvil', 500000, 11000, 2023),
(112, 5, 'Vida', 800000, 12500, 2022),
(113, 8, 'Gastos Médicos', 850000, 21000, 2021),
(114, 3, 'Automóvil', 450000, 9800, 2024);


INSERT INTO Siniestros VALUES
(1001, 101, 'Colisión', 45000, 40000, 2023),
(1002, 103, 'Hospitalización', 120000, 110000, 2022),
(1003, 104, 'Invalidez', 250000, 230000, 2021),
(1004, 105, 'Robo', 150000, 145000, 2024),
(1005, 106, 'Cirugía', 180000, 170000, 2020),
(1006, 108, 'Invalidez', 300000, 280000, 2023),
(1007, 109, 'Hospitalización', 95000, 90000, 2024),
(1008, 110, 'Colisión', 60000, 55000, 2022),
(1009, 111, 'Robo', 200000, 190000, 2024),
(1010, 113, 'Cirugía', 140000, 130000, 2023),
(1011, 101, 'Daños materiales', 30000, 25000, 2024),
(1012, 114, 'Colisión', 70000, 65000, 2025);



SELECT * FROM Clientes;
SELECT * FROM Polizas;
SELECT * FROM Siniestros;



-- Ejercicio 1. Prima superior al promedio
Muestre las pólizas cuya prima anual sea superior al promedio de todas las primas.

SELECT * FROM Polizas  
WHERE prima_anual > (SELECT AVG(prima_anual) FROM Polizas);

Interpretación: Las pólizas que cumplen con esta condición representan un mayor riesgo financiero para la aseguradora, ya que requieren primas más altas, 
lo que podría indicar una mayor probabilidad de siniestros o mayores costos asociados a la cobertura. 
La aseguradora debe evaluar si estas pólizas están adecuadamente valoradas y si los clientes están dispuestos a pagar estas primas más altas.



-- Ejercicio 2. Ingresos superiores al promedio
Muestre nombre, edad, ciudad e ingreso mensual de los clientes cuyo ingreso sea superior al ingreso promedio.

SELECT nombre, edad, ciudad , ingreso_mensual FROM Clientes
WHERE ingreso_mensual > (SELECT AVG(ingreso_mensual) FROM Clientes);

interpretación: Los clientes con ingresos superiores al promedio pueden representar un segmento de mercado más estable y con mayor capacidad de pago.
Esto podría influir en la estrategia de la aseguradora para ofrecer productos financieros más sofisticados o personalizados, 
así como en la evaluación del riesgo asociado a estos clientes, ya que podrían tener menos probabilidades de incumplir con sus pagos de primas.



-- Ejercicio 3. Póliza con prima máxima
Encuentre la póliza que presenta la prima anual más alta.

SELECT * FROM Polizas
WHERE prima_anual = (SELECT MAX(prima_anual) FROM Polizas);

interpretación: La póliza con la prima anual más alta representa un mayor riesgo financiero para la aseguradora, 
lo que podría indicar una mayor probabilidad de siniestros o mayores costos asociados a la cobertura. 
La aseguradora debe evaluar si esta póliza está adecuadamente valorada y si el cliente está dispuesto a pagar una prima tan alta.



-- Ejercicio 4. Póliza con mayor suma asegurada
Muestre id_poliza, tipo_seguro y suma_asegurada de la póliza con mayor suma asegurada.

SELECT id_poliza, tipo_seguro, suma_asegurada FROM Polizas
WHERE suma_asegurada = (SELECT MAX(suma_asegurada) FROM Polizas);

interpretación: La póliza con la mayor suma asegurada representa un riesgo significativo para la aseguradora, 
ya que en caso de un siniestro, el monto a pagar sería considerablemente alto. 
Esto podría indicar que el cliente tiene necesidades de cobertura más extensas o valiosas,
y la aseguradora debe asegurarse de que la prima cobrada sea adecuada para cubrir este riesgo potencial.



-- Ejercicio 5. Clientes que tienen póliza
Obtenga los clientes cuyo id_cliente aparezca en la tabla Polizas. Utilice IN.

SELECT * FROM Clientes
WHERE id_cliente IN (SELECT id_cliente FROM Polizas);

interpretación: Los clientes que tienen pólizas representan una base de clientes activa para la aseguradora. 
Estos clientes ya han demostrado interés en adquirir productos de seguro, 
lo que podría indicar un menor riesgo de incumplimiento en comparación con aquellos que no tienen pólizas. 
La aseguradora puede enfocarse en mantener y fortalecer la relación con estos clientes, 
ofreciendo servicios adicionales o renovaciones de pólizas para asegurar su fidelidad y satisfacción.



-- Ejercicio 6. Clientes con seguro de vida
Muestre nombre y ciudad de los clientes que tengan al menos una póliza de tipo Vida.

SELECT nombre,ciudad FROM Clientes
WHERE id_cliente IN (
    SELECT id_cliente
    FROM Polizas
    WHERE tipo_seguro = 'Vida'
);

interpretación: Los clientes con seguro de vida representan un segmento de mercado importante para la aseguradora, 
ya que estos clientes han demostrado interés en proteger su bienestar a largo plazo. 
La aseguradora debe asegurarse de que estos clientes reciban el servicio adecuado y que las pólizas sean competitivas en el mercado.



-- Ejercicio 7. Clientes con gastos médicos
Muestre nombre, edad y ciudad de los clientes con póliza de Gastos Médicos.

SELECT nombre, edad, ciudad FROM Clientes
WHERE id_cliente IN (
    SELECT id_cliente
    FROM Polizas
    WHERE tipo_seguro = 'Gastos Médicos'
);

interpretación: Los clientes con gastos médicos representan un segmento de mercado importante para la aseguradora, 
ya que estos clientes han demostrado interés en proteger su salud y bienestar. 
La aseguradora debe asegurarse de que estos clientes reciban el servicio adecuado y que las pólizas sean competitivas en el mercado.



-- Ejercicio 8. Clientes cuyas pólizas tienen siniestros
Utilice una subconsulta dentro de otra subconsulta para encontrar clientes asociados a pólizas que aparecen en Siniestros.

SELECT * FROM Clientes
WHERE id_cliente IN (
    SELECT id_cliente FROM Polizas
    WHERE id_poliza IN (
        SELECT id_poliza FROM Siniestros
    )
);

interpretación: Los clientes cuyas pólizas tienen siniestros representan un segmento de mercado que ha experimentado eventos adversos cubiertos por sus seguros. 
La aseguradora debe analizar estos casos para evaluar la frecuencia y gravedad de los siniestros, 
lo que puede influir en la determinación de primas futuras y en la gestión del riesgo. 
Además, es importante mantener una comunicación efectiva con estos clientes para garantizar su satisfacción y fidelidad a largo plazo.



-- Ejercicio 9. Pólizas sin siniestros
Muestre las pólizas cuyo id_poliza no aparezca en la tabla Siniestros. Utilice NOT IN.

SELECT * FROM Polizas
WHERE id_poliza NOT IN (
    SELECT id_poliza FROM Siniestros
);

interpretación: Las pólizas sin siniestros representan un grupo de clientes que no han experimentado eventos adversos durante el período de vigencia de sus seguros. 
Esto puede indicar una menor probabilidad de siniestros en el futuro, lo que podría influir en la determinación de primas y en la gestión del riesgo por parte de la aseguradora.
Además, estos clientes pueden ser considerados como más confiables desde un punto de vista financiero.



-- Ejercicio 10. Clientes con pólizas sin siniestros
Muestre los clientes que tengan al menos una póliza sin registros de siniestro.

SELECT * FROM Clientes
WHERE id_cliente IN (
    SELECT id_cliente FROM Polizas
    WHERE id_poliza NOT IN (
        SELECT id_poliza FROM Siniestros
    )
);

interpretación: Los clientes con pólizas sin siniestros representan un grupo de clientes que han demostrado una menor incidencia de eventos adversos. 
La aseguradora puede considerar estos clientes como más confiables y potencialmente más rentables, 
ya que tienen menos probabilidades de generar siniestros y, por lo tanto, menos costos asociados.



-- Ejercicio 11. Siniestros con pago superior al promedio
Muestre los siniestros cuyo monto_pagado sea mayor que el promedio de monto_pagado.

SELECT * FROM Siniestros
WHERE monto_pagado > (SELECT AVG(monto_pagado) FROM Siniestros);

interpretación: Los siniestros con un monto_pagado superior al promedio representan casos de mayor impacto financiero para la aseguradora. 
Estos siniestros pueden indicar eventos más graves o costosos, lo que podría influir en la evaluación del riesgo y en la determinación de primas futuras. 
La aseguradora debe analizar estos casos para identificar patrones y tomar decisiones informadas sobre la gestión del riesgo y la cobertura ofrecida a los clientes.



-- Ejercicio 12. Siniestro con mayor pago
Obtenga el siniestro con el monto_pagado máximo.

SELECT * FROM Siniestros
WHERE monto_pagado = (SELECT MAX(monto_pagado) FROM Siniestros);

interpretación: El siniestro con el monto_pagado máximo representa un evento de alto impacto financiero para la aseguradora. 
Este caso puede indicar un riesgo significativo asociado a la póliza y al cliente involucrado. 
La aseguradora debe evaluar si la prima cobrada fue adecuada para cubrir este riesgo y considerar ajustes en la política de suscripción o en la determinación de primas 
para clientes con características similares.



-- Ejercicio 13. Cliente asociado al siniestro de mayor pago
Mediante subconsultas anidadas encuentre el cliente asociado al siniestro con mayor monto_pagado.

SELECT * FROM Clientes
WHERE id_cliente = (
    SELECT id_cliente FROM Polizas
    WHERE id_poliza = (
        SELECT id_poliza FROM Siniestros
        WHERE monto_pagado = (SELECT MAX(monto_pagado) FROM Siniestros)
    )
);

interpretación: El cliente asociado al siniestro con el mayor monto_pagado representa un caso de alto riesgo para la aseguradora. 
Este cliente ha experimentado un evento significativo que ha resultado en un pago elevado, 
lo que podría influir en la evaluación del riesgo y en la determinación de primas futuras. 
La aseguradora debe analizar este caso para identificar factores de riesgo y 
considerar ajustes en la política de suscripción o en la cobertura ofrecida a clientes con características similares.



-- Ejercicio 14. EXISTS
Muestre los clientes que tienen al menos una póliza utilizando EXISTS.

SELECT * FROM Clientes
WHERE EXISTS (
    SELECT 1 FROM Polizas
    WHERE Polizas.id_cliente = Clientes.id_cliente
);

interpretación: Los clientes que tienen al menos una póliza representan un grupo activo de asegurados para la compañía. 
La existencia de pólizas indica que estos clientes han confiado en la aseguradora para proteger sus bienes o su bienestar, 
lo que puede reflejar una relación estable y potencialmente rentable. La aseguradora puede enfocarse en mantener y fortalecer esta relación, 
ofreciendo servicios adicionales o renovaciones de pólizas para asegurar la satisfacción y fidelidad del cliente.



-- Ejercicio 15. Clientes con al menos un siniestro
Utilice EXISTS anidado para encontrar clientes cuyas pólizas tengan por lo menos un siniestro.

SELECT * FROM Clientes
WHERE EXISTS (
    SELECT 1 FROM Polizas
    WHERE Polizas.id_cliente = Clientes.id_cliente 
    AND EXISTS (
        SELECT 1 FROM Siniestros
        WHERE Siniestros.id_poliza = Polizas.id_poliza
    )
);

interpretación: Los clientes cuyas pólizas tienen al menos un siniestro representan un grupo que ha experimentado eventos adversos cubiertos por sus seguros. 
La existencia de siniestros puede indicar un mayor riesgo asociado a estos clientes, lo que podría influir en la evaluación del riesgo y en la determinación de primas futuras.
La aseguradora debe analizar estos casos para identificar patrones y tomar decisiones informadas sobre la gestión del riesgo y la cobertura ofrecida a los clientes.



-- Ejercicio 16. NOT EXISTS
Muestre los clientes que no tengan ningún siniestro asociado a sus pólizas.

SELECT * FROM Clientes
WHERE NOT EXISTS (
    SELECT 1 FROM Polizas
    WHERE Polizas.id_cliente = Clientes.id_cliente 
    AND NOT EXISTS (
        SELECT 1 FROM Siniestros
        WHERE Siniestros.id_poliza = Polizas.id_poliza
    )
);

interpretación: Los clientes que no tienen ningún siniestro asociado a sus pólizas representan un grupo de asegurados que han experimentado una menor incidencia de eventos adversos. 
Esto puede indicar un menor riesgo financiero para la aseguradora, ya que estos clientes tienen menos probabilidades de generar siniestros y, 
por lo tanto, menos costos asociados. La aseguradora puede considerar estos clientes como más confiables y potencialmente más rentables, 
lo que podría influir en la determinación de primas y en la gestión del riesgo.



-- Ejercicio 17. Prima superior al promedio de su tipo
Construya una subconsulta correlacionada para identificar las pólizas cuya prima sea superior al promedio del mismo tipo de seguro.

SELECT id_poliza, id_cliente, tipo_seguro, prima_anual FROM Polizas AS p1
WHERE p1.prima_anual > (
    SELECT AVG(p2.prima_anual)
    FROM Polizas AS p2
    WHERE p2.tipo_seguro = p1.tipo_seguro
);

interpretación: Las pólizas cuya prima anual es superior al promedio del mismo tipo de seguro representan un mayor riesgo financiero para la aseguradora. 
Esto podría indicar que estas pólizas están asociadas a clientes con características de riesgo más altas o que requieren coberturas más extensas. 
La aseguradora debe evaluar si estas primas están adecuadamente valoradas y si los clientes están dispuestos a pagar estas primas más altas, 
así como considerar ajustes en la política de suscripción o en la determinación de primas para clientes con características similares.



-- Ejercicio 18. Ingreso superior al promedio de su ciudad
Construya una subconsulta correlacionada para mostrar clientes cuyo ingreso sea superior al promedio de su propia ciudad.

SELECT * FROM Clientes AS c1
WHERE c1.ingreso_mensual > (
    SELECT AVG(c2.ingreso_mensual) 
    FROM Clientes AS c2 
    WHERE c2.ciudad = c1.ciudad
);

interpretación: Los clientes cuyo ingreso mensual es superior al promedio de su propia ciudad representan un grupo de asegurados con un nivel de ingresos
más alto en comparación con sus vecinos. Esto podría indicar una mayor capacidad de pago y, por lo tanto, una menor probabilidad de incumplimiento en el pago de primas. 
La aseguradora puede considerar estos clientes como más confiables y potencialmente más rentables, lo que podría influir en la determinación de primas y en la gestión del riesgo.



-- Ejercicio 19. Subconsulta en FROM
Obtenga la prima promedio por tipo de seguro usando una subconsulta dentro de FROM como tabla derivada.

SELECT tipo_seguro, AVG(prima_anual) AS prima_promedio
FROM (
    SELECT tipo_seguro, prima_anual 
    FROM Polizas
) AS subconsulta
GROUP BY tipo_seguro;

interpretación: La prima promedio por tipo de seguro proporciona información valiosa sobre el riesgo financiero asociado a cada tipo de cobertura.
Los tipos de seguro con primas promedio más altas pueden indicar un mayor riesgo o una mayor probabilidad de siniestros, 
lo que podría influir en la determinación de primas futuras y en la gestión del riesgo por parte de la aseguradora.



-- Ejercicio 20. Comparación contra promedio general
Muestre id_poliza, tipo_seguro, prima_anual y una columna adicional con la prima promedio general.

SELECT id_poliza, tipo_seguro, prima_anual,
    (SELECT AVG(prima_anual) FROM Polizas) AS prima_promedio_anual
FROM Polizas;

interpretación: La comparación de la prima anual de cada póliza contra la prima promedio general permite a la aseguradora identificar pólizas que representan un mayor riesgo financiero.
Las pólizas con primas anuales superiores al promedio general pueden indicar clientes con características de riesgo más altas o que requieren coberturas más extensas.
La aseguradora debe evaluar si estas primas están adecuadamente valoradas y si los clientes están dispuestos a pagar estas primas más altas, 
así como considerar ajustes en la política de suscripción o en la determinación de primas para clientes con características similares.



-- Ejercicio 21. Diferencia contra el promedio
Calcule para cada póliza la diferencia entre prima_anual y la prima promedio general.

SELECT id_poliza, tipo_seguro, prima_anual,
    (SELECT AVG(prima_anual) FROM Polizas) AS prima_promedio_general,
    prima_anual - (SELECT AVG (prima_anual) FROM Polizas) AS diferencia
FROM Polizas;

interpretación: La diferencia entre la prima anual de cada póliza y la prima promedio general permite a la aseguradora identificar pólizas que representan un mayor o menor riesgo financiero en comparación con el promedio.
Las pólizas con diferencias positivas indican que la prima anual es superior al promedio general, lo que podría reflejar un mayor riesgo asociado a estas pólizas. 
Por otro lado, las pólizas con diferencias negativas indican que la prima anual es inferior al promedio general, 
lo que podría reflejar un menor riesgo asociado a estas pólizas. La aseguradora debe evaluar si estas primas están adecuadamente valoradas y si los clientes están dispuestos a pagar estas primas más altas o más bajas, así como considerar ajustes en la política de suscripción o en la determinación de primas para clientes con características similares.



-- -- Ejercicio 22. Interpretación
Seleccione uno de los resultados anteriores y escriba una interpretación breve desde la perspectiva del riesgo actuarial.

SELECT id_poliza, tipo_seguro, prima_anual,
    (SELECT AVG(prima_anual) FROM Polizas) AS prima_promedio_general,
    prima_anual - (SELECT AVG(prima_anual) FROM Polizas) AS diferencia
FROM Polizas
WHERE id_poliza = 101;

interpretación: La póliza con id_poliza 101 tiene una prima anual de 8500, que es inferior a la prima promedio general de todas las pólizas.
Esto podría indicar que esta póliza representa un menor riesgo financiero para la aseguradora en comparación con otras pólizas con primas más altas.



-- Reto 1.Riesgo elevado
Encuentre los clientes que tengan al menos una póliza asociada a un siniestro cuyo monto pagado sea superior al promedio de todos los siniestros.

SELECT *
FROM Clientes
WHERE id_cliente IN (
    SELECT id_cliente
    FROM Polizas
    WHERE id_poliza IN (
        SELECT id_poliza
        FROM Siniestros
        WHERE monto_pagado > (SELECT AVG(monto_pagado) FROM Siniestros)
    )
);

interpretación: Los clientes que tienen al menos una póliza asociada a un siniestro con un monto pagado superior al promedio 
representan un grupo de asegurados con un mayor riesgo financiero para la aseguradora.
Estos clientes han experimentado eventos adversos significativos que han resultado en pagos elevados, 
lo que podría influir en la evaluación del riesgo y en la determinación de primas futuras.
La aseguradora debe analizar estos casos para identificar factores de riesgo y 
considerar ajustes en la política de suscripción o en la cobertura ofrecida a clientes con características similares.


-- Reto 2. Alta exposición
Encuentre los clientes cuya suma asegurada total sea superior a la suma asegurada promedio de todos los clientes. Puede usar GROUP BY dentro de una subconsulta.

SELECT *
FROM Clientes
WHERE id_cliente IN (
    SELECT id_cliente
    FROM Polizas
    GROUP BY id_cliente
    HAVING SUM(suma_asegurada) > 
        (SELECT AVG(total_suma_asegurada) 
        FROM (SELECT SUM(suma_asegurada) AS total_suma_asegurada 
        FROM Polizas 
        GROUP BY id_cliente) AS subconsulta)
);

interpretación: Los clientes cuya suma asegurada total es superior a la suma asegurada promedio de todos los clientes representan 
un grupo de asegurados con una mayor exposición financiera para la aseguradora.
Estos clientes tienen pólizas que cubren montos más altos, lo que podría indicar un mayor riesgo de siniestros significativos y,
por lo tanto, un mayor impacto financiero en caso de reclamaciones.
La aseguradora debe evaluar si estas pólizas están adecuadamente valoradas y si los clientes están dispuestos
a pagar primas más altas para cubrir este riesgo, así como considerar ajustes en la política de suscripción o en la determinación de primas para 
clientes con características similares.



-- Reto 3. Perfil combinado de riesgo
Encuentre clientes con ingreso superior al promedio, al menos una póliza, al menos un siniestro y algún monto_pagado superior al promedio.

SELECT *
FROM Clientes
WHERE ingreso_mensual > (SELECT AVG(ingreso_mensual) FROM Clientes)
    AND id_cliente IN (SELECT id_cliente FROM Polizas)
    AND id_cliente IN (SELECT id_cliente FROM Siniestros)
    AND id_cliente IN (SELECT id_cliente FROM Siniestros 
    WHERE monto_pagado > (SELECT AVG(monto_pagado) FROM Siniestros));


interpretación: Los clientes que cumplen con este perfil combinado de riesgo representan un grupo de asegurados con un mayor riesgo financiero para la aseguradora.
Estos clientes tienen ingresos superiores al promedio, lo que podría indicar una mayor capacidad de pago, pero también tienen al menos una póliza y
al menos un siniestro con un monto pagado superior al promedio, lo que sugiere que han experimentado eventos adversos significativos.
La aseguradora debe analizar estos casos para identificar factores de riesgo y considerar ajustes en la política de suscripción o en la cobertura ofrecida a 
clientes con características similares, así como evaluar la adecuación de las primas cobradas para cubrir este riesgo potencial.


-- Reto 4. Siniestralidad simplificada
Calcule por póliza la razón monto pagado total / prima anual e identifique las pólizas cuya razón sea superior al promedio de las pólizas con siniestros.

SELECT id_poliza, tipo_seguro, prima_anual,
    (SELECT SUM(monto_pagado) FROM Siniestros WHERE Siniestros.id_poliza = Polizas.id_poliza) AS monto_pagado_total,
    (SELECT SUM(monto_pagado) FROM Siniestros WHERE Siniestros.id_poliza = Polizas.id_poliza) / prima_anual AS razon
FROM Polizas
WHERE (SELECT SUM(monto_pagado) FROM Siniestros WHERE Siniestros.id_poliza = Polizas.id_poliza) / prima_anual > 
    (SELECT AVG((SELECT SUM(monto_pagado) FROM Siniestros WHERE Siniestros.id_poliza = Polizas.id_poliza) / prima_anual) 
    FROM Polizas WHERE EXISTS (SELECT 1 FROM Siniestros WHERE Siniestros.id_poliza = Polizas.id_poliza));


interpretación: Las pólizas cuya razón monto pagado total / prima anual es superior al promedio de las pólizas con siniestros representan
un mayor riesgo financiero para la aseguradora.
Esto podría indicar que estas pólizas han experimentado siniestros significativos en relación con las primas cobradas, 
lo que podría influir en la evaluación del riesgo y en la determinación de primas futuras.
La aseguradora debe analizar estos casos para identificar factores de riesgo y considerar ajustes en la política de suscripción
o en la cobertura ofrecida a clientes con características similares.


-- Preguntas de Analisis

1. ¿Qué es una subconsulta?
Una subconsulta es una consulta SQL que se ejecuta dentro de otra consulta SQL. Se utiliza para obtener datos que se necesitan para la consulta principal.


2. ¿En qué orden se ejecuta una consulta que contiene una subconsulta?
La subconsulta se ejecuta primero, y luego la consulta principal utiliza los resultados de la subconsulta para realizar su propia ejecución.


3. ¿Cuándo conviene utilizar IN en lugar de =?
Se recomienda utilizar IN cuando se desea comparar un valor con una lista de valores devueltos por una subconsulta, 
especialmente cuando se espera que la subconsulta devuelva múltiples resultados. 
Por otro lado, se utiliza "=" cuando se espera que la subconsulta devuelva un solo valor.


4. ¿Qué significa EXISTS?
EXISTS es un operador en SQL que se utiliza para verificar si una subconsulta devuelve al menos una fila. 
Si la subconsulta devuelve al menos una fila, EXISTS devuelve true; de lo contrario, devuelve false.


5. ¿Qué diferencia existe entre EXISTS y NOT EXISTS?
EXISTS ayuda a determinar si una subconsulta devuelve al menos una fila, mientras que NOT EXISTS verifica si la subconsulta no devuelve ninguna fila.


6. ¿Qué es una subconsulta correlacionada?
Una subconsulta correlacionada es una subconsulta que hace referencia a una columna de la consulta principal.
Esto significa que la subconsulta depende de la consulta principal para su ejecución, y se evalúa para cada fila de la consulta principal.


7. ¿Por qué el promedio de una subconsulta correlacionada puede cambiar para cada registro?
El promedio de una subconsulta correlacionada puede cambiar para cada registro porque la subconsulta se evalúa en el contexto de cada fila de la consulta principal.
Esto significa que los valores utilizados para calcular el promedio pueden variar según los datos de la fila actual, lo que resulta en un promedio diferente para cada registro de la consulta principal.


8. ¿Qué ventaja ofrece una subconsulta dentro de FROM?
Una subconsulta dentro de FROM, también conocida como tabla derivada, permite crear un conjunto de resultados temporal que puede ser tratado como una tabla para la consulta principal.
Esto ofrece la ventaja de simplificar consultas complejas, permitiendo realizar agregaciones, filtrados o uniones sobre los resultados de la subconsulta antes de que se utilicen en la consulta principal.


9. ¿Qué utilidad tienen las subconsultas en el análisis actuarial?
Las subconsultas son útiles en el análisis actuarial porque permiten realizar cálculos y comparaciones complejas sobre los datos de seguros y clientes.
Pueden ayudar a identificar patrones de riesgo, evaluar la rentabilidad de pólizas, analizar la frecuencia y gravedad de siniestros, y tomar decisiones informadas sobre la determinación de primas y la gestión del riesgo.


10. ¿Cómo usaría las subconsultas para detectar clientes o pólizas de mayor riesgo?
Para detectar clientes o pólizas de mayor riesgo utilizando subconsultas, se pueden realizar las siguientes acciones:
- Identificar pólizas con primas superiores al promedio de su tipo de seguro, lo que podría indicar un mayor riesgo financiero.
- Analizar clientes con ingresos superiores al promedio de su ciudad, lo que podría reflejar una mayor capacidad de pago y menor riesgo de incumplimiento.
- Evaluar clientes cuyas pólizas tengan siniestros, ya que esto podría indicar un mayor riesgo asociado a estos clientes.
- Comparar el monto_pagado de siniestros con el promedio, para identificar casos de alto impacto financiero y evaluar la probabilidad de futuros siniestros.


