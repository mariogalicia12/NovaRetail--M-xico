# NovaRetail México — Análisis de Datos

Proyecto de análisis de datos de una operación minorista simulada utilizando PostgreSQL, Excel y Power BI.

## Descripción del proyecto

NovaRetail México es un proyecto integral de análisis de datos desarrollado para simular la operación de una cadena de tiendas minoristas en México.

El proyecto representa un flujo de trabajo de análisis de datos de principio a fin, comenzando con el almacenamiento y validación de información en PostgreSQL, continuando con su preparación y análisis en Excel, y finalizando con la creación de visualizaciones y un dashboard en Power BI.

El objetivo es transformar datos operativos en información útil para analizar el comportamiento de las ventas, clientes, productos, sucursales, inventario y devoluciones, identificando tendencias y patrones que puedan apoyar la toma de decisiones.

> **Nota:** NovaRetail México es una empresa ficticia creada exclusivamente con fines de aprendizaje y demostración de habilidades de análisis de datos. Los datos utilizados son simulados y fueron generados bajo reglas de negocio definidas para representar un escenario de operación minorista.

---

## Objetivo del proyecto

El objetivo principal de NovaRetail México es desarrollar un flujo completo de análisis de datos que permita obtener información relevante a partir de datos operativos de una empresa de retail.

El proyecto busca responder preguntas relacionadas con:

- ¿Cómo evolucionan las ventas a través del tiempo?
- ¿Qué sucursales presentan mayor actividad?
- ¿Qué productos tienen mayor participación en las ventas?
- ¿Cómo se comporta el inventario?
- ¿Cómo varía el comportamiento entre periodos?
- ¿Qué patrones pueden identificarse en las devoluciones?
- ¿Qué información puede utilizarse para apoyar la toma de decisiones?

Además, el proyecto tiene como finalidad demostrar el uso integrado de diferentes herramientas utilizadas en un flujo de trabajo de análisis de datos:

**PostgreSQL → Excel → Power BI**

---

## Periodo analizado

Los datos corresponden al periodo comprendido entre:

**1 de enero de 2023 y 31 de diciembre de 2025**

---

## Alcance de los datos

La base de datos contiene información sobre diferentes áreas de la operación comercial:

| Entidad | Registros |
|---|---:|
| Sucursales | 12 |
| Empleados | 50 |
| Clientes | 1,000 |
| Productos | 80 |
| Ventas | 15,000 |
| Detalles de venta | 45,000 |
| Devoluciones | 600 |
| Inventario diario | 1,052,160 |

El volumen de registros de inventario corresponde a la combinación de:

**12 sucursales × 80 productos × 1,096 días**

---

## Flujo de trabajo

El proyecto se desarrolla mediante diferentes etapas que forman parte de un mismo proceso de análisis.

### 1. Modelado y almacenamiento

La información operativa se almacena en PostgreSQL mediante un modelo relacional compuesto por tablas de dimensiones y hechos.

### 2. Generación y validación de datos

Los datos son generados de manera determinística utilizando reglas de negocio previamente definidas.

Posteriormente se realizan validaciones para comprobar la integridad, consistencia y relación entre los diferentes conjuntos de datos.

### 3. Análisis con SQL

Se utilizan consultas SQL para explorar y analizar la información desde diferentes perspectivas, incluyendo ventas, sucursales, productos, clientes, inventario y devoluciones.

### 4. Preparación y análisis en Excel

Los resultados obtenidos se utilizan como base para realizar análisis complementarios, resúmenes y preparación de información para su posterior visualización.

### 5. Visualización en Power BI

Finalmente, la información preparada se utiliza para construir un dashboard que permita consultar indicadores, tendencias y resultados de manera visual.

---

## Tecnologías utilizadas

| Herramienta | Uso |
|---|---|
| PostgreSQL | Almacenamiento, modelado, validación y análisis de datos |
| SQL | Consultas y análisis de información |
| Excel | Preparación, análisis y presentación de datos |
| Power Query | Transformación y preparación de datos |
| Power BI | Visualización y construcción del dashboard |
| DAX | Creación de medidas y métricas |
| Git / GitHub | Control de versiones y documentación |

---

## Modelo de datos

La base de datos utiliza un modelo relacional que separa la información descriptiva de los eventos transaccionales.

### Tablas de dimensiones

- `dim_clientes`
- `dim_empleados`
- `dim_productos`
- `dim_sucursales`

### Tablas de hechos

- `fact_ventas`
- `fact_venta_detalle`
- `fact_devoluciones`
- `fact_inventario_diario`

Esta estructura permite analizar los eventos de negocio desde diferentes perspectivas, como producto, cliente, empleado, sucursal y periodo.

---

## Reglas de generación de datos

Los datos fueron diseñados para representar una operación minorista con diferentes patrones de comportamiento.

La generación considera:

- Diferencias en la actividad entre días laborales y fines de semana.
- Estacionalidad durante el año.
- Incrementos de actividad durante periodos comerciales relevantes.
- Comportamiento asociado con Buen Fin.
- Incremento de actividad durante la temporada navideña.
- Entradas y salidas de mercancía.
- Ajustes logísticos.
- Variaciones en los niveles de inventario.
- Continuidad del inventario entre días consecutivos.

Los datos fueron generados de manera determinística, evitando el uso de valores aleatorios que pudieran dificultar la reproducción de los resultados.

---

## Control de inventario

La información de inventario fue diseñada bajo una regla de continuidad entre días consecutivos.

El inventario inicial de un producto en una sucursal para un día determinado corresponde al inventario final registrado para el día anterior.

La ecuación utilizada para determinar el inventario final es:

**Stock final = Stock inicial + Entradas − Salidas + Ajuste logístico**

Esta regla permite mantener continuidad en los registros y facilita la validación de los movimientos de inventario.

