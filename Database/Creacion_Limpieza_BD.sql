-- database: F:\PruebaConocimientoIETS\Prueba Práctica - Cientifico Analista Datos\REPS_Analisis\Database\reps.db

-- ===========================================================
-- CREACIÓN DE TABLAS EN BASE DE DATOS reps.db
-- ===========================================================

-- Crear tabla Municipios
DROP TABLE IF EXISTS Municipios;
CREATE TABLE Municipios (
    DP INTEGER,
    Departamento TEXT,
    MPIO INTEGER,
    Municipio TEXT,
    Superficie REAL,
    PopTot INTEGER,
    Rural REAL,
    Region TEXT
);


-- Crear tabla Prestadores
DROP TABLE IF EXISTS Prestadores;
CREATE TABLE Prestadores (
    depa_nombre TEXT,
    muni_nombre TEXT,
    codigo_habilitacion TEXT,
    nombre_prestador TEXT,
    tido_codigo TEXT,
    nits_nit TEXT,
    razon_social TEXT,
    clpr_codigo TEXT,
    clpr_nombre TEXT,
    ese TEXT,
    direccion TEXT,
    telefono TEXT,
    fax TEXT,
    email TEXT,
    gerente TEXT,
    nivel TEXT,
    caracter TEXT,
    habilitado TEXT,
    fecha_radicacion TEXT,         
    fecha_vencimiento TEXT,        
    fecha_cierre TEXT,
    dv TEXT,
    clase_persona TEXT,
    naju_codigo TEXT,
    naju_nombre TEXT,
    numero_sede_principal TEXT,
    fecha_corte_REPS TEXT,
    telefono_adicional TEXT,
    email_adicional TEXT,
    rep_legal TEXT,
    Municipio_PDET TEXT,
    Municipio_ZOMAC TEXT,
    Municipio_PNIS TEXT,
    Municipio_PNSR_antes_2023 TEXT,
    Municipio_PNSR_2023 TEXT,
    Municipio_PNSR_2024 TEXT
);


-- Crear tabla Consolidado
DROP TABLE IF EXISTS Consolidado;
CREATE TABLE consolidado (
    depa_codigo INTEGER PRIMARY KEY,
    depa_nombre TEXT,
    total_prestadores INTEGER,
    total_sedes INTEGER,
    total_servicios INTEGER,
    total_camas INTEGER,
    total_salas INTEGER,
    total_sillas INTEGER,
    total_ambulancias INTEGER
);

-- ===========================================================
-- LIMPIEZA Y ESTANDARIZACIÓN DE CAMPOS EN MUNICIPIOS Y PRESTADORES
-- ===========================================================

-- --------------------------
-- LIMPIEZA: TABLA MUNICIPIOS
-- --------------------------

-- 1. Normalizar Departamento
-- Normalizar y limpiar campo Departamento
UPDATE Municipios
SET Departamento = UPPER(
    REPLACE(
        REPLACE(
            REPLACE(
                REPLACE(
                    REPLACE(
                        REPLACE(
                            REPLACE(
                                REPLACE(
                                    TRIM(LOWER(Departamento)),
                                '%', ''),
                            '&', ''),
                        '#', ''),
                    '!', ''),
                '*', ''),
            '?', ''),
        '>', ''),
    '''', '')
);

-- 2. Reemplazar múltiples espacios por uno solo
-- Reemplazar múltiples espacios en blanco
UPDATE Municipios
SET Departamento = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
    Departamento,
    '  ', ' '),
    '  ', ' '),
    '  ', ' '),
    '  ', ' '),
    '  ', ' '),
    '  ', ' '),
    '  ', ' '),
    '  ', ' '),
    '  ', ' ');

-- 3. Convertir a mayúsculas
UPDATE Municipios
SET Departamento = UPPER(Departamento);

-- 4. Normalizar Municipio
-- Normalizar y limpiar campo Municipio
UPDATE Municipios
SET Municipio = UPPER(
    REPLACE(
        REPLACE(
            REPLACE(
                REPLACE(
                    REPLACE(
                        REPLACE(
                            REPLACE(
                                REPLACE(
                                    TRIM(LOWER(Municipio)),
                                '%', ''),
                            '&', ''),
                        '#', ''),
                    '!', ''),
                '*', ''),
            '?', ''),
        '>', ''),
    '''', '')
);

-- Reemplazar múltiples espacios en blanco
UPDATE Municipios
SET Municipio = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
    Municipio,
    '  ', ' '),
    '  ', ' '),
    '  ', ' '),
    '  ', ' '),
    '  ', ' '),
    '  ', ' '),
    '  ', ' '),
    '  ', ' '),
    '  ', ' ');

UPDATE Municipios
SET Municipio = UPPER(Municipio);


-- -----------------------------
-- LIMPIEZA: TABLA PRESTADORES
-- -----------------------------

-- 1. Normalizar Departamento
UPDATE Prestadores
SET depa_nombre = UPPER(
    REPLACE(
        REPLACE(
            REPLACE(
                REPLACE(
                    REPLACE(
                        REPLACE(
                            REPLACE(
                                REPLACE(
                                    TRIM(LOWER(depa_nombre)),
                                '%', ''),
                            '&', ''),
                        '#', ''),
                    '!', ''),
                '*', ''),
            '?', ''),
        '>', ''),
    '''', '')
);

-- 2. Reemplazar múltiples espacios por uno solo
UPDATE Prestadores
SET depa_nombre = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
    depa_nombre,
    '  ', ' '),
    '  ', ' '),
    '  ', ' '),
    '  ', ' '),
    '  ', ' '),
    '  ', ' '),
    '  ', ' '),
    '  ', ' '),
    '  ', ' ');

-- 3. Convertir a mayúsculas
UPDATE Prestadores
SET depa_nombre = UPPER(depa_nombre);

-- 4. Normalizar Municipio
UPDATE Prestadores
SET muni_nombre = UPPER(
    REPLACE(
        REPLACE(
            REPLACE(
                REPLACE(
                    REPLACE(
                        REPLACE(
                            REPLACE(
                                REPLACE(
                                    TRIM(LOWER(muni_nombre)),
                                '%', ''),
                            '&', ''),
                        '#', ''),
                    '!', ''),
                '*', ''),
            '?', ''),
        '>', ''),
    '''', '')
);

UPDATE Prestadores
SET muni_nombre = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
    muni_nombre,
    '  ', ' '),
    '  ', ' '),
    '  ', ' '),
    '  ', ' '),
    '  ', ' '),
    '  ', ' '),
    '  ', ' '),
    '  ', ' '),
    '  ', ' ');

UPDATE Prestadores
SET muni_nombre = UPPER(muni_nombre);

-- ===========================================================
-- VALIDACIÓN: ¿EXISTEN MUNICIPIOS DE PRESTADORES SIN COINCIDENCIA?
-- ===========================================================
SELECT DISTINCT p.depa_nombre, p.muni_nombre
FROM Prestadores p
LEFT JOIN Municipios m
  ON p.depa_nombre = m.Departamento AND p.muni_nombre = m.Municipio
WHERE m.Municipio IS NULL
ORDER BY p.depa_nombre, p.muni_nombre;
