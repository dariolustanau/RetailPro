Proyecto RetailPro
Descripción
Proyecto de análisis de datos desarrollado para optimizar la gestión comercial de RetailPro, integrando el procesamiento de bases de datos relacionales y la visualización de indicadores clave para la toma de decisiones.

Herramientas utilizadas
SQL Server: Utilizado para la gestión de bases de datos, creación del modelo relacional con integridad referencial, vistas base y consultas analíticas.

Power BI Desktop: Plataforma utilizada para la importación del modelo de datos dimensional en estrella y la creación de reportes interactivos.

Estructura del Repositorio
/sql/: Contiene los scripts de creación de tablas, consultas base (INNER JOIN) y reportes ejecutivos.

/powerbi/: Archivos del modelo visual (.pbix).

Cómo ejecutar los scripts SQL
Abre SQL Server Management Studio (SSMS) en tu entorno local.

Crea una base de datos con el nombre correspondiente al proyecto.

Ejecuta los scripts provistos en la carpeta /sql/ en orden secuencial para poblar las tablas (ventas, clientes, productos, categorias, zonas, vendedores) y generar las consultas analíticas.
