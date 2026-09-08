-- =============================================================================
-- PROYECTO: NovaRetail México
-- ARCHIVO: 03_validaciones.sql
-- OBJETIVO:
-- Comprobar la integridad, consistencia y cobertura de los datos generados.
-- =============================================================================


-- =============================================================================
-- 1. VALIDACIÓN DE CANTIDAD DE REGISTROS
-- =============================================================================

-- Clientes esperados: 1,000
SELECT COUNT(*) AS total_clientes
FROM dim_clientes;

-- Empleados esperados: 120
SELECT COUNT(*) AS total_empleados
FROM dim_empleados;

-- Productos esperados: 80
SELECT COUNT(*) AS total_productos
FROM dim_productos;

-- Sucursales esperadas: 12
SELECT COUNT(*) AS total_sucursales
FROM dim_sucursales;

-- Ventas esperadas: 15,000
SELECT COUNT(*) AS total_ventas
FROM fact_ventas;

-- Detalles esperados: 45,000
SELECT COUNT(*) AS total_detalles
FROM fact_venta_detalle;

-- Devoluciones esperadas: 600
SELECT COUNT(*) AS total_devoluciones
FROM fact_devoluciones;

-- Inventario esperado: 1,052,160
SELECT COUNT(*) AS total_inventario
FROM fact_inventario_diario;


-- =============================================================================
-- 2. VALIDACIÓN DE DISTRIBUCIÓN DEL CATÁLOGO DE PRODUCTOS
-- =============================================================================

-- Cada categoría debe contener 20 productos.
SELECT
    categoria,
    COUNT(*) AS total_productos
FROM dim_productos
GROUP BY categoria
ORDER BY categoria;


-- =============================================================================
-- 3. VALIDACIÓN DE DISTRIBUCIÓN DE EMPLEADOS
-- =============================================================================

-- Cada sucursal debe tener 10 empleados.
SELECT
    dim_sucursales.id_sucursal,
    dim_sucursales.nombre_sucursal,
    COUNT(dim_empleados.id_empleado) AS total_empleados
FROM dim_sucursales
INNER JOIN dim_empleados
    ON dim_sucursales.id_sucursal = dim_empleados.id_sucursal
GROUP BY
    dim_sucursales.id_sucursal,
    dim_sucursales.nombre_sucursal
ORDER BY dim_sucursales.id_sucursal;


-- Distribución del personal por puesto.
SELECT
    puesto,
    COUNT(*) AS total_empleados
FROM dim_empleados
GROUP BY puesto
ORDER BY puesto;


-- =============================================================================
-- 4. VALIDACIÓN DE COBERTURA DE CLIENTES
-- =============================================================================

-- Clientes que aparecen en las ventas.
SELECT
    COUNT(DISTINCT id_cliente) AS clientes_con_compras
FROM fact_ventas
WHERE id_cliente IS NOT NULL;


-- Clientes de la dimensión que no aparecen en ninguna venta.
SELECT
    dim_clientes.id_cliente,
    dim_clientes.nombre_cliente
FROM dim_clientes
LEFT JOIN fact_ventas
    ON dim_clientes.id_cliente = fact_ventas.id_cliente
WHERE fact_ventas.id_venta IS NULL
ORDER BY dim_clientes.id_cliente;


-- =============================================================================
-- 5. VALIDACIÓN DE COBERTURA DE EMPLEADOS
-- =============================================================================

-- Empleados que tienen ventas registradas.
SELECT
    COUNT(DISTINCT id_empleado) AS empleados_con_ventas
FROM fact_ventas;


-- Empleados sin ventas registradas.
SELECT
    dim_empleados.id_empleado,
    dim_empleados.nombre_empleado,
    dim_empleados.puesto
FROM dim_empleados
LEFT JOIN fact_ventas
    ON dim_empleados.id_empleado = fact_ventas.id_empleado
WHERE fact_ventas.id_venta IS NULL
ORDER BY dim_empleados.id_empleado;


-- =============================================================================
-- 6. VALIDACIÓN DE RELACIÓN ENTRE VENTAS Y DETALLES
-- =============================================================================

-- Cada venta debe tener exactamente 3 detalles.
SELECT
    id_venta,
    COUNT(*) AS total_detalles
FROM fact_venta_detalle
GROUP BY id_venta
HAVING COUNT(*) <> 3
ORDER BY id_venta;


-- =============================================================================
-- 7. VALIDACIÓN DE RECONCILIACIÓN FINANCIERA
-- =============================================================================

-- El subtotal de cada venta debe coincidir con la suma de sus detalles.
SELECT
    fv.id_venta,
    fv.subtotal AS subtotal_venta,
    SUM(fvd.subtotal) AS subtotal_detalles,
    fv.subtotal - SUM(fvd.subtotal) AS diferencia
FROM fact_ventas fv
INNER JOIN fact_venta_detalle fvd
    ON fv.id_venta = fvd.id_venta
GROUP BY
    fv.id_venta,
    fv.subtotal
HAVING fv.subtotal <> SUM(fvd.subtotal)
ORDER BY fv.id_venta;


-- El IVA debe corresponder al 16% del subtotal.
SELECT
    id_venta,
    subtotal,
    iva,
    subtotal * 0.16 AS iva_calculado,
    iva - (subtotal * 0.16) AS diferencia
FROM fact_ventas
WHERE iva <> subtotal * 0.16;


-- El total debe corresponder a subtotal + IVA.
SELECT
    id_venta,
    subtotal,
    iva,
    monto_total,
    subtotal + iva AS total_calculado,
    monto_total - (subtotal + iva) AS diferencia
FROM fact_ventas
WHERE monto_total <> subtotal + iva;


-- =============================================================================
-- 8. VALIDACIÓN DE DEVOLUCIONES
-- =============================================================================

-- Deben existir exactamente 600 devoluciones.
SELECT COUNT(*) AS total_devoluciones
FROM fact_devoluciones;


-- Todas las devoluciones deben estar asociadas a una venta existente.
SELECT
    fd.id_devolucion,
    fd.id_venta
FROM fact_devoluciones fd
LEFT JOIN fact_ventas fv
    ON fd.id_venta = fv.id_venta
WHERE fv.id_venta IS NULL;


-- =============================================================================
-- 9. VALIDACIÓN DE INVENTARIO
-- =============================================================================

-- Deben existir 12 sucursales x 80 productos x 1,096 días.
SELECT COUNT(*) AS total_registros_inventario
FROM fact_inventario_diario;


-- Validar que no existan combinaciones duplicadas
-- de sucursal, producto y fecha.
SELECT
    id_sucursal,
    id_producto,
    fecha,
    COUNT(*) AS registros
FROM fact_inventario_diario
GROUP BY
    id_sucursal,
    id_producto,
    fecha
HAVING COUNT(*) > 1
ORDER BY registros DESC;


-- Validar que el stock final no sea negativo.
SELECT
    id_sucursal,
    id_producto,
    fecha,
    stock_final
FROM fact_inventario_diario
WHERE stock_final < 0;
