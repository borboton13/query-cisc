-- -------------------
-- PRODUCTOS LACTEOS
-- -------------------
-- ---------------------------------------------------------------
-- ------------- REPORTE 1. VENTAS CLIENTES x PEDIDO (PEDIDOS) -------------
-- ---------------------------------------------------------------
-- select pc.`IDPERSONACLIENTE` as ID, pc.`NIT`, pc.`NRO_DOC`, t.`NOMBRE`, pc.`ESPERSONA`, concat(pc.`NOM`, ' ', pc.`AP`, ' ', pc.`AM`) as CLIENTE, sum(a.`IMPORTE`) as TOTAL_BS, count(distinct p.`CODIGO`) as CANT_PEDIDOS
SELECT pc.`IDPERSONACLIENTE` AS ID, pc.`NIT`, pc.`NRO_DOC`, CONCAT(pc.`NOM`, ' ', pc.`AP`, ' ', pc.`AM`) AS CLIENTE, t.`NOMBRE`, SUM(a.`IMPORTE`) AS TOTAL_BS, COUNT(DISTINCT p.`CODIGO`) AS CANT_PEDIDOS
FROM articulos_pedido a
LEFT JOIN pedidos p 		ON a.idpedidos = p.`IDPEDIDOS`
LEFT JOIN personacliente pc 	ON p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
LEFT JOIN inv_articulos ar 	ON a.`cod_art` = ar.`cod_art`
LEFT JOIN territoriotrabajo t 	ON pc.`IDTERRITORIOTRABAJO` = t.`IDTERRITORIOTRABAJO`
WHERE p.`FECHA_ENTREGA` BETWEEN '2021-04-01' AND '2021-04-30'
AND P.`ESTADO` <> 'ANULADO'
AND p.`IDUSUARIO` NOT IN (5, 408)
AND p.`tipoventa` = 'CREDIT'
AND pc.`IDPERSONACLIENTE` <> 2238
GROUP BY pc.`IDPERSONACLIENTE`, pc.`NIT`, pc.`NRO_DOC`, t.`NOMBRE`
-- , t.`NOMBRE`, pc.`ESPERSONA`
;
-- ---------------------------------------------------

-- --------------------------------------------------------------------------
-- ------------- REPORTE 2. VENTAS CLIENTES x PRODUCTO (PEDIDOS) -------------
-- --------------------------------------------------------------------------
-- SELECT pc.`NOM`, pc.`AP`, pc.`AM`, p.`IDPEDIDOS`, p.`CODIGO` AS COD_PED, a.`IDARTICULOSPEDIDO`, a.`cod_art`, ar.`descri`, a.`CANTIDAD`, a.`REPOSICION`, a.`TOTAL`, p.`ESTADO`, a.`IMPORTE`
SELECT pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art` AS COD_ART, ar.`descri` AS PRODUCTO, SUM(a.`CANTIDAD`) AS CANT_PRODUCTOS, SUM(a.`IMPORTE`) AS TOTAL_BS
FROM articulos_pedido a
LEFT JOIN pedidos p ON a.idpedidos = p.`IDPEDIDOS`
LEFT JOIN personacliente pc ON p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
WHERE p.`FECHA_ENTREGA` BETWEEN '2021-04-01' AND '2021-04-30'
AND P.`ESTADO` <> 'ANULADO'
AND p.`IDUSUARIO` NOT IN (5, 408)
AND p.`tipoventa` = 'CREDIT'
AND pc.`IDPERSONACLIENTE` <> 2238
GROUP BY pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art`, ar.`descri`;
-- ---------------------------------------------------


-- -----------------------------------------------------------------
-- ------------- *** REPORTE 3. VENTAS x PRODUCTO (PEDIDOS) -------------
-- -----------------------------------------------------------------
-- SELECT pc.`NOM`, pc.`AP`, pc.`AM`, p.`IDPEDIDOS`, p.`CODIGO` AS COD_PED, a.`IDARTICULOSPEDIDO`, a.`cod_art`, ar.`descri`, a.`CANTIDAD`, a.`REPOSICION`, a.`TOTAL`, p.`ESTADO`, a.`IMPORTE`
SELECT a.`cod_art` AS COD_ART, ar.`descri` AS PRODUCTO, SUM(a.`CANTIDAD`) AS CANT_ARTICULOS, /*SUM(a.total),*/ SUM(a.`IMPORTE`) AS TOTAL_BS
FROM articulos_pedido a
LEFT JOIN pedidos p ON a.idpedidos = p.`IDPEDIDOS`
LEFT JOIN personacliente pc ON p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
WHERE p.`FECHA_ENTREGA` BETWEEN '2021-04-01' AND '2021-04-30'
AND P.`ESTADO` <> 'ANULADO'
AND p.`IDUSUARIO` NOT IN (5, 408)
AND p.`IDTIPOPEDIDO` IN (1, 5)
AND p.`tipoventa` = 'CREDIT'
AND pc.`IDPERSONACLIENTE` <> 2238
GROUP BY a.`cod_art`, ar.`descri`;

-- --------------------------------------------------------------
-- ------------- REPORTE 4. VENTAS x PRODUCTO (CONTADO)-------------
-- --------------------------------------------------------------
-- SELECT pc.`NOM`, pc.`AP`, pc.`AM`, p.`IDPEDIDOS`, p.`CODIGO` AS COD_PED, a.`IDARTICULOSPEDIDO`, a.`cod_art`, ar.`descri`, a.`CANTIDAD`, a.`REPOSICION`, a.`TOTAL`, p.`ESTADO`, a.`IMPORTE`
SELECT a.`cod_art` AS COD_ART, ar.`descri` AS PRODUCTO, SUM(a.`CANTIDAD`) AS CANT_ARTICULOS, /*SUM(a.`TOTAL`),*/ SUM(a.`IMPORTE`) AS TOTAL_BS
FROM articulos_pedido a
LEFT JOIN ventadirecta v ON a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
LEFT JOIN personacliente pc ON v.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
WHERE v.`FECHA_PEDIDO` BETWEEN '2021-03-01' AND '2021-03-31'
AND v.`ESTADO` <> 'ANULADO'
-- AND ar.`cuenta_art` = '4420110201'
AND v.`IDUSUARIO` <> 5
GROUP BY a.`cod_art`, ar.`descri`;

