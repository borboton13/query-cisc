
-- 1.- ACTUALIZAR TABLA AUXINV CON CANTIDAD Y COSTO_PROM A UNA FECHA DADA
-- 1.1 Eliminando tabla
-- DELETE FROM auxinv WHERE alm = 2;

-- 1.2 Insertando
-- INSERT INTO auxinv (cod_art, nombre, cantidad, und, alm, cu, costo_uni, costo_prom)
SELECT 	t.`cod_art`, t.`nombre`, 
	t.`cantidad` + IFNULL(pp.prod_total, 0) - IFNULL(vv.total, 0) + IFNULL(d.cantidad, 0) - IFNULL(ba.cantidad, 0) - IFNULL(br.cantidad, 0) + IFNULL(rec.cantidad, 0) - IFNULL(egr.cantidad, 0) AS inv_final, 
	'UN', 2, 0, 0, cu.costo_uni
FROM inv_inicio t -- -> Inventario inicial, cargar los nuevos productos 
LEFT JOIN (
	SELECT v.`cod_art`, a.`descri`, SUM(v.`TOTAL`) AS total
	FROM ventas v
	JOIN inv_inventario i ON v.`cod_art` = i.`cod_art`
	JOIN inv_articulos a  ON i.`cod_art` = a.`cod_art`
	WHERE i.`cod_alm` = 2
	AND v.`FECHA` BETWEEN '2019-01-01' AND '2019-12-31'
	GROUP BY v.`cod_art`, a.`descri`
	) vv ON t.`cod_art` = vv.cod_art
LEFT JOIN (
	SELECT p.`COD_ART`, p.`NOMBRE`, SUM((p.`CANTIDAD_SP` + p.`REPROCESO_SP`)) AS prod_total
	FROM producciontotal p
	WHERE p.`FECHA` BETWEEN '2019-01-01' AND '2019-12-31'
	GROUP BY p.`COD_ART`, p.`NOMBRE`
	) pp ON t.`cod_art` = pp.cod_art
LEFT JOIN (
	-- COSTO UNITARIO PROMEDIO, Ordenes de Produccion
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
				WHERE p.fecha BETWEEN '2019-01-01' AND '2019-12-31'
				GROUP BY m.`cod_art`, m.`descripcion`
		) b 	ON a.cod_art = b.cod_art
	LEFT JOIN (	-- COSTOS TOTALES REPROCESOS
				SELECT m.`cod_art`, m.`descripcion`, SUM(ps.`cantidad`) AS cantidad, SUM(ps.`costototalproduccion`) AS costototal 
				FROM productosimple ps
				JOIN productobase pb ON ps.`idproductobase` = pb.`idproductobase`
				JOIN planificacionproduccion p ON pb.`idplanificacionproduccion` = p.`idplanificacionproduccion`
				JOIN productosimpleprocesado pr ON ps.`idproductosimple` = pr.`idproductosimple`
				JOIN metaproductoproduccion m ON pr.`idmetaproductoproduccion` = m.`idmetaproductoproduccion`
				WHERE p.fecha BETWEEN '2019-01-01' AND '2019-12-31'
				GROUP BY m.`cod_art`, m.`descripcion`
		) c 	ON a.cod_art = c.cod_art
	LEFT JOIN inv_articulos i ON a.cod_art = i.`cod_art`
	) cu ON t.`cod_art` = cu.cod_art
LEFT JOIN (
	-- DEVOLUCION DE PRODUCTOS
	SELECT d.`cod_art`, d.`descri`, SUM(d.`cantidad`) AS cantidad
	FROM inv_devolucion d
	WHERE d.`cod_alm` = 2
	AND d.`fecha` BETWEEN '2019-01-01' AND '2019-12-31'
	GROUP BY d.`cod_art`, d.`descri`
	) d ON t.cod_art = d.cod_art
LEFT JOIN (
	-- BAJA DE PRODUCTOS
	SELECT b.`cod_art`, b.`descri`, SUM(b.`cantidad`)  AS cantidad
	FROM inv_bajas b
	WHERE b.`cod_alm` = 2
	AND b.`fecha` BETWEEN '2019-01-01' AND '2019-12-31'
	GROUP BY b.`cod_art`, b.`descri`
	) ba ON t.cod_art = ba.cod_art
LEFT JOIN (
	-- BAJA X REPROCESOS
	SELECT b.`cod_art`, b.`descri`, SUM(b.`cantidad`)  AS cantidad
	FROM inv_reprocesos b
	WHERE b.`cod_alm` = 2
	AND b.`fecha` BETWEEN '2019-01-01' AND '2019-12-31'
	GROUP BY b.`cod_art`, b.`descri`
	) br ON t.cod_art = br.cod_art

