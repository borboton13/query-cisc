-- 1.- ACTUALIZAR TABLA AUXINV CON CANTIDAD Y COSTO_PROM A UNA FECHA DADA
-- 1.1 Eliminando tabla
DELETE FROM auxinv WHERE alm = 2;

-- 1.2 Insertando
-- INSERT INTO auxinv (cod_art, nombre, cantidad, und, alm, cu, costo_uni, costo_prom)
SELECT 	t.`cod_art`, t.`nombre`, 
	t.`cantidad` + IFNULL(pp.prod_total, 0) - IFNULL(vv.total, 0) - IFNULL(b.cantidad, 0) AS inv_final,
	'UN',
	2, 0, 0, 
	cu.costo_uni
FROM inv_tmp t -- -> Inventario inicial, cargar los nuevos productos 
LEFT JOIN (
	-- VENTAS TOTALES
	SELECT v.`cod_art`, a.`descri`, SUM(v.`TOTAL`) AS total
	FROM ventas v
	JOIN inv_inventario i ON v.`cod_art` = i.`cod_art`
	JOIN inv_articulos a  ON i.`cod_art` = a.`cod_art`
	WHERE i.`cod_alm` = 2
	AND v.`FECHA` BETWEEN '2017-01-01' AND '2017-10-31'
	GROUP BY v.`cod_art`, a.`descri`
	) vv ON t.`cod_art` = vv.cod_art
LEFT JOIN (
	-- PRODUCCION TOTAL
	SELECT p.`COD_ART`, p.`NOMBRE`, SUM((p.`CANTIDAD_SP` + p.`REPROCESO_SP`)) AS prod_total
	FROM producciontotal p
	WHERE p.`FECHA` BETWEEN '2017-01-01' AND '2017-10-31'
	GROUP BY p.`COD_ART`, p.`NOMBRE`
	) pp ON t.`cod_art` = pp.cod_art
LEFT JOIN (
	-- COSTO UNITARIO PROMEDIO, PRODUCCION
	SELECT 	a.cod_art, i.`descri`, IFNULL( ( (IFNULL(b.costototal, 0) + IFNULL(c.costototal, 0)) / (IFNULL(b.cantidad, 0) + IFNULL(c.cantidad, 0)) ), 0 ) AS costo_uni
	FROM 	( SELECT i.`cod_art`
		  FROM inv_inventario i
		  WHERE i.`cod_alm` = 2
		) a
	LEFT JOIN (	-- COSTOS TOTALES PRODUCCION NORMAL
				SELECT m.`cod_art`, m.`descripcion`, SUM(op.`cantidadproducida`) AS cantidad, SUM(op.`costotoalproduccion`) costototal
				FROM ordenproduccion op
				JOIN planificacionproduccion p ON op.`idplanificacionproduccion` = p.`idplanificacionproduccion`
				JOIN composicionproducto c ON op.`idcomposicionproducto` = c.`idcomposicionproducto`
				JOIN productoprocesado pp ON c.`idproductoprocesado` = pp.`idproductoprocesado`
				JOIN metaproductoproduccion m ON pp.`idproductoprocesado` = m.`idmetaproductoproduccion`
				WHERE p.fecha BETWEEN '2017-01-01' AND '2017-10-31'
				GROUP BY m.`cod_art`, m.`descripcion`
		) b 	ON a.cod_art = b.cod_art
	LEFT JOIN (	-- COSTOS TOTALES REPROCESOS
				SELECT m.`cod_art`, m.`descripcion`, SUM(ps.`cantidad`) AS cantidad, SUM(ps.`costototalproduccion`) AS costototal 
				FROM productosimple ps
				JOIN productobase pb ON ps.`idproductobase` = pb.`idproductobase`
				JOIN planificacionproduccion p ON pb.`idplanificacionproduccion` = p.`idplanificacionproduccion`
				JOIN productosimpleprocesado pr ON ps.`idproductosimple` = pr.`idproductosimple`
				JOIN metaproductoproduccion m ON pr.`idmetaproductoproduccion` = m.`idmetaproductoproduccion`
				WHERE p.fecha BETWEEN '2017-01-01' AND '2017-10-31'
				GROUP BY m.`cod_art`, m.`descripcion`
		) c 	ON a.cod_art = c.cod_art
	LEFT JOIN inv_articulos i ON a.cod_art = i.`cod_art`
	) cu ON t.`cod_art` = cu.cod_art