-- REPORTE 4. VENTAS x PRODUCTO (CONTADO)
-- PEDIDOS
SELECT COD_ART, DESCRI, SUM(CANT_ARTICULOS) AS CANT_ARTICULOS, SUM(TOTAL_BS) AS TOTAL_BS
FROM (
	SELECT a.`cod_art`, ar.`descri`, SUM(a.`CANTIDAD`) AS CANT_ARTICULOS, SUM(a.`IMPORTE`) AS TOTAL_BS
	FROM articulos_pedido a
	LEFT JOIN pedidos p ON a.idpedidos = p.`IDPEDIDOS`
	LEFT JOIN personacliente pc ON p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
	LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
	WHERE p.`FECHA_ENTREGA` BETWEEN '2021-04-01' AND '2021-04-30'
	AND P.`ESTADO` <> 'ANULADO'
	AND p.`IDUSUARIO` NOT IN (5, 408)
	AND p.`IDTIPOPEDIDO` IN (1, 5)
	AND p.`tipoventa` = 'CASH'
	GROUP BY a.`cod_art`, ar.`descri`
	UNION ALL
	-- VENTADIRECTA
	SELECT a.`cod_art`, ar.`descri`, SUM(a.`CANTIDAD`) AS CANT_ARTICULOS, SUM(a.`IMPORTE`) AS TOTAL_BS
	FROM articulos_pedido a
	LEFT JOIN ventadirecta v ON a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
	LEFT JOIN personacliente pc ON v.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
	LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
	WHERE v.`FECHA_PEDIDO` BETWEEN '2021-04-01' AND '2021-04-30'
	AND v.`ESTADO` <> 'ANULADO'
	AND v.`IDUSUARIO` NOT IN (5, 408)
	GROUP BY a.`cod_art`, ar.`descri`
) v
GROUP BY cod_art, descri;

-- ---------------------------------------------------

	-- AGENCIA
	SELECT a.`cod_art`, ar.`descri`, SUM(a.`CANTIDAD`) AS CANT_ARTICULOS, SUM(a.`IMPORTE`) AS TOTAL_BS
	FROM articulos_pedido a
	LEFT JOIN pedidos p ON a.idpedidos = p.`IDPEDIDOS`
	LEFT JOIN personacliente pc ON p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
	LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
	WHERE p.`FECHA_ENTREGA` BETWEEN '2021-04-12' AND '2021-04-30'
	AND P.`ESTADO` <> 'ANULADO'
	AND p.`IDUSUARIO` IN (541)
	AND p.`IDTIPOPEDIDO` IN (1, 5)
	AND p.`tipoventa` = 'CASH'
	GROUP BY a.`cod_art`, ar.`descri`
	;





-- ------------------------------------------------------------------------------
-- ------------- REPORTE 5. VENTAS CLIENTES x Producto (VENTA CONTADO) -------------
-- ------------------------------------------------------------------------------
-- SELECT pc.`NOM`, pc.`AP`, pc.`AM`, p.`IDPEDIDOS`, p.`CODIGO` AS COD_PED, a.`IDARTICULOSPEDIDO`, a.`cod_art`, ar.`descri`, a.`CANTIDAD`, a.`REPOSICION`, a.`TOTAL`, p.`ESTADO`, a.`IMPORTE`
SELECT pc.`NRO_DOC`, pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art` AS COD_ART, ar.`descri` AS PRODUCTO, SUM(a.`CANTIDAD`) AS CANT_PRODUCTOS, SUM(a.`IMPORTE`) AS TOTAL_BS
FROM articulos_pedido a
LEFT JOIN ventadirecta v ON a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
LEFT JOIN personacliente pc ON v.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
WHERE v.`FECHA_PEDIDO` BETWEEN '2021-03-01' AND '2021-03-31'
AND v.`ESTADO` <> 'ANULADO'
-- AND V.`IDUSUARIO` IN (6, 404)
AND v.`IDUSUARIO` <> 5
GROUP BY pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art`, ar.`descri`;
-- ---------------------------------------------------

-- REPORTE 5. VENTAS CLIENTES x Producto (VENTA CONTADO)
-- PEDIDOS
SELECT NOM, AP, AM, COD_ART, PRODUCTO, SUM(CANT_PRODUCTOS) AS CANT_PRODUCTOS, SUM(TOTAL_BS) AS TOTAL_BS
FROM (
	SELECT pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art` AS COD_ART, ar.`descri` AS PRODUCTO, SUM(a.`CANTIDAD`) AS CANT_PRODUCTOS, SUM(a.`IMPORTE`) AS TOTAL_BS
	FROM articulos_pedido a
	LEFT JOIN pedidos p ON a.idpedidos = p.`IDPEDIDOS`
	LEFT JOIN personacliente pc ON p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
	LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
	WHERE p.`FECHA_ENTREGA` BETWEEN '2021-04-01' AND '2021-04-30'
	AND P.`ESTADO` <> 'ANULADO'
	AND p.`IDUSUARIO` NOT IN (5, 408)
	AND p.`tipoventa` = 'CASH'
	GROUP BY pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art`, ar.`descri`
	UNION ALL
	-- VENTADIRECTA
	SELECT pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art` AS COD_ART, ar.`descri` AS PRODUCTO, SUM(a.`CANTIDAD`) AS CANT_PRODUCTOS, SUM(a.`IMPORTE`) AS TOTAL_BS
	FROM articulos_pedido a
	LEFT JOIN ventadirecta v ON a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
	LEFT JOIN personacliente pc ON v.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
	LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
	WHERE v.`FECHA_PEDIDO` BETWEEN '2021-04-01' AND '2021-04-30'
	AND v.`ESTADO` <> 'ANULADO'
	AND v.`IDUSUARIO` NOT IN (5, 408)
	GROUP BY pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art`, ar.`descri`
	) v
	GROUP BY NOM, AP, AM, COD_ART, PRODUCTO
	;







