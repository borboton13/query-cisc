SELECT z.cod_art, SUM(z.monto) AS monto,  SUM(z.cantidad) AS cantidad, SUM(z.monto) / SUM(z.cantidad) AS costo_uni 
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
	SELECT d.cod_art, SUM(d.monto) AS monto, SUM(d.cantidad) AS cantidad
	FROM inv_vales i
	JOIN inv_movdet d ON i.no_trans = d.no_trans
	WHERE i.fecha BETWEEN '2019-01-01' AND '2019-01-31'
	AND i.cod_alm = 2
	AND (i.idordenproduccion IS NOT NULL OR i.idproductobase IS NOT NULL)
	GROUP BY d.cod_art
	/*SELECT t.cod_art, SUM(t.costototalproduccion) AS monto,   SUM(t.cant_total) AS cantidad 
	FROM producciontotal t 
	WHERE t.fecha BETWEEN '2019-01-01' AND '2019-01-31'
	GROUP BY t.cod_art */
) z 
GROUP BY z.cod_art ;


SELECT d.`cod_art`, SUM(d.`monto`) AS monto, SUM(d.`cantidad`) AS cantidad
FROM inv_vales i
JOIN inv_movdet d ON i.`no_trans` = d.`no_trans`
WHERE i.`fecha` BETWEEN '2019-01-01' AND '2019-01-31'
AND i.`cod_alm` = 2
AND (i.`idordenproduccion` IS NOT NULL OR i.`idproductobase` IS NOT NULL)
GROUP BY d.`cod_art`
;


SELECT e.`id_tmpenc`, e.`fecha`, e.`no_doc`, e.`estado`, e.`glosa`, d.`cuenta`, d.`debe`, d.`haber`, d.`cod_art`, d.`cant_art`
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
WHERE e.`fecha` BETWEEN '2019-01-01' AND '2019-01-31' 
AND d.`cod_art` = 151
AND d.`cuenta` = 1510110201
;



	SELECT i.cod_art, SUM(i.cantidad * i.costo_uni) AS monto, SUM(i.cantidad) AS cantidad 
	FROM inv_inicio i 
	WHERE i.gestion = 2019 AND i.alm = 2 AND i.cantidad > 0 
	GROUP BY i.cod_art 
	;
	
	-- UNION 
	
	SELECT d.cod_art, SUM(d.monto) AS monto, SUM(d.cantidad) AS cantidad 
	FROM inv_movdet d 
	LEFT JOIN inv_vales v ON d.no_trans = v.no_trans 
	WHERE v.fecha BETWEEN '2019-01-01' AND '2019-01-31'
	AND v.cod_alm = 2 AND d.tipo_mov = 'E' AND v.id_com_encoc IS NOT NULL 
	GROUP BY d.cod_art 
	;
	
	-- UNION 
	SELECT t.`FECHA`, t.cod_art, t.costototalproduccion AS monto, t.cant_total 
	FROM producciontotal t 
	WHERE t.fecha BETWEEN '2019-01-01' AND '2019-01-31'
	AND t.`COD_ART` = 151
	-- GROUP BY t.cod_art 
	;









