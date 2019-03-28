-- ------------------------------------------------------
-- 1. Select, Update. Estado Orden de produccion Normal
-- ------------------------------------------------------
SELECT *
FROM ordenproduccion o
-- UPDATE ordenproduccion o
JOIN planificacionproduccion p ON o.`idplanificacionproduccion` = p.`idplanificacionproduccion`
SET o.`estadoorden` = 'FINALIZED'
WHERE p.`fecha` BETWEEN '2019-02-01' AND '2019-02-28'
-- AND o.codigo = '1611-0035'
;

-- 2. Select, Update. Estado Orden de produccion Reproceso
SELECT *
FROM productosimple ps
-- UPDATE productosimple ps 
JOIN productobase pb ON ps.`idproductobase` = pb.`idproductobase`
JOIN planificacionproduccion p ON pb.`idplanificacionproduccion` = p.`idplanificacionproduccion`
-- WHERE p.`fecha` BETWEEN '2019-02-01' AND '2019-02-28'
SET ps.`estado` = 'FINALIZED' 
WHERE p.`fecha` BETWEEN '2019-02-01' AND '2019-02-28'
;

-- , pb.`estado` = 'FINALIZED'

-- ------------------------------------------------------
-- ------
-- ORDEN PRODUCCION - VALES
-- ORDEN DE PRODUCCION POR MES + COSTO
SELECT o.`idordenproduccion`, p.`fecha`, p.`estado`, o.`codigo`, o.`estadoorden`, v.`no_trans`, v.`no_vale`, o.`no_vale`, m.`cod_art`, i.`descri`, o.`cantidadproducida`, o.`costotoalproduccion`, o.`costounitario`, o.`id_tmpenc`
FROM ordenproduccion o
LEFT JOIN planificacionproduccion p ON o.`idplanificacionproduccion` = p.`idplanificacionproduccion`
LEFT JOIN inv_vales v  		ON o.`no_vale`  = v.`no_vale`
-- LEFT JOIN inv_vales v  		ON o.`no_trans`  = v.`no_trans`
LEFT JOIN inv_movdet m 		ON v.`no_trans` = m.`no_trans`
LEFT JOIN inv_articulos i 	ON m.`cod_art`  = i.`cod_art` 
WHERE p.`fecha` BETWEEN '2019-01-01' AND '2019-01-31'
-- mand v.`no_vale` is not null
;

-- ORDEN DE PRODUCCION POR MES + COSTO + asiento
SELECT o.`idordenproduccion`, p.`fecha`, m.`cod_art`, i.`descri`, v.`no_vale`,
v.`idtmpenc`, e.`tipo_doc`, e.`no_doc`, d.`id_tmpdet`, d.`debe`, d.`cod_art`, d.`cant_art`
FROM ordenproduccion o
LEFT JOIN planificacionproduccion p ON o.`idplanificacionproduccion` = p.`idplanificacionproduccion`
LEFT JOIN inv_vales v  		ON o.`no_vale`  = v.`no_vale`
LEFT JOIN inv_movdet m 		ON v.`no_trans` = m.`no_trans`
LEFT JOIN inv_articulos i 	ON m.`cod_art`  = i.`cod_art` 
LEFT JOIN sf_tmpenc e 		ON v.`idtmpenc` = e.`id_tmpenc`
LEFT JOIN sf_tmpdet d 		ON e.`id_tmpenc` = d.`id_tmpenc`
WHERE p.`fecha` BETWEEN '2019-01-01' AND '2019-01-31'
AND d.`cuenta` = '1510110201'
-- mand v.`no_vale` is not null
;

-- REPROCESOS
SELECT pb.`idproductobase`, p.`fecha`, pb.`codigo`, pb.`estado`, i.`cod_art`, i.`descri`, ps.`idproductosimple`, ps.`estado`, ps.`cantidad` AS cantidad, ps.`costototalproduccion`, ps.`costounitario`, pb.`no_vale`,
pb.`id_tmpenc`
FROM productosimple ps
LEFT JOIN productosimpleprocesado pp ON ps.`idproductosimple` = pp.`idproductosimple`
LEFT JOIN metaproductoproduccion m   ON pp.`idmetaproductoproduccion` = m.`idmetaproductoproduccion`
LEFT JOIN productobase pb            ON ps.`idproductobase` = pb.`idproductobase`
LEFT JOIN planificacionproduccion p  ON pb.`idplanificacionproduccion` = p.`idplanificacionproduccion`
LEFT JOIN inv_articulos i 	     ON m.`cod_art`  = i.`cod_art`
WHERE p.`fecha` BETWEEN '2019-01-01' AND '2019-01-31'
-- GROUP BY i.`cod_art`, i.`descri`
;

