-- ------------------------------------------------------------------------------
-- PROCESO PARA ELIMINAR REGISTROS Y VOLVER A CONTABILIZAR ORDENES DE PRODUCCION
-- ------------------------------------------------------------------------------
-- 1. Identificar asientos de las ordenes de produccion
SELECT *
FROM sf_tmpenc e
WHERE e.`tipo_doc` = 'TR'
AND e.`glosa` LIKE '%RECEPCION, ALMACEN (ALM PRODUCTOS TERMINADOS)%'
AND e.`fecha` BETWEEN '2017-08-01' AND '2017-09-31'
;

-- 2. Eliminar asientos
SELECT * FROM sf_tmpenc
-- delete from sf_tmpdet
-- DELETE FROM sf_tmpenc
WHERE id_tmpenc IN ();

-- Anular asientos
-- update sf_tmpenc e set e.estado = 'ANL', e.`descri` = 'Anulado por cambio en costo leche 3.20'
WHERE e.`id_tmpenc` IN (

);

-- 3. Identificar ordenes de produccion, vales
-- PARA ELIMINAR VALES Y  ASIENTOS DE ORDENES DE PRODUCCION
-- ORDEN DE PRODUCCION
SELECT p.`fecha`, o.`codigo`, o.`estadoorden`, o.`no_vale`, v.`no_trans`, o.`id_tmpenc`, o.`no_trans`, m.`cod_art`, i.`descri`, o.`cantidadproducida`, o.`costotoalproduccion`, o.`costounitario`, v.`estado`
FROM ordenproduccion o
LEFT JOIN planificacionproduccion p ON o.`idplanificacionproduccion` = p.`idplanificacionproduccion`
LEFT JOIN inv_vales v  		ON o.`no_vale`  = v.`no_vale`
LEFT JOIN inv_movdet m 		ON v.`no_trans` = m.`no_trans`
LEFT JOIN inv_articulos i 	ON m.`cod_art`  = i.`cod_art` 
WHERE p.`fecha` BETWEEN '2017-08-01' AND '2017-09-31'
;
-- PARA ELIMINAR VALES Y  ASIENTOS DE ORDENES DE PRODUCCION
-- REPROCESOS
SELECT ps.`idproductosimple`, ps.`estado`, pb.`idproductobase`, pb.`no_vale`, v.`no_trans`, pb.`id_tmpenc`, v.`estado`
FROM productosimple ps
JOIN productobase pb ON ps.`idproductobase` = pb.`idproductobase`
JOIN planificacionproduccion p ON pb.`idplanificacionproduccion` = p.`idplanificacionproduccion`
JOIN inv_vales v  		ON pb.`no_vale`  = v.`no_vale`
WHERE p.`fecha` BETWEEN '2017-08-01' AND '2017-09-31'
;

-- anular vales
-- update inv_vales i set i.`estado` = 'ANL'
WHERE i.`no_trans` IN ();

SELECT *
-- from inv_vales i
-- FROM inv_mov i
-- FROM inv_movdet i
-- delete FROM inv_movdet
-- delete FROM inv_mov
-- DELETE FROM inv_vales
WHERE no_trans IN (

);

-- Eliminar Costos Indirectos
-- ELIMINANDO COSTOS INDIRECTOS DE LAS ORDENES DE PROD. NORMALES
SELECT *
-- DELETE 
FROM costosindirectos 
WHERE idordenproduccion IN (
	SELECT o.`idordenproduccion`
	FROM ordenproduccion o
	JOIN planificacionproduccion p ON o.`idplanificacionproduccion` = p.`idplanificacionproduccion`
	WHERE p.`fecha` BETWEEN '2017-08-01' AND '2017-09-31'
);

-- ELIMINANDO COSTOS INDIRECTOS DE LAS ORDENES DE PROD. REPROCESOS
SELECT *
-- DELETE 
FROM costosindirectos 
WHERE idproductosimple IN (
	SELECT ps.idproductosimple
	FROM productosimple ps
	JOIN productobase pb ON ps.`idproductobase` = pb.`idproductobase`
	JOIN planificacionproduccion p ON pb.`idplanificacionproduccion` = p.`idplanificacionproduccion`
	WHERE p.`fecha` BETWEEN '2017-08-01' AND '2017-09-31'
);


SELECT *
FROM planificacionproduccion p
-- update planificacionproduccion p set p.`estado` = 'PENDING'
WHERE p.`fecha` BETWEEN '2017-08-01' AND '2017-08-31'
;

-- UPDATE productobase set estado = 'PENDING' WHERE ()... PARA CONTABILIZAR REPROCESOS
