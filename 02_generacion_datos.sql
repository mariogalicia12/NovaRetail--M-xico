-- ============================================================================
-- PROYECTO: NovaRetail México
-- ARCHIVO: 02_generacion_datos.sql
-- DESCRIPCIÓN: Generación y carga de datos sintéticos deterministas
-- MOTOR: PostgreSQL 13+
-- ============================================================================

BEGIN;

-- ============================================================================
-- 1. CARGA DE DIM_SUCURSALES
-- ============================================================================
-- 12 sucursales distribuidas en diferentes regiones de México.
-- Se incluye una sucursal destinada al canal E-commerce.

INSERT INTO dim_sucursales
    (id_sucursal, nombre_sucursal, region, tipo_tienda, superficie_m2, fecha_apertura)
VALUES
(1,  'Sucursal Polanco CDMX',       'Centro',    'Física',     1200, '2018-03-15'),
(2,  'Sucursal Santa Fe CDMX',      'Centro',    'Física',     1500, '2019-06-20'),
(3,  'Sucursal Insurgentes Sur',    'Centro',    'Física',     1100, '2020-01-10'),
(4,  'Sucursal Guadalajara Centro', 'Occidente', 'Física',     1300, '2018-11-05'),
(5,  'Sucursal Zapopan Andares',    'Occidente', 'Física',     1400, '2021-02-18'),
(6,  'Sucursal Monterrey Valle',    'Norte',     'Física',     1600, '2017-09-01'),
(7,  'Sucursal Monterrey Cumbres',  'Norte',     'Física',     1000, '2021-08-12'),
(8,  'Sucursal Puebla Angelopolis', 'Sur',       'Física',     1250, '2019-10-30'),
(9,  'Sucursal Queretaro Antea',    'Centro',    'Física',     1350, '2020-05-14'),
(10, 'Sucursal Merida Altabrisa',   'Sur',       'Física',     1150, '2022-01-22'),
(11, 'Sucursal Leon Campestre',     'Centro',    'Física',     1200, '2021-11-11'),
(12, 'Canal E-commerce Mexico',     'Nacional',  'E-commerce',    0, '2020-03-01');


-- ============================================================================
-- 2. CARGA DE DIM_EMPLEADOS
-- ============================================================================
-- 120 empleados asignados de manera determinista a las 12 sucursales.
-- Se generan nombres, puestos y fechas de ingreso mediante combinaciones
-- de arreglos y operaciones matemáticas.

WITH nombres_base AS (
    SELECT
        ARRAY[
            'Mateo', 'Isabella', 'Santiago', 'Lucia',
            'Leonardo', 'Victoria', 'Matias', 'Elena',
            'Sebastian', 'Emilia', 'Emiliano', 'Regina',
            'Rodrigo', 'Renata', 'Gonzalo', 'Carmen'
        ] AS nombres,

        ARRAY[
            'Castillo', 'Romero', 'Alvarez', 'Chavez',
            'Rivera', 'Juarez', 'Dominguez', 'Herrera',
            'Medina', 'Vargas', 'Castro', 'Guzman',
            'Velazquez', 'Munoz', 'Rojas', 'Contreras'
        ] AS apellidos
)

INSERT INTO dim_empleados
    (id_empleado, nombre_empleado, id_sucursal, puesto, fecha_ingreso, activo)

SELECT
    i AS id_empleado,

    nombres[1 + (i % 16)] ||
    ' ' ||
    apellidos[1 + (i % 16)] ||
    ' ' ||
    apellidos[1 + ((i * 5) % 16)] AS nombre_empleado,

    1 + (i % 12) AS id_sucursal,

    (ARRAY[
        'Vendedor',
        'Cajero',
        'Gerente de Tienda',
        'Especialista E-commerce'
    ])[1 + (i % 4)] AS puesto,

    '2020-01-01'::DATE +
        ((i * 7) % 1000) * INTERVAL '1 day' AS fecha_ingreso,

    TRUE AS activo

FROM generate_series(1, 120) i, nombres_base;