-- ---------------------------------------------------------------------------------
-- ------------- REPORTE 5.1 VENTAS CLIENTES x VENTAS (Para categorizar) -----------
-- ---------------------------------------------------------------------------------
SELECT pc.`NRO_DOC`, CONCAT(pc.`NOM`,' ', pc.`AP`, ' ', pc.`AM`) AS nombre , SUM(a.`IMPORTE`) AS TOTAL_BS, COUNT(v.`IDVENTADIRECTA`) AS NRO_VENTAS
FROM articulos_pedido a
LEFT JOIN ventadirecta v ON a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
LEFT JOIN personacliente pc ON v.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
WHERE v.`FECHA_PEDIDO` BETWEEN '2020-07-01' AND '2020-07-30'
AND v.`ESTADO` <> 'ANULADO'
-- AND V.`IDUSUARIO` IN (6, 404)
AND v.`IDUSUARIO` <> 5
GROUP BY pc.`NOM`, pc.`AP`, pc.`AM`;
-- ---------------------------------------------------

-- ---------------------------------------------------------------
-- ------------- REPORTE 6 VENTAS CLIENTES x PEDIDO (PEDIDOS DELIVERY)-------------
-- ---------------------------------------------------------------
SELECT pc.`IDPERSONACLIENTE` AS ID, pc.`NIT`, pc.`NRO_DOC`, CONCAT(pc.`NOM`, ' ', pc.`AP`, ' ', pc.`AM`) AS CLIENTE, SUM(a.`IMPORTE`) AS TOTAL_BS, COUNT(DISTINCT p.`CODIGO`) AS CANT_PEDIDOS
FROM articulos_pedido a
LEFT JOIN pedidos p ON a.idpedidos = p.`IDPEDIDOS`
LEFT JOIN personacliente pc ON p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
WHERE p.`FECHA_ENTREGA` BETWEEN '2020-10-01' AND '2020-10-31'
AND P.`ESTADO` <> 'ANULADO'
AND p.`IDUSUARIO` <> 5
AND pc.`IDTERRITORIOTRABAJO` IN (19, 20)
GROUP BY pc.`IDPERSONACLIENTE`, pc.`NIT`, pc.`NRO_DOC`;
-- ---------------------------------------------------


-- -------------------------------------------------------------------------------------------------------------

-- ------------------------------------
-- PRODUCTOS VETERINARIOS
-- ------------------------------------
-- ---------------------------------------------------------------
-- ------------- REPORTE 1. VENTAS CLIENTES x PEDIDO (PEDIDOS)-------------
-- ---------------------------------------------------------------
SELECT pc.`IDPERSONACLIENTE` AS ID, pc.`NIT`, pc.`NRO_DOC`, CONCAT(pc.`NOM`, ' ', pc.`AP`, ' ', pc.`AM`) AS CLIENTE, SUM(a.`IMPORTE`) AS TOTAL_BS, COUNT(DISTINCT p.`CODIGO`) AS CANT_PEDIDOS
FROM articulos_pedido a
LEFT JOIN pedidos p ON a.idpedidos = p.`IDPEDIDOS`
LEFT JOIN personacliente pc ON p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
WHERE p.`FECHA_ENTREGA` BETWEEN '2019-01-01' AND '2019-01-31'
AND P.`ESTADO` <> 'ANULADO'
AND p.`IDUSUARIO` = 5
GROUP BY pc.`IDPERSONACLIENTE`, pc.`NIT`, pc.`NRO_DOC`;
-- ---------------------------------------------------

-- --------------------------------------------------------------------------
-- ------------- REPORTE 2. VENTAS CLIENTES x PRODUCTO (PEDIDOS) -------------
-- --------------------------------------------------------------------------
-- SELECT pc.`NOM`, pc.`AP`, pc.`AM`, p.`IDPEDIDOS`, p.`CODIGO` AS COD_PED, a.`IDARTICULOSPEDIDO`, a.`cod_art`, ar.`descri`, a.`CANTIDAD`, a.`REPOSICION`, a.`TOTAL`, p.`ESTADO`, a.`IMPORTE`
SELECT pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art` AS COD_ART, ar.`descri` AS PRODUCTO, SUM(a.`CANTIDAD`) AS CANT_PRODUCTOS, SUM(a.`IMPORTE`) AS TOTAL_BS
FROM articulos_pedido a
LEFT JOIN pedidos p ON a.idpedidos = p.`IDPEDIDOS`
LEFT JOIN personacliente pc ON p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
WHERE p.`FECHA_ENTREGA` BETWEEN '2019-03-01' AND '2019-03-31'
AND P.`ESTADO` <> 'ANULADO'
AND p.`IDUSUARIO` <> 5
-- AND p.`IDCLIENTE` = 165
-- AND pc.`NOM` LIKE '%TORRES%'
GROUP BY pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art`, ar.`descri`;
-- ---------------------------------------------------