SELECT p.`fecha`, pb.`codigo`, pb.`estado`, pb.`no_vale`, i.`cod_art`, i.`descri`, ps.`cantidad` AS cantidad, ps.`costototalproduccion`, ps.`costounitario`, 
pb.`id_tmpenc`, e.`no_trans`, e.`tipo_doc`, e.`no_doc`, e.`estado`, d.`id_tmpdet`, d.`debe`, d.`cod_art`, d.`cant_art`
FROM productosimple ps
LEFT JOIN productosimpleprocesado pp ON ps.`idproductosimple` = pp.`idproductosimple`
LEFT JOIN metaproductoproduccion m   ON pp.`idmetaproductoproduccion` = m.`idmetaproductoproduccion`
LEFT JOIN productobase pb            ON ps.`idproductobase` = pb.`idproductobase`
LEFT JOIN planificacionproduccion p  ON pb.`idplanificacionproduccion` = p.`idplanificacionproduccion`
LEFT JOIN inv_articulos i 	     ON m.`cod_art`  = i.`cod_art`
LEFT JOIN sf_tmpenc e 		ON pb.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN sf_tmpdet d 		ON e.`id_tmpenc` = d.`id_tmpenc`
WHERE p.`fecha` BETWEEN '2019-01-01' AND '2019-01-31'
AND d.`cuenta` = '1510110201'
;

-- PRODUCTOS REPROCESADOS
SELECT p.`fecha`, pb.`codigo`, i.`cod_art`, i.`descri`, pr.`unidades`, pr.`volumen`
FROM productoreprocesado pr
LEFT JOIN productobase pb 	     ON pr.`idproductobase` = pb.`idproductobase`
LEFT JOIN planificacionproduccion p  ON pb.`idplanificacionproduccion` = p.`idplanificacionproduccion`
LEFT JOIN metaproductoproduccion m   ON pr.`idmetaproductoproduccion` = m.`idmetaproductoproduccion`
LEFT JOIN inv_articulos i 	     ON m.`cod_art`  = i.`cod_art`
WHERE p.`fecha` BETWEEN '2019-01-01' AND '2019-01-31'
;

-- PRODUCTOS REPROCESADOS GROUP BY
SELECT i.`cod_art`, i.`descri`, SUM(pr.`unidades`) unds, SUM(pr.`volumen`) vol
FROM productoreprocesado pr
LEFT JOIN productobase pb 	     ON pr.`idproductobase` = pb.`idproductobase`
LEFT JOIN planificacionproduccion p  ON pb.`idplanificacionproduccion` = p.`idplanificacionproduccion`
LEFT JOIN metaproductoproduccion m   ON pr.`idmetaproductoproduccion` = m.`idmetaproductoproduccion`
LEFT JOIN inv_articulos i 	     ON m.`cod_art`  = i.`cod_art`
WHERE p.`fecha` BETWEEN '2019-01-01' AND '2019-01-31'
GROUP BY i.`cod_art`, i.`descri`
;


SELECT pb.`idproductobase`, pb.`estado`, pb.`codigo`, pp.`fecha`, pr.`idproductoreprocesado`, pr.`unidades`, pr.`volumen`
FROM productobase pb 
LEFT JOIN planificacionproduccion pp ON pb.`idplanificacionproduccion` = pp.`idplanificacionproduccion`
LEFT JOIN productoreprocesado pr     ON pb.`idproductobase` = pr.`idproductobase`
WHERE pp.`fecha` BETWEEN '2019-01-01' AND '2019-01-31'
;

-- -------------------------------------------------------------------------
-- PARA CU, Orden de produccion NORMAL
-- ORDEN DE PRODUCCION POR MES + 
-- SELECT 	p.`fecha`, o.`codigo`, o.`estadoorden`, o.`no_vale`, m.`cod_art`, i.`descri`, 
SELECT 	m.`cod_art`, i.`descri`, 
	SUM(o.`cantidadproducida`) AS CANT_PROD, 
	SUM(o.`costotoalproduccion`) AS COSTO_TOTAL, 
	SUM(o.`costounitario`) AS COSTO_UNIT,
	COUNT(o.`no_vale`) AS COUNTER
