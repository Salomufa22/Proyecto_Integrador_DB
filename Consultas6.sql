-- Calcular el precio promedio de los productos en cada categoría
SELECT c.nombre AS categoria_producto, AVG(p.precio_unitario) AS precio_promedio
FROM Producto p, Categoria c
WHERE p.categoria_ID = c.ID_Categoria
GROUP BY categoria_producto;
-- Obtener la cantidad total de productos en stock por categoría
SELECT c.nombre AS categoria_producto, SUM(s.cantidad) AS cantidad_productos
FROM Stock s, Categoria c, Producto p
WHERE s.producto_ID = p.ID_Producto AND p.categoria_ID = c.ID_Categoria
GROUP BY categoria_producto;
-- Calcular el total de ventas por sucursal
SELECT s.nombre AS nombre_sucursal, SUM(i.monto_venta) AS ventas_sucursal
FROM Item i, Sucursal s, Orden o
WHERE s.ID_Sucursal = o.sucursal_ID AND i.orden_ID = o.ID_Orden
GROUP BY nombre_sucursal;
-- Obtener el cliente que ha realizado el mayor monto de compras
SELECT c.nombre AS nombre_cliente, SUM(o.total) AS monto_compra
FROM Cliente c
JOIN Orden o ON c.ID_Cliente = o.cliente_ID
GROUP BY nombre_cliente
ORDER BY monto_compra DESC
LIMIT 1;

