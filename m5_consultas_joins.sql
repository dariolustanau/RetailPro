USE Ventas_Tech_DB;

-- antes de empezar con los ejercicios del M5 voy a agregar las tablas que había listado en el M1 

DROP TABLE IF EXISTS proveedores;
DROP TABLE IF EXISTS vendedores;
DROP TABLE IF EXISTS zonas;

CREATE TABLE proveedores (
    id_proveedor INT PRIMARY KEY,
    nombre_proveedor VARCHAR(50) NOT NULL,
    Ubicacion VARCHAR(200)
);

CREATE TABLE vendedores (
    id_vendedor INT PRIMARY KEY,
    nombre_vendedor VARCHAR(50) NOT NULL,
);

CREATE TABLE zonas (
    id_zona INT PRIMARY KEY,
    nombre_zona VARCHAR(50) NOT NULL,
);

INSERT INTO proveedores(id_proveedor, nombre_proveedor, Ubicacion) VALUES 
(1, 'TecnoLogística S.A.', 'Avellaneda'),
(2, 'Insumos Informáticos del Plata', 'La Plata'),
(3, 'Global Hardware Distribuciones', 'CABA');

INSERT INTO vendedores(id_vendedor, nombre_vendedor) VALUES 
(1, 'Marcos Pérez'),
(2, 'Sofia Gomez'),
(3, 'Lucas Fernandez'),
(4, 'Valeria Martinez')

INSERT INTO zonas(id_zona, nombre_zona) VALUES 
(1, 'CABA'),
(2, 'GBA Sur'),
(3, 'GBA Norte'),
(4, 'GBA Oeste');

-- procedo a agregar los datos a la tabla de ventas y a la respectiva vinculación de las claves

ALTER TABLE ventas 
ADD id_vendedor INT,
    id_zona INT;

UPDATE ventas 
SET id_vendedor = (id_venta % 4) + 1;

UPDATE ventas 
SET id_zona = (id_venta % 3) + 2;

ALTER TABLE ventas 
ADD CONSTRAINT FK_ventas_vendedores 
FOREIGN KEY (id_vendedor) REFERENCES vendedores(id_vendedor);

ALTER TABLE ventas 
ADD CONSTRAINT FK_ventas_zonas 
FOREIGN KEY (id_zona) REFERENCES zonas(id_zona);

-- procedo a agregar los datos a la tabla de productos y a la respectiva vinculación de las claves

ALTER TABLE productos 
ADD id_proveedor INT;

UPDATE productos
SET id_proveedor = (id_producto % 3) + 1;

ALTER TABLE productos 
ADD CONSTRAINT FK_productos_proveedores 
FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedor);

-- una vez creadas y completadas las tablas y vinculadas sus claves empiezo con los ejercicios del M5

-- consulta 1

SELECT 
    v.id_venta,
    v.fecha_venta AS Fecha,
    c.nombre AS Cliente,
    z.nombre_zona AS Zona,
    p.nombre_producto AS Producto,
    ct.nombre_categoria AS Categoria,
    vd.nombre_vendedor AS Vendedor,
    v.cantidad AS Cantidad,
    v.precio_unitario AS Precio_unitario,
    (v.cantidad * v.precio_unitario) AS Valor_Total
FROM ventas v 
INNER JOIN clientes c ON v.id_cliente = c.id_cliente
INNER JOIN productos p ON v.id_producto = p.id_producto
INNER JOIN categorias ct ON p.id_categoria = ct.id_categoria
INNER JOIN zonas z ON v.id_zona = z.id_zona
INNER JOIN vendedores vd ON v.id_vendedor = vd.id_vendedor;

-- consulta 2

SELECT 
    c.id_cliente,
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes c
LEFT JOIN ventas v ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;

-- consulta 3

SELECT 
    p.id_producto,
    p.nombre_producto,
    p.id_categoria,
    p.precio
FROM productos p
LEFT JOIN ventas v ON p.id_producto = v.id_producto
WHERE v.id_venta IS NULL;

-- consulta 4
-- para esta consulta tuve que usar IA en su totalidad ya que excedía mis conocimientos o lo visto hasta ahora en el curso

WITH VentasConsolidadas AS (
    SELECT 
        fecha_venta AS fecha, 
        (cantidad * precio_unitario) AS total, 
        'Online' AS canal 
    FROM ventas 
    WHERE id_vendedor IN (1, 2)

    UNION ALL 

    SELECT 
        fecha_venta AS fecha, 
        (cantidad * precio_unitario) AS total, 
        'Presencial' AS canal 
    FROM ventas 
    WHERE id_vendedor IN (3, 4)
)

SELECT 
    canal,
    SUM(total) AS total_facturado
FROM VentasConsolidadas
GROUP BY canal;