LEFT JOIN (
	SELECT d.`cod_art`, SUM(d.`cantidad`) AS cantidad
	FROM inv_movdet d
	LEFT JOIN inv_vales v ON d.`no_trans` = v.`no_trans`
	WHERE v.`fecha` BETWEEN '2019-01-01' AND '2019-12-31'
	AND v.`cod_doc` IN ('REC', 'EGR')
	AND v.`cod_alm` = 2
	AND v.`idordenproduccion` IS NULL
	AND v.`idproductobase` IS NULL
	AND d.`tipo_mov` = 'E'
	GROUP BY d.`cod_art`
	) rec ON t.cod_art = rec.cod_art
LEFT JOIN (
	SELECT d.`cod_art`, SUM(d.`cantidad`) AS cantidad
	FROM inv_movdet d
	LEFT JOIN inv_vales v ON d.`no_trans` = v.`no_trans`
	WHERE v.`fecha` BETWEEN '2019-01-01' AND '2019-12-31'
	AND v.`cod_doc` IN ('REC', 'EGR')
	AND v.`cod_alm` = 2
	AND v.`idordenproduccion` IS NULL
	AND v.`idproductobase` IS NULL
	AND d.`tipo_mov` = 'S'
	GROUP BY d.`cod_art`
	) egr ON t.cod_art = egr.cod_art
WHERE t.alm = 2 AND t.gestion = 2019
;


SELECT d.`cod_art`, SUM(d.`cantidad`) AS cantidad
FROM inv_movdet d
LEFT JOIN inv_vales v ON d.`no_trans` = v.`no_trans`
WHERE v.`fecha` BETWEEN '2018-01-01' AND '2018-09-30'
AND v.`cod_doc` IN ('REC', 'EGR')
AND v.`cod_alm` = 2
AND v.`idordenproduccion` IS NULL
AND v.`idproductobase` IS NULL
AND d.`tipo_mov` = 'S'
GROUP BY d.`cod_art`
;
SELECT *
FROM inv_articulos i
WHERE i.`descri` LIKE '%YOG%120%';

-- 2. Actualizando CostoS 
-- 	Queso Prensado en EDAM, 
--	127 LECHE SABORIZADA FRUTILLA 120
-- 	478 ILFRUT DURAZNO 150 ML 
--	138 YOGURT SACHET DURAZNO 80 CC

UPDATE auxinv i SET i.`costo_prom` = 0.637661 WHERE i.`cod_art` = 127;
UPDATE auxinv i SET i.`costo_prom` = 0.266430 WHERE i.`cod_art` = 478;
UPDATE auxinv i SET i.`costo_prom` = 0.387188 WHERE i.`cod_art` = 138;

UPDATE auxinv i SET i.`costo_prom` = 0.720466 WHERE i.`cod_art` = 125; -- FRUTIKID
UPDATE auxinv i SET i.`costo_prom` = 0.769829 WHERE i.`cod_art` = 585; -- BANANA 160
UPDATE auxinv i SET i.`costo_prom` = 18.372657 WHERE i.`cod_art` = 148; -- EDAM
-- UPDATE auxinv i SET i.`costo_prom` = 18.372657 WHERE i.`cod_art` = 151; -- PRENSADO

UPDATE auxinv i SET i.`costo_prom` = 0.621655 WHERE i.`cod_art` = 120; -- LECHE SABORIZADA CHOCOLATE 160ML ***


-- 4.- ACTUALIZAR INV_ARTICULOS, COSTO_UNI, CU, SALDO_MON
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

-- Fijando en cero QUESO RECORTE
UPDATE inv_inventario i         SET i.`saldo_uni` = 0 WHERE i.`cod_art` = 195;
UPDATE inv_inventario_detalle i SET i.`cantidad`  = 0 WHERE i.`cod_art` = 195;

UPDATE inv_inventario i         SET i.`saldo_uni` = 0 WHERE i.`cod_art` = 196;
UPDATE inv_inventario_detalle i SET i.`cantidad`  = 0 WHERE i.`cod_art` = 196;

-- ---------------------------------------------------------------------------------------
-- CRUCE INV_INICIO - INV_ARTICULOS
SELECT a.`cod_art`, a.`descri`, a.`saldo_mon`, a.`ct`, a.`costo_uni`, a.`cu`, i.`cod_art`, i.`nombre`, i.`costo_uni`
FROM inv_articulos a
LEFT JOIN inv_inicio i ON a.`cod_art` = i.`cod_art`
WHERE a.`cod_alm` = 5
AND i.`gestion` = 2019
;

