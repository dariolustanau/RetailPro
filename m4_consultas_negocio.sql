USE Ventas_Tech_DB

SELECT * FROM ventas



SELECT 
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(id_venta) AS cantidad_pedidos,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta);



SELECT TOP 5 
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_generado
FROM ventas
GROUP BY id_producto
ORDER BY total_generado DESC;



SELECT 
    id_cliente,
    COUNT(*) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1;


-- para este ejercicio final de la práctica necesite utilizar la IA en su totalidad, a diferencia del resto
WITH ResumenMensual AS (
    SELECT 
        MONTH(fecha_venta) AS mes,
        SUM(cantidad * precio_unitario) AS total_facturado
    FROM ventas
    GROUP BY MONTH(fecha_venta)
)
SELECT 
    mes,
    total_facturado,
    CASE 
        WHEN total_facturado >= (SELECT AVG(total_facturado) FROM ResumenMensual) THEN 'Por encima'
        ELSE 'Por debajo'
    END AS comparacion_promedio
FROM ResumenMensual;


-- 1. El producto 1 (Laptop Pro 15) concentra la mayor proporción de la facturación total debido a su elevado precio unitario.
-- 2. El artículo con mayor rotación en unidades presenta un bajo impacto en la facturación, lo que sugiere una oportunidad para revisar su estrategia de precios o márgenes.
-- 3. Los clientes ID 1 y ID 5 representan los segmentos de mayor ticket acumulado, posicionándose como los compradores más valiosos del periodo analizado.