-- ============================================================================
-- 3. CARGA DE DIM_PRODUCTOS
-- ============================================================================
-- 80 productos distribuidos en cuatro categorías.
-- Los precios, costos y stock mínimo se generan mediante reglas deterministas.

WITH productos_base AS (
    SELECT
        i AS id_producto,

        CASE 1 + (i % 4)
            WHEN 1 THEN 'Electrónica'
            WHEN 2 THEN 'Hogar'
            WHEN 3 THEN 'Ropa'
            ELSE 'Abarrotes / Gourmet'
        END AS categoria,

        CASE 1 + (i % 4)
            WHEN 1 THEN
                (ARRAY[
                    'Televisores',
                    'Cómputo',
                    'Telefonía',
                    'Audio',
                    'Accesorios'
                ])[1 + (i % 5)]

            WHEN 2 THEN
                (ARRAY[
                    'Línea Blanca',
                    'Electrodomésticos',
                    'Cocina',
                    'Decoración',
                    'Blancos'
                ])[1 + (i % 5)]

            WHEN 3 THEN
                (ARRAY[
                    'Caballeros',
                    'Damas',
                    'Calzado',
                    'Accesorios',
                    'Deportes'
                ])[1 + (i % 5)]

            ELSE
                (ARRAY[
                    'Despensa',
                    'Vinos y Licores',
                    'Gourmet',
                    'Bebidas',
                    'Snacks'
                ])[1 + (i % 5)]
        END AS subcategoria,

        CASE 1 + (i % 4)

            WHEN 1 THEN
                (ARRAY[
                    'Pantalla Smart TV 55 4K',
                    'Audifonos Inalambricos Bluetooth',
                    'Laptop Pro 15 16GB RAM',
                    'Consola de Videojuegos 1TB',
                    'Smartphone 128GB OLED',
                    'Bocina Portatil Recargable',
                    'Tablet 10 Pulgadas Wi-Fi',
                    'Monitor Gamer 27 144Hz',
                    'Teclado Mecanico RGB',
                    'Mouse Inalambrico Ergonomico',
                    'Camara de Seguridad Wi-Fi',
                    'Barra de Sonido 2.1',
                    'Cargador Carga Rapida USB-C',
                    'Reloj Inteligente Deportivo',
                    'Power Bank 20000mAh',
                    'Disco Duro Externo 2TB',
                    'Proyector Portatil HD',
                    'Audifonos Gamer con Microfono',
                    'Soporte Ergonomico para Laptop',
                    'Hub USB-C Multipuerto'
                ])[1 + ((i / 4) % 20)]

            WHEN 2 THEN
                (ARRAY[
                    'Cafetera Programable 12 Tazas',
                    'Licuadora de Alta Potencia 3 Vel',
                    'Freidora de Aire 4.5L',
                    'Aspiradora Robot Inteligente',
                    'Horno de Microondas 1.1 p3',
                    'Plancha de Vapor Ceramica',
                    'Batidora de Inmersion 800W',
                    'Juego de Sartenes Antiadherentes 3Pz',
                    'Set de Cuchillos de Cocina 6Pz',
                    'Procesador de Alimentos 500W',
                    'Humidificador Ultrasonico 3L',
                    'Lampara de Escritorio LED',
                    'Juego de Sabanas Algodon Matrimonial',
                    'Almohada Ortopedica Memory Foam',
                    'Edredon Termico Ligero',
                    'Bascula Digital de Bano',
                    'Purificador de Aire HEPA',
                    'Ventilador de Torre Oscilante',
                    'Organizador de Cocina Multiusos',
                    'Tetera Electrica de Acero Inoxidable'
                ])[1 + ((i / 4) % 20)]

            WHEN 3 THEN
                (ARRAY[
                    'Playera Polo 100% Algodon',
                    'Jeans Mezclilla Corte Recto',
                    'Chamarra Termica Impermeable',
                    'Sudadera con Capucha Algodon',
                    'Camisa Formal Manga Larga',
                    'Pantalon Casual Chino',
                    'Tenis Deportivos Running',
                    'Zapato Formal de Piel',
                    'Chaleco Acolchado Casual',
                    'Chamarra de Mezclilla Clasica',
                    'Vestido Casual de Verano',
                    'Sueter de Tejido Ligero',
                    'Pijama de Algodon 2 Piezas',
                    'Cinturon de Piel Reversible',
                    'Gorra Deportiva Ajustable',
                    'Calcetines Deportivos 6 Pares',
                    'Bufanda de Lana Tejida',
                    'Ensamble Ligero Dama',
                    'Short Deportivo Secado Rapido',
                    'Mochila Urbana para Laptop'
                ])[1 + ((i / 4) % 20)]

            ELSE
                (ARRAY[
                    'Cafe en Grano Gourmet 1kg',
                    'Aceite de Oliva Extra Virgen 1L',
                    'Miel de Abeja Organica 500g',
                    'Chocolate Amargo 70% Cacao 200g',
                    'Caja de Te Variado Gourmet 40 Sobres',
                    'Avellana con Cacao Untable 400g',
                    'Cereal de Avena Organica 800g',
                    'Vino Tinto Reserva 750ml',
                    'Queso Parmesano Maduro 250g',
                    'Arroz Selecto Super Extra 1kg',
                    'Frijol Negro Queretaro 1kg',
                    'Mezcla de Frutos Secos 500g',
                    'Salsa Botanera Artesanal 350ml',
                    'Mermelada de Fresa Organica 400g',
                    'Galletas Integrales con Miel 300g',
                    'Agua Mineral de Manantial 1.5L',
                    'Pasta Italiana Spaghetti 500g',
                    'Harina de Trigo Preparada 1kg',
                    'Vinagre Balsamico de Modena 250ml',
                    'Sal de Mar con Especias 200g'
                ])[1 + ((i / 4) % 20)]
        END AS nombre_producto,

        ROUND(
            (50 + ((i * 137) % 4950))::NUMERIC,
            2
        ) AS precio_unitario,

        ROUND(
            (30 + ((i * 137) % 4950) * 0.65)::NUMERIC,
            2
        ) AS costo_unitario,

        10 + (i % 30) AS stock_minimo_sugerido

    FROM generate_series(1, 80) i
)