-- -----------------------------------------------------------------
-- ------------- *** REPORTE 3. VENTAS x PRODUCTO (PEDIDOS) -------------
-- -----------------------------------------------------------------
-- SELECT pc.`NOM`, pc.`AP`, pc.`AM`, p.`IDPEDIDOS`, p.`CODIGO` AS COD_PED, a.`IDARTICULOSPEDIDO`, a.`cod_art`, ar.`descri`, a.`CANTIDAD`, a.`REPOSICION`, a.`TOTAL`, p.`ESTADO`, a.`IMPORTE`
SELECT a.`cod_art` AS COD_ART, ar.`descri` AS PRODUCTO, SUM(a.`CANTIDAD`) AS CANT_ARTICULOS, /*SUM(a.total),*/ SUM(a.`IMPORTE`) AS TOTAL_BS
FROM articulos_pedido a
LEFT JOIN pedidos p ON a.idpedidos = p.`IDPEDIDOS`
LEFT JOIN personacliente pc ON p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
WHERE p.`FECHA_ENTREGA` BETWEEN '2019-04-01' AND '2019-04-30'
AND P.`ESTADO` <> 'ANULADO'
AND p.`IDUSUARIO` = 5
AND p.`IDTIPOPEDIDO` IN (1, 6)
GROUP BY a.`cod_art`, ar.`descri`;

-- --------------------------------------------------------------
-- ------------- *** REPORTE 4. VENTAS x PRODUCTO (CONTADO)-------------
-- --------------------------------------------------------------
-- SELECT pc.`NOM`, pc.`AP`, pc.`AM`, p.`IDPEDIDOS`, p.`CODIGO` AS COD_PED, a.`IDARTICULOSPEDIDO`, a.`cod_art`, ar.`descri`, a.`CANTIDAD`, a.`REPOSICION`, a.`TOTAL`, p.`ESTADO`, a.`IMPORTE`
SELECT a.`cod_art` AS COD_ART, ar.`descri` AS PRODUCTO, SUM(a.`CANTIDAD`) AS CANT_ARTICULOS, /*SUM(a.`TOTAL`),*/ SUM(a.`IMPORTE`) AS TOTAL_BS
FROM articulos_pedido a
LEFT JOIN ventadirecta v ON a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
LEFT JOIN personacliente pc ON v.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
WHERE v.`FECHA_PEDIDO` BETWEEN '2019-08-01' AND '2019-08-31'
AND v.`ESTADO` <> 'ANULADO'
AND v.`IDUSUARIO` = 5
GROUP BY a.`cod_art`, ar.`descri`;

-- ---------------------------------------------------

-- ------------------------------------------------------------------------------
-- ------------- REPORTE 5. VENTAS CLIENTES x Producto (VENTA CONTADO) -------------
-- ------------------------------------------------------------------------------
-- SELECT pc.`NOM`, pc.`AP`, pc.`AM`, p.`IDPEDIDOS`, p.`CODIGO` AS COD_PED, a.`IDARTICULOSPEDIDO`, a.`cod_art`, ar.`descri`, a.`CANTIDAD`, a.`REPOSICION`, a.`TOTAL`, p.`ESTADO`, a.`IMPORTE`
SELECT pc.`NRO_DOC`, pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art` AS COD_ART, ar.`descri` AS PRODUCTO, SUM(a.`CANTIDAD`) AS CANT_PRODUCTOS, SUM(a.`IMPORTE`) AS TOTAL_BS
FROM articulos_pedido a
LEFT JOIN ventadirecta v ON a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
LEFT JOIN personacliente pc ON v.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
WHERE v.`FECHA_PEDIDO` BETWEEN '2019-08-01' AND '2019-08-31'
AND v.`ESTADO` <> 'ANULADO'
-- AND V.`IDUSUARIO` IN (6, 404)
AND v.`IDUSUARIO` <> 5
GROUP BY pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art`, ar.`descri`;
-- ---------------------------------------------------



-- AUX
-- -----------------------------------------------------------------
-- ------------- *** REPORTE 3. VENTAS x PRODUCTO (PEDIDOS) -------------
-- -----------------------------------------------------------------
SELECT a.`cod_art` AS COD_ART, ar.`descri` AS PRODUCTO, SUM(a.`CANTIDAD`) AS CANT, /*SUM(a.`PROMOCION`) AS PROMO,*/  SUM(a.`IMPORTE`) AS TOTAL_BS
FROM articulos_pedido a
LEFT JOIN pedidos p ON a.idpedidos = p.`IDPEDIDOS`
LEFT JOIN personacliente pc ON p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
WHERE p.`FECHA_ENTREGA` BETWEEN '2019-01-01' AND '2019-06-31'
AND P.`ESTADO` <> 'ANULADO'
AND p.`IDUSUARIO` <> 5
AND p.`IDTIPOPEDIDO` IN (1, 5) -- Normal, Desc_Lacteo
AND a.`cod_art` IN (128, 129, 130, 131, 132)
GROUP BY a.`cod_art`, ar.`descri`;

-- AUX ------------------------------------------------------------------
-- ------------- *** REPORTE 4. VENTAS x PRODUCTO (CONTADO)--------------
-- ----------------------------------------------------------------------
SELECT a.`cod_art` AS COD_ART, ar.`descri` AS PRODUCTO, SUM(a.`CANTIDAD`) AS CANT_ARTICULOS, SUM(a.`IMPORTE`) AS TOTAL_BS
FROM articulos_pedido a
LEFT JOIN ventadirecta v ON a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
LEFT JOIN personacliente pc ON v.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
WHERE v.`FECHA_PEDIDO` BETWEEN '2019-10-07' AND '2019-10-12'
AND v.`ESTADO` <> 'ANULADO'
AND a.`cod_art` IN (128, 129, 130, 131, 132)
AND v.`IDUSUARIO` <> 5
GROUP BY a.`cod_art`, ar.`descri`;

-- *** CONTADO: CANTIDAD PRODUCTOS X DIA
SELECT v.`FECHA_PEDIDO`, a.`cod_art` AS COD_ART, ar.`descri` AS PRODUCTO, SUM(a.`CANTIDAD`) AS CANT_ARTICULOS
FROM articulos_pedido a
LEFT JOIN ventadirecta v ON a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
LEFT JOIN personacliente pc ON v.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
WHERE v.`FECHA_PEDIDO` BETWEEN '2019-09-01' AND '2019-09-07'
AND v.`ESTADO` <> 'ANULADO'
AND v.`IDUSUARIO` <> 5
GROUP BY v.`FECHA_PEDIDO`, a.`cod_art`, ar.`descri`;