FROM ordenproduccion o
LEFT JOIN planificacionproduccion p ON o.`idplanificacionproduccion` = p.`idplanificacionproduccion`
LEFT JOIN inv_vales v  		ON o.`no_vale`  = v.`no_vale`
LEFT JOIN inv_movdet m 		ON v.`no_trans` = m.`no_trans`
LEFT JOIN inv_articulos i 	ON m.`cod_art`  = i.`cod_art` 
WHERE p.`fecha` BETWEEN '2016-09-01' AND '2016-09-30'
GROUP BY m.`cod_art`, i.`descri`
;

-- PARA CU, Orden de produccion REPROCESOS
-- SELECT p.`fecha`, pb.`codigo`, pb.`estado`, i.`cod_art`, i.`descri`, ps.`cantidadproducidaresponsable` as cantidad, ps.`costototalproduccion`, ps.`costounitario`
SELECT 	i.`cod_art`, i.`descri`, 
	SUM(ps.`cantidadproducidaresponsable`) AS cantidad, 
	SUM(ps.`costototalproduccion`) AS costo_prod, 
	SUM(ps.`costounitario`) AS costounit, 
	COUNT(ps.`idproductosimple`) AS counter
FROM productosimple ps
LEFT JOIN productosimpleprocesado pp ON ps.`idproductosimple` = pp.`idproductosimple`
LEFT JOIN metaproductoproduccion m   ON pp.`idmetaproductoproduccion` = m.`idmetaproductoproduccion`
LEFT JOIN productobase pb            ON ps.`idproductobase` = pb.`idproductobase`
LEFT JOIN planificacionproduccion p  ON pb.`idplanificacionproduccion` = p.`idplanificacionproduccion`
LEFT JOIN inv_articulos i 	     ON m.`cod_art`  = i.`cod_art`
WHERE p.`fecha` BETWEEN '2016-09-01' AND '2016-09-30'
GROUP BY i.`cod_art`, i.`descri`
;


-- -----------------------------------------------------------------
--  VENTAS PEDIDOS + CONTADO, PARA CU
-- -----------------------------------------------------------------
SELECT ped.*, con.*, i.`costo_uni`, i.`cu`
FROM 	(
	SELECT a.`cod_art` AS COD_ART, ar.`descri` AS PRODUCTO, SUM(a.`CANTIDAD`) AS CANTIDAD, SUM(a.`IMPORTE`) AS TOTAL_BS
	FROM articulos_pedido a
	LEFT JOIN pedidos p 	   ON a.idpedidos = p.`IDPEDIDOS`
	LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
	WHERE p.`FECHA_ENTREGA` BETWEEN '2016-10-01' AND '2016-10-31'
	AND p.`ESTADO` <> 'ANULADO' AND p.`IDTIPOPEDIDO` = 1
	GROUP BY a.`cod_art`, ar.`descri`
	) ped
LEFT JOIN (
	SELECT a.`cod_art` AS COD_ART, ar.`descri` AS PRODUCTO, SUM(a.`CANTIDAD`) AS CANTIDAD, SUM(a.`IMPORTE`) AS TOTAL_BS
	FROM articulos_pedido a
	LEFT JOIN ventadirecta v   ON a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
	LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
	WHERE v.`FECHA_PEDIDO` BETWEEN '2016-10-01' AND '2016-10-31'
	AND v.`ESTADO` <> 'ANULADO'
	AND ar.`cuenta_art` = '4420110201'
	GROUP BY a.`cod_art`, ar.`descri`
	) con ON ped.cod_art = con.cod_art 
LEFT JOIN inv_articulos i ON ped.cod_Art = i.`cod_art`
;


/** PARA CAMBIAR COSTO UNITARIO DEL AGUA 152 **/
SELECT 	DISTINCT
	op.`idordenproduccion`, 
	pl.`fecha`,
	op.`codigo`, 
	op.`preciototalmaterial`, 	
	op.`preciototalinsumo`,
	op.`preciototalmanoobra`,
	op.`totalcostoindirecto`,
	op.`costotoalproduccion`,
	op.`cantidadproducida`, 
	op.`costounitario`,
	oi.`idordeninsumo`,
	oi.`cod_art`, oi.`cantidad`, oi.`costototal`, oi.`costounitario`
