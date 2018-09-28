-- --------------------------------
-- Proceso Modificar CU Leche Cruda
-- --------------------------------

-- 1. Eliminando Costos Indirectos, Ord. Prod. Normal
SELECT *
-- DELETE 
FROM costosindirectos 
WHERE idordenproduccion IN (
	SELECT o.`idordenproduccion`
	FROM ordenproduccion o
	JOIN planificacionproduccion p ON o.`idplanificacionproduccion` = p.`idplanificacionproduccion`
	WHERE p.`fecha` BETWEEN '2017-08-01' AND '2017-09-31'
);

-- 2. Eliminando Costos Indirectos, Ord. Prod. Reprocesos
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

-- 3. PARA ELIMINAR VALES Y  ASIENTOS DE ORDENES DE PRODUCCION
-- ORDEN DE PRODUCCION
SELECT p.`fecha`, o.`codigo`, o.`estadoorden`, o.`no_vale`, v.`no_trans`, o.`id_tmpenc`, o.`no_trans`, m.`cod_art`, i.`descri`, o.`cantidadproducida`, o.`costotoalproduccion`, o.`costounitario`, v.`estado`
FROM ordenproduccion o
LEFT JOIN planificacionproduccion p ON o.`idplanificacionproduccion` = p.`idplanificacionproduccion`
LEFT JOIN inv_vales v  		ON o.`no_vale`  = v.`no_vale`
LEFT JOIN inv_movdet m 		ON v.`no_trans` = m.`no_trans`
LEFT JOIN inv_articulos i 	ON m.`cod_art`  = i.`cod_art` 
WHERE p.`fecha` BETWEEN '2017-08-01' AND '2017-09-31'
;

-- 4. PARA ELIMINAR VALES Y  ASIENTOS DE ORDENES DE PRODUCCION
-- REPROCESOS
SELECT ps.`idproductosimple`, ps.`estado`, pb.`idproductobase`, pb.`no_vale`, v.`no_trans`, pb.`id_tmpenc`
FROM productosimple ps
JOIN productobase pb ON ps.`idproductobase` = pb.`idproductobase`
JOIN planificacionproduccion p ON pb.`idplanificacionproduccion` = p.`idplanificacionproduccion`
JOIN inv_vales v  	       ON pb.`no_vale`  = v.`no_vale`
WHERE p.`fecha` BETWEEN '2017-08-01' AND '2017-09-31'
;

SELECT *
-- delete FROM inv_movdet 
-- delete FROM inv_mov
-- delete FROM inv_vales
WHERE no_trans IN (

);

-- 5. Eliminar asientos contables
SELECT *
-- delete 
FROM sf_tmpenc
-- delete from sf_tmpdet
WHERE id_tmpenc IN (

);

--
--
/** PARA CAMBIAR COSTO UNITARIO **/
SELECT 	DISTINCT
	op.`idordenproduccion`, 
	pl.`fecha`,
	op.`codigo`, 
	op.`cantidadproducida`, 
	op.`preciototalmaterial`, 	
	op.`preciototalinsumo`,
	op.`preciototalmanoobra`,
	op.`totalcostoindirecto`,
	op.`costotoalproduccion`,
	op.`costounitario`,
	oi.`idordeninsumo`,
	oi.`cod_art`, oi.`cantidad`, oi.`costototal`, oi.`costounitario`
FROM ordenproduccion op
LEFT JOIN ordeninsumo oi		ON op.`idordenproduccion` = oi.`idordenproduccion`
LEFT JOIN ordenmaterial om		ON op.`idordenproduccion` = om.`idordenproduccion`
LEFT JOIN costosindirectos ci 		ON op.`idordenproduccion` = ci.`idordenproduccion`
LEFT JOIN planificacionproduccion pl 	ON op.`idplanificacionproduccion` = pl.`idplanificacionproduccion`
WHERE pl.`fecha` BETWEEN '2017-08-01' AND '2017-09-31'
AND oi.`cod_art` = 1
;
--
/** PARA CAMBIAR COSTO UNITARIO REPROCESOS **/
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
WHERE pl.`fecha` BETWEEN '2017-08-01' AND '2017-09-31'
AND oi.`cod_art` = 1
;
--
-- 6. Actualizando (1) LECHE CRUDA a 3.30 en Orden Produccion NORMAL al 06/02/2017
-- UPDATE ordenproduccion 	SET preciototalinsumo = 	3875.84	,	costotoalproduccion = 	9103.7	,	costounitario = 	0.258628	 WHERE idordenproduccion = 	5398	;
-- UPDATE ordeninsumo 	SET costounitario = 3.3, 	costototal = 	561	 WHERE idordeninsumo = 	47103	;

--
-- 8. Cambiar etado planificacion
SELECT *
FROM ordenproduccion o
-- UPDATE ordenproduccion o
JOIN planificacionproduccion p ON o.`idplanificacionproduccion` = p.`idplanificacionproduccion`
SET o.`estadoorden` = 'FINALIZED'
WHERE p.`fecha` BETWEEN '2017-08-03' AND '2017-08-31'
;

-- 2. Select, Update. Estado Orden de produccion Reproceso
SELECT *
FROM productosimple ps
-- UPDATE productosimple ps 
JOIN productobase pb ON ps.`idproductobase` = pb.`idproductobase`
JOIN planificacionproduccion p ON pb.`idplanificacionproduccion` = p.`idplanificacionproduccion`
-- SET ps.`estado` = 'FINALIZED'
WHERE p.`fecha` BETWEEN '2017-08-01' AND '2017-08-31'
;

-- PARA VOLVER A CONTABILIZAR
SELECT *
FROM planificacionproduccion p
-- update planificacionproduccion p set p.`estado` = 'PENDING'
WHERE p.`fecha` BETWEEN '2017-08-01' AND '2017-08-31'
;

SELECT *
FROM productobase p
-- from productosimple p
-- UPDATE productobase p set p.estado = 'PENDING'
WHERE p.`idproductobase` IN (

);




