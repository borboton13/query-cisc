-- PROCESO PARA CORREGIR CU EN ARTICULOS PEDIDOS, PARA GENEREAR CV
-- COSTO DE VENTAS
--
--
-- VENTAS CREDITO - DETALLE VERIFICAR CU
SELECT p.`FECHA_ENTREGA`, a.`IDARTICULOSPEDIDO`, i.`cod_art`, i.`descri`, a.`PRECIO`, a.`CANTIDAD`, a.`PROMOCION`, a.`REPOSICION`, a.`TOTAL`, a.`IMPORTE`, a.`cu`, p.`CV`
FROM articulos_pedido a
JOIN pedidos p 		ON a.`IDPEDIDOS` = p.`IDPEDIDOS`
JOIN inv_articulos i 	ON a.`cod_art` = i.`cod_art` 
WHERE p.`FECHA_ENTREGA` BETWEEN '2019-01-01' AND '2019-01-31'
AND p.`ESTADO` <> 'ANULADO'
AND p.idtipopedido IN (1, 6) 
-- AND p.`IDUSUARIO` <> 5
AND p.`IDUSUARIO` = 5
;

-- VENTAS A CREDITO - COSTO TOTAL
SELECT a.`cod_art`, SUM(a.`CANTIDAD`) AS cantidad,  (SUM(a.`CANTIDAD`) * a.`cu`) AS cost_total
FROM articulos_pedido a
JOIN pedidos p 		ON a.`IDPEDIDOS` = p.`IDPEDIDOS`
WHERE p.`FECHA_ENTREGA` BETWEEN '2019-01-01' AND '2019-01-31'
-- AND p.`IDTIPOPEDIDO` = 1
AND p.idtipopedido IN (1, 6) 
AND p.`ESTADO` <> 'ANULADO'
AND p.`IDUSUARIO` = 5
GROUP BY a.`cod_art`
;

-- VENTAS AL CONTADO - DETALLE VERIFICAR CU
SELECT v.`FECHA_PEDIDO`, a.`IDARTICULOSPEDIDO`, i.`cod_art`, i.`descri`, a.`PRECIO`, a.`CANTIDAD`, a.`PROMOCION`, a.`REPOSICION`, a.`TOTAL`, a.`IMPORTE`, a.`cu`
FROM articulos_pedido a
JOIN ventadirecta v 	ON a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
JOIN inv_articulos i 	ON a.`cod_art` = i.`cod_art` 
WHERE v.`FECHA_PEDIDO` BETWEEN '2019-01-01' AND '2019-01-31'
AND v.`ESTADO` <> 'ANULADO'
-- AND v.`IDUSUARIO` <> 5
AND v.`IDUSUARIO` = 5
;

-- VENTAS AL CONTADO - COSTO TOTAL
SELECT a.`cod_art`, SUM(a.`CANTIDAD`) AS cantidad,  (SUM(a.`CANTIDAD`) * a.`cu`) AS cost_total
FROM articulos_pedido a
JOIN ventadirecta v 	ON a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
WHERE v.`FECHA_PEDIDO` BETWEEN '2019-01-01' AND '2019-01-31'
AND v.`ESTADO` <> 'ANULADO'
-- AND v.`IDUSUARIO` <> 5
AND v.`IDUSUARIO` = 5
GROUP BY a.`cod_art`
;



-- 1.- Eliminar de la tabla auxiliar
-- 
SELECT *
-- DELETE FROM auxinv
-- FROM auxinv
WHERE alm = 5;

-- 2.- Insertar en tabla auxiliar
-- INSERT INTO auxinv... (A_PROCESO_INV)
INSERT INTO auxinv
SELECT i.`cod_art`, i.`descri`, NULL, NULL, NULL, NULL, 5, NULL, i.`costo_uni`
FROM inv_articulos i
WHERE i.`cod_alm` = 5
;

--
-- 3.- actualizar costos
-- 	Queso Prensado en EDAM, 
--	127 LECHE SABORIZADA FRUTILLA 120
-- 	478 ILFRUT DURAZNO 150 ML 
--	138 YOGURT SACHET DURAZNO 80 CC

