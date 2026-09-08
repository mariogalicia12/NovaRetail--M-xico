-- =============================================================================
-- PROYECTO: NovaRetail México
-- ARCHIVO: 04_analisis.sql
-- OBJETIVO:
-- Consultas de análisis de negocio para evaluar clientes, productos,
-- empleados, sucursales e inventario.
-- =============================================================================


-- =============================================================================
-- 1. ANÁLISIS DE CLIENTES
-- =============================================================================

-- 1.1 Total de compras por cliente
SELECT
    dim_clientes.id_cliente,
    dim_clientes.nombre_cliente,
    COUNT(fact_ventas.id_venta) AS total_compras
FROM dim_clientes
INNER JOIN fact_ventas
    ON dim_clientes.id_cliente = fact_ventas.id_cliente
GROUP BY
    dim_clientes.id_cliente,
    dim_clientes.nombre_cliente
ORDER BY total_compras DESC;


-- 1.2 Clientes con mayor gasto acumulado
SELECT
    dim_clientes.id_cliente,
    dim_clientes.nombre_cliente,
    SUM(fact_ventas.monto_total) AS monto_total_compras
FROM dim_clientes
INNER JOIN fact_ventas
    ON dim_clientes.id_cliente = fact_ventas.id_cliente
GROUP BY
    dim_clientes.id_cliente,
    dim_clientes.nombre_cliente
ORDER BY monto_total_compras DESC;


-- 1.3 Ticket promedio por cliente
SELECT
    dim_clientes.id_cliente,
    dim_clientes.nombre_cliente,
    AVG(fact_ventas.monto_total) AS ticket_promedio
FROM dim_clientes
INNER JOIN fact_ventas
    ON dim_clientes.id_cliente = fact_ventas.id_cliente
GROUP BY
    dim_clientes.id_cliente,
    dim_clientes.nombre_cliente
ORDER BY ticket_promedio DESC;


-- 1.4 Top 10 clientes con mayor frecuencia de compra
SELECT
    dim_clientes.id_cliente,
    dim_clientes.nombre_cliente,
    COUNT(fact_ventas.id_venta) AS frecuencia_compra
FROM dim_clientes
INNER JOIN fact_ventas
    ON dim_clientes.id_cliente = fact_ventas.id_cliente
GROUP BY
    dim_clientes.id_cliente,
    dim_clientes.nombre_cliente
ORDER BY frecuencia_compra DESC
LIMIT 10;


-- 1.5 Top 10 clientes por monto total de compra
SELECT
    dim_clientes.id_cliente,
    dim_clientes.nombre_cliente,
    SUM(fact_ventas.monto_total) AS monto_total_compras
FROM dim_clientes
INNER JOIN fact_ventas
    ON dim_clientes.id_cliente = fact_ventas.id_cliente
GROUP BY
    dim_clientes.id_cliente,
    dim_clientes.nombre_cliente
ORDER BY monto_total_compras DESC
LIMIT 10;


-- 1.6 Evolución anual de compras por cliente
SELECT
    dim_clientes.id_cliente,
    dim_clientes.nombre_cliente,
    EXTRACT(YEAR FROM fact_ventas.fecha_venta) AS año,
    SUM(fact_ventas.monto_total) AS ventas_totales
FROM dim_clientes
INNER JOIN fact_ventas
    ON dim_clientes.id_cliente = fact_ventas.id_cliente
GROUP BY
    dim_clientes.id_cliente,
    dim_clientes.nombre_cliente,
    año
ORDER BY
    dim_clientes.id_cliente,
    año;


-- =============================================================================
-- 2. ANÁLISIS DE PRODUCTOS
-- =============================================================================

-- 2.1 Precio promedio de lista por categoría
SELECT
    categoria,
    AVG(precio_lista) AS precio_promedio
FROM dim_productos
GROUP BY categoria
ORDER BY precio_promedio DESC;


-- 2.2 Margen bruto estándar individual por producto
SELECT
    id_producto,
    nombre_producto,
    categoria,
    precio_lista,
    costo_estandar,
    precio_lista - costo_estandar AS margen_estandar
FROM dim_productos
ORDER BY margen_estandar DESC;


-- 2.3 Margen bruto estándar promedio por categoría
SELECT
    categoria,
    AVG(precio_lista - costo_estandar) AS margen_promedio
FROM dim_productos
GROUP BY categoria
ORDER BY margen_promedio DESC;