FROM ordenproduccion op
LEFT JOIN ordeninsumo oi		ON op.`idordenproduccion` = oi.`idordenproduccion`
LEFT JOIN ordenmaterial om		ON op.`idordenproduccion` = om.`idordenproduccion`
LEFT JOIN costosindirectos ci 		ON op.`idordenproduccion` = ci.`idordenproduccion`
LEFT JOIN planificacionproduccion pl 	ON op.`idplanificacionproduccion` = pl.`idplanificacionproduccion`
WHERE pl.`fecha` BETWEEN '2018-12-26' AND '2018-12-26'
-- AND oi.`cod_art` = 1
-- AND om.`cod_art` = 74
;

SELECT 	DISTINCT
	pb.`idproductobase`, ps.`idproductosimple`,
	pl.`fecha`, pb.`codigo`, ps.`cantidadproducidaresponsable`, 
	ps.`costototalmateriales`,
	ps.`costototalinsumos`,
	ps.`costototalmanoobra`, 
	ps.`costototalindirecto`,
	ps.`costototalproduccion`,
	ps.`costounitario`,
	oi.`idordeninsumo`,
	oi.`cod_art`, oi.`cantidad`, oi.`costototal`, oi.`costounitario`
FROM productobase pb
LEFT JOIN productosimple ps 		ON pb.`idproductobase` = ps.`idproductobase`
LEFT JOIN ordeninsumo oi		ON pb.`idproductobase` = oi.`idproductobase`
-- LEFT JOIN ordenmaterial om		ON om.`idordenproduccion`
LEFT JOIN costosindirectos ci 		ON ps.`idproductosimple` = ci.`idproductosimple`
LEFT JOIN planificacionproduccion pl 	ON pb.`idplanificacionproduccion` = pl.`idplanificacionproduccion`
WHERE pl.`fecha` BETWEEN '2018-12-26' AND '2018-12-26'
-- AND oi.`cod_art` = 1
;

SELECT *
FROM productobase
UPDATE productobase SET estado = 'PENDING', no_trans = NULL
WHERE idproductobase IN (
 
);

-- ------------------------------------
-- ------------------------------------

-- Prod Sep
-- SELECT COD_ART, NOMBRE, SUM(CANTIDAD_SC), SUM(CANTIDAD_SP), SUM(REPROCESO_SC), SUM(REPROCESO_SP)
SELECT p.COD_ART, p.NOMBRE, SUM(p.CANTIDAD_SC) + SUM(p.REPROCESO_SC) AS CANTIDAD, i.cu, (SUM(p.CANTIDAD_SC) + SUM(p.REPROCESO_SC))*i.cu AS COSTO
FROM producciontotal p
LEFT JOIN inv_articulos i ON p.cod_art = i.cod_art
WHERE p.fecha BETWEEN '2016-12-08' AND '2016-12-08'
GROUP BY p.COD_ART, p.NOMBRE
;

-- COSTO UNITARIO PROMEDIO, MAY - NOV
SELECT 	
	a.cod_art, 
	i.`descri`, 
	(IFNULL(b.cantidad, 0) + IFNULL(c.cantidad, 0)) AS cantidad, 
	(IFNULL(b.costototal, 0) + IFNULL(c.costototal, 0)) AS costototal, 
	( (IFNULL(b.costototal, 0) + IFNULL(c.costototal, 0)) / (IFNULL(b.cantidad, 0) + IFNULL(c.cantidad, 0)) ) AS costo_uni
	
FROM (
	SELECT i.`cod_art`
	FROM inv_inventario i
	WHERE i.`cod_alm` = 2
	) a
LEFT JOIN (
	-- COSTOS TOTALES PRODUCCION NORMAL
	SELECT m.`cod_art`, m.`descripcion`, SUM(op.`cantidadproducida`) AS cantidad, SUM(op.`costotoalproduccion`) costototal
	FROM ordenproduccion op
	LEFT JOIN planificacionproduccion p ON op.`idplanificacionproduccion` = p.`idplanificacionproduccion`
	LEFT JOIN composicionproducto c ON op.`idcomposicionproducto` = c.`idcomposicionproducto`
	LEFT JOIN productoprocesado pp ON c.`idproductoprocesado` = pp.`idproductoprocesado`
	LEFT JOIN metaproductoproduccion m ON pp.`idproductoprocesado` = m.`idmetaproductoproduccion`
	WHERE p.fecha BETWEEN '2016-12-12' AND '2016-12-16'
	GROUP BY m.`cod_art`, m.`descripcion`
	) b 	ON a.cod_art = b.cod_art
