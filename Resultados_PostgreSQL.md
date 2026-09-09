# Resultados del análisis — NovaRetail México

Este documento resume los principales resultados obtenidos mediante la ejecución de consultas SQL sobre la base de datos `novaretail_db`, desarrollada en PostgreSQL para el proyecto de portafolio **NovaRetail México**.

El análisis integra información de clientes, ventas, productos, inventario, empleados y sucursales, utilizando agregaciones, agrupaciones, uniones entre tablas, análisis temporales y validaciones de datos.

---

## 1. Análisis de clientes

El análisis de la dimensión de clientes permitió evaluar la participación de los clientes, el gasto acumulado, la frecuencia de compra y el ticket promedio.

### Clientes con compras registradas

- **Clientes con compras:** 875
- **Clientes sin compras:** 125

### Clientes con mayor gasto acumulado

| ID Cliente | Nombre del Cliente | Monto Total de Compras | Ticket Promedio |
|---:|---|---:|---:|
| 757 | Patricia Vazquez Jimenez | $160,175.70 | $10,678.38 |
| 517 | Mariana Vazquez Jimenez | $160,175.70 | $10,678.38 |
| 37 | Mariana Vazquez Jimenez | $160,175.70 | $10,678.38 |
| 117 | Patricia Aguilar Jimenez | $160,175.70 | $10,678.38 |
| 277 | Patricia Vazquez Jimenez | $160,175.70 | $10,678.38 |

### Clientes con mayor frecuencia de compra

| ID Cliente | Nombre del Cliente | Frecuencia de Compra |
|---:|---|---:|
| 51 | Claudia Lopez Cruz | 15 |
| 951 | Ximena Jimenez Aguilar | 15 |
| 839 | Daniela Moreno Aguilar | 15 |
| 70 | Luis Fernando Mendez Gutierrez | 15 |
| 350 | Guillermo Reyes Gutierrez | 15 |

### Clientes sin compras registradas

Mediante un `LEFT JOIN` se identificaron **125 clientes sin transacciones registradas** durante el periodo analizado.

Algunos ejemplos son:

- Camila Cruz Lopez — `id_cliente: 681`
- Sonia Garcia Lopez — `id_cliente: 601`
- Paola Diaz Lopez — `id_cliente: 497`

### Principales hallazgos

- Se identificaron **875 clientes con compras registradas**.
- El mayor gasto acumulado por cliente es de **$160,175.70**.
- El ticket promedio asociado a los clientes con mayor gasto alcanza **$10,678.38**.
- La frecuencia máxima registrada es de **15 compras** por cliente.

---

## 2. Análisis de productos y categorías

El catálogo de NovaRetail México está compuesto por **80 productos**, distribuidos equitativamente entre cuatro categorías comerciales.

### Distribución del catálogo

| Categoría | Total de Productos | Precio Promedio de Lista | Margen Estándar Promedio |
|---|---:|---:|---:|
| Electrónica | 20 | $730.00 | $292.00 |
| Abarrotes | 20 | $715.00 | $286.00 |
| Ropa | 20 | $700.00 | $280.00 |
| Hogar | 20 | $685.00 | $274.00 |

### Top 5 productos por margen estándar

El margen estándar se obtiene mediante la diferencia entre `precio_lista` y `costo_estandar`.

| ID Producto | Nombre del Producto | Categoría | Precio Lista | Costo Estándar | Margen Estándar |
|---:|---|---|---:|---:|---:|
| 80 | Pantalla Smart TV 55 4K | Electrónica | $1,300.00 | $780.00 | $520.00 |
| 79 | Sal de Mar con Especias 200g | Abarrotes | $1,285.00 | $771.00 | $514.00 |
| 78 | Mochila Urbana para Laptop | Ropa | $1,270.00 | $762.00 | $508.00 |
| 77 | Tetera Electrica de Acero Inoxidable | Hogar | $1,255.00 | $753.00 | $502.00 |
| 76 | Hub USB-C Multipuerto | Electrónica | $1,240.00 | $744.00 | $496.00 |

### Top 5 productos por unidades vendidas

| ID Producto | Nombre del Producto | Categoría | Unidades Vendidas |
|---:|---|---|---:|
| 27 | Cereal de Avena Organica 800g | Abarrotes | 2,064 |
| 57 | Edredon Termico Ligero | Hogar | 2,064 |
| 72 | Soporte Ergonomico para Laptop | Electrónica | 2,064 |
| 42 | Vestido Casual de Verano | Ropa | 2,064 |
| 12 | Consola de Videojuegos 1TB | Electrónica | 2,063 |

### Top 5 productos por ingresos

| ID Producto | Nombre del Producto | Categoría | Ingresos por Ventas |
|---:|---|---|---:|
| 77 | Tetera Electrica de Acero Inoxidable | Hogar | $2,589,065.00 |
| 72 | Soporte Ergonomico para Laptop | Electrónica | $2,435,520.00 |
| 76 | Hub USB-C Multipuerto | Electrónica | $2,321,280.00 |
| 67 | Pasta Italiana Spaghetti 500g | Abarrotes | $2,277,405.00 |
| 80 | Pantalla Smart TV 55 4K | Electrónica | $2,198,300.00 |