-- 2.4 Unidades vendidas por producto
SELECT
    dim_productos.id_producto,
    dim_productos.nombre_producto,
    dim_productos.categoria,
    SUM(fact_venta_detalle.cantidad) AS unidades_vendidas
FROM dim_productos
INNER JOIN fact_venta_detalle
    ON dim_productos.id_producto = fact_venta_detalle.id_producto
GROUP BY
    dim_productos.id_producto,
    dim_productos.nombre_producto,
    dim_productos.categoria
ORDER BY unidades_vendidas DESC;


-- 2.5 Productos con mayor ingreso acumulado por ventas
SELECT
    dim_productos.id_producto,
    dim_productos.nombre_producto,
    dim_productos.categoria,
    SUM(fact_venta_detalle.subtotal) AS ingresos_ventas
FROM dim_productos
INNER JOIN fact_venta_detalle
    ON dim_productos.id_producto = fact_venta_detalle.id_producto
GROUP BY
    dim_productos.id_producto,
    dim_productos.nombre_producto,
    dim_productos.categoria
ORDER BY ingresos_ventas DESC;


-- 2.6 Productos con mayor utilidad total generada
SELECT
    dim_productos.id_producto,
    dim_productos.nombre_producto,
    dim_productos.categoria,
    SUM(fact_venta_detalle.utilidad_linea) AS utilidad_total
FROM dim_productos
INNER JOIN fact_venta_detalle
    ON dim_productos.id_producto = fact_venta_detalle.id_producto
GROUP BY
    dim_productos.id_producto,
    dim_productos.nombre_producto,
    dim_productos.categoria
ORDER BY utilidad_total DESC;


-- 2.7 Ventas totales por categoría de producto
SELECT
    dim_productos.categoria,
    SUM(fact_venta_detalle.total_linea) AS ventas_totales
FROM dim_productos
INNER JOIN fact_venta_detalle
    ON dim_productos.id_producto = fact_venta_detalle.id_producto
GROUP BY dim_productos.categoria
ORDER BY ventas_totales DESC;


-- 2.8 Relación entre unidades vendidas y stock promedio
SELECT
    dim_productos.id_producto,
    dim_productos.nombre_producto,
    SUM(fact_venta_detalle.cantidad) AS unidades_vendidas,
    AVG(fact_inventario_diario.stock_final) AS stock_promedio
FROM dim_productos
INNER JOIN fact_venta_detalle
    ON dim_productos.id_producto = fact_venta_detalle.id_producto
INNER JOIN fact_inventario_diario
    ON dim_productos.id_producto = fact_inventario_diario.id_producto
GROUP BY
    dim_productos.id_producto,
    dim_productos.nombre_producto
ORDER BY unidades_vendidas DESC;


-- 2.9 Movimientos de inventario por producto
SELECT
    dim_productos.id_producto,
    dim_productos.nombre_producto,
    SUM(fact_inventario_diario.entradas) AS total_entradas,
    SUM(fact_inventario_diario.salidas) AS total_salidas,
    SUM(ABS(fact_inventario_diario.ajuste_logistico)) AS total_ajustes
FROM dim_productos
INNER JOIN fact_inventario_diario
    ON dim_productos.id_producto = fact_inventario_diario.id_producto
GROUP BY
    dim_productos.id_producto,
    dim_productos.nombre_producto
ORDER BY total_salidas DESC;


-- =============================================================================
-- 3. ANÁLISIS DE EMPLEADOS Y RENDIMIENTO
-- =============================================================================

-- 3.1 Número de operaciones de venta por empleado
SELECT
    dim_empleados.id_empleado,
    dim_empleados.nombre_empleado,
    COUNT(fact_ventas.id_venta) AS total_ventas
FROM dim_empleados
INNER JOIN fact_ventas
    ON dim_empleados.id_empleado = fact_ventas.id_empleado
GROUP BY
    dim_empleados.id_empleado,
    dim_empleados.nombre_empleado
ORDER BY total_ventas DESC;


-- 3.2 Monto acumulado de ventas generado por empleado
SELECT
    dim_empleados.id_empleado,
    dim_empleados.nombre_empleado,
    SUM(fact_ventas.monto_total) AS ventas_totales
FROM dim_empleados
INNER JOIN fact_ventas
    ON dim_empleados.id_empleado = fact_ventas.id_empleado
GROUP BY
    dim_empleados.id_empleado,
    dim_empleados.nombre_empleado
ORDER BY ventas_totales DESC;


-- 3.3 Ticket promedio por empleado
SELECT
    dim_empleados.id_empleado,
    dim_empleados.nombre_empleado,
    AVG(fact_ventas.monto_total) AS ticket_promedio
