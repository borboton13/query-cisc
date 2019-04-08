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

-- REPORTE TOTAL POR MES
-- Union Normal - Reproceso
SELECT z.mes, z.cod_art, z.nombrecorto, SUM(z.cantidad) AS cantidad, SUM(z.costo) AS costo, SUM(z.costo) / SUM(z.cantidad) AS unit
FROM (
	SELECT DAY(p.`fecha`) AS mes, m.`cod_art`, i.nombrecorto , SUM(m.`cantidad`) AS cantidad, SUM(d.`debe`) AS costo
	FROM ordenproduccion o
	LEFT JOIN planificacionproduccion p ON o.`idplanificacionproduccion` = p.`idplanificacionproduccion`
	LEFT JOIN inv_vales v  		ON o.`no_vale`  = v.`no_vale`
	LEFT JOIN inv_movdet m 		ON v.`no_trans` = m.`no_trans`
	LEFT JOIN inv_articulos i 	ON m.`cod_art`  = i.`cod_art` 
	LEFT JOIN sf_tmpenc e 		ON v.`idtmpenc` = e.`id_tmpenc`
	LEFT JOIN sf_tmpdet d 		ON e.`id_tmpenc` = d.`id_tmpenc`
	WHERE p.`fecha` BETWEEN '2018-02-01' AND '2018-02-28'
	AND d.`cuenta` = '1510110201'
	GROUP BY DAY(p.`fecha`) , m.`cod_art`, i.`descri`
	UNION ALL
	SELECT  MONTH(p.`fecha`)AS mes, i.`cod_art`, i.`nombrecorto`, SUM(ps.`cantidad`) AS cantidad, SUM(d.`debe`) AS costo
	FROM productosimple ps
	LEFT JOIN productosimpleprocesado pp ON ps.`idproductosimple` = pp.`idproductosimple`
	LEFT JOIN metaproductoproduccion m   ON pp.`idmetaproductoproduccion` = m.`idmetaproductoproduccion`
	LEFT JOIN productobase pb            ON ps.`idproductobase` = pb.`idproductobase`
	LEFT JOIN planificacionproduccion p  ON pb.`idplanificacionproduccion` = p.`idplanificacionproduccion`
	LEFT JOIN inv_articulos i 	     ON m.`cod_art`  = i.`cod_art`
	LEFT JOIN sf_tmpenc e 		ON pb.`id_tmpenc` = e.`id_tmpenc`
	LEFT JOIN sf_tmpdet d 		ON e.`id_tmpenc` = d.`id_tmpenc`
	WHERE p.`fecha` BETWEEN '2018-02-01' AND '2018-02-28'
	AND d.`cuenta` = '1510110201'
	GROUP BY DAY(p.`fecha`), i.`cod_art`, i.`descri`
) z
GROUP BY z.mes, z.cod_art, z.nombrecorto
;



--
--
SELECT d.`cuenta`, a.`cod_art`, a.`descri`, SUM(d.`debe`) AS debe, SUM(d.`haber`) AS haber
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e 		ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN inv_articulos a 	ON d.`cod_art` = a.`cod_art` 
WHERE d.`cuenta` = '1510110201'
AND e.`fecha` BETWEEN '2018-01-01' AND '2018-12-31'
AND e.`estado` <> 'ANL'
GROUP BY d.`cuenta`, a.`cod_art`, a.`descri`
;



SELECT p.`IDPEDIDOS`, p.`FECHA_ENTREGA`, p.`CODIGO`, a.`cod_art`, i.`descri`, a.`CANTIDAD`, a.`PROMOCION`, a.`REPOSICION`, a.`cu`, p.`IDTIPOPEDIDO`, p.`id_tmpenc`, e.`no_trans`, e.`tipo_doc`, e.`no_doc`, d.`id_tmpdet`, 
d.`cuenta`, pc.`descri`, d.`debe`, d.`haber`
FROM articulos_pedido a
LEFT JOIN pedidos p 		ON a.`IDPEDIDOS` = p.`IDPEDIDOS`
LEFT JOIN inv_articulos i 	ON a.`cod_art` = i.`cod_art`
LEFT JOIN sf_tmpenc e 		ON p.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN sf_tmpdet d 		ON e.`id_tmpenc` = d.`id_tmpenc`
LEFT JOIN arcgms pc 		ON d.`cuenta` = pc.`cuenta`
WHERE p.`FECHA_ENTREGA` BETWEEN '2018-01-01' AND '2018-12-31'
AND p.`ESTADO` <> 'ANULADO'
AND p.`IDUSUARIO` <> 5
AND d.`cuenta` IN ('1510110201', '4470510300', '4470310400')
-- and p.`IDTIPOPEDIDO` <> 1
AND p.`IDTIPOPEDIDO` IN (1)
;