-- 4.- Fijar en cero
-- UPDATE articulos_pedido a
JOIN pedidos p 		ON a.`IDPEDIDOS` = p.`IDPEDIDOS`
SET a.`cu` = 0
WHERE p.`FECHA_ENTREGA` BETWEEN '2019-01-01' AND '2019-01-31'
-- AND p.`ESTADO` <> 'ANULADO'
AND p.idusuario <> 5
;


-- 5.- Actualizar CU Pedidos
SELECT p.`FECHA_ENTREGA`, a.`IDARTICULOSPEDIDO`, a.`cod_art`, a.`PRECIO`, a.`CANTIDAD`, a.`PROMOCION`, a.`REPOSICION`, a.`TOTAL`, a.`IMPORTE`, a.`cu`, ai.`costo_prom`
FROM articulos_pedido a
-- UPDATE articulos_pedido a
JOIN pedidos p 		ON a.`IDPEDIDOS` = p.`IDPEDIDOS`
JOIN auxinv ai		ON a.`cod_art` = ai.`cod_art`
SET a.`cu` = ai.costo_prom
WHERE p.`FECHA_ENTREGA` BETWEEN '2019-01-01' AND '2019-01-31'
AND p.`ESTADO` <> 'ANULADO'
-- AND p.`IDUSUARIO` <> 5
AND p.`IDUSUARIO` = 5
;


-- 6.- Actualizar CU ventas contado
SELECT v.`FECHA_PEDIDO`, a.`IDARTICULOSPEDIDO`, a.`cod_art`, a.`PRECIO`, a.`CANTIDAD`, a.`PROMOCION`, a.`REPOSICION`, a.`TOTAL`, a.`IMPORTE`, a.`cu`, ai.`costo_prom`
FROM articulos_pedido a
-- UPDATE articulos_pedido a
JOIN ventadirecta v 	ON a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
JOIN auxinv ai		ON a.`cod_art` = ai.`cod_art`
SET a.`cu` = ai.costo_prom
WHERE v.`FECHA_PEDIDO` BETWEEN '2019-01-01' AND '2019-01-31'
AND v.`ESTADO` <> 'ANULADO'
-- AND v.`IDUSUARIO` <> 5
AND v.`IDUSUARIO` = 5
;


--
--
-- CHECK ART VETERINARIOS
SELECT v.`FECHA_PEDIDO`, a.`IDARTICULOSPEDIDO`, a.`cod_art`, a.`PRECIO`, a.`CANTIDAD`, a.`PROMOCION`, a.`REPOSICION`, a.`TOTAL`, a.`IMPORTE`, a.`cu` -- , ai.`costo_prom`
FROM articulos_pedido a
JOIN ventadirecta v 	ON a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
-- JOIN auxinv ai		ON a.`cod_art` = ai.`cod_art`
WHERE v.`FECHA_PEDIDO` BETWEEN '2019-01-01' AND '2019-01-31'
AND v.`ESTADO` <> 'ANULADO'
AND v.`IDUSUARIO` IN (5)
;

SELECT *
FROM pedidos p
WHERE p.`FECHA_ENTREGA` BETWEEN '2018-06-01' AND '2018-06-30'
AND p.`ESTADO` <> 'ANULADO'
AND p.`IDUSUARIO` <> 5
;

SELECT *
FROM ventadirecta v
WHERE v.`FECHA_PEDIDO` BETWEEN '2018-07-01' AND '2018-07-31'
AND v.`ESTADO` <> 'ANULADO'
AND v.`IDUSUARIO` <> 5
;

-- PEDIDOS
SELECT * FROM pedidos p
-- UPDATE pedidos p SET p.`CV` = 0
WHERE p.`FECHA_ENTREGA` BETWEEN '2019-01-01' AND '2019-01-31'
AND p.`IDUSUARIO` <> 5
;

-- CONTADO
-- UPDATE ventadirecta v SET v.`CV` = 0 
WHERE v.`FECHA_PEDIDO` BETWEEN '2019-01-01' AND '2019-01-31'
AND v.`IDUSUARIO` <> 5
;