LEFT JOIN (
	SELECT d.`cod_art`, a.`descri`, SUM(d.`cantidad`) AS cantidad
	FROM inv_movdet d
	LEFT JOIN inv_mov m   ON d.`no_trans` = m.`no_trans`
	LEFT JOIN inv_vales v ON m.`no_trans` = v.`no_trans`
	LEFT JOIN inv_articulos a ON d.`cod_art` = a.`cod_art`
	WHERE v.`cod_doc` = 'BAJ'
	AND v.`fecha` BETWEEN '2017-01-01' AND '2017-10-31'
	AND v.`estado` IN ('APR')
	GROUP BY d.`cod_art`, a.`descri`
	) b      ON t.cod_art = b.cod_art
LEFT JOIN inv_articulos ar ON t.cod_art = ar.cod_art
-- WHERE ar.estado = 'VIG'
;

-- 2. Actualizando CostoS 
-- 	Queso Prensado en EDAM, 
--	127 LECHE SABORIZADA FRUTILLA 120
-- 	478 ILFRUT DURAZNO 150 ML 
--	138 YOGURT SACHET DURAZNO 80 CC

UPDATE auxinv i SET i.`costo_prom` = 22.245120 WHERE i.`cod_art` = 148;
UPDATE auxinv i SET i.`costo_prom` = 0.637661 WHERE i.`cod_art` = 127;
UPDATE auxinv i SET i.`costo_prom` = 0.266430 WHERE i.`cod_art` = 478;
UPDATE auxinv i SET i.`costo_prom` = 0.318052 WHERE i.`cod_art` = 138;

-- 4.- ACTUALIZAR INV_ARTICULOS, COSTO_UNI, CU, SALDO_MON, ...
-- Verificando...
SELECT i.`cod_art`, i.`descri`, i.`costo_uni`, i.`cu`, i.`saldo_mon`, i.`ct`, a.`costo_prom`
FROM inv_articulos i
JOIN auxinv a ON i.`cod_art` = a.`cod_art`
WHERE i.`cuenta_art` = '4420110201' 
AND i.`cod_art` NOT IN (490,193,194,192,521,197, 541, 493)
;

-- 4.1 Fijando en CERO
UPDATE inv_articulos i
JOIN auxinv a ON i.`cod_art` = a.`cod_art`
SET i.`costo_uni` = 0, i.`cu` = 0, i.`saldo_mon` = 0, i.ct = 0
WHERE a.`alm` = 2;

-- 
UPDATE inv_articulos i
JOIN auxinv a ON i.`cod_art` = a.`cod_art`
SET 	i.`costo_uni` = a.`costo_prom`, 
	i.`cu` 	      = (a.`costo_prom`*100)/87, 
	i.`saldo_mon` = a.`cantidad` * a.`costo_prom`, 
	i.ct 	      = a.`cantidad` * ((a.`costo_prom`*100)/87)
WHERE a.`alm` = 2;


-- 3. ACTUALIZAR TABLAS INV_INVENTARIO, INV_INVENTARIO_DETALLE
UPDATE inv_inventario_detalle i SET i.`cantidad` = 0, i.`version` = 0 WHERE i.`cod_alm` = 2;
UPDATE inv_inventario i SET i.`saldo_uni` = 0, i.`version` = 0 WHERE i.`cod_alm` = 2;


UPDATE inv_inventario i
JOIN auxinv a ON i.`cod_art` = a.`cod_art`
SET i.`saldo_uni` = a.`cantidad`
WHERE i.`cod_alm` = 2
;

UPDATE inv_inventario_detalle i
JOIN auxinv a ON i.`cod_art` = a.`cod_art`
SET i.`cantidad` = a.`cantidad`
WHERE i.`cod_alm` = 2
;



-- delete from inv_product_register;
-- DELETE FROM inv_product;






