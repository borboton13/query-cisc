
-- Vales
SELECT 	d.`no_trans` AS id, 
	d.`fecha`, 
	v.`fecha`,
	v.`no_vale` AS codigo, 
	d.`cod_art`, 
	a.`descri`, 
	v.`estado`,
	d.`cod_alm`,
	d.`cantidad`, 
	IF(STRCMP(d.`tipo_mov`,'E'), 'Salida', 'Entrada') AS tipo_mov, 
	d.`costounitario`, d.`preciounitcompra`, d.`preciocompra`, d.`monto`,
	v.`id_com_encoc`
	-- m.descri AS descripcion
FROM inv_movdet d
LEFT JOIN inv_mov m 	  ON d.`no_trans` = m.no_trans
LEFT JOIN inv_vales v 	  ON d.`no_trans` = v.`no_trans`
LEFT JOIN inv_articulos a ON d.`cod_art` = a.`cod_art`
-- WHERE v.fecha BETWEEN '2017-01-01' AND '2017-12-31'
WHERE v.fecha >= '2017-01-01'
AND d.`cod_art` = 35
;

-- compras detalle
SELECT e.`id_com_encoc`, e.`fecha`, e.`fecha_recepcion`, e.`no_orden`, d.`cod_art`, d.`cant_sol`, d.`costo_uni`, d.`total` , e.`glosa`
FROM com_detoc d
LEFT JOIN com_encoc e ON d.`id_com_encoc` = e.`id_com_encoc`
WHERE e.fecha BETWEEN '2017-01-01' AND '2017-12-31'
-- WHERE e.`fecha_recepcion` BETWEEN '2017-01-01' AND '2017-12-31'
AND d.`cod_art` = 280
;


SELECT com.*, '-', val.*
FROM (
	-- compras detalle
	SELECT e.`id_com_encoc`, e.`fecha`, e.`fecha_recepcion`, e.`estado`, e.`no_orden`, d.`cod_art`, d.`cant_sol`, d.`costo_uni`, d.`total` -- , e.`glosa`
	FROM com_detoc d
	LEFT JOIN com_encoc e ON d.`id_com_encoc` = e.`id_com_encoc`
	WHERE e.`fecha` BETWEEN '2019-02-01' AND '2019-03-28'
	AND e.`cod_alm` = 5
--	AND d.`cod_art` = 624
     ) com
JOIN (
	SELECT 	d.`id_inv_movdet`,
		d.`no_trans`, 
		d.`fecha`, 
		v.`estado`,
		v.`no_vale` AS codigo, 
		d.`cod_art`, 
		a.`descri`, 
		a.`cantiad_equi`,
		d.`cantidad`, 
		IF(STRCMP(d.`tipo_mov`,'E'), 'Salida', 'Entrada') AS tipo_mov, 
		d.`costounitario`, d.`preciounitcompra`, d.`preciocompra`, d.`monto`,
		v.`id_com_encoc`
		-- m.descri AS descripcion
	FROM inv_movdet d
	LEFT JOIN inv_mov m 	  ON d.`no_trans` = m.no_trans
	LEFT JOIN inv_vales v 	  ON d.`no_trans` = v.`no_trans`
	LEFT JOIN inv_articulos a ON d.`cod_art` = a.`cod_art`
	WHERE v.fecha BETWEEN '2019-02-01' AND '2019-03-28'
	-- AND a.`cuenta_art` = "4430110900"
	-- AND d.`cod_art` = 624
     ) val ON com.id_com_encoc = val.id_com_encoc
WHERE com.cod_art = val.cod_art
-- where com.id_com_encoc = val.id_com_encoc
;     
     
     
 SELECT 	d.`id_inv_movdet`,
		d.`no_trans`, 
		d.`fecha`, 
		v.`estado`,
		v.`no_vale`, 
		d.`cod_art`, 
		d.`cantidad`, 
		d.`tipo_mov`, 
		d.`costounitario`, d.`preciounitcompra`, d.`preciocompra`, d.`monto`,
		v.`id_com_encoc`,
		c.`id_com_encoc`, c.`no_orden`, 
		de.`cant_sol`, de.`costo_uni`
	FROM inv_movdet d
	LEFT JOIN inv_mov m 	  ON d.`no_trans` = m.no_trans
	LEFT JOIN inv_vales v 	  ON d.`no_trans` = v.`no_trans`
	LEFT JOIN com_encoc c     ON v.`id_com_encoc` = c.`id_com_encoc`
	LEFT JOIN com_detoc de    ON c.`id_com_encoc` = de.`id_com_encoc`
	WHERE v.fecha >= '2017-01-01'
	AND v.`id_com_encoc` IS NOT NULL
	AND d.`cod_art` = de.`cod_art`
	;





