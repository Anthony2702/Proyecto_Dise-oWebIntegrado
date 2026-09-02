-- ============================================================
-- Portal de Gestion de Clientes y Licencias - AUTODEV
-- Script de creacion de la base de datos (MySQL)
-- Desarrollo Web Integrado - APF1
-- Anthony Flores - U24221515
-- ============================================================

DROP DATABASE IF EXISTS autodev_db;
CREATE DATABASE autodev_db
    DEFAULT CHARACTER SET utf8mb4
    DEFAULT COLLATE utf8mb4_general_ci;

USE autodev_db;

-- ------------------------------------------------------------
-- Usuarios del portal
-- ------------------------------------------------------------
CREATE TABLE usuario (
    id_usuario      INT AUTO_INCREMENT,
    nombres         VARCHAR(80)  NOT NULL,
    correo          VARCHAR(100) NOT NULL,
    clave           VARCHAR(60)  NOT NULL,
    rol             VARCHAR(20)  NOT NULL,
    estado          CHAR(1)      NOT NULL DEFAULT 'A',
    fecha_registro  DATE         NOT NULL,
    CONSTRAINT pk_usuario     PRIMARY KEY (id_usuario),
    CONSTRAINT uq_usuario_correo UNIQUE (correo),
    CONSTRAINT ck_usuario_rol    CHECK (rol IN ('ADMINISTRADOR','VENDEDOR')),
    CONSTRAINT ck_usuario_estado CHECK (estado IN ('A','I'))
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- Clientes
-- ------------------------------------------------------------
CREATE TABLE cliente (
    id_cliente      INT AUTO_INCREMENT,
    ruc             CHAR(11)     NOT NULL,
    razon_social    VARCHAR(150) NOT NULL,
    contacto        VARCHAR(80)  NOT NULL,
    correo          VARCHAR(100) NOT NULL,
    telefono        VARCHAR(15),
    fecha_registro  DATE         NOT NULL,
    estado          CHAR(1)      NOT NULL DEFAULT 'A',
    CONSTRAINT pk_cliente     PRIMARY KEY (id_cliente),
    CONSTRAINT uq_cliente_ruc UNIQUE (ruc),
    CONSTRAINT ck_cliente_estado CHECK (estado IN ('A','I'))
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- Catalogo de productos
-- ------------------------------------------------------------
CREATE TABLE producto (
    id_producto     INT AUTO_INCREMENT,
    codigo          VARCHAR(20)   NOT NULL,
    nombre          VARCHAR(60)   NOT NULL,
    descripcion     VARCHAR(255)  NOT NULL,
    precio_anual    DECIMAL(10,2) NOT NULL,
    estado          CHAR(1)       NOT NULL DEFAULT 'A',
    CONSTRAINT pk_producto        PRIMARY KEY (id_producto),
    CONSTRAINT uq_producto_codigo UNIQUE (codigo),
    CONSTRAINT ck_producto_precio CHECK (precio_anual > 0),
    CONSTRAINT ck_producto_estado CHECK (estado IN ('A','I'))
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- Licencias (resuelve el N:M cliente-producto)
-- ------------------------------------------------------------
CREATE TABLE licencia (
    id_licencia     INT AUTO_INCREMENT,
    id_cliente      INT           NOT NULL,
    id_producto     INT           NOT NULL,
    fecha_inicio    DATE          NOT NULL,
    fecha_fin       DATE          NOT NULL,
    monto_contrato  DECIMAL(10,2) NOT NULL,
    estado          VARCHAR(12)   NOT NULL DEFAULT 'VIGENTE',
    CONSTRAINT pk_licencia          PRIMARY KEY (id_licencia),
    CONSTRAINT fk_licencia_cliente  FOREIGN KEY (id_cliente)  REFERENCES cliente(id_cliente),
    CONSTRAINT fk_licencia_producto FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
    CONSTRAINT ck_licencia_fechas   CHECK (fecha_fin > fecha_inicio),
    CONSTRAINT ck_licencia_estado   CHECK (estado IN ('VIGENTE','VENCIDA','ANULADA'))
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- Pagos por licencia
-- ------------------------------------------------------------
CREATE TABLE pago (
    id_pago         INT AUTO_INCREMENT,
    id_licencia     INT           NOT NULL,
    monto           DECIMAL(10,2) NOT NULL,
    fecha_pago      DATE          NOT NULL,
    medio_pago      VARCHAR(20)   NOT NULL,
    nro_operacion   VARCHAR(30)   NOT NULL,
    CONSTRAINT pk_pago          PRIMARY KEY (id_pago),
    CONSTRAINT fk_pago_licencia FOREIGN KEY (id_licencia) REFERENCES licencia(id_licencia),
    CONSTRAINT ck_pago_monto    CHECK (monto > 0),
    CONSTRAINT ck_pago_medio    CHECK (medio_pago IN ('YAPE','PLIN','TRANSFERENCIA','EFECTIVO','DEPOSITO'))
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- Indices
-- ------------------------------------------------------------
CREATE INDEX ix_licencia_fecha_fin ON licencia(fecha_fin);
CREATE INDEX ix_licencia_cliente   ON licencia(id_cliente);
CREATE INDEX ix_pago_licencia      ON pago(id_licencia);