---

# Análisis realizado

El análisis de NovaRetail se divide en diferentes áreas del negocio.

## Ventas

Se analiza el comportamiento de las ventas a través del tiempo, considerando:

- Ventas mensuales.
- Comparación entre años.
- Crecimiento porcentual.
- Tendencias de ventas.
- Periodos con mayor actividad.

## Sucursales

Se comparan las diferentes sucursales para identificar diferencias en su comportamiento operativo y comercial.

Entre las variables analizadas se encuentran:

- Ventas.
- Inventario.
- Movimientos de inventario.
- Ajustes logísticos.
- Actividad por periodo.

## Productos

El análisis de productos permite identificar diferencias en su comportamiento comercial y su relación con las ventas y el inventario.

## Clientes

Se analiza la participación y comportamiento de los clientes dentro de la operación comercial.

## Inventario

Se analiza el comportamiento del inventario mediante indicadores como:

- Stock promedio.
- Stock máximo.
- Variaciones diarias.
- Entradas.
- Salidas.
- Ajustes logísticos.
- Comportamiento por sucursal.
- Comportamiento anual.
- Comportamiento mensual.

## Devoluciones

Se analiza la información de devoluciones para identificar patrones relacionados con los productos y las operaciones de venta.

---

# Principales resultados

## Evolución del inventario promedio

El análisis del inventario mostró un incremento progresivo del stock promedio durante el periodo analizado.

| Año | Stock promedio |
|---|---:|
| 2023 | 686.64 |
| 2024 | 1,798.12 |
| 2025 | 2,912.00 |

El comportamiento observado representa un crecimiento considerable del inventario promedio entre 2023 y 2025.

## Comportamiento mensual del inventario

El análisis mensual mostró un incremento progresivo del stock promedio conforme avanza el año.

| Mes | Stock promedio |
|---|---:|
| Enero | 1,287.01 |
| Febrero | 1,377.82 |
| Marzo | 1,472.96 |
| Abril | 1,564.90 |
| Mayo | 1,658.38 |
| Junio | 1,750.32 |
| Julio | 1,843.80 |
| Agosto | 1,936.35 |
| Septiembre | 2,028.29 |
| Octubre | 2,121.77 |
| Noviembre | 2,213.71 |
| Diciembre | 2,307.19 |

Los valores más altos se concentran durante los últimos meses del año.

## Movimientos de inventario

Durante el periodo analizado se registraron los siguientes movimientos:

| Movimiento | Total |
|---|---:|
| Entradas | 3,456,000 |
| Salidas | 135,000 |
| Ajustes logísticos | -116,280 |

Las entradas representan el mayor volumen de movimiento dentro de la operación de inventario.

También se identificaron diferencias entre sucursales en la magnitud de los ajustes logísticos.

---

# Excel

Excel constituye la segunda etapa del flujo de análisis.

En esta fase se utiliza la información obtenida de PostgreSQL para realizar análisis complementarios y preparar los datos que posteriormente serán utilizados en Power BI.

El trabajo contempla:

- Limpieza y revisión de información.
- Organización de datos.
- Tablas dinámicas.
- Análisis de indicadores.
- Comparaciones entre periodos.
- Resúmenes por sucursal.
- Resúmenes por producto.
- Preparación de información para visualización.

El objetivo de esta etapa es transformar los resultados obtenidos mediante SQL en información estructurada y accesible para el análisis.

---

# Power BI

Power BI constituye la etapa final del flujo de análisis.

El dashboard está orientado a presentar visualmente los principales indicadores de la operación de NovaRetail México.

Entre los indicadores considerados se encuentran:

- Ventas totales.
- Número de ventas.
- Ticket promedio.
- Productos vendidos.
- Devoluciones.
- Inventario.
- Ventas por sucursal.
- Ventas por producto.
- Evolución de ventas a través del tiempo.

El dashboard permite explorar la información mediante filtros y segmentaciones para analizar diferentes periodos, sucursales y categorías.

---

# Conclusiones

NovaRetail México integra diferentes etapas de un proceso de análisis de datos, desde el almacenamiento y validación de información hasta su análisis y visualización.

El proyecto utiliza PostgreSQL como fuente principal de información y posteriormente integra Excel y Power BI para complementar el análisis y facilitar la interpretación de los resultados.

El flujo general del proyecto puede representarse como:

**Datos → Validación → Análisis → Preparación → Visualización → Insights**

La integración de estas etapas permite trabajar los datos como un proceso completo y no como ejercicios independientes de SQL, Excel o Power BI.

El proyecto también permite trabajar con diferentes volúmenes de información y analizar distintas áreas de una operación minorista, proporcionando un escenario práctico para demostrar habilidades de análisis de datos.

---

# Habilidades demostradas

Este proyecto permite demostrar experiencia práctica en:

- SQL.
- PostgreSQL.
- Análisis exploratorio de datos.
- Modelado relacional.
- Validación y calidad de datos.
- Excel.
- Power Query.
- Power BI.
- DAX.
- Creación de indicadores.
- Análisis de tendencias.
- Interpretación de resultados.
- Visualización de datos.
- Documentación técnica.
- Control de versiones con Git y GitHub.

---

# Estructura del repositorio

```text
NovaRetail-Mexico/
│
├── README.md
│
├── PostgreSQL/
│   ├── README.md
│   ├── 01_modelo_datos.sql
│   ├── 02_generacion_datos.sql
│   ├── 03_validaciones.sql
│   └── 04_analisis.sql
│
├── Excel/
│   └── README.md
│
└── PowerBI/
    └── README.md
```

---

## Autor

**Mario Galicia Suarez**

Ingeniero en Sistemas Computacionales

Proyecto desarrollado con fines de portafolio profesional.
