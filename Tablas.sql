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
    precio_unitario MONEY NOT NULL,
    FOREIGN KEY (categoria_ID) REFERENCES Categoria(ID_Categoria)
);

CREATE TABLE Stock
(
    ID_Stock SERIAL PRIMARY KEY, 
    sucursal_ID INT NOT NULL,
    producto_ID INT NOT NULL,
    cantidad INT NOT NULL, 
    UNIQUE (sucursal_ID, producto_ID),
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
    telefono INT NOT NULL   
);

CREATE TABLE Orden
(
    ID_Orden SERIAL PRIMARY KEY, 
    cliente_ID INT NOT NULL,
    sucursal_ID INT NOT NULL,
    fecha DATE NOT NULL,
    total MONEY NOT NULL,
    FOREIGN KEY (cliente_ID) REFERENCES Cliente(ID_Cliente),
    FOREIGN KEY (sucursal_ID) REFERENCES Sucursal(ID_Sucursal)
);

CREATE TABLE Sucursal
(
    ID_Sucursal SERIAL PRIMARY KEY, 
    nombre VARCHAR NOT NULL,
    direccion VARCHAR NOT NULL   
);