### Top 5 productos por utilidad bruta total

| ID Producto | Nombre del Producto | Categoría | Utilidad Bruta Total |
|---:|---|---|---:|
| 80 | Pantalla Smart TV 55 4K | Electrónica | $769,600.00 |
| 77 | Tetera Electrica de Acero Inoxidable | Hogar | $765,236.25 |
| 75 | Vinagre Balsamico de Modena 250ml | Abarrotes | $723,301.25 |
| 72 | Soporte Ergonomico para Laptop | Electrónica | $719,092.00 |
| 76 | Hub USB-C Multipuerto | Electrónica | $707,854.00 |

### Ventas totales por categoría

| Categoría | Ventas Totales |
|---|---:|
| Electrónica | $26,342,521.20 |
| Abarrotes | $25,455,295.20 |
| Ropa | $24,529,302.00 |
| Hogar | $24,423,370.80 |

### Principales hallazgos

- **Electrónica** presenta el mayor precio promedio de lista, con **$730.00**.
- **Electrónica** también registra la mayor facturación total, con **$26,342,521.20**.
- La **Pantalla Smart TV 55 4K** presenta la mayor utilidad bruta total, con **$769,600.00**.
- La **Tetera Electrica de Acero Inoxidable** registra el mayor ingreso acumulado por ventas, con **$2,589,065.00**.

---

## 3. Análisis de empleados

El análisis de la dimensión `dim_empleados` permitió evaluar la distribución de puestos y la participación de los empleados en las operaciones de venta.

### Distribución de empleados

- **Total de empleados:** 120
- **Vendedores:** 108
- **Gerentes:** 12
- **Empleados con ventas registradas:** 60
- **Empleados sin ventas registradas:** 60

### Top 5 empleados por ventas

| ID Empleado | Nombre del Empleado | Total de Ventas | Ventas Totales | Ticket Promedio |
|---:|---|---:|---:|---:|
| 12 | Rodrigo Velazquez Velazquez | 250 | $2,441,481.00 | $9,765.92 |
| 67 | Lucia Chavez Contreras | 250 | $2,440,819.80 | $9,763.28 |
| 27 | Regina Guzman Herrera | 250 | $2,439,497.40 | $9,757.99 |
| 107 | Regina Guzman Herrera | 250 | $2,435,530.20 | $9,742.12 |
| 52 | Leonardo Rivera Rivera | 250 | $2,434,869.00 | $9,739.48 |

### Evolución anual de ventas

| ID Empleado | Nombre del Empleado | 2023 | 2024 | 2025 |
|---:|---|---:|---:|---:|
| 1 | Isabella Romero Juarez | $663,757.80 | $664,105.80 | $670,874.40 |
| 3 | Lucia Chavez Contreras | $638,865.36 | $630,633.42 | $633,765.42 |
| 7 | Elena Herrera Chavez | $781,042.50 | $791,456.40 | $785,009.70 |
| 12 | Rodrigo Velazquez Velazquez | $819,226.80 | $813,771.90 | $808,482.30 |

### Empleados sin ventas registradas

Mediante un `LEFT JOIN` entre `dim_empleados` y `fact_ventas` se identificaron **60 empleados sin operaciones registradas**.

Algunos ejemplos:

- Santiago Alvarez Castro — `id_empleado: 2`
- Leonardo Rivera Rivera — `id_empleado: 4`
- Regina Guzman Herrera — `id_empleado: 11`
- Carmen Contreras Guzman — `id_empleado: 31`

### Principales hallazgos

- **60 de 120 empleados** cuentan con registros de ventas.
- Los empleados con mayor número de operaciones registran **250 ventas**.
- El mayor monto acumulado registrado por empleado es de **$2,441,481.00**.
- El ticket promedio más elevado registrado es de **$9,765.92**.

---

## 4. Análisis de sucursales

El análisis de sucursales permitió comparar la facturación acumulada y el promedio de ventas por empleado.

### Desempeño comercial por sucursal