INSERT INTO dim_productos
    (
        id_producto,
        nombre_producto,
        categoria,
        subcategoria,
        precio_unitario,
        costo_unitario,
        stock_minimo_sugerido
    )

SELECT
    id_producto,
    nombre_producto,
    categoria,
    subcategoria,
    precio_unitario,
    costo_unitario,
    stock_minimo_sugerido
FROM productos_base;


-- ============================================================================
-- 4. CARGA DE DIM_CLIENTES
-- ============================================================================
-- 1,000 clientes generados mediante combinaciones deterministas de nombres
-- y apellidos.

WITH nombres_base AS (
    SELECT
        ARRAY[
            'Carlos', 'Sofia', 'Alejandro', 'Valeria',
            'Miguel Angel', 'Mariana', 'Luis Fernando', 'Daniela',
            'Jose Luis', 'Camila', 'Jorge', 'Andrea',
            'Fernando', 'Natalia', 'Ricardo', 'Fernanda',
            'Eduardo', 'Paola', 'Gabriel', 'Claudia',
            'Diego', 'Patricia', 'Adrian', 'Ximena',
            'Javier', 'Sonia', 'Roberto', 'Lorena',
            'Raul', 'Monique', 'Guillermo', 'Beatriz'
        ] AS nombres,

        ARRAY[
            'Hernandez', 'Garcia', 'Martinez', 'Lopez',
            'Gonzalez', 'Perez', 'Rodriguez', 'Sanchez',
            'Ramirez', 'Cruz', 'Flores', 'Gomez',
            'Morales', 'Vazquez', 'Reyes', 'Jimenez',
            'Torres', 'Diaz', 'Gutierrez', 'Mendoza',
            'Ruiz', 'Aguilar', 'Mendez', 'Moreno'
        ] AS apellidos
)

