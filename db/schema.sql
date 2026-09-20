-- Esquema de base de datos para el ejercicio 13 (Edificio)
-- Motor: PostgreSQL 14+
-- Este script se ejecuta directamente dentro de la base de datos ya creada
-- por el proveedor de hosting (no crea ni selecciona la base de datos).

DROP TABLE IF EXISTS usuario;
CREATE TABLE usuario (
    id     VARCHAR(150) NOT NULL PRIMARY KEY, -- correo electronico del usuario, usado tambien como login
    clave  VARCHAR(255) NOT NULL,             -- clave con hash BCrypt, nunca en texto plano
    nombre VARCHAR(150) NOT NULL,
    rol    VARCHAR(20)  NOT NULL              -- ADMINISTRADOR o USUARIO
);

DROP TABLE IF EXISTS edificio;
CREATE TABLE edificio (
    id                    SERIAL PRIMARY KEY,
    nombre                VARCHAR(150)   NOT NULL,
    metros_cuadrados      DECIMAL(10,2)  NOT NULL,
    altura                DECIMAL(6,2)   NOT NULL,
    num_pisos             INT            NOT NULL,
    num_apartamentos      INT            NOT NULL,
    num_oficinas          INT            NOT NULL,
    nombre_parqueadero    VARCHAR(150),
    num_piscinas          INT            NOT NULL DEFAULT 0,
    pais                  VARCHAR(100)   NOT NULL,
    departamento          VARCHAR(100)   NOT NULL,
    ciudad                VARCHAR(100)   NOT NULL,
    tiene_ascensor        BOOLEAN        NOT NULL DEFAULT FALSE,
    valor_administracion  DECIMAL(12,2)  NOT NULL,
    tiene_zona_social     BOOLEAN        NOT NULL DEFAULT FALSE
);

CREATE INDEX idx_edificio_ciudad ON edificio (ciudad);
CREATE INDEX idx_edificio_num_pisos ON edificio (num_pisos);
CREATE INDEX idx_edificio_valor_admin ON edificio (valor_administracion);