LEFT JOIN (
	-- COSTOS TOTALES REPROCESOS
	SELECT m.`cod_art`, m.`descripcion`, SUM(ps.`cantidad`) AS cantidad, SUM(ps.`costototalproduccion`) AS costototal 
	FROM productosimple ps
	LEFT JOIN productobase pb ON ps.`idproductobase` = pb.`idproductobase`
	LEFT JOIN planificacionproduccion p ON pb.`idplanificacionproduccion` = p.`idplanificacionproduccion`
	LEFT JOIN productosimpleprocesado pr ON ps.`idproductosimple` = pr.`idproductosimple`
	LEFT JOIN metaproductoproduccion m ON pr.`idmetaproductoproduccion` = m.`idmetaproductoproduccion`
	WHERE p.fecha BETWEEN '2016-12-12' AND '2016-12-16'
	GROUP BY m.`cod_art`, m.`descripcion`
	) c 	ON a.cod_art = c.cod_art
LEFT JOIN inv_articulos i ON a.cod_art = i.`cod_art`
;

-- 14/02/2018
SELECT  p.`fecha`,
	m.`cod_art`, 
	m.`descripcion`, 
	op.`cantidadproducida` AS cantidad, 
	op.`costounitario`,
	op.`costotoalproduccion` AS costototal
FROM ordenproduccion op
LEFT JOIN planificacionproduccion p ON op.`idplanificacionproduccion` = p.`idplanificacionproduccion`
LEFT JOIN composicionproducto c ON op.`idcomposicionproducto` = c.`idcomposicionproducto`
LEFT JOIN productoprocesado pp ON c.`idproductoprocesado` = pp.`idproductoprocesado`
LEFT JOIN metaproductoproduccion m ON pp.`idproductoprocesado` = m.`idmetaproductoproduccion`
WHERE p.fecha BETWEEN '2019-01-01' AND '2019-01-31'
;





-- COSTOS TOTALES PRODUCCION NORMAL
	SELECT m.`cod_art`, m.`descripcion`, SUM(op.`cantidadproducida`) AS cantidad, SUM(op.`costotoalproduccion`) AS costototal, (SUM(op.`costotoalproduccion`) / SUM(op.`cantidadproducida`)) AS cu
	FROM ordenproduccion op
	LEFT JOIN planificacionproduccion p 	ON op.`idplanificacionproduccion` = p.`idplanificacionproduccion`
	LEFT JOIN composicionproducto c 	ON op.`idcomposicionproducto` = c.`idcomposicionproducto`
	LEFT JOIN productoprocesado pp 		ON c.`idproductoprocesado` = pp.`idproductoprocesado`
	LEFT JOIN metaproductoproduccion m 	ON pp.`idproductoprocesado` = m.`idmetaproductoproduccion`
	WHERE p.fecha BETWEEN '2019-01-01' AND '2019-01-31'
	GROUP BY m.`cod_art`, m.`descripcion`
	;


	-- COSTOS TOTALES REPROCESOS
	SELECT m.`cod_art`, m.`descripcion`, SUM(ps.`cantidad`) AS cantidad, SUM(ps.`costototalproduccion`) AS costototal 
	FROM productosimple ps
	LEFT JOIN productobase pb ON ps.`idproductobase` = pb.`idproductobase`
	LEFT JOIN planificacionproduccion p ON pb.`idplanificacionproduccion` = p.`idplanificacionproduccion`
	LEFT JOIN productosimpleprocesado pr ON ps.`idproductosimple` = pr.`idproductosimple`
	LEFT JOIN metaproductoproduccion m ON pr.`idmetaproductoproduccion` = m.`idmetaproductoproduccion`
	WHERE p.fecha BETWEEN '2019-01-01' AND '2019-01-31'
	GROUP BY m.`cod_art`, m.`descripcion`
	;