INSERT INTO dim_clientes
    (
        id_cliente,
        nombre_cliente,
        email,
        rfc,
        tipo_cliente,
        fecha_registro
    )

SELECT
    i AS id_cliente,

    nombres[1 + (i % 32)] ||
    ' ' ||
    apellidos[1 + (i % 24)] ||
    ' ' ||
    apellidos[1 + ((i * 3) % 24)] AS nombre_cliente,

    'cliente_' || i || '@novaretail.mx' AS email,

    'XAXX' ||
    LPAD(i::TEXT, 6, '0') ||
    'MX' AS rfc,

    (ARRAY[
        'Regular',
        'Frecuente',
        'VIP'
    ])[1 + (i % 3)] AS tipo_cliente,

    '2021-01-01'::DATE +
        ((i * 3) % 700) * INTERVAL '1 day' AS fecha_registro

FROM generate_series(1, 1000) i, nombres_base;


-- ============================================================================
-- 5. CARGA DE FACT_VENTAS
-- ============================================================================
-- 15,000 ventas generadas para el periodo 2023-2025.
-- Las sucursales, empleados, clientes, canales y métodos de pago se asignan
-- mediante reglas deterministas.

INSERT INTO fact_ventas
    (
        id_venta,
        fecha_venta,
        id_sucursal,
        id_cliente,
        id_empleado,
        canal_venta,
        metodo_pago,
        subtotal,
        iva,
        total
    )

SELECT
    i AS id_venta,

    '2023-01-01 08:00:00'::TIMESTAMP +
        ((i - 1) * INTERVAL '105 minutes') AS fecha_venta,

    1 + (i % 12) AS id_sucursal,

    CASE
        WHEN i % 5 = 0 THEN NULL
        ELSE 1 + ((i * 7) % 1000)
    END AS id_cliente,

    1 + ((i * 3) % 120) AS id_empleado,

    CASE
        WHEN (1 + (i % 12)) = 12
            THEN 'E-commerce'
        ELSE 'Tienda Física'
    END AS canal_venta,

    (ARRAY[
        'Efectivo',
        'Tarjeta de Crédito',
        'Tarjeta de Débito',
        'Transferencia'
    ])[1 + (i % 4)] AS metodo_pago,

    0.00 AS subtotal,
    0.00 AS iva,
    0.00 AS total

FROM generate_series(1, 15000) i;


-- ============================================================================
-- 6. CARGA DE FACT_VENTA_DETALLE
-- ============================================================================
-- 45,000 partidas: tres productos por cada una de las 15,000 ventas.

WITH detalle_gen AS (
    SELECT
        d AS id_detalle,

        1 + ((d - 1) / 3) AS id_venta,

        1 + ((d * 11) % 80) AS id_producto,

        1 + (d % 4) AS cantidad,

        CASE
            WHEN d % 10 = 0 THEN 50.00
            ELSE 0.00
        END AS descuento_aplicado

    FROM generate_series(1, 45000) d
)

INSERT INTO fact_venta_detalle
    (
        id_detalle,
        id_venta,
        id_producto,
        cantidad,
        precio_unitario_aplicado,
        descuento_aplicado,
        importe_bruto,
        importe_neto,
        costo_total,
        ganancia_bruta
    )

SELECT
    dg.id_detalle,
    dg.id_venta,
    dg.id_producto,
    dg.cantidad,
    p.precio_unitario AS precio_unitario_aplicado,
    dg.descuento_aplicado,

    dg.cantidad * p.precio_unitario AS importe_bruto,

    (dg.cantidad * p.precio_unitario)
        - dg.descuento_aplicado AS importe_neto,

    dg.cantidad * p.costo_unitario AS costo_total,

    ((dg.cantidad * p.precio_unitario)
        - dg.descuento_aplicado)
        - (dg.cantidad * p.costo_unitario) AS ganancia_bruta

FROM detalle_gen dg

