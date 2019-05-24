SELECT d.`cod_art`, i.`descri`, SUM(d.`cant_sol`) AS cant_sol, SUM(d.`total`) AS total, SUM(d.`costo_uni`) AS costo_uni_sum , COUNT(d.`cod_art`) AS counter, (SUM(d.`costo_uni`) / COUNT(d.`cod_art`)) AS CU
FROM com_detoc d
LEFT JOIN com_encoc e 	  ON d.`id_com_encoc` = e.`id_com_encoc`
LEFT JOIN inv_articulos i ON d.`cod_art`      = i.`cod_art`
WHERE i.`cuenta_art` = '4460110300'
AND e.`fecha` BETWEEN '2016-05-01' AND '2016-11-30'
-- and e.`fecha_recepcion` between '2016-05-01' and '2016-07-31'
GROUP BY d.`cod_art`, i.`descri`
;


--
-- Insumos de Produccion
-- 
SELECT 	DISTINCT
	pl.`fecha`,
	oi.`cod_art`,
	op.`codigo`,
	oi.`cantidad`,
	oi.`costounitario`,
	oi.`costototal`
FROM ordenproduccion op
LEFT JOIN ordeninsumo oi		ON op.`idordenproduccion` = oi.`idordenproduccion`
LEFT JOIN planificacionproduccion pl 	ON op.`idplanificacionproduccion` = pl.`idplanificacionproduccion`
WHERE pl.`fecha` BETWEEN '2016-11-01' AND '2016-11-30'
AND oi.`cod_art` IN (12,13,14,15,18,20,8)
UNION ALL
SELECT 	DISTINCT
	pl.`fecha`, 
	oi.`cod_art`,
	pb.`codigo`, 
	oi.`cantidad`,
	oi.`costounitario`,
	oi.`costototal`
FROM productobase pb
LEFT JOIN productosimple ps 		ON pb.`idproductobase` = ps.`idproductobase`
LEFT JOIN ordeninsumo oi		ON pb.`idproductobase` = oi.`idproductobase`
LEFT JOIN planificacionproduccion pl 	ON pb.`idplanificacionproduccion` = pl.`idplanificacionproduccion`
WHERE pl.`fecha` BETWEEN '2016-11-01' AND '2016-11-30'
AND oi.`cod_art` IN (12,13,14,15,18,20,8)
;

-- REPORTE DE INSUMOS UTILIZADOS X FECHA
SELECT z.`cod_art`, z.`descri`, z.`cod_med`, SUM(z.cantidad) AS cantidad
FROM (
	SELECT oi.`cod_art`, a.`descri`, a.`cod_med`, SUM(oi.`cantidad`) AS cantidad
	FROM ordeninsumo oi 	
	LEFT JOIN inv_articulos a  		ON oi.`cod_art` = a.`cod_art`
	LEFT JOIN ordenproduccion op 		ON oi.`idordenproduccion` = op.`idordenproduccion`
	LEFT JOIN planificacionproduccion pl 	ON op.`idplanificacionproduccion` = pl.`idplanificacionproduccion`
	WHERE pl.`fecha` BETWEEN '2017-01-01' AND '2017-12-31'
	GROUP BY oi.`cod_art`, a.`descri`, a.`cod_med`
	UNION ALL
	SELECT oi.`cod_art`, a.`descri`, a.`cod_med`, SUM(oi.`cantidad`) AS cantidad
	FROM productobase pb
	LEFT JOIN productosimple ps 		ON pb.`idproductobase` = ps.`idproductobase`
	LEFT JOIN ordeninsumo oi		ON pb.`idproductobase` = oi.`idproductobase`
	LEFT JOIN inv_articulos a 		ON oi.`cod_art` = a.`cod_art`
	LEFT JOIN planificacionproduccion pl 	ON pb.`idplanificacionproduccion` = pl.`idplanificacionproduccion`
	WHERE pl.`fecha` BETWEEN '2017-01-01' AND '2017-12-31'
	GROUP BY oi.`cod_art`, a.`descri`, a.`cod_med`
) z 
GROUP BY z.`cod_art`, z.`descri`, z.`cod_med`
;


-- REPORTE DE MATERIALES UTILIZADOS X FECHA
SELECT z.`cod_art`, z.`descri`, z.`cod_med`, SUM(z.cantidad) AS cantidad
FROM (

	SELECT om.`cod_art`, a.`descri`, a.`cod_med`, SUM(om.`cantidadpesousada`) AS cantidad
	FROM ordenmaterial om 	
	LEFT JOIN inv_articulos a  		ON om.`cod_art` = a.`cod_art`
	LEFT JOIN ordenproduccion op 		ON om.`idordenproduccion` = op.`idordenproduccion`
	LEFT JOIN planificacionproduccion pl 	ON op.`idplanificacionproduccion` = pl.`idplanificacionproduccion`
	WHERE pl.`fecha` BETWEEN '2018-01-01' AND '2018-07-31'
	GROUP BY om.`cod_art`, a.`descri`, a.`cod_med`
	UNION ALL
	SELECT om.`cod_art`, a.`descri`, a.`cod_med`, SUM(om.`cantidadpesousada`) AS cantidad
	FROM productosimple ps
	LEFT JOIN productobase pb 		ON ps.`idproductobase` = pb.`idproductobase`
	LEFT JOIN ordenmaterial om		ON ps.idproductosimple = om.`idproductosimple`
	LEFT JOIN inv_articulos a 		ON om.`cod_art` = a.`cod_art`
	LEFT JOIN planificacionproduccion pl 	ON pb.`idplanificacionproduccion` = pl.`idplanificacionproduccion`
	WHERE pl.`fecha` BETWEEN '2018-01-01' AND '2018-07-31'
	GROUP BY om.`cod_art`, a.`descri`, a.`cod_med`
) z 
GROUP BY z.`cod_art`, z.`descri`, z.`cod_med`
;






