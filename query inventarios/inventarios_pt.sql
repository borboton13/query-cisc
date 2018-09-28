--
-- REPORTE FINAL PRODUCTO TERMINADO - 12.01.2017
/*
SELECT 	-- i.`cod_art`, i.`nombre`, i.`cantidad` AS inicial, 
	ar.cod_art, ar.descri, i.`cantidad` AS inicial, 
	IFNULL(SUM(v.`TOTAL`), 0) AS ventas, 
	IFNULL(pro.cantidad, 0) AS produccion,
	IFNULL(d.cantidad, 0)  AS devolucion,
	IFNULL(ba.cantidad, 0) AS bajas,
	i.`cantidad` + IFNULL(pro.cantidad, 0) - IFNULL(SUM(v.`TOTAL`), 0) + IFNULL(d.cantidad, 0) - IFNULL(ba.cantidad, 0) AS saldo_final,
	IFNULL(pro.costounitario, 0) AS costo_unit
FROM inv_inicio i
LEFT JOIN ventas v ON i.`cod_art` = v.`cod_art`
LEFT JOIN (
	SELECT v.cod_art, SUM(v.cantidad) AS cantidad
	FROM inv_inicio i
	LEFT JOIN ventas v ON i.cod_art = v.cod_art
	WHERE i.`alm` = 2 AND i.gestion = 2018
	AND v.fecha BETWEEN '2018-01-01' AND '2018-09-30'
	GROUP BY v.cod_art
	   ) vv ON i.cod_art = vv.cod_art
LEFT JOIN (
	-- REPORTE DE PRODUCCION TOTAL
	SELECT 	p.`COD_ART`, p.`NOMBRE`, 
		SUM(p.`CANTIDAD_SP` + p.`REPROCESO_SP`) AS CANTIDAD,
		SUM(p.COSTOTOTALPRODUCCION) AS COSTOTOTALPRODUCCION,
		SUM(p.COSTOTOTALPRODUCCION) / SUM(p.`CANTIDAD_SP` + p.`REPROCESO_SP`)  AS COSTOUNITARIO
	FROM producciontotal p
	WHERE p.`FECHA` BETWEEN '2018-01-01' AND '2018-09-30'
	GROUP BY p.`COD_ART`, p.`NOMBRE`
	  ) pro ON i.`cod_art` = pro.cod_art
LEFT JOIN (
	-- DEVOLUCION DE PRODUCTOS
	SELECT d.`cod_art`, d.`descri`, SUM(d.`cantidad`) AS cantidad
	FROM inv_devolucion d
	WHERE d.`cod_alm` = 2
	AND d.`fecha` BETWEEN '2018-01-01' AND '2018-09-30'
	GROUP BY d.`cod_art`, d.`descri`
	) d ON i.cod_art = d.cod_art
LEFT JOIN (
	-- BAJA DE PRODUCTOS
	SELECT b.`cod_art`, b.`descri`, SUM(b.`cantidad`)  AS cantidad
	FROM inv_bajas b
	WHERE b.`cod_alm` = 2
	AND b.`fecha` BETWEEN '2018-01-01' AND '2018-09-30'
	GROUP BY b.`cod_art`, b.`descri`
	) ba ON i.cod_art = ba.cod_art
LEFT JOIN inv_articulos ar ON i.cod_art = ar.cod_art
WHERE i.`alm` = 2 AND i.gestion = 2018
-- AND v.fecha BETWEEN '2018-01-01' AND '2018-12-31'
-- GROUP BY i.`cod_art`, i.`nombre`, i.`cantidad`
;
*/