JOIN dim_productos p
    ON dg.id_producto = p.id_producto;


-- ============================================================================
-- 7. ACTUALIZACIÓN DE TOTALES DE FACT_VENTAS
-- ============================================================================
-- Los totales de cada venta se calculan a partir de sus partidas.
-- Se aplica IVA del 16%.

WITH totales_calculados AS (
    SELECT
        id_venta,

        SUM(importe_neto) AS subtotal_calc,

        ROUND(
            (SUM(importe_neto) * 0.16)::NUMERIC,
            2
        ) AS iva_calc,

        ROUND(
            (SUM(importe_neto) * 1.16)::NUMERIC,
            2
        ) AS total_calc

    FROM fact_venta_detalle

    GROUP BY id_venta
)

UPDATE fact_ventas v

SET
    subtotal = tc.subtotal_calc,
    iva = tc.iva_calc,
    total = tc.total_calc

FROM totales_calculados tc

WHERE v.id_venta = tc.id_venta;


-- ============================================================================
-- 8. CARGA DE FACT_DEVOLUCIONES
-- ============================================================================
-- 600 devoluciones asociadas a ventas existentes.
-- Se generan mediante una selección determinista de ventas y productos.

INSERT INTO fact_devoluciones
    (
        id_devolucion,
        id_venta,
        id_producto,
        fecha_devolucion,
        cantidad_devuelta,
        monto_reembolsado,
        motivo
    )

SELECT
    i AS id_devolucion,

    i * 25 AS id_venta,

    1 + ((i * 7) % 80) AS id_producto,

    '2023-01-05'::DATE +
        ((i * 3) % 1080) * INTERVAL '1 day'
        AS fecha_devolucion,

    1 AS cantidad_devuelta,

    ROUND(
        (p.precio_unitario * 1.16)::NUMERIC,
        2
    ) AS monto_reembolsado,

    (ARRAY[
        'Defectuoso',
        'Talla Incorrecta',
        'Inconformidad',
        'Empaque Dañado'
    ])[1 + (i % 4)] AS motivo

FROM generate_series(1, 600) i

JOIN dim_productos p
    ON p.id_producto = 1 + ((i * 7) % 80);


-- ============================================================================
-- 9. CARGA DE FACT_INVENTARIO_DIARIO
-- ============================================================================
-- Se genera un registro diario por cada combinación de sucursal y producto.
--
-- 1,096 días × 12 sucursales × 80 productos
-- = 1,052,160 registros.

WITH RECURSIVE calendario AS (

    SELECT
        '2023-01-01'::DATE AS fecha,
        1 AS dia_num

    UNION ALL

    SELECT
        (fecha + INTERVAL '1 day')::DATE,
        dia_num + 1

    FROM calendario

    WHERE fecha < '2025-12-31'
),

base_combinada AS (

    SELECT
        c.fecha,
        c.dia_num,
        s.id_sucursal,
        p.id_producto

    FROM calendario c

    CROSS JOIN dim_sucursales s

    CROSS JOIN dim_productos p
)

INSERT INTO fact_inventario_diario
    (
        fecha,
        id_sucursal,
        id_producto,
        stock_inicial,
        entradas,
        salidas,
        stock_final
    )

SELECT
    fecha,

    id_sucursal,

    id_producto,

    50 + (
        (id_sucursal + id_producto + dia_num) % 20
    ) AS stock_inicial,

    CASE
        WHEN dia_num % 7 = 0 THEN 15
        ELSE 0
    END AS entradas,

    (
        id_sucursal + id_producto + dia_num
    ) % 5 AS salidas,

    (
        50 + (
            (id_sucursal + id_producto + dia_num) % 20
        )
        +
        CASE
            WHEN dia_num % 7 = 0 THEN 15
            ELSE 0
        END
        -
        (
            (id_sucursal + id_producto + dia_num) % 5
        )
    ) AS stock_final

FROM base_combinada;


-- ============================================================================
-- FINALIZACIÓN
-- ============================================================================

COMMIT;