-- *** CREDITO: CANTIDAD PRODUCTOS X DIA
SELECT P.`FECHA_ENTREGA`, a.`cod_art` AS COD_ART, ar.`descri` AS PRODUCTO, SUM(a.`CANTIDAD`) AS CANTIDAD
FROM articulos_pedido a
LEFT JOIN pedidos p ON a.idpedidos = p.`IDPEDIDOS`
LEFT JOIN personacliente pc ON p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
WHERE p.`FECHA_ENTREGA` BETWEEN '2019-09-01' AND '2019-09-07'
AND P.`ESTADO` <> 'ANULADO'
AND p.`IDUSUARIO` <> 5
AND p.`IDTIPOPEDIDO` IN (1, 5) -- Normal, Desc_Lacteo
AND p.`IDCLIENTE` NOT IN (911,1463,1468,1464,1472,1557,1466,1465) -- sin SEDEM
-- AND a.`cod_art` IN (128, 129, 130, 131, 132)
GROUP BY P.`FECHA_ENTREGA`, a.`cod_art`, ar.`descri`;

-- AUX
-- --------------------------------------------------------------------------
-- ------------- REPORTE 2. VENTAS CLIENTES x PRODUCTO (PEDIDOS) -------------
-- --------------------------------------------------------------------------
-- SELECT pc.`NOM`, pc.`AP`, pc.`AM`, p.`IDPEDIDOS`, p.`CODIGO` AS COD_PED, a.`IDARTICULOSPEDIDO`, a.`cod_art`, ar.`descri`, a.`CANTIDAD`, a.`REPOSICION`, a.`TOTAL`, p.`ESTADO`, a.`IMPORTE`
SELECT pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art` AS COD_ART, ar.`descri` AS PRODUCTO, SUM(a.`CANTIDAD`) AS CANT_PRODUCTOS, SUM(a.`IMPORTE`) AS TOTAL_BS
FROM articulos_pedido a
LEFT JOIN pedidos p ON a.idpedidos = p.`IDPEDIDOS`
LEFT JOIN personacliente pc ON p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
WHERE p.`FECHA_ENTREGA` BETWEEN '2019-05-01' AND '2019-05-31'
AND P.`ESTADO` <> 'ANULADO'
AND p.`IDUSUARIO` <> 5
-- and p.`IDCLIENTE` in (911	,1463	,1464	,1465	,1466	,1468	,1472	,1557	) -- SEDEM
AND A.`cod_art` IN (808)
GROUP BY pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art`, ar.`descri`;
-- ---------------------------------------------------



-- --------------------------------------------------------------------------
-- ------------- REPORTE ANUAL. VENTAS CLIENTES x PRODUCTO (SEMAPA) -------------
-- --------------------------------------------------------------------------
SELECT p.`FECHA_ENTREGA`, pc.`NOM`, a.`cod_art` AS COD_ART, ar.`descri` AS PRODUCTO, p.`CODIGO`, p.`IDMOVIMIENTO`, M.`NROFACTURA`, SUM(a.`CANTIDAD`) AS CANT_PRODUCTOS, SUM(a.`IMPORTE`) AS TOTAL_BS
FROM articulos_pedido a
LEFT JOIN pedidos p ON a.idpedidos = p.`IDPEDIDOS`
LEFT JOIN personacliente pc ON p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
LEFT JOIN movimiento m ON p.`IDMOVIMIENTO` = m.`IDMOVIMIENTO`
WHERE p.`FECHA_ENTREGA` BETWEEN '2019-01-01' AND '2019-12-31'
AND P.`ESTADO` <> 'ANULADO'
AND p.`IDUSUARIO` <> 5
-- AND p.`IDCLIENTE` = 165
AND pc.`NOM` LIKE '%SEMAPA%'
GROUP BY p.`FECHA_ENTREGA`, pc.`NOM`, a.`cod_art`, ar.`descri`, p.`CODIGO`, p.`IDMOVIMIENTO`, M.`NROFACTURA`;
-- ---------------------------------------------------


SELECT *
FROM pedidos p
WHERE p.`FECHA_ENTREGA` BETWEEN '2021-01-01' AND '2021-03-31'
AND p.`IDCLIENTE` = 1657
AND p.`ESTADO` <> 'ANULADO'
;


-- ----------------------------------------------------------------
-- ---------------------- RESUMEN PEDIDOS X ZONA PREVENTA -------------------------
SELECT p.`IDPEDIDOS`, pc.`NOM`, pc.`AP`, pc.`AM`, p.`FECHA_ENTREGA`, p.`CODIGO`, p.`ESTADO`, t.`NOMBRE`, p.`TOTAL`, p.`TOTALIMPORTE`, p.`id_tmpenc`, p.`IDMOVIMIENTO`
FROM pedidos p
LEFT JOIN personacliente pc ON p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
LEFT JOIN tipopedido t ON p.`IDTIPOPEDIDO` = t.`IDTIPOPEDIDO`
WHERE p.`FECHA_ENTREGA` BETWEEN '2021-06-01' AND '2021-06-30'
AND (pc.`IDTERRITORIOTRABAJO` IN (24, 25) OR pc.`IDPERSONACLIENTE` = 1657)
-- and pc.`IDTERRITORIOTRABAJO` in (25)
-- and pc.`IDPERSONACLIENTE` in (2064)
AND p.`ESTADO` <> 'ANULADO'
;