FROM dim_empleados
INNER JOIN fact_ventas
    ON dim_empleados.id_empleado = fact_ventas.id_empleado
GROUP BY
    dim_empleados.id_empleado,
    dim_empleados.nombre_empleado
ORDER BY ticket_promedio DESC;


-- 3.4 Desempeño de ventas por empleado dentro de cada sucursal
SELECT
    dim_sucursales.nombre_sucursal,
    dim_empleados.id_empleado,
    dim_empleados.nombre_empleado,
    SUM(fact_ventas.monto_total) AS ventas_totales
FROM dim_empleados
INNER JOIN dim_sucursales
    ON dim_empleados.id_sucursal = dim_sucursales.id_sucursal
INNER JOIN fact_ventas
    ON dim_empleados.id_empleado = fact_ventas.id_empleado
GROUP BY
    dim_sucursales.nombre_sucursal,
    dim_empleados.id_empleado,
    dim_empleados.nombre_empleado
ORDER BY
    dim_sucursales.nombre_sucursal,
    ventas_totales DESC;


-- 3.5 Evolución anual de ventas por empleado
SELECT
    dim_empleados.id_empleado,
    dim_empleados.nombre_empleado,
    EXTRACT(YEAR FROM fact_ventas.fecha_venta) AS año,
    SUM(fact_ventas.monto_total) AS ventas_totales
FROM dim_empleados
INNER JOIN fact_ventas
    ON dim_empleados.id_empleado = fact_ventas.id_empleado
GROUP BY
    dim_empleados.id_empleado,
    dim_empleados.nombre_empleado,
    año
ORDER BY
    dim_empleados.id_empleado,
    año;


-- 3.6 Promedio de ventas generado por empleado según sucursal
SELECT
    dim_sucursales.id_sucursal,
    dim_sucursales.nombre_sucursal,
    AVG(ventas_por_empleado.ventas_totales) AS promedio_ventas_empleado
FROM (
    SELECT
        dim_empleados.id_empleado,
        dim_empleados.id_sucursal,
        SUM(fact_ventas.monto_total) AS ventas_totales
    FROM dim_empleados
    INNER JOIN fact_ventas
        ON dim_empleados.id_empleado = fact_ventas.id_empleado
    GROUP BY
        dim_empleados.id_empleado,
        dim_empleados.id_sucursal
) AS ventas_por_empleado
INNER JOIN dim_sucursales
    ON ventas_por_empleado.id_sucursal = dim_sucursales.id_sucursal
GROUP BY
    dim_sucursales.id_sucursal,
    dim_sucursales.nombre_sucursal
ORDER BY promedio_ventas_empleado DESC;


-- =============================================================================
-- 4. ANÁLISIS DE SUCURSALES
-- =============================================================================

-- 4.1 Ventas totales acumuladas por sucursal
SELECT
    dim_sucursales.id_sucursal,
    dim_sucursales.nombre_sucursal,
    SUM(fact_ventas.monto_total) AS ventas_totales
FROM dim_sucursales
INNER JOIN fact_ventas
    ON dim_sucursales.id_sucursal = fact_ventas.id_sucursal
GROUP BY
    dim_sucursales.id_sucursal,
    dim_sucursales.nombre_sucursal
ORDER BY ventas_totales DESC;


-- 4.2 Ticket promedio por sucursal
SELECT
    dim_sucursales.id_sucursal,
    dim_sucursales.nombre_sucursal,
    AVG(fact_ventas.monto_total) AS ticket_promedio
FROM dim_sucursales
INNER JOIN fact_ventas
    ON dim_sucursales.id_sucursal = fact_ventas.id_sucursal
GROUP BY
    dim_sucursales.id_sucursal,
    dim_sucursales.nombre_sucursal
ORDER BY ticket_promedio DESC;


-- 4.3 Evolución anual de ventas por sucursal
SELECT
    dim_sucursales.id_sucursal,
    dim_sucursales.nombre_sucursal,
    EXTRACT(YEAR FROM fact_ventas.fecha_venta) AS año,
    SUM(fact_ventas.monto_total) AS ventas_totales
FROM dim_sucursales
INNER JOIN fact_ventas
    ON dim_sucursales.id_sucursal = fact_ventas.id_sucursal
GROUP BY
    dim_sucursales.id_sucursal,
    dim_sucursales.nombre_sucursal,
    año
ORDER BY
    dim_sucursales.id_sucursal,
    año;