| ID Sucursal | Nombre de Sucursal | Ventas Totales | Promedio Ventas por Empleado |
|---:|---|---:|---:|
| 8 | Sucursal Puebla Angelopolis | $8,544,093.10 | $1,708,818.62 |
| 12 | Sucursal Veracruz Puerto | $8,535,601.90 | $1,707,120.38 |
| 4 | Sucursal Guadalajara Centro | $8,533,374.70 | $1,706,674.94 |
| 2 | Sucursal Santa Fe CDMX | $8,479,782.70 | $1,695,956.54 |
| 10 | Sucursal Merida Altabrisa | $8,469,551.50 | $1,693,910.30 |
| 6 | Sucursal Monterrey Valle | $8,468,646.70 | $1,693,729.34 |
| 9 | Sucursal Queretaro Antea | $8,464,018.30 | $1,692,803.66 |
| 1 | Sucursal Polanco CDMX | $8,458,102.30 | $1,691,620.46 |
| 5 | Sucursal Zapopan Andares | $8,447,662.30 | $1,689,532.46 |
| 3 | Sucursal Insurgentes Sur | $8,122,421.50 | $1,624,484.30 |
| 7 | Sucursal Monterrey Cumbres | $8,116,783.90 | $1,623,356.78 |
| 11 | Sucursal Leon Campestre | $8,110,450.30 | $1,622,090.06 |

### Principales hallazgos

- La **Sucursal Puebla Angelopolis** registra la mayor facturación, con **$8,544,093.10**.
- Las sucursales presentan una facturación relativamente homogénea.
- El promedio de ventas por empleado se encuentra entre **$1,622,090.06** y **$1,708,818.62**.

---

## 5. Análisis de inventario

El análisis de `fact_inventario_diario` permitió revisar los movimientos de inventario registrados para los productos.

### Movimientos de inventario

| ID Producto | Nombre del Producto | Total Entradas | Total Salidas | Total Ajustes Logísticos | Stock Promedio |
|---:|---|---:|---:|---:|---:|
| 27 | Cereal de Avena Organica 800g | 43,200 | 2,064 | 0 | 1,842.99 |
| 57 | Edredon Termico Ligero | 43,200 | 2,064 | 315 | 1,830.36 |
| 72 | Soporte Ergonomico para Laptop | 43,200 | 2,064 | 6,480 | 1,575.43 |
| 42 | Vestido Casual de Verano | 43,200 | 2,064 | 0 | 1,843.05 |
| 62 | Calcetines Deportivos 6 Pares | 43,200 | 2,063 | 2,940 | 1,724.10 |
| 77 | Tetera Electrica de Acero Inoxidable | 43,200 | 2,063 | 6,480 | 1,573.10 |

### Principales hallazgos

- Los productos mostrados presentan **43,200 entradas** en los resultados documentados.
- Se identificaron ajustes logísticos de hasta **6,480 unidades** en algunos productos.
- El stock promedio de los productos mostrados se encuentra aproximadamente entre **1,500 y 1,850 unidades**.

---

## 6. Validación e integridad de los datos

Las consultas de validación permitieron revisar la consistencia básica de las dimensiones y tablas de hechos de `novaretail_db`.

| Validación | Resultado |
|---|---|
| Clientes registrados con compras | 875 clientes |
| Clientes sin compras registradas | 125 clientes |
| Empleados registrados | 120 empleados |
| Empleados con ventas registradas | 60 empleados |
| Empleados sin ventas registradas | 60 empleados |
| Sucursales operativas | 12 |
| Empleados por sucursal | 10 |
| Categorías de producto | 4 |
| Productos por categoría | 20 |

Estas validaciones permiten comprobar aspectos básicos de cobertura, distribución y relación entre las dimensiones y las tablas de hechos utilizadas en el análisis.

---

## 7. Técnicas SQL utilizadas

Las consultas desarrolladas para el análisis utilizaron diferentes elementos del lenguaje SQL en PostgreSQL.

### Consultas y filtrado

- `SELECT`
- `FROM`
- `WHERE`
- `ORDER BY`
- `LIMIT`

### Agrupación y agregación

- `GROUP BY`
- `HAVING`
- `COUNT()`
- `COUNT(DISTINCT)`
- `SUM()`
- `AVG()`
- `ABS()`

### Combinación de tablas

- `INNER JOIN`
- `LEFT JOIN`

### Análisis temporal

- `EXTRACT(YEAR FROM ...)`

### Subconsultas

- Subconsultas utilizadas para obtener métricas agregadas y comparaciones.

### Operaciones aritméticas

- Cálculo de margen estándar mediante:

`precio_lista - costo_estandar`

---

## 8. Conclusiones

1. El análisis permitió identificar **875 clientes con compras registradas**, así como 125 clientes sin transacciones durante el periodo analizado.

2. El catálogo está compuesto por **80 productos distribuidos en cuatro categorías**, con 20 productos por categoría. Electrónica presenta la mayor facturación total entre las categorías analizadas.

3. De los **120 empleados registrados**, 60 cuentan con operaciones de venta asociadas en `fact_ventas`.

4. El análisis de sucursales muestra una distribución relativamente homogénea de la facturación, con Puebla Angelopolis como la sucursal con mayor monto registrado en los resultados analizados.

5. El análisis de inventario permitió revisar entradas, salidas, ajustes logísticos y niveles promedio de stock por producto.

6. En conjunto, las consultas desarrolladas demuestran el uso de PostgreSQL para realizar agregaciones, relaciones entre tablas, análisis temporal y validaciones sobre un modelo de datos relacional.