SELECT t.`COD_ART`, t.`NOMBRE`, SUM(t.`COSTOTOTALPRODUCCION`) AS COSTO_TOTAL, SUM(t.`CANT_TOTAL`) AS CANT_TOTAL, SUM(t.`COSTOTOTALPRODUCCION`) / SUM(t.`CANT_TOTAL`) AS COSTO_UNI
FROM producciontotal t
WHERE t.`FECHA` BETWEEN '2019-01-01' AND '2019-01-31'
GROUP BY t.`COD_ART`, t.`NOMBRE`
;

SELECT CONCAT(i.`gestion`, '-01-01') AS fecha, i.`cod_art`, i.`nombre`, '0000-0000', i.`cantidad`, 0, 0, 0, (i.`cantidad` * i.`costo_uni`) AS COSTOTOTALPRODUCCION
FROM inv_inicio i 
WHERE i.`alm` = 2
AND i.`cantidad` > 0
;


-- Produccion Total - costo_uni
SELECT t.`COD_ART`, t.`NOMBRE`, SUM(t.`COSTOTOTALPRODUCCION`), SUM(t.`CANT_TOTAL`), (SUM(t.`COSTOTOTALPRODUCCION`)/SUM(t.`CANT_TOTAL`))
FROM producciontotal t
WHERE t.`FECHA` BETWEEN '2019-01-01' AND '2019-01-31'
GROUP BY t.`COD_ART`, t.`NOMBRE`
;

SELECT *
FROM producciontotal t
WHERE t.`FECHA` BETWEEN '2019-01-01' AND '2019-01-31'
GROUP BY t.`COD_ART`, t.`NOMBRE`
;

SELECT d.`cod_art`, SUM(d.`monto`), SUM(d.`cantidad`), SUM(d.`monto`) / SUM(d.`cantidad`)
FROM inv_movdet d
LEFT JOIN inv_vales v ON d.`no_trans` = v.`no_trans`
WHERE v.`fecha` BETWEEN '2019-01-01' AND '2019-01-31'
AND v.`cod_alm` = 2 AND v.id
GROUP BY d.`cod_art`
;

SELECT t.`COD_ART`, t.`NOMBRE`, SUM(t.`COSTOTOTALPRODUCCION`), SUM(t.`CANT_TOTAL`), (SUM(t.`COSTOTOTALPRODUCCION`)/SUM(t.`CANT_TOTAL`))
FROM producciontotal t
WHERE t.`FECHA` BETWEEN '2019-01-01' AND '2019-01-31'
-- AND t.`COD_ART` = 118
GROUP BY t.`COD_ART`, t.`NOMBRE`
;

	SELECT d.`cod_art`, SUM(d.`monto`), SUM(d.`cantidad`), SUM(d.`monto`) / SUM(d.`cantidad`)
	-- SELECT d.`cod_art`, d.`monto`, d.`cantidad`, d.`preciounitcompra`, v.`id_com_encoc`
	FROM inv_movdet d
	LEFT JOIN inv_vales v ON d.`no_trans` = v.`no_trans`
	WHERE v.`fecha` BETWEEN '2019-01-01' AND '2019-03-31'
	AND v.`cod_alm` = 2 AND d.tipo_mov = 'E' AND v.id_com_encoc IS NOT NULL
	GROUP BY d.`cod_art`
	;


SELECT t.`COD_ART`, (SUM(t.`COSTOTOTALPRODUCCION`)/SUM(t.`CANT_TOTAL`))
FROM producciontotal t
WHERE t.`FECHA` BETWEEN '2019-01-01' AND '2019-01-31'
GROUP BY t.`COD_ART`
;

SELECT z.cod_art, SUM(z.monto) / SUM(z.cantidad)
FROM (
	SELECT d.`cod_art`, SUM(d.`monto`) AS monto, SUM(d.`cantidad`) AS cantidad
	FROM inv_movdet d
	LEFT JOIN inv_vales v ON d.`no_trans` = v.`no_trans`
	WHERE v.`fecha` BETWEEN '2019-01-01' AND '2019-03-31'
	AND v.`cod_alm` = 2 AND d.tipo_mov = 'E' AND v.id_com_encoc IS NOT NULL
	GROUP BY d.`cod_art`
	UNION
	SELECT t.`COD_ART`, SUM(t.`COSTOTOTALPRODUCCION`) AS monto,   SUM(t.`CANT_TOTAL`) AS cantidad
	FROM producciontotal t
	WHERE t.`FECHA` BETWEEN '2019-01-01' AND '2019-01-31'
	GROUP BY t.`COD_ART`
) z 
GROUP BY z.cod_art
;


