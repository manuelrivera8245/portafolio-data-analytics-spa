# Sistema de Inteligencia de Negocios — Centro de Estética

Proyecto académico de Business Intelligence desarrollado en equipo de 3 personas
para digitalizar y analizar los registros de ventas de un centro de estética que,
hasta este proyecto, se llevaban a mano en un cuaderno físico.

## Problema

Los registros originales presentaban:
- Nombres de servicios inconsistentes (ej. "Plancha", "Planchado", "Planchado + ondas"
  referían al mismo servicio)
- Fechas en tres formatos distintos dentro de la misma hoja (texto, serial de Excel, fecha real)
- Totales de facturación que no cuadraban entre lo apuntado y la suma real
- Ningún historial consultable: imposible ver tendencias, estacionalidad o
  desempeño por categoría de servicio

## Solución

1. **ETL en Excel**: perfilado, normalización y consolidación de los registros
   manuscritos, con una bitácora de errores documentada (17 incidencias
   clasificadas por severidad) y una tabla de equivalencias que redujo 185
   descripciones libres a 132 servicios canónicos, conservando el valor
   original para trazabilidad.
2. **Modelo dimensional en SQL Server**: esquema en estrella con la tabla de
   hechos `RegistroServicio` y las dimensiones `CatalogoServicio`,
   `CategoriaServicio` y `Personal`.
3. **Dashboards** en Power BI (con medidas DAX) y Looker Studio para el
   seguimiento de KPIs: facturación, ticket promedio, estacionalidad y
   distribución por categoría y método de pago.

## Arquitectura de datos

Esquema en estrella / copo de nieve:

```
RegistroServicio (hechos)
 ├── IDPersonal   → Personal
 └── IDServicio   → CatalogoServicio → IDCategoria → CategoriaServicio
```

Ver [`sql/schema.sql`](sql/schema.sql) para el DDL completo.

## Proceso ETL

Resumen del flujo (detalle completo en [`etl/`](etl)):

| Paso | Descripción |
|---|---|
| Extracción | Consolidación de 6 hojas mensuales (Enero–Junio) en una sola tabla |
| Transformación | Normalización de nombres de servicio, parsing de fechas heterogéneas, inferencia de método de pago (Efectivo / Yape / Mixto), categorización |
| Validación | Anotación de registros ambiguos para verificar con la propietaria en vez de corregirlos a ciegas |
| Carga | Inserción en el modelo relacional de SQL Server |

## Dashboards

Capturas en [`powerbi/screenshots/`](powerbi/screenshots). 4 páginas:
Resumen Ejecutivo, Análisis de Servicio, Tendencias Temporales y Detalle
Operativo, más un tablero paralelo en Looker Studio con filtros por
servicio, periodo, personal y método de pago.

## Stack

- **ETL / staging**: Excel
- **Base de datos**: SQL Server (T-SQL)
- **Modelado**: Kimball / esquema en estrella
- **BI**: Power BI Desktop (DAX), Google Looker Studio
- **Documentación**: Word / PDF

## Datos

Los datos reales de facturación pertenecen a un negocio real y no se incluyen
en este repositorio. En [`data/sample/`](data/sample) hay un dataset sintético
con la misma estructura de columnas para poder correr el esquema y probar
consultas sin exponer información comercial de terceros.

## Equipo

Proyecto colaborativo — Ingeniería de Sistemas e Informática, 2026.
