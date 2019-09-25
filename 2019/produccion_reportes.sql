-- Reporte de Produccion: Producto x Cantidad x Costo x DIA
SELECT o.`idordenproduccion`, p.`fecha`, m.`cod_art`, i.`descri`, v.`no_vale`, m.`cantidad`, v.`idtmpenc`, e.`tipo_doc`, e.`no_doc`, d.`id_tmpdet`, d.`debe` AS costo
FROM ordenproduccion o
LEFT JOIN planificacionproduccion p ON o.`idplanificacionproduccion` = p.`idplanificacionproduccion`
LEFT JOIN inv_vales v  		ON o.`no_vale`  = v.`no_vale`
LEFT JOIN inv_movdet m 		ON v.`no_trans` = m.`no_trans`
LEFT JOIN inv_articulos i 	ON m.`cod_art`  = i.`cod_art` 
LEFT JOIN sf_tmpenc e 		ON v.`idtmpenc` = e.`id_tmpenc`
LEFT JOIN sf_tmpdet d 		ON e.`id_tmpenc` = d.`id_tmpenc`
WHERE p.`fecha` BETWEEN '2018-01-01' AND '2018-12-31'
AND d.`cuenta` = '1510110201'
-- mand v.`no_vale` is not null
;

-- Reporte de Produccion: Producto x Cantidad x Costo x MES
SELECT MONTH(p.`fecha`) AS mes, m.`cod_art`, i.`descri`, SUM(m.`cantidad`) AS cantidad, SUM(d.`debe`) AS costo
FROM ordenproduccion o
LEFT JOIN planificacionproduccion p ON o.`idplanificacionproduccion` = p.`idplanificacionproduccion`
LEFT JOIN inv_vales v  		ON o.`no_vale`  = v.`no_vale`
LEFT JOIN inv_movdet m 		ON v.`no_trans` = m.`no_trans`
LEFT JOIN inv_articulos i 	ON m.`cod_art`  = i.`cod_art` 
LEFT JOIN sf_tmpenc e 		ON v.`idtmpenc` = e.`id_tmpenc`
LEFT JOIN sf_tmpdet d 		ON e.`id_tmpenc` = d.`id_tmpenc`
WHERE p.`fecha` BETWEEN '2018-01-01' AND '2018-12-31'
AND d.`cuenta` = '1510110201'
GROUP BY MONTH(p.`fecha`) , m.`cod_art`, i.`descri`
;

-- Reporte de Produccion: Producto x Cantidad x Costo x AÑO
SELECT YEAR(p.`fecha`) AS mes, m.`cod_art`, i.`descri`, SUM(m.`cantidad`) AS cantidad, SUM(d.`debe`) AS costo
FROM ordenproduccion o
LEFT JOIN planificacionproduccion p ON o.`idplanificacionproduccion` = p.`idplanificacionproduccion`
LEFT JOIN inv_vales v  		ON o.`no_vale`  = v.`no_vale`
LEFT JOIN inv_movdet m 		ON v.`no_trans` = m.`no_trans`
LEFT JOIN inv_articulos i 	ON m.`cod_art`  = i.`cod_art` 
LEFT JOIN sf_tmpenc e 		ON v.`idtmpenc` = e.`id_tmpenc`
LEFT JOIN sf_tmpdet d 		ON e.`id_tmpenc` = d.`id_tmpenc`
WHERE p.`fecha` BETWEEN '2018-01-01' AND '2018-12-31'
AND d.`cuenta` = '1510110201'
GROUP BY YEAR(p.`fecha`) , m.`cod_art`, i.`descri`
;


-- REPROCESO
--
-- SELECT p.`fecha`, pb.`codigo`, pb.`estado`, pb.`no_vale`, i.`cod_art`, i.`descri`, ps.`cantidad` AS cantidad, ps.`costototalproduccion`, ps.`costounitario`, pb.`id_tmpenc`, e.`no_trans`, e.`tipo_doc`, e.`no_doc`, e.`estado`, d.`id_tmpdet`, d.`debe`, d.`cod_art`
SELECT  MONTH(p.`fecha`)AS mes, i.`cod_art`, i.`descri`, SUM(ps.`cantidad`) AS cantidad, SUM(d.`debe`) AS costo
FROM productosimple ps
LEFT JOIN productosimpleprocesado pp ON ps.`idproductosimple` = pp.`idproductosimple`
LEFT JOIN metaproductoproduccion m   ON pp.`idmetaproductoproduccion` = m.`idmetaproductoproduccion`
LEFT JOIN productobase pb            ON ps.`idproductobase` = pb.`idproductobase`
LEFT JOIN planificacionproduccion p  ON pb.`idplanificacionproduccion` = p.`idplanificacionproduccion`
LEFT JOIN inv_articulos i 	     ON m.`cod_art`  = i.`cod_art`
LEFT JOIN sf_tmpenc e 		ON pb.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN sf_tmpdet d 		ON e.`id_tmpenc` = d.`id_tmpenc`
WHERE p.`fecha` BETWEEN '2018-01-01' AND '2018-12-31'
AND d.`cuenta` = '1510110201'
GROUP BY MONTH(p.`fecha`), i.`cod_art`, i.`descri`
;

