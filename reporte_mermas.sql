

-- ----------------------------------------------------------------
-- --------------------- REPORTE MERMAS -----------------------
-- ----------------------------------------------------------------
SELECT 	p.`FECHA_ENTREGA` AS FECHA, 
	p.`IDPEDIDOS`, 
	-- p.`CODIGO` AS COD_PED, 
	CONCAT(pc.`NOM`,' ',pc.`AP`,' ',pc.`AM`) AS CLIENTE, 
	a.`cod_art`, 
	a.`IDARTICULOSPEDIDO` AS IdArtP, 
	ar.`descri`, 
	a.`CANTIDAD`, a.`PROMOCION`, a.`REPOSICION`, a.`TOTAL`, a.`PRECIO`, a.`IMPORTE`, 
	p.`IDTIPOPEDIDO`
	-- p.`ESTADO`
FROM articulos_pedido a
LEFT JOIN pedidos p ON a.idpedidos = p.`IDPEDIDOS`
LEFT JOIN personacliente pc ON p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
WHERE p.`FECHA_ENTREGA` BETWEEN '2016-05-01' AND '2016-09-30'
AND p.`ESTADO` <> 'ANULADO'
AND p.`IDTIPOPEDIDO` = 1;

-- -------------------------------------------------------------------------------

SELECT 	iv.`cod_art`, i.`descri`,
	IFNULL(deg.degustacion, 0) AS degustacion,
	IFNULL(ref.refrigerio, 0) AS refrigerio,
	IFNULL(pr.promocion, 0) AS promocion, 
	IFNULL(pr.reposicion, 0) + IFNULL(rep.reposicion, 0) AS reposicion,
	IFNULL(deg.degustacion, 0) + IFNULL(ref.refrigerio, 0) + IFNULL(pr.promocion, 0) + IFNULL(pr.reposicion, 0) + IFNULL(rep.reposicion, 0) AS cant_total,
	i.costo_uni AS cu_neto, 
	i.cu AS cu_total
FROM inv_inventario iv
LEFT JOIN (
	-- Reporte1 Merma DEGUSTACION
	SELECT 	a.`cod_art`, ar.`descri`, SUM(a.`CANTIDAD`) AS degustacion 
	FROM articulos_pedido a
	LEFT JOIN pedidos p ON a.idpedidos = p.`IDPEDIDOS`
	LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
	WHERE p.`FECHA_ENTREGA` BETWEEN '2016-05-01' AND '2016-09-31'
	AND p.`ESTADO` <> 'ANULADO' AND p.`IDTIPOPEDIDO` = 2
	GROUP BY a.`cod_art`, ar.`descri`
	) deg ON iv.cod_art = deg.cod_art
LEFT JOIN (
	-- Reporte2 Merma REFRIGERIO
	SELECT 	a.`cod_art`, ar.`descri`, SUM(a.`CANTIDAD`) AS refrigerio
	FROM articulos_pedido a
	LEFT JOIN pedidos p ON a.idpedidos = p.`IDPEDIDOS`
	LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
	WHERE p.`FECHA_ENTREGA` BETWEEN '2016-05-01' AND '2016-09-31'
	AND p.`ESTADO` <> 'ANULADO' AND p.`IDTIPOPEDIDO` = 3
	GROUP BY a.`cod_art`, ar.`descri`
	) ref ON iv.cod_art = ref.cod_art
LEFT JOIN (
	-- Reporte3 Merma REFRIGERIO
	SELECT 	a.`cod_art`, ar.`descri`, SUM(a.`CANTIDAD`) AS reposicion
	FROM articulos_pedido a
	LEFT JOIN pedidos p ON a.idpedidos = p.`IDPEDIDOS`
	LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
	WHERE p.`FECHA_ENTREGA` BETWEEN '2016-05-01' AND '2016-09-30'
	AND p.`ESTADO` <> 'ANULADO' AND p.`IDTIPOPEDIDO` = 4
	GROUP BY a.`cod_art`, ar.`descri`
	) rep ON iv.cod_art = rep.cod_art
LEFT JOIN (
	-- Reporte2 Merma REPOSICION, PROMOCION en pedidos de tipo NORMAL
	SELECT 	a.`cod_art`, ar.`descri`,
		SUM(a.`PROMOCION`) AS promocion,
		SUM(a.`REPOSICION`) AS reposicion
	FROM articulos_pedido a
	LEFT JOIN pedidos p ON a.idpedidos = p.`IDPEDIDOS`
	LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
	WHERE p.`FECHA_ENTREGA` BETWEEN '2016-05-01' AND '2016-09-30'
	AND p.`ESTADO` <> 'ANULADO'
	AND p.`IDTIPOPEDIDO` = 1
	GROUP BY a.`cod_art`, ar.`descri`
	) pr ON iv.cod_art = pr.cod_art
LEFT JOIN inv_articulos i ON iv.`cod_art` = i.`cod_art`
WHERE iv.cod_alm = 2 
;

