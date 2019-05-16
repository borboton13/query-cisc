-- 
-- Ordenes Compra Veterinarios
SELECT e.`fecha`, e.`fecha_recepcion`, e.`no_orden`, d.`no_orden`, e.`total`, e.`sub_total`, d.`cod_art`, i.`descri`, d.`cant_sol`, d.`total`, d.`costo_uni`
FROM com_detoc d
LEFT JOIN com_encoc e 	  ON d.`id_com_encoc` = e.`id_com_encoc`
LEFT JOIN inv_articulos i ON d.`cod_art`      = i.`cod_art`
WHERE i.`cuenta_art` = '4430110900'
AND e.`fecha` BETWEEN '2016-05-01' AND '2016-07-31'
-- and e.`fecha_recepcion` between '2016-05-01' and '2016-07-31'
;


-- Ordenes Compra Veterinarios, Counter, CU PROMEDIO
-- SELECT e.`fecha`, e.`fecha_recepcion`, e.`no_orden`, d.`no_orden`, e.`total`, e.`sub_total`, d.`cod_art`, i.`descri`, d.`cant_sol`, d.`total`, d.`costo_uni`
CREATE VIEW vete08 AS
SELECT d.`cod_art`, i.`descri`, SUM(d.`cant_sol`) AS cant_sol, SUM(d.`total`) AS total, SUM(d.`costo_uni`) AS costo_uni , COUNT(d.`cod_art`) AS counter, (SUM(d.`costo_uni`) / COUNT(d.`cod_art`)) AS CU
FROM com_detoc d
LEFT JOIN com_encoc e 	  ON d.`id_com_encoc` = e.`id_com_encoc`
LEFT JOIN inv_articulos i ON d.`cod_art`      = i.`cod_art`
WHERE i.`cuenta_art` = '4430110900'
AND e.`fecha` BETWEEN '2016-01-01' AND '2016-11-30'
-- and e.`fecha_recepcion` between '2016-05-01' and '2016-07-31'
GROUP BY d.`cod_art`, i.`descri`
;

-- CANTIDAD DE VENTAS DE PRODUCTOS VETERINARIOS
-- select v.`FECHA_PEDIDO`, v.`CODIGO`, v.`ESTADO`, v.`TOTALIMPORTE`, p.`cod_art`, p.`CANTIDAD`, p.`PRECIO_INV`, p.`cu`, p.`IMPORTE`
CREATE VIEW venta08 AS
SELECT p.`cod_art`, SUM(p.`CANTIDAD`) AS cantidad
FROM articulos_pedido p
LEFT JOIN ventadirecta v  ON p.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
LEFT JOIN inv_articulos i ON p.`cod_art` = i.`cod_art`
WHERE i.`cuenta_art` = '4430110900'
AND v.`FECHA_PEDIDO` BETWEEN '2016-11-01' AND '2016-11-30'
AND v.estado <> 'ANULADO'
GROUP BY p.`cod_art`
;

SELECT v.*, e.`descri`, e.`CU`
FROM venta08 v
LEFT JOIN vete08 e ON v.`cod_art` = e.`cod_art`
;


--
-- PARA COSTO DE VENTAS Pedidos
-- select p.`IDPEDIDOS`, p.`FECHA_ENTREGA`, p.`ESTADO`, i.`cod_art`, i.`descri`, a.`CANTIDAD`
SELECT a.`cod_art`, i.`descri`, SUM(a.`CANTIDAD`) AS cantidad, i.`costo_uni`, i.`cu`
FROM articulos_pedido a
JOIN pedidos p       ON a.`IDPEDIDOS` = p.`IDPEDIDOS`
JOIN inv_articulos i ON a.`cod_art` = i.`cod_art` 
AND p.`ESTADO` <> 'ANULADO'
AND p.`IDTIPOPEDIDO` NOT IN (3,4)
WHERE p.`FECHA_ENTREGA` BETWEEN '2016-10-01' AND '2016-10-31'
GROUP BY a.`cod_art`,  i.`descri`
;

-- PARA COSTO DE VENTAS Ventas contado
-- select p.`IDPEDIDOS`, p.`FECHA_ENTREGA`, p.`ESTADO`, i.`cod_art`, i.`descri`, a.`CANTIDAD`
SELECT a.`cod_art`, i.`descri`, SUM(a.`CANTIDAD`) AS cantidad, i.`costo_uni`, i.`cu`
FROM articulos_pedido a
JOIN ventadirecta v  ON a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
JOIN inv_articulos i ON a.`cod_art` = i.`cod_art` 
AND v.`ESTADO` <> 'ANULADO'
AND i.`cuenta_art` = '4420110201'
WHERE v.`FECHA_PEDIDO` BETWEEN '2016-10-01' AND '2016-10-31'
GROUP BY a.`cod_art`,  i.`descri`
;



SELECT a.`IDARTICULOSPEDIDO`, v.`FECHA_PEDIDO`, a.`cod_art`, i.`descri`, a.`CANTIDAD`, i.`costo_uni`, i.`cu`, a.`cu`
FROM articulos_pedido a
LEFT JOIN ventadirecta v  ON a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
LEFT JOIN inv_articulos i ON a.`cod_art` = i.`cod_art`
WHERE i.`cuenta_art` = '4430110900'
AND v.`FECHA_PEDIDO` BETWEEN '2016-11-01' AND '2016-11-30'
AND v.`ESTADO` <> 'ANULADO'
-- GROUP BY p.`cod_art`
;










