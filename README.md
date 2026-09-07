NovaRetail México — Análisis de Datos

Proyecto integral de análisis de datos de una operación minorista simulada en México, desarrollado mediante PostgreSQL, Excel y Power BI.

El proyecto representa un flujo de trabajo de análisis de datos de principio a fin, desde la generación, almacenamiento y validación de información hasta su preparación, análisis, visualización e interpretación.

Descripción del proyecto

NovaRetail México es una empresa ficticia creada para simular la operación de una cadena de tiendas minoristas.

El proyecto integra información relacionada con diferentes áreas de una operación comercial:

Ventas.
Clientes.
Productos.
Sucursales.
Empleados.
Devoluciones.
Inventario.

El objetivo es trabajar estos datos como un proceso completo de análisis, utilizando diferentes herramientas para transformar datos operativos en información útil para la toma de decisiones.

El flujo general del proyecto es:

PostgreSQL → Excel → Power BI

Nota: NovaRetail México es una empresa ficticia creada exclusivamente con fines de aprendizaje, demostración y construcción de portafolio profesional. Todos los datos utilizados son simulados.

Objetivo del proyecto

El objetivo principal de NovaRetail México es desarrollar un flujo completo de análisis de datos que permita explorar una operación minorista y obtener información relevante a partir de sus datos.

El proyecto busca responder preguntas de negocio como:

¿Cómo evolucionan las ventas a través del tiempo?
¿Qué periodos presentan mayor actividad comercial?
¿Qué sucursales generan mayores ventas?
¿Qué productos tienen mayor volumen de ventas?
¿Qué productos generan mayor ingreso y utilidad?
¿Cómo se comportan los clientes dentro de la operación?
¿Qué diferencias existen entre empleados y sucursales?
¿Qué patrones presentan las devoluciones?
¿Cómo se comporta el inventario?
¿Qué tendencias y diferencias pueden identificarse en los datos?
¿Cómo pueden transformarse estos resultados en indicadores y visualizaciones útiles?

Además del análisis de negocio, el proyecto busca demostrar el uso integrado de herramientas y técnicas utilizadas en un flujo real de trabajo de análisis de datos.

Periodo analizado

Los datos principales del proyecto corresponden al periodo:

1 de enero de 2023 al 31 de diciembre de 2025

La información fue diseñada para permitir análisis temporales por:

Año.
Mes.
Día de la semana.
Hora.
Periodos comerciales.
Alcance de los datos

La base de datos contiene información de diferentes entidades de la operación comercial.

Entidad	Registros
Sucursales	12
Empleados	120
Clientes	1,000
Productos	80
Ventas	15,000
Detalles de venta	45,000
Devoluciones	600
Inventario diario	1,052,160

En total, el proyecto trabaja con más de 1.1 millones de registros.

El volumen de información de inventario corresponde a la combinación de:

12 sucursales × 80 productos × 1,096 días

Esto permite trabajar tanto con datos transaccionales como con información de seguimiento diario.

Flujo de trabajo

El proyecto se desarrolla mediante diferentes etapas que forman parte de un mismo proceso de análisis.

1. Modelado y almacenamiento

La información operativa se almacena en PostgreSQL mediante un modelo relacional compuesto por tablas de dimensiones y hechos.

En esta etapa se definen:

Estructura de las tablas.
Claves primarias.
Claves foráneas.
Restricciones.
Relaciones entre entidades.
Tipos de datos.
2. Generación de datos

Los datos son generados de manera determinística a partir de reglas de negocio previamente definidas.

La generación considera diferentes características de una operación minorista, incluyendo:

Estacionalidad.
Diferencias entre días laborales y fines de semana.
Periodos comerciales.
Buen Fin.
Temporada navideña.
Comportamiento de ventas.
Movimientos de inventario.
Devoluciones.
Relaciones entre las diferentes entidades.

El uso de generación determinística permite reproducir los datos y mantener consistencia entre las diferentes tablas.