-- Ventas Totales
SELECT v.`cod_art`, a.`descri`, SUM(v.`CANTIDAD`), SUM(v.`PROMOCION`), SUM(v.`REPOSICION`), SUM(v.`TOTAL`)
FROM ventas v
LEFT JOIN inv_articulos a ON v.`cod_art` = a.`cod_art`
WHERE v.`FECHA` BETWEEN '2019-01-01' AND '2019-01-31'
AND v.`idusuario` = 5
GROUP BY v.`cod_art`, a.`descri`
;

SELECT v.`cod_art`, a.`descri`, v.`CANTIDAD`, v.`PROMOCION`, v.`REPOSICION`, v.`TOTAL`, v.`idtipopedido`
FROM ventas v
LEFT JOIN inv_articulos a ON v.`cod_art` = a.`cod_art`
WHERE v.`FECHA` BETWEEN '2019-01-01' AND '2019-01-31'
AND v.`idusuario` = 5 
-- AND v.`idtipopedido` IN (1,5)
;

-- REPOSICIONES y PROMOCIONES
SELECT z.cod_art, SUM(z.cantidad)
FROM (	-- REPOSICIONES + PROMOCION EN PEDIDOS NORMALES
	SELECT a.`cod_art`, SUM(a.`REPOSICION`) + SUM(a.`PROMOCION`) AS cantidad
	FROM articulos_pedido a
	LEFT JOIN pedidos p ON a.`IDPEDIDOS` = p.`IDPEDIDOS`
	WHERE p.`FECHA_ENTREGA` BETWEEN '2019-01-01' AND '2019-01-31'
	AND p.`IDTIPOPEDIDO` = 1 AND p.`ESTADO` <> 'ANULADO'
	GROUP BY a.`cod_art`
	UNION
	-- REPOSICIONES
	SELECT a.`cod_art`, SUM(a.`CANTIDAD`) AS cantidad
	FROM articulos_pedido a
	LEFT JOIN pedidos p ON a.`IDPEDIDOS` = p.`IDPEDIDOS`
	WHERE p.`FECHA_ENTREGA` BETWEEN '2019-01-01' AND '2019-01-31'
	AND p.`IDTIPOPEDIDO` = 4 AND p.`ESTADO` <> 'ANULADO'
	GROUP BY a.`cod_art`
) z 
GROUP BY z.cod_art
;


SELECT a.`cod_art`, SUM(a.`REPOSICION`) + SUM(a.`PROMOCION`)
FROM articulos_pedido a
LEFT JOIN pedidos p ON a.`IDPEDIDOS` = p.`IDPEDIDOS`
WHERE p.`FECHA_ENTREGA` BETWEEN '2019-01-01' AND '2019-01-31'
AND p.`IDTIPOPEDIDO` = 1 AND p.`ESTADO` <> 'ANULADO'
GROUP BY a.`cod_art`
;	


-- DEGUSTACION
SELECT a.`cod_art`, SUM(a.`CANTIDAD`) AS degustacion
FROM articulos_pedido a
LEFT JOIN pedidos p ON a.`IDPEDIDOS` = p.`IDPEDIDOS`
WHERE p.`FECHA_ENTREGA` BETWEEN '2019-01-01' AND '2019-01-31'
AND p.`IDTIPOPEDIDO` = 2 AND p.`ESTADO` <> 'ANULADO'
GROUP BY a.`cod_art`
;


-- COMPRAS PROD VETE
SELECT *
FROM com_detoc d
JOIN com_encoc e ON d.`id_com_encoc` = e.`id_com_encoc`
WHERE e.`fecha_recepcion` BETWEEN '2019-01-01' AND '2019-01-31'
AND e.`cod_alm` = 5
;

SELECT *
FROM inv_movdet d
LEFT JOIN inv_vales v ON d.`no_trans` = v.`no_trans`
WHERE v.`fecha` BETWEEN '2019-01-01' AND '2019-01-31'
AND v.`cod_alm` = 5
;
SELECT d.`cod_art`, SUM(d.`monto`), SUM(d.`cantidad`), SUM(d.`monto`) / SUM(d.`cantidad`)
FROM inv_movdet d
LEFT JOIN inv_vales v ON d.`no_trans` = v.`no_trans`
WHERE v.`fecha` BETWEEN '2019-01-01' AND '2019-01-31'
AND v.`cod_alm` = 5
GROUP BY d.`cod_art`
;

