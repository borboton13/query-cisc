SELECT *
FROM inv_inventario
WHERE cod_alm = 2
;

-- update inv_inventario set saldo_uni = 0
WHERE cod_alm = 2
;

SELECT *
FROM inv_inventario_detalle
WHERE cod_alm = 2
;

-- update inv_inventario_detalle set cantidad = 0
WHERE cod_alm = 2
;

SELECT *
FROM inv_articulos
WHERE cuenta_art = '4420110201'
;

-- update inv_articulos set saldo_mon = 0
WHERE cuenta_art = '4420110201'
;

SELECT *
FROM inv_inventario
WHERE cod_art = 119
;

-- update inv_inventario set saldo_uni = 1000
WHERE cod_art = 254
;

SELECT *
FROM inv_inventario_detalle
WHERE cod_art = 254
;

SELECT *
FROM inv_inventario_detalle id
JOIN inv_inventario i ON id.`cod_art` = i.`cod_art`
WHERE i.cod_art = 118
;

-- update inv_inventario_detalle id
JOIN inv_inventario i ON id.cod_art = i.cod_art
SET id.cantidad = i.saldo_uni
WHERE i.cod_art = 119
;

SELECT *
FROM ventadirecta
WHERE FECHA_PEDIDO BETWEEN '2016-01-01' AND '2016-01-31'
;

-- 

SELECT *
FROM inv_inventario
WHERE cod_alm = 2
;

-- UPDATE inv_inventario i
JOIN resumensaldo r ON i.`cod_art` = r.cod_art
SET i.saldo_uni = i.saldo_uni + r.prod_total - r.venta_total
WHERE cod_alm = 2
;

-- UPDATE inv_inventario_detalle id
JOIN inv_inventario i ON id.cod_art = i.cod_art
SET id.cantidad = i.saldo_uni
WHERE i.`cod_alm` = 2
;


-- update inv_inventario set saldo_uni = 0
WHERE cod_alm = 2
;

-- UPDATE INVENTARIO FROM VIEW RESUMENSALDO
UPDATE inv_inventario i
JOIN resumensaldo r ON i.`cod_art` = r.cod_art
SET i.saldo_uni = i.saldo_uni + r.prod_total - r.venta_total
WHERE cod_alm = 2
;

UPDATE inv_inventario_detalle id
JOIN inv_inventario i ON id.cod_art = i.cod_art
SET id.cantidad = i.saldo_uni
WHERE i.`cod_alm` = 2
;



SELECT *
FROM ventaarticulo v
WHERE v.`cod_art` = 122
;

SELECT *
FROM ventacliente v
WHERE v.`cod_art` = 122
;

-- FOR PRODUCTION 01/02/2016, STOCKS AL 31/01/2016
--
-- 1. Reemplazar Chico 160 x Chico 150 en ARTICULOS_PEDIDOS
-- update articulos_pedido a set a.`cod_art` = 121
WHERE a.`cod_art` = 122
;

-- 2. Reemplazar Chico 160 x Chico 150 en VENTACLIENTE (precios especiales)
UPDATE ventacliente v SET v.`cod_art` = 121
WHERE v.`cod_art` = 122
;

-- Fijar cantidad en CERO tabla INV_PRODUCT (stocks prod)
UPDATE inv_product SET cantidad = 0;

-- Elminar registros
DELETE FROM inv_product_register;

-- Actualizar secuencia
UPDATE secuencia SET valor = 1
-- select * from secuencia
WHERE tabla = 'inv_product_register'
;

-- Quitar Chicot 160 de ventas, VENTAARTICULO
DELETE FROM ventaarticulo
WHERE cod_art = 122
;
