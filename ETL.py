import sqlite3

con = sqlite3.connect(":memory:")
cur = con.cursor()

cur.executescript("""


CREATE TABLE ventas_origen
(id INTEGER PRIMARY KEY, 
producto TEXT, 
cantidad INTEGER, 
precio REAL);


CREATE TABLE ventas_limpias(
id INTEGER PRIMARY KEY, 
producto TEXT NOT NULL,
cantidad INTEGER NOT NULL CHECK(cantidad>0), 
precio REAL NOT NULL CHECK(precio>0),
total REAL NOT NULL);


CREATE TABLE inventario(producto TEXT PRIMARY KEY,
existencias INTEGER NOT NULL CHECK(existencias>=0));


INSERT INTO ventas_origen VALUES
(1,'Laptop',2,12500),
(2,'Mouse',5,250),
(3,'Teclado',-3,450),
(4,'Monitor',3,3200),
(5,'Laptop',2,12500),
(6,'USB',10,0),
(7,'Impresora',1,2800),
(8,'Mouse',4,250),(9,'Webcam',2,850),
(10,'Bocinas',-1,600);


INSERT INTO inventario VALUES
('Laptop',10),('Mouse',20),('Monitor',8),('Impresora',5),('Webcam',10);

""")
con.commit()

print(cur.execute("SELECT * FROM ventas_origen").fetchall())



# TODO 1: detectar errores y duplicados.
print("\n ERRORES")
errores = cur.execute("SELECT * FROM ventas_origen WHERE cantidad <= 0 OR precio <= 0").fetchall()
for row in errores: print(row)


print("\n DUPLICADOS")
duplicados = cur.execute("""
    SELECT producto, cantidad, precio, COUNT(*) AS repeticiones
    FROM ventas_origen
    GROUP BY producto, cantidad, precio
    HAVING COUNT(*) > 1;
""").fetchall()
for row in duplicados: print(row)

# TODO 2: transformar y cargar ventas validas.
# TRASFORMACION
cur.execute("""
    INSERT INTO ventas_limpias (id, producto, cantidad, precio, total)
    SELECT MIN(id), producto, cantidad, precio, (cantidad * precio)
    FROM ventas_origen
    WHERE cantidad > 0 AND precio > 0
    GROUP BY producto, cantidad, precio;
""")
con.commit()

print("\n--- VENTAS LIMPIAS (Tabla Transformada) ---")
for row in cur.execute("SELECT * FROM ventas_limpias").fetchall(): print(row)

# Resumen ETL
cargados = cur.execute("SELECT COUNT(*) FROM ventas_limpias").fetchone()[0]
rechazados = len(errores)
dups_omitidos = cur.execute("SELECT COUNT(*) FROM ventas_origen").fetchone()[0] - cargados - rechazados
importe_total = cur.execute("SELECT SUM(total) FROM ventas_limpias").fetchone()[0]
mayor_importe = cur.execute("SELECT producto, SUM(total) FROM ventas_limpias GROUP BY producto ORDER BY SUM(total) DESC LIMIT 1").fetchone()

print("\n--- RESUMEN ETL ---")
print(f"Registros cargados: {cargados}")
print(f"Registros rechazados: {rechazados}")
print(f"Duplicados omitidos: {dups_omitidos}")
print(f"Importe Total Acumulado: ${importe_total:,.2f}")
print(f"Producto con mayor importe: {mayor_importe[0]} (${mayor_importe[1]:,.2f})")


# TODO 3: transaccion correcta (con.commit()).
print("\n--- TRANSACCIÓN: Venta de 3 Laptops ---")
print("Inventario antes:", cur.execute("SELECT existencias FROM inventario WHERE producto='Laptop'").fetchone()[0])
try:
    cur.execute("BEGIN TRANSACTION;")
    # Comprobar existencias antes de actualizar
    stock = cur.execute("SELECT existencias FROM inventario WHERE producto='Laptop'").fetchone()[0]
    if stock >= 3:
        cur.execute("UPDATE inventario SET existencias = existencias - 3 WHERE producto='Laptop'")
        con.commit()
        print("Venta exitosa. Transacción confirmada (COMMIT).")
    else:
        con.rollback()
except Exception:
    con.rollback()
print("Inventario después:", cur.execute("SELECT existencias FROM inventario WHERE producto='Laptop'").fetchone()[0])



# TODO 4: transaccion fallida (con.rollback()).
print("\n--- TRANSACCIÓN: Venta de 50 Laptops ---")
print("Inventario antes:", cur.execute("SELECT existencias FROM inventario WHERE producto='Laptop'").fetchone()[0])
try:
    cur.execute("BEGIN TRANSACTION;")
    stock = cur.execute("SELECT existencias FROM inventario WHERE producto='Laptop'").fetchone()[0]
    if stock >= 50:
        cur.execute("UPDATE inventario SET existencias = existencias - 50 WHERE producto='Laptop'")
        con.commit()
    else:
        print("Error: Existencias insuficientes. Revirtiendo cambios (ROLLBACK).")
        con.rollback()
except sqlite3.IntegrityError:
    # Capturaría el error del CHECK(existencias>=0) si la base de datos lo forzara
    con.rollback()
print("Inventario después:", cur.execute("SELECT existencias FROM inventario WHERE producto='Laptop'").fetchone()[0])