-- ============================================================================
-- PROYECTO: NovaRetail México
-- ARCHIVO: 01_modelo_datos.sql
-- DESCRIPCIÓN: Creación del modelo relacional de NovaRetail México
-- MOTOR: PostgreSQL 13+
-- ============================================================================

BEGIN;

-- ============================================================================
-- 1. LIMPIEZA DEL ESQUEMA
-- ============================================================================
-- Se eliminan las tablas existentes para permitir ejecutar nuevamente
-- el script durante pruebas o reconstrucciones de la base de datos.

DROP TABLE IF EXISTS fact_devoluciones CASCADE;
DROP TABLE IF EXISTS fact_venta_detalle CASCADE;
DROP TABLE IF EXISTS fact_ventas CASCADE;
DROP TABLE IF EXISTS fact_inventario_diario CASCADE;

DROP TABLE IF EXISTS dim_empleados CASCADE;
DROP TABLE IF EXISTS dim_clientes CASCADE;
DROP TABLE IF EXISTS dim_productos CASCADE;
DROP TABLE IF EXISTS dim_sucursales CASCADE;


-- ============================================================================
-- 2. TABLAS DIMENSIONALES
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 2.1 Dimensión de sucursales
-- ----------------------------------------------------------------------------

CREATE TABLE dim_sucursales (
    id_sucursal INT PRIMARY KEY,
    nombre_sucursal VARCHAR(100) NOT NULL,
    estado VARCHAR(50) NOT NULL
);


-- ----------------------------------------------------------------------------
-- 2.2 Dimensión de productos
-- ----------------------------------------------------------------------------

CREATE TABLE dim_productos (
    id_producto INT PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    precio_lista NUMERIC(10,2) NOT NULL CHECK (precio_lista > 0),
    costo_estandar NUMERIC(10,2) NOT NULL CHECK (costo_estandar > 0)
);


-- ----------------------------------------------------------------------------
-- 2.3 Dimensión de clientes
-- ----------------------------------------------------------------------------

CREATE TABLE dim_clientes (
    id_cliente INT PRIMARY KEY,
    nombre_cliente VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    rfc VARCHAR(13)
);


-- ----------------------------------------------------------------------------
-- 2.4 Dimensión de empleados
-- ----------------------------------------------------------------------------

CREATE TABLE dim_empleados (
    id_empleado INT PRIMARY KEY,
    id_sucursal INT NOT NULL,
    nombre_empleado VARCHAR(100) NOT NULL,
    puesto VARCHAR(50) NOT NULL,

    CONSTRAINT fk_empleados_sucursal
        FOREIGN KEY (id_sucursal)
        REFERENCES dim_sucursales(id_sucursal)
);


-- ============================================================================
-- 3. TABLAS DE HECHOS
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 3.1 Hecho de ventas
-- ----------------------------------------------------------------------------

CREATE TABLE fact_ventas (
    id_venta INT PRIMARY KEY,
    fecha_venta TIMESTAMP NOT NULL,

    id_sucursal INT NOT NULL,
    id_empleado INT NOT NULL,
    id_cliente INT,

    canal_venta VARCHAR(20),

    subtotal NUMERIC(12,2) NOT NULL DEFAULT 0,
    monto_descuento NUMERIC(12,2) NOT NULL DEFAULT 0,
    iva NUMERIC(12,2) NOT NULL DEFAULT 0,
    monto_total NUMERIC(12,2) NOT NULL DEFAULT 0,
    utilidad_bruta NUMERIC(12,2) NOT NULL DEFAULT 0,

    CONSTRAINT fk_ventas_sucursal
        FOREIGN KEY (id_sucursal)
        REFERENCES dim_sucursales(id_sucursal),

    CONSTRAINT fk_ventas_empleado
        FOREIGN KEY (id_empleado)
        REFERENCES dim_empleados(id_empleado),

    CONSTRAINT fk_ventas_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES dim_clientes(id_cliente)
);


-- ----------------------------------------------------------------------------
-- 3.2 Detalle de ventas
-- ----------------------------------------------------------------------------

CREATE TABLE fact_venta_detalle (
    id_venta INT NOT NULL,
    id_producto INT NOT NULL,

    cantidad INT NOT NULL CHECK (cantidad > 0),

    precio_unitario NUMERIC(10,2) NOT NULL,

    porcentaje_descuento NUMERIC(5,2) NOT NULL
        CHECK (porcentaje_descuento BETWEEN 0 AND 1),

    subtotal NUMERIC(12,2) NOT NULL,
    monto_descuento NUMERIC(12,2) NOT NULL,
    iva NUMERIC(12,2) NOT NULL,
    total_linea NUMERIC(12,2) NOT NULL,

    costo_linea NUMERIC(12,2) NOT NULL,
    utilidad_linea NUMERIC(12,2) NOT NULL,

    CONSTRAINT pk_venta_detalle
        PRIMARY KEY (id_venta, id_producto),

    CONSTRAINT fk_detalle_venta
        FOREIGN KEY (id_venta)
        REFERENCES fact_ventas(id_venta),

    CONSTRAINT fk_detalle_producto
        FOREIGN KEY (id_producto)
        REFERENCES dim_productos(id_producto)
);


-- ----------------------------------------------------------------------------
-- 3.3 Hecho de devoluciones
-- ----------------------------------------------------------------------------

CREATE TABLE fact_devoluciones (
    id_devolucion INT PRIMARY KEY,

    id_venta INT NOT NULL,
    id_producto INT NOT NULL,

    fecha_devolucion TIMESTAMP NOT NULL,

    cantidad INT NOT NULL CHECK (cantidad > 0),

    monto_reembolsado NUMERIC(12,2) NOT NULL,

    CONSTRAINT fk_devolucion_venta_detalle
        FOREIGN KEY (id_venta, id_producto)
        REFERENCES fact_venta_detalle(id_venta, id_producto)
);


-- ----------------------------------------------------------------------------
-- 3.4 Hecho de inventario diario
-- ----------------------------------------------------------------------------

CREATE TABLE fact_inventario_diario (
    fecha DATE NOT NULL,

    id_sucursal INT NOT NULL,
    id_producto INT NOT NULL,

    stock_inicial INT NOT NULL,
    entradas INT NOT NULL DEFAULT 0,
    salidas INT NOT NULL DEFAULT 0,
    ajuste_logistico INT NOT NULL DEFAULT 0,
    stock_final INT NOT NULL,

    CONSTRAINT pk_inventario_diario
        PRIMARY KEY (fecha, id_sucursal, id_producto),

    CONSTRAINT fk_inventario_sucursal
        FOREIGN KEY (id_sucursal)
        REFERENCES dim_sucursales(id_sucursal),

    CONSTRAINT fk_inventario_producto
        FOREIGN KEY (id_producto)
        REFERENCES dim_productos(id_producto)
);


-- ============================================================================
-- 4. FINALIZACIÓN
-- ============================================================================

COMMIT;
