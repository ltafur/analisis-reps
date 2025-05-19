# Análisis de Datos REPS - Registro Especial de Prestadores de Servicios de Salud

Este repositorio contiene el análisis exploratorio, descriptivo y econométrico del Registro Especial de Prestadores de Servicios de Salud (REPS), utilizando datos de distintas fuentes relacionadas con municipios y prestadores en Colombia.

## 📂 Fuentes de datos utilizadas

- **Tabla Municipios**: Información sociodemográfica por municipio (población, ruralidad, superficie).
- **Tabla Prestadores**: Registro detallado de prestadores de servicios de salud habilitados (naturaleza jurídica, nivel de atención, fechas de radicación).
- **Tabla Consolidados**: Resumen por departamento de la cantidad de prestadores.

## ⚙️ Proceso de análisis

### 1. Creación de la base de datos

- Se utilizó SQLite3 para construir una base de datos `reps.db`.
- Las tablas fueron definidas y limpiadas mediante el archivo SQL `Creacion_Limpieza_BD.sql`.
- Posteriormente, los datos fueron cargados desde archivos planos con Pandas en el notebook `Carga_Datos.ipynb`.

### 2. Exploración y limpieza

- Se identificaron y corrigieron inconsistencias en los nombres de departamentos y municipios entre tablas.
- Se detectó que 114 municipios registrados en la tabla Municipios no tenían prestadores asociados, información relevante para el análisis posterior.

### 3. Análisis descriptivo de Municipios

- Se calcularon métricas como la densidad poblacional (hab/km²) y se analizó la distribución urbano-rural por municipio y departamento.
- Antioquia resultó ser el departamento con mayor cantidad de población rural.

### 4. Análisis descriptivo de Prestadores

- Se identificó que los prestadores más frecuentes son profesionales independientes, con naturaleza jurídica privada, nivel de atención 1, y de carácter municipal.
- Se observó una tendencia creciente en la radicación de prestadores desde 2008.

### 5. Análisis Consolidados y cruce de datos

- Se analizó la cantidad de prestadores por departamento y por cada 10 mil habitantes.
- Se contrastaron los datos con población municipal y regional.

## 📈 Análisis Econométrico

Se ajustó un modelo de regresión lineal simple para estimar la población total municipal en función del número de prestadores habilitados:

```text
Modelo: PopTot ~ cantidad_prestadores
R-cuadrado: 0.945
Coeficiente: 531.90
