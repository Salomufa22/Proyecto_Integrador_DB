--Obtener el precio mínimo, precio máximo y precio promedio de todos los productos.
SELECT MIN(precio_unitario) AS Minimo,
	MAX(precio_unitario) AS Maximo,
	AVG(precio_unitario) AS Promedio
FROM Producto;

--Calcular la cantidad total de productos en stock por sucursal.
SELECT
    Sucursal.nombre AS sucursal,
    SUM(Stock.cantidad) AS cantidad_total
FROM Sucursal
LEFT JOIN Stock ON Sucursal.ID_Sucursal = Stock.sucursal_ID
GROUP BY Sucursal.nombre;

--Obtener el total de ventas por cliente.
SELECT
    Cliente.nombre AS cliente,
    SUM(orden.total) AS cantidad_total
FROM Cliente
LEFT JOIN orden ON Cliente.ID_Cliente = orden.cliente_ID
GROUP BY Cliente.nombre;

