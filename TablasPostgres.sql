-- Database: Proyecto_Integrador_DB

-- DROP DATABASE IF EXISTS "Proyecto_Integrador_DB";

--CREATE DATABASE "Proyecto_Integrador_DB"
    --WITH
    --OWNER = postgres
   -- ENCODING = 'UTF8'
    --LC_COLLATE = 'Spanish_Colombia.1252'
    --LC_CTYPE = 'Spanish_Colombia.1252'
   -- TABLESPACE = pg_default
  --  CONNECTION LIMIT = -1
    --IS_TEMPLATE = False;

--COMMENT ON DATABASE "Proyecto_Integrador_DB"
  --  IS 'Base de datos creada para la plaraforma ADA School.
--Creada por: Laura Salome Murcia Farfan 
--Cohorte 38';

CREATE TABLE Categoria
(
    ID_Categoria SERIAL PRIMARY KEY,
    nombre VARCHAR NOT NULL
);

CREATE TABLE Producto
(
    ID_Producto SERIAL PRIMARY KEY,
    nombre VARCHAR NOT NULL,
    marca VARCHAR NOT NULL,
    categoria_ID INT NOT NULL,
    precio_unitario INT NOT NULL,
    FOREIGN KEY (categoria_ID) REFERENCES Categoria(ID_Categoria)
);

CREATE TABLE Stock
(
    ID_Stock SERIAL PRIMARY KEY,
    sucursal_ID INT NOT NULL,
    producto_ID INT NOT NULL,
    cantidad INT NOT NULL,
    CONSTRAINT uc_stock UNIQUE (sucursal_ID, producto_ID),
    FOREIGN KEY (sucursal_ID) REFERENCES Sucursal(ID_Sucursal),
    FOREIGN KEY (producto_ID) REFERENCES Producto(ID_Producto)
);

CREATE TABLE Item
(
    ID_Item SERIAL PRIMARY KEY,
    orden_ID INT NOT NULL,
    producto_ID INT NOT NULL,
    cantidad INT NOT NULL,
    monto_venta MONEY NOT NULL,
    FOREIGN KEY (orden_ID) REFERENCES Orden(ID_Orden),
    FOREIGN KEY (producto_ID) REFERENCES Producto(ID_Producto)
);

CREATE TABLE Cliente
(
    ID_Cliente SERIAL PRIMARY KEY,
    nombre VARCHAR NOT NULL,
    telefono VARCHAR NOT NULL
);

CREATE TABLE Orden
(
    ID_Orden SERIAL PRIMARY KEY,
    cliente_ID INT NOT NULL,
    sucursal_ID INT NOT NULL,
    fecha DATE NOT NULL,
    total NUMERIC(10, 2) NOT NULL,
    FOREIGN KEY (cliente_ID) REFERENCES Cliente(ID_Cliente),
    FOREIGN KEY (sucursal_ID) REFERENCES Sucursal(ID_Sucursal)
);

CREATE TABLE Sucursal
(
    ID_Sucursal INT PRIMARY KEY,
    nombre VARCHAR NOT NULL,
    direccion VARCHAR NOT NULL
);