-- RESUMEN MONTO
SELECT MONTH(p.`FECHA_ENTREGA`) AS mes, pc.`IDTERRITORIOTRABAJO`, COUNT(p.`IDPEDIDOS`) AS CANT, SUM(p.`TOTALIMPORTE`) AS IMPORTE, COUNT(DISTINCT p.`IDCLIENTE`) AS CLIENTES
FROM pedidos p
LEFT JOIN personacliente pc ON p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
WHERE p.`FECHA_ENTREGA` BETWEEN '2021-06-01' AND '2021-06-30'
AND pc.`IDTERRITORIOTRABAJO` IN (24, 25)
-- and pc.`IDPERSONACLIENTE` in (2064)
AND p.`ESTADO` <> 'ANULADO'
GROUP BY MONTH(p.`FECHA_ENTREGA`), pc.`IDTERRITORIOTRABAJO`
;

-- PREVENTA TELEFONOS
SELECT pc.`IDPERSONACLIENTE`, pc.`NOM`, pc.`AP`, pc.`AM`, pc.`TELEFONO`, pc.`DIRECCION`, COUNT(p.`IDPEDIDOS`) AS RECURRENCIA, MAX(p.`FECHA_ENTREGA`) AS ULTIMA, SUM(p.`TOTALIMPORTE`) AS IMPORTE
FROM pedidos p
LEFT JOIN personacliente pc ON p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
WHERE p.`FECHA_ENTREGA` BETWEEN '2020-12-01' AND '2021-03-31'
AND pc.`IDTERRITORIOTRABAJO` = 25
AND p.`IDTIPOPEDIDO` = 1
-- AND pc.`IDPERSONACLIENTE` in (2064)
AND p.`ESTADO` <> 'ANULADO'
GROUP BY pc.`IDPERSONACLIENTE`, pc.`NOM`, pc.`AP`, pc.`AM`
;


-- PREVENTA DETALLE
SELECT p.`IDPEDIDOS`, pc.`NOM`, pc.`AP`, pc.`AM`, p.`FECHA_ENTREGA`, p.`CODIGO`, p.`ESTADO`, t.`NOMBRE`, p.`TOTALIMPORTE`, a.`cod_art`, i.`descri`, a.`CANTIDAD`, a.`PRECIO`, a.`IMPORTE`
FROM pedidos p
LEFT JOIN articulos_pedido a ON p.`IDPEDIDOS` = a.`IDPEDIDOS`
LEFT JOIN inv_articulos i    ON a.`cod_art` = i.`cod_art`
LEFT JOIN personacliente pc ON p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
LEFT JOIN tipopedido t ON p.`IDTIPOPEDIDO` = t.`IDTIPOPEDIDO`
WHERE p.`FECHA_ENTREGA` BETWEEN '2021-01-01' AND '2021-02-28'
AND pc.`IDTERRITORIOTRABAJO` = 24
AND p.`ESTADO` <> 'ANULADO'
;




-- PREVENTA DETALLE x PRODUCTO
SELECT a.`cod_art`, i.`descri`, SUM(a.`CANTIDAD`) AS cant, SUM(a.`IMPORTE`) AS importe
FROM pedidos p
LEFT JOIN articulos_pedido a ON p.`IDPEDIDOS` = a.`IDPEDIDOS`
LEFT JOIN inv_articulos i    ON a.`cod_art` = i.`cod_art`
LEFT JOIN personacliente pc ON p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
LEFT JOIN tipopedido t ON p.`IDTIPOPEDIDO` = t.`IDTIPOPEDIDO`
WHERE p.`FECHA_ENTREGA` BETWEEN '2021-02-18' AND '2021-02-18'
AND pc.`IDTERRITORIOTRABAJO` = 24
AND p.`ESTADO` <> 'ANULADO'
AND p.`IDPEDIDOS` NOT IN (59322, 59325, 59342)
GROUP BY a.`cod_art`, i.`descri`
;

-- ======================================
SELECT *
FROM personacliente p
WHERE p.`NOM` LIKE '%SEDEM%'
;

-- VENTAS
SELECT MONTH(v.`FECHA`) AS mes, v.`cod_art`, a.`descri`, SUM(v.`CANTIDAD`) AS cantidad, SUM(v.`importe`) AS montobs
FROM ventas v
LEFT JOIN inv_articulos a ON v.`cod_art` = a.`cod_art`
WHERE v.`FECHA` BETWEEN '2019-01-01' AND '2019-12-31'
AND v.`idusuario` <> 5
GROUP BY mes, v.`cod_art`, a.`descri`
;

-- Reporte general ventas x Producto x Cantidad x Monto
SELECT v.`cod_art`, a.`descri`, SUM(v.`CANTIDAD`) AS cantidad, SUM(v.`importe`) AS montobs
FROM ventas v
LEFT JOIN inv_articulos a ON v.`cod_art` = a.`cod_art`
WHERE v.`FECHA` BETWEEN '2020-01-01' AND '2020-12-31'
AND v.`idusuario` <> 5
AND v.`idtipopedido` IN (1, 5)
GROUP BY v.`cod_art`, a.`descri`
;

-- Reporte ventas x Tipo Cliente x Cantidad x Monto
SELECT t.`IDTIPOCLIENTE`, t.`NOMBRE`, SUM(v.`CANTIDAD`) AS cantidad, SUM(v.`importe`) AS montobs
FROM ventas v
LEFT JOIN inv_articulos a ON v.`cod_art` = a.`cod_art`
LEFT JOIN personacliente p ON v.`idcliente` = p.`IDPERSONACLIENTE`
LEFT JOIN tipocliente t ON p.`IDTIPOCLIENTE` = t.`IDTIPOCLIENTE`
WHERE v.`FECHA` BETWEEN '2019-01-01' AND '2019-12-31'
AND v.`idusuario` <> 5
-- and v.`idtipopedido` in (1, 5)
-- and v.`idcliente` in (911,1463,1464,1465,1466,1468,1472,1557) -- sedem
-- and v.`idcliente` in (176,177,178,405,444,731,732,733,734,735,736,737,934) -- Hipermaxi
-- AND V.`idcliente` IN (174,175) -- ICNORTE
-- AND v.`idcliente` in (363, 460) -- Desayuno
AND v.`IDVENTADIRECTA` IS NOT NULL -- contado
-- AND t.`IDTIPOCLIENTE` in (5, 11)
GROUP BY t.`IDTIPOCLIENTE`, t.`NOMBRE`
;


