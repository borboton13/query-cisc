
SELECT 	d.`no_trans`, 
	v.`fecha`,
	m.`fecha_cre`, m.`fecha_mov`,
	d.`fecha`, 
	v.`no_vale` AS codigo, 
	d.`cod_art`, 
	a.`descri`, 
	d.`cantidad`, 
	IF(STRCMP(d.`tipo_mov`,'E'), 'Salida', 'Entrada') AS tipo_mov, v.`idordenproduccion`, v.`idproductobase`,
	m.descri AS descripcion
FROM inv_movdet d
LEFT JOIN inv_mov m 	  ON d.`no_trans` = m.no_trans
LEFT JOIN inv_vales v 	  ON d.`no_trans` = v.`no_trans`
LEFT JOIN inv_articulos a ON d.`cod_art` = a.`cod_art`
WHERE v.fecha BETWEEN '2017-01-01' AND '2017-12-31'
-- WHERE d.fecha BETWEEN '2017-01-01' AND '2017-12-31'
-- AND d.`cod_alm` = 2
-- AND d.`tipo_mov` = 'E'
AND d.`cod_art` = 35
;
--
--
-- CREATE OR REPLACE VIEW kardexart AS 
-- VALES
SELECT 	d.`no_trans` AS id, 
	d.`fecha`, 
	v.`no_vale` AS codigo, 
	d.`cod_art`, 
	a.`descri`, 
	d.`cantidad`, 
	IF(STRCMP(d.`tipo_mov`,'E'), 'Salida', 'Entrada') AS tipo_mov, 
	m.descri AS descripcion
FROM inv_movdet d
LEFT JOIN inv_mov m 	  ON d.`no_trans` = m.no_trans
LEFT JOIN inv_vales v 	  ON d.`no_trans` = v.`no_trans`
LEFT JOIN inv_articulos a ON d.`cod_art` = a.`cod_art`
WHERE v.fecha >= '2017-01-01'
UNION ALL
-- VENTAS CONTADO
SELECT 	a.`IDARTICULOSPEDIDO`,
	v.`FECHA_PEDIDO`,
	v.`CODIGO`,
	a.`cod_art`, 
	ar.`descri`, 
	a.`TOTAL` AS cantidad,
	'Salida' AS tipo_mov,
	CONCAT('Venta al contado ', v.`CODIGO`) AS descripcion
FROM articulos_pedido a
JOIN ventadirecta v ON a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
WHERE v.`FECHA_PEDIDO` >= '2017-01-01'
UNION ALL
SELECT 	a.`IDARTICULOSPEDIDO`,
	p.`FECHA_ENTREGA`,
	p.`CODIGO`,
	a.`cod_art`, 
	ar.`descri`, 
	a.`TOTAL` AS cantidad,
	'Salida' AS tipo_mov,
	CONCAT('Venta a credito ', p.`CODIGO`) AS descripcion
FROM articulos_pedido a
JOIN pedidos p ON a.`IDPEDIDOS` = p.`IDPEDIDOS`
JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
WHERE p.`FECHA_ENTREGA` >= '2017-01-01'
;



SELECT *
FROM kardexart k
WHERE k.`cod_art` = 35
AND k.`fecha` BETWEEN '2017-01-01' AND '2017-12-31';



SELECT IF(STRCMP('S','E'), 'Salida', 'Entrada');