-- REPORTE TOTAL MESxDia
-- Union Normal - Reproceso
SELECT z.dia, z.cod_art, z.nombrecorto, SUM(z.cantidad) AS cantidad, SUM(z.costo) AS costo, SUM(z.costo) / SUM(z.cantidad) AS unit
FROM (
	SELECT DAY(p.`fecha`) AS dia, m.`cod_art`, i.nombrecorto , SUM(m.`cantidad`) AS cantidad, SUM(d.`debe`) AS costo
	FROM ordenproduccion o
	LEFT JOIN planificacionproduccion p ON o.`idplanificacionproduccion` = p.`idplanificacionproduccion`
	-- left join inv_vales v  		on o.`no_vale`  = v.`no_vale`
	LEFT JOIN inv_vales v 		ON o.`idordenproduccion` = v.`idordenproduccion`
	LEFT JOIN inv_movdet m 		ON v.`no_trans` = m.`no_trans`
	LEFT JOIN inv_articulos i 	ON m.`cod_art`  = i.`cod_art` 
	LEFT JOIN sf_tmpenc e 		ON v.`idtmpenc` = e.`id_tmpenc`
	LEFT JOIN sf_tmpdet d 		ON e.`id_tmpenc` = d.`id_tmpenc`
	WHERE p.`fecha` BETWEEN '2019-04-01' AND '2019-04-30'
	AND d.`cuenta` = '1510110201'
	GROUP BY DAY(p.`fecha`) , m.`cod_art`, i.`descri`
	UNION ALL
	SELECT  DAY(p.`fecha`)AS dia, i.`cod_art`, i.`nombrecorto`, SUM(ps.`cantidad`) AS cantidad, SUM(d.`debe`) AS costo
	FROM productosimple ps
	LEFT JOIN productosimpleprocesado pp ON ps.`idproductosimple` = pp.`idproductosimple`
	LEFT JOIN metaproductoproduccion m   ON pp.`idmetaproductoproduccion` = m.`idmetaproductoproduccion`
	LEFT JOIN productobase pb            ON ps.`idproductobase` = pb.`idproductobase`
	LEFT JOIN planificacionproduccion p  ON pb.`idplanificacionproduccion` = p.`idplanificacionproduccion`
	LEFT JOIN inv_articulos i 	     ON m.`cod_art`  = i.`cod_art`
	LEFT JOIN sf_tmpenc e 		ON pb.`id_tmpenc` = e.`id_tmpenc`
	LEFT JOIN sf_tmpdet d 		ON e.`id_tmpenc` = d.`id_tmpenc`
	WHERE p.`fecha` BETWEEN '2019-04-01' AND '2019-04-30'
	AND d.`cuenta` = '1510110201'
	AND i.`cod_art` = d.`cod_art`
	GROUP BY DAY(p.`fecha`), i.`cod_art`, i.`descri`
) z
GROUP BY z.dia, z.cod_art, z.nombrecorto
;


-- 
-- Para: Planilla de Costo de Produccion v2
SELECT DAY(pl.`fecha`) AS dia, pr.`cod_art`, i.`nombrecorto`, SUM(pr.`cantidad`) AS cantidad, SUM(pr.`costo`) AS costo, SUM(pr.`costo`)/SUM(pr.`cantidad`) AS unit
FROM pr_producto pr
LEFT JOIN pr_plan pl ON pr.`idplan` = pl.`idplan`
LEFT JOIN inv_articulos i ON pr.`cod_art` = i.`cod_art`
WHERE pl.`fecha` BETWEEN '2019-07-01' AND '2019-07-31'
-- and i.cod_gru in (4, 6)
-- and i.cod_gru in (5)
GROUP BY DAY(pl.`fecha`), pr.`cod_art`, i.`descri`
;