3. Validación y calidad de datos

Después de generar la información se realizan diferentes validaciones para comprobar su integridad y consistencia.

Entre los aspectos revisados se encuentran:

Cantidad de registros.
Integridad referencial.
Valores nulos.
Duplicados.
Relaciones entre tablas.
Consistencia de las ventas y sus detalles.
Consistencia de los movimientos de inventario.
Valores financieros.
Fechas.
Reglas de negocio.

Esta etapa permite detectar inconsistencias antes de utilizar la información para el análisis.

4. Análisis con SQL

PostgreSQL se utiliza para realizar el análisis exploratorio y responder diferentes preguntas de negocio mediante SQL.

El análisis incluye información de:

Ventas.
Clientes.
Productos.
Sucursales.
Empleados.
Devoluciones.
Inventario.

Se utilizan agregaciones, filtros, agrupaciones, ordenamientos, funciones de fecha, JOIN, CTE y otras estructuras SQL necesarias para obtener los indicadores.

5. Preparación y análisis en Excel

Los resultados obtenidos a partir de PostgreSQL se utilizan como base para realizar análisis complementarios en Excel.

Esta etapa contempla:

Revisión y preparación de información.
Organización de datos.
Tablas dinámicas.
Indicadores.
Comparaciones entre periodos.
Resúmenes por sucursal.
Resúmenes por producto.
Preparación de información para visualización.
6. Visualización en Power BI

Finalmente, la información preparada se utiliza para construir un dashboard en Power BI.

El objetivo es transformar los resultados obtenidos durante las etapas anteriores en una herramienta visual que facilite la exploración de los datos y la interpretación de los principales indicadores.

Tecnologías utilizadas
Herramienta	Uso dentro del proyecto
PostgreSQL	Almacenamiento, modelado, generación, validación y análisis
SQL	Consultas, transformación y análisis de información
Excel	Preparación, análisis y presentación de datos
Power Query	Transformación y preparación de información
Power BI	Visualización y construcción del dashboard
DAX	Creación de medidas e indicadores
Git / GitHub	Control de versiones y documentación
Modelo de datos

La base de datos utiliza un modelo relacional que separa la información descriptiva de los eventos transaccionales.

Tablas de dimensiones

Las dimensiones contienen información descriptiva utilizada para analizar los eventos de negocio.

dim_clientes
dim_empleados
dim_productos
dim_sucursales
Tablas de hechos

Las tablas de hechos contienen los eventos y movimientos generados durante la operación.

fact_ventas
fact_venta_detalle
fact_devoluciones
fact_inventario_diario

Esta estructura permite analizar la operación desde diferentes perspectivas, como:

Cliente → Producto → Empleado → Sucursal → Tiempo

y relacionarlas con los eventos comerciales y operativos.

Áreas de análisis

El análisis de NovaRetail se divide en diferentes áreas del negocio.

Ventas

Se analiza el comportamiento comercial de la operación mediante:

Ventas totales.
Número de ventas.
Ticket promedio.
Utilidad bruta.
Ventas por año.
Ventas por mes.
Ventas por día de la semana.
Ventas por hora.
Ventas por canal.
Participación de clientes.
Clientes

El análisis de clientes permite estudiar:

Clientes con compras.
Clientes sin compras.
Clientes con mayor volumen acumulado.
Ticket promedio por cliente.
Comportamiento de compra a través del tiempo.
Productos

El análisis de productos permite identificar:

Productos con mayor volumen de unidades.
Productos con mayor generación de ingresos.
Productos con mayor utilidad.
Diferencias entre categorías.
Precio y costo de los productos.
Desempeño comercial de los productos.
Sucursales

Las sucursales se comparan para identificar diferencias en su desempeño.

Se analizan variables como:

Ventas totales.
Ticket promedio.
Evolución anual.
Actividad comercial.
Inventario.
Movimientos operativos.
Empleados

El análisis de empleados permite estudiar:

Ventas acumuladas por empleado.
Ticket promedio.
Desempeño por sucursal.
Distribución de puestos.
Diferencias de desempeño entre empleados.
Devoluciones

Las devoluciones se analizan para identificar:

Productos con mayor cantidad de devoluciones.
Productos con mayores montos reembolsados.
Comportamiento por categoría.
Evolución de las devoluciones.
Relación entre devoluciones y productos vendidos.
Inventario

El inventario se analiza como una de las áreas operativas que complementan el análisis comercial.

Se consideran indicadores como:

Stock promedio.
Stock máximo.
Entradas.
Salidas.
Ajustes logísticos.
Comportamiento mensual.
Comportamiento anual.
Diferencias entre sucursales.
Continuidad de los registros.
Principales resultados

El análisis de NovaRetail permitió obtener indicadores generales sobre el comportamiento de la operación durante el periodo 2023–2025.

Ventas

Durante el periodo principal se registraron:

15,000 ventas
$100,750,489.20 en ventas totales
$6,716.70 de ticket promedio
$29,673,810.00 de utilidad bruta

La distribución anual de las ventas fue:

Año	Ventas totales	Utilidad bruta
2023	$33,534,410.13	$9,876,539.25
2024	$33,650,074.02	$9,910,765.50
2025	$33,566,005.05	$9,886,505.25

El comportamiento anual muestra una operación relativamente estable durante los tres años analizados.

Clientes

De los 1,000 clientes registrados, 875 realizaron al menos una compra durante el periodo principal.

Esto permite diferenciar entre clientes registrados y clientes con actividad comercial, además de analizar su comportamiento individual y acumulado.

Productos

La operación cuenta con 80 productos distribuidos en cuatro categorías:

Electrónica.
Abarrotes.
Ropa.
Hogar.

Las categorías presentaron los siguientes niveles de ventas acumuladas:

Categoría	Ventas acumuladas
Electrónica	$26,342,521.20
Abarrotes	$25,455,295.20
Ropa	$24,529,302.00
Hogar	$24,423,370.80

Estos resultados permiten comparar el desempeño comercial de las diferentes categorías y profundizar posteriormente en los productos que las componen.

Sucursales

NovaRetail cuenta con 12 sucursales.

La comparación entre sucursales permite identificar diferencias en:

Ventas.
Ticket promedio.
Evolución anual.
Actividad comercial.
Inventario.
Desempeño operativo.

La información puede utilizarse posteriormente en Power BI para crear comparativos y filtros por ubicación.

Empleados

La base contiene 120 empleados, distribuidos entre las 12 sucursales.

El análisis permite estudiar el desempeño individual y comparar los resultados entre empleados y sucursales.

También se identificaron diferencias en la distribución de puestos y en la participación de empleados dentro de las ventas registradas.

Devoluciones

Durante la operación se registraron:

600 devoluciones
$248,089.20 en montos reembolsados
$413.48 de reembolso promedio

El análisis permitió identificar diferencias entre productos y categorías respecto a la cantidad de unidades devueltas y los montos reembolsados.

Durante la validación se detectaron además 2 devoluciones registradas en 2026, fuera del periodo principal de análisis. Esta situación se documenta como una inconsistencia de calidad de datos.

Inventario

El inventario diario contiene 1,052,160 registros correspondientes a productos y sucursales durante el periodo analizado.

El análisis permite estudiar la evolución del stock y los movimientos de mercancía, incluyendo:

Entradas.
Salidas.
Ajustes logísticos.
Stock promedio.
Diferencias entre sucursales.
Comportamiento temporal.

Esta información complementa el análisis de ventas y permite observar la operación comercial desde una perspectiva adicional.

Reglas de generación de datos

Los datos fueron diseñados para representar una operación minorista con diferentes patrones de comportamiento.

Entre las reglas utilizadas se consideran:

Estacionalidad durante el año.
Diferencias entre días laborales y fines de semana.
Incrementos de actividad durante periodos comerciales.
Buen Fin.
Temporada navideña.
Relaciones entre ventas y sus detalles.
Relaciones entre empleados y sucursales.
Relaciones entre productos y movimientos.
Entradas y salidas de mercancía.
Ajustes logísticos.
Continuidad de los registros de inventario.

Los datos fueron generados de manera determinística, evitando el uso de valores aleatorios que dificulten la reproducción y validación de los resultados.

Control y calidad de datos

La calidad de los datos constituye una parte importante del proyecto.

Durante la etapa de validación se revisaron diferentes aspectos:

Conteo de registros.
Claves primarias.
Claves foráneas.
Integridad referencial.
Consistencia entre ventas y detalles.
Valores nulos.
Duplicados.
Fechas fuera del periodo esperado.
Consistencia de importes.
Reglas de negocio.
Continuidad de inventario.

La validación también permitió identificar inconsistencias presentes en los datos simulados, como registros de devoluciones posteriores al periodo principal de análisis.

Estas situaciones se documentan en lugar de ocultarse, simulando un escenario más cercano a un proceso real de calidad de datos.

Excel

Excel constituye la segunda etapa del flujo de análisis.

En esta fase se utiliza la información obtenida desde PostgreSQL para realizar análisis complementarios y preparar los datos que posteriormente serán utilizados en Power BI.

El trabajo contempla:

Limpieza y revisión de información.
Organización de datos.
Tablas dinámicas.
Indicadores.
Comparaciones entre periodos.
Análisis por sucursal.
Análisis por producto.
Resúmenes de información.
Preparación para visualización.

La documentación y los archivos correspondientes a esta etapa se encuentran en:

/Excel

Power BI

Power BI constituye la etapa final del flujo de análisis.

El dashboard está orientado a presentar visualmente los principales indicadores de la operación de NovaRetail México.

Entre los indicadores considerados se encuentran:

Ventas totales.
Número de ventas.
Ticket promedio.
Utilidad.
Productos vendidos.
Devoluciones.
Inventario.
Ventas por sucursal.
Ventas por producto.
Ventas por categoría.
Evolución de ventas.

El dashboard permitirá explorar la información mediante filtros y segmentaciones para analizar diferentes periodos, sucursales, productos y categorías.

La documentación y los archivos correspondientes a esta etapa se encuentran en:

/PowerBI

Conclusiones

NovaRetail México integra diferentes etapas de un proceso de análisis de datos, desde la generación y almacenamiento de información hasta su análisis, preparación y visualización.

El proyecto utiliza PostgreSQL como fuente principal de información y posteriormente integra Excel y Power BI para complementar el análisis y facilitar la interpretación de los resultados.

El flujo general puede representarse como:

Datos → Validación → Análisis → Preparación → Visualización → Insights

La integración de estas etapas permite trabajar los datos como un proceso completo en lugar de desarrollar ejercicios independientes de SQL, Excel o Power BI.

El proyecto también permite trabajar con diferentes volúmenes de información y analizar distintas áreas de una operación minorista, proporcionando un escenario práctico para demostrar habilidades técnicas y analíticas.

Habilidades demostradas

Este proyecto permite demostrar experiencia práctica en:

SQL.
PostgreSQL.
Modelado relacional.
Análisis exploratorio de datos.
Consultas y agregaciones.
Validación de datos.
Calidad de datos.
Excel.
Power Query.
Power BI.
DAX.
Creación de indicadores.
Análisis temporal.
Análisis de tendencias.
Interpretación de resultados.
Visualización de datos.
Documentación técnica.
Control de versiones con Git y GitHub.
Estructura del repositorio
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

La documentación específica de cada etapa se encuentra dentro de sus respectivas carpetas.

Autor

Mario Galicia Suarez

Ingeniero en Sistemas Computacionales

Proyecto desarrollado con fines de portafolio profesional, aprendizaje y demostración de habilidades de análisis de datos.