SELECT d.`cod_art`, SUM(d.`monto`) / SUM(d.`cantidad`)
FROM inv_movdet d
LEFT JOIN inv_vales v ON d.`no_trans` = v.`no_trans`
WHERE v.`fecha` BETWEEN '2019-01-01' AND '2019-01-31'
AND v.`cod_alm` = 5
GROUP BY d.`cod_art`
;

-- compras veterinarias
SELECT z.cod_art, SUM(z.monto) / SUM(z.cantidad)
FROM (
	SELECT d.`cod_art`, d.`monto`, d.`cantidad`
	FROM inv_movdet d
	LEFT JOIN inv_vales v ON d.`no_trans` = v.`no_trans`
	WHERE v.`fecha` BETWEEN '2019-01-01' AND '2019-01-31'
	AND v.`cod_alm` = 5
	AND d.tipo_mov = 'E' AND v.id_com_encoc IS NOT NULL
	UNION
	SELECT i.`cod_art`, (i.`costo_uni` * i.`cantidad`) AS monto, i.cantidad
	FROM inv_inicio i
	WHERE i.`gestion` = 2019
	AND i.`alm` = 5
	AND i.`cantidad` > 0
) z 
GROUP BY z.cod_art
;

-- TOTAL PRODUCTOS
SELECT z.cod_art, SUM(z.monto) / SUM(z.cantidad) AS costo_uni
FROM ( 
	SELECT i.cod_art, SUM(i.cantidad * i.costo_uni) AS monto, SUM(i.cantidad) AS cantidad
	FROM inv_inicio i
	WHERE i.gestion = 2019 AND i.alm = 2 AND i.cantidad > 0
	GROUP BY i.cod_art
	UNION
	SELECT d.cod_art, SUM(d.monto) AS monto, SUM(d.cantidad) AS cantidad 
        FROM inv_movdet d 
        LEFT JOIN inv_vales v ON d.no_trans = v.no_trans 
        WHERE v.fecha BETWEEN '2019-01-01' AND '2019-01-31'
        AND v.cod_alm = 2 AND d.tipo_mov = 'E' AND v.id_com_encoc IS NOT NULL 
        GROUP BY d.cod_art 
        UNION 
        SELECT t.cod_art, SUM(t.costototalproduccion) AS monto,   SUM(t.cant_total) AS cantidad 
        FROM producciontotal t 
        WHERE t.fecha BETWEEN '2019-01-01' AND '2019-01-31'
        GROUP BY t.cod_art 
        ) z 
GROUP BY z.cod_art 
;

SELECT z.cod_art, a.descri, SUM(z.monto) AS monto, SUM(z.cantidad) AS cantidad, SUM(z.monto) / SUM(z.cantidad) AS costo_uni
FROM ( 
	SELECT i.cod_art, SUM(i.cantidad * i.costo_uni) AS monto, SUM(i.cantidad) AS cantidad
	FROM inv_inicio i
	WHERE i.gestion = 2019 AND i.alm = 2 AND i.cantidad > 0
	GROUP BY i.cod_art
	UNION
	SELECT d.cod_art, SUM(d.monto) AS monto, SUM(d.cantidad) AS cantidad 
        FROM inv_movdet d 
        LEFT JOIN inv_vales v ON d.no_trans = v.no_trans 
        WHERE v.fecha BETWEEN '2019-01-01' AND '2019-01-31'
        AND v.cod_alm = 2 AND d.tipo_mov = 'E' AND v.id_com_encoc IS NOT NULL 
        GROUP BY d.cod_art 
        UNION 
        SELECT t.cod_art, SUM(t.costototalproduccion) AS monto,   SUM(t.cant_total) AS cantidad 
        FROM producciontotal t 
        WHERE t.fecha BETWEEN '2019-01-01' AND '2019-01-31'
        GROUP BY t.cod_art 
        ) z 
LEFT JOIN inv_articulos a ON z.cod_art = a.cod_art
GROUP BY z.cod_art, a.descri
;

SELECT i.`cod_art`, SUM(i.`cantidad` * i.costo_uni) AS monto, SUM(i.`cantidad`) AS cantidad
FROM inv_inicio i
WHERE i.`gestion` = 2019 AND i.`alm` = 2 AND i.`cantidad` > 0
GROUP BY i.`cod_art`
;