-- Reporte ventas x Zonz
SELECT tr.`NOMBRE` AS Zona, SUM(v.`importe`) AS Montobs
FROM ventas v
LEFT JOIN inv_articulos a 	ON v.`cod_art` = a.`cod_art`
LEFT JOIN personacliente p 	ON v.`idcliente` = p.`IDPERSONACLIENTE`
LEFT JOIN tipocliente t 	ON p.`IDTIPOCLIENTE` = t.`IDTIPOCLIENTE`
LEFT JOIN territoriotrabajo tr  ON p.`IDTERRITORIOTRABAJO` = tr.`IDTERRITORIOTRABAJO`
WHERE v.`FECHA` BETWEEN '2020-01-01' AND '2020-01-31'
AND v.`idusuario` <> 5
-- and v.`tipoventa` = 'CREDIT'
GROUP BY tr.`NOMBRE`
;


SELECT p.`IDPERSONACLIENTE` AS id, CONCAT(p.`NOM`, ' ', p.`AP`, ' ', p.`AM`) AS cliente,  SUM(v.`CANTIDAD`) AS cantidad, SUM(v.`importe`) AS montobs
FROM ventas v
LEFT JOIN inv_articulos a ON v.`cod_art` = a.`cod_art`
LEFT JOIN personacliente p ON v.`idcliente` = p.`IDPERSONACLIENTE`
LEFT JOIN tipocliente t ON p.`IDTIPOCLIENTE` = t.`IDTIPOCLIENTE`
WHERE v.`FECHA` BETWEEN '2019-01-01' AND '2019-12-31'
AND v.`idusuario` <> 5
AND v.`idtipopedido` IN (1, 5)
AND v.`IDVENTADIRECTA` IS NULL
AND t.`IDTIPOCLIENTE` NOT IN (2, 6, 8, 13)
GROUP BY id, cliente
;



-- Reporte de Botellas 2L x Mes
SELECT MONTH(v.`FECHA`) AS mes, SUM(v.`CANTIDAD`) AS cantidad, SUM(v.`importe`) AS montobs
FROM ventas v
LEFT JOIN inv_articulos a ON v.`cod_art` = a.`cod_art`
WHERE v.`FECHA` BETWEEN '2019-01-01' AND '2019-12-31'
AND v.`idusuario` <> 5
AND v.`idtipopedido` IN (1, 5)
AND v.`cod_art` IN (128, 129, 130, 131, 132)
GROUP BY mes
;


-- Reporte ventas Queso SUBSIDIO
SELECT MONTH(v.`FECHA`) AS mes, p.`NOM`,  v.`cod_art`, a.`descri`, SUM(v.`CANTIDAD`) AS cantidad, SUM(v.`importe`) AS montobs
FROM ventas v
LEFT JOIN inv_articulos a  ON v.`cod_art` = a.`cod_art`
LEFT JOIN personacliente p ON v.`idcliente` = p.`IDPERSONACLIENTE`
WHERE v.`FECHA` BETWEEN '2019-01-01' AND '2019-12-31'
AND v.`idusuario` <> 5
AND v.`idtipopedido` IN (1, 5)
AND v.`cod_art` IN (148, 150)
AND v.`idcliente` IN (911,1463,1464,1465,1466,1468,1472,1557)
GROUP BY mes, p.`NOM`, v.`cod_art`, a.`descri`
;


-- Revision de Ventas por cliente
SELECT p.`FECHA_ENTREGA`, p.`ESTADO`, p.`CODIGO`, pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art` AS COD_ART, ar.`descri` AS PRODUCTO, SUM(a.`CANTIDAD`) AS CANT_PRODUCTOS, SUM(a.`IMPORTE`) AS TOTAL_BS
FROM articulos_pedido a
LEFT JOIN pedidos p ON a.idpedidos = p.`IDPEDIDOS`
LEFT JOIN personacliente pc ON p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
WHERE p.`FECHA_ENTREGA` BETWEEN '2020-07-01' AND '2020-07-31'
AND P.`ESTADO` <> 'ANULADO'
AND p.`IDUSUARIO` <> 5
AND p.`IDCLIENTE` IN (66)
GROUP BY p.`FECHA_ENTREGA`, p.`ESTADO`, p.`CODIGO`, pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art`, ar.`descri`;


SELECT pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art` AS COD_ART, ar.`descri` AS PRODUCTO, SUM(a.`CANTIDAD`) AS CANT_PRODUCTOS, SUM(a.`IMPORTE`) AS TOTAL_BS
FROM articulos_pedido a
LEFT JOIN pedidos p ON a.idpedidos = p.`IDPEDIDOS`
LEFT JOIN personacliente pc ON p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
WHERE p.`FECHA_ENTREGA` BETWEEN '2020-08-01' AND '2020-08-31'
AND P.`ESTADO` <> 'ANULADO'
AND p.`IDUSUARIO` <> 5
AND p.`IDCLIENTE` IN (66)
GROUP BY pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art`, ar.`descri`;



SELECT pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art` AS COD_ART, ar.`descri` AS PRODUCTO, SUM(a.`CANTIDAD`) AS CANT_PRODUCTOS, SUM(a.`IMPORTE`) AS TOTAL_BS, SUM(a.`PROMOCION`) AS PROMOCION
FROM articulos_pedido a
LEFT JOIN pedidos p ON a.idpedidos = p.`IDPEDIDOS`
LEFT JOIN personacliente pc ON p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
WHERE p.`FECHA_ENTREGA` BETWEEN '2021-01-15' AND '2021-01-26'
AND P.`ESTADO` <> 'ANULADO'
AND p.`IDUSUARIO` <> 5
AND p.`tipoventa` = 'CREDIT'
AND a.`cod_art` = 118
GROUP BY pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art`, ar.`descri`;


