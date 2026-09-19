USE master;
GO

-- Crear base de datos
CREATE DATABASE BDSpa;
GO

USE BDSpa;
GO

-- CREAR TABLAS

CREATE TABLE CategoriaServicio (
    IDCategoria   INT           PRIMARY KEY,
    NombreCategoria NVARCHAR(100) NOT NULL
);

CREATE TABLE CatalogoServicio (
    IDServicio    INT            PRIMARY KEY,
    NombreServicio NVARCHAR(200) NOT NULL,
    Descripcion   NVARCHAR(500)  NULL,
    PrecioBase    DECIMAL(10,2)  NOT NULL,
    IDCategoria   INT            NOT NULL,
    CONSTRAINT FK_Catalogo_Categoria FOREIGN KEY (IDCategoria)
        REFERENCES CategoriaServicio(IDCategoria)
);

CREATE TABLE Personal (
    IDPersonal    INT            PRIMARY KEY,
    Nombre        NVARCHAR(200)  NOT NULL,
    TipoPersonal  NVARCHAR(100)  NULL,
    Estado        NVARCHAR(50)   NULL
);

CREATE TABLE RegistroServicio (
    IDRegistroServicio INT            PRIMARY KEY,
    Fecha              DATE           NOT NULL,
    IDPersonal         INT            NOT NULL,
    IDServicio         INT            NOT NULL,
    Cantidad           INT            NOT NULL,
    Precio             DECIMAL(10,2)  NOT NULL,
    Total              DECIMAL(10,2)  NOT NULL,
    Modalidad          NVARCHAR(100)  NULL,
    MetodoPago         NVARCHAR(100)  NULL,
    Notas              NVARCHAR(500)  NULL,
    CONSTRAINT FK_Registro_Servicio FOREIGN KEY (IDServicio)
        REFERENCES CatalogoServicio(IDServicio),
    CONSTRAINT FK_Registro_Personal FOREIGN KEY (IDPersonal)
        REFERENCES Personal(IDPersonal)
);

GO

-- Los datos de catálogo (CategoriaServicio, CatalogoServicio) y las
-- transacciones (RegistroServicio) se cargan por separado.
-- Ver /data/sample para un dataset de ejemplo con la misma estructura.