SELECT p.`FECHA_ENTREGA`, pc.`IDPERSONACLIENTE`, pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art` AS COD_ART, ar.`descri` AS PRODUCTO, a.`CANTIDAD`, a.`IMPORTE`, a.`PROMOCION`, pc.`IDTIPOCLIENTE`
FROM articulos_pedido a
LEFT JOIN pedidos p ON a.idpedidos = p.`IDPEDIDOS`
LEFT JOIN personacliente pc ON p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
WHERE p.`FECHA_ENTREGA` BETWEEN '2020-09-26' AND '2020-11-30'
AND P.`ESTADO` <> 'ANULADO'
AND p.`IDUSUARIO` <> 5
-- and p.`tipoventa` = 'CREDIT'
AND a.`cod_art` = 118
-- and a.`PROMOCION` > 0
AND pc.`IDTIPOCLIENTE` NOT IN (2)
AND pc.`IDPERSONACLIENTE` IN (

)
;


-- ------------- *** REPORTE 3. VENTAS x PRODUCTO + PROMOCION (PEDIDOS) -------------
-- -----------------------------------------------------------------
SELECT a.`cod_art` AS COD_ART, ar.`descri` AS PRODUCTO, SUM(a.`CANTIDAD`) AS CANT, SUM(a.`PROMOCION`) AS PROMOCION, SUM(a.`IMPORTE`) AS TOTAL_BS
FROM articulos_pedido a
LEFT JOIN pedidos p ON a.idpedidos = p.`IDPEDIDOS`
LEFT JOIN personacliente pc ON p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
WHERE p.`FECHA_ENTREGA` BETWEEN '2021-04-17' AND '2021-05-08'
AND P.`ESTADO` <> 'ANULADO'
AND p.`IDUSUARIO` NOT IN (5, 408)
AND p.`IDTIPOPEDIDO` IN (1, 5)
AND a.`cod_art` = 118
-- AND p.`tipoventa` = 'CREDIT'
GROUP BY a.`cod_art`, ar.`descri`
;



-- 
-- 	VENTAS AGENCIA
	SELECT a.`cod_art`, ar.`descri`, SUM(a.`CANTIDAD`) AS CANT, SUM(a.`REPOSICION`) AS REP, SUM(a.`PROMOCION`) AS PROMO, SUM(a.`IMPORTE`) AS TOTAL_BS
	FROM articulos_pedido a
	LEFT JOIN pedidos p ON a.idpedidos = p.`IDPEDIDOS`
	LEFT JOIN personacliente pc ON p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
	LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
	WHERE p.`FECHA_ENTREGA` BETWEEN '2021-04-12' AND '2021-06-30'
	AND P.`ESTADO` <> 'ANULADO'
	AND p.`IDUSUARIO` IN (541)
	AND p.`IDTIPOPEDIDO` IN (1, 5)
	AND p.`tipoventa` = 'CASH'
	GROUP BY a.`cod_art`, ar.`descri`
	;


--      PEDIDOS PARA AGENCIA
	SELECT a.`cod_art`, ar.`descri`, COUNT(p.`IDPEDIDOS`) AS cont, SUM(a.`CANTIDAD`) AS CANT, SUM(a.`REPOSICION`) AS REP, SUM(a.`PROMOCION`) AS PROMO, SUM(a.`IMPORTE`) AS TOTAL_BS
	FROM articulos_pedido a
	LEFT JOIN pedidos p ON a.idpedidos = p.`IDPEDIDOS`
	LEFT JOIN personacliente pc ON p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
	LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
	WHERE p.`FECHA_ENTREGA` BETWEEN '2021-04-01' AND '2021-07-30'
	AND P.`ESTADO` <> 'ANULADO'
	AND p.`IDTIPOPEDIDO` IN (1, 5)
	AND p.`tipoventa` = 'CREDIT'
	AND p.`IDCLIENTE` = 2238
	GROUP BY a.`cod_art`, ar.`descri`
	;




-- ----------------------------------------------------------------
-- --------------------- DETALLE DE PEDIDOS -----------------------
SELECT 	a.`IDARTICULOSPEDIDO` AS IdArtP, p.`FECHA_ENTREGA`, P.`FECHA_PEDIDO`,
	p.`IDPEDIDOS`, 
	p.`CODIGO`,
	P.`tipoventa`,
	P.`ESTADO`,
	p.`IDCLIENTE`,
	CONCAT(pc.`NOM`,' ',pc.`AP`,' ',pc.`AM`) AS CLIENTE, p.`OBSERVACION`, p.`DESCRIPCION`,
	a.`cod_art`, 
	ar.`descri`, 
	a.`CANTIDAD`, a.`PROMOCION`, a.`REPOSICION`, a.`TOTAL`, a.`PRECIO`, a.`IMPORTE`, 
	p.`VALORCOMISION`, p.`TOTALIMPORTE`,
	-- a.`cu`,
	p.`IDTIPOPEDIDO`, p.`CV`, p.`IDMOVIMIENTO`,
	p.`ESTADO`, p.`id_tmpenc`, p.`TIENEFACTURA`, p.`FACTURA`, p.`id_tmpenc`
FROM articulos_pedido a
LEFT JOIN pedidos p ON a.idpedidos = p.`IDPEDIDOS`
LEFT JOIN personacliente pc ON p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
WHERE p.`FECHA_ENTREGA` BETWEEN '2021-04-01' AND '2021-07-30'
AND p.`IDCLIENTE` = 2238
AND p.`IDTIPOPEDIDO` NOT IN (2)
AND p.`ESTADO` <> 'ANULADO'
;
