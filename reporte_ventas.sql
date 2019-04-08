-- -------------------
-- PRODUCTOS LACTEOS
-- -------------------
-- ---------------------------------------------------------------
-- ------------- REPORTE 1. VENTAS CLIENTES x PEDIDO (PEDIDOS)-------------
-- ---------------------------------------------------------------
SELECT pc.`IDPERSONACLIENTE` AS ID, pc.`NIT`, pc.`NRO_DOC`, CONCAT(pc.`NOM`, ' ', pc.`AP`, ' ', pc.`AM`) AS CLIENTE, SUM(a.`IMPORTE`) AS TOTAL_BS, COUNT(DISTINCT p.`CODIGO`) AS CANT_PEDIDOS
FROM articulos_pedido a
LEFT JOIN pedidos p ON a.idpedidos = p.`IDPEDIDOS`
LEFT JOIN personacliente pc ON p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
WHERE p.`FECHA_ENTREGA` BETWEEN '2019-03-01' AND '2019-03-31'
AND P.`ESTADO` <> 'ANULADO'
AND p.`IDUSUARIO` <> 5
-- AND pc.`NOM` LIKE '%TORRES%'
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
-- ------------- REPORTE 3. VENTAS x PRODUCTO (PEDIDOS) -------------
-- -----------------------------------------------------------------
-- SELECT pc.`NOM`, pc.`AP`, pc.`AM`, p.`IDPEDIDOS`, p.`CODIGO` AS COD_PED, a.`IDARTICULOSPEDIDO`, a.`cod_art`, ar.`descri`, a.`CANTIDAD`, a.`REPOSICION`, a.`TOTAL`, p.`ESTADO`, a.`IMPORTE`
SELECT a.`cod_art` AS COD_ART, ar.`descri` AS PRODUCTO, SUM(a.`CANTIDAD`) AS CANT_ARTICULOS, /*SUM(a.total),*/ SUM(a.`IMPORTE`) AS TOTAL_BS
FROM articulos_pedido a
LEFT JOIN pedidos p ON a.idpedidos = p.`IDPEDIDOS`
LEFT JOIN personacliente pc ON p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
WHERE p.`FECHA_ENTREGA` BETWEEN '2019-03-01' AND '2019-03-31'
AND P.`ESTADO` <> 'ANULADO'
AND p.`IDUSUARIO` <> 5
-- AND pc.`NOM` LIKE '%TORRES%'
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
WHERE v.`FECHA_PEDIDO` BETWEEN '2019-03-01' AND '2019-03-31'
AND v.`ESTADO` <> 'ANULADO'
-- AND ar.`cuenta_art` = '4420110201'
AND v.`IDUSUARIO` <> 5
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
WHERE v.`FECHA_PEDIDO` BETWEEN '2019-03-01' AND '2019-03-31'
AND v.`ESTADO` <> 'ANULADO'
-- AND V.`IDUSUARIO` IN (6, 404)
AND v.`IDUSUARIO` <> 5
GROUP BY pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art`, ar.`descri`;
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
-- ------------- REPORTE 3. VENTAS x PRODUCTO (PEDIDOS) -------------
-- -----------------------------------------------------------------
-- SELECT pc.`NOM`, pc.`AP`, pc.`AM`, p.`IDPEDIDOS`, p.`CODIGO` AS COD_PED, a.`IDARTICULOSPEDIDO`, a.`cod_art`, ar.`descri`, a.`CANTIDAD`, a.`REPOSICION`, a.`TOTAL`, p.`ESTADO`, a.`IMPORTE`
SELECT a.`cod_art` AS COD_ART, ar.`descri` AS PRODUCTO, SUM(a.`CANTIDAD`) AS CANT_ARTICULOS, /*SUM(a.total),*/ SUM(a.`IMPORTE`) AS TOTAL_BS
FROM articulos_pedido a
LEFT JOIN pedidos p ON a.idpedidos = p.`IDPEDIDOS`
LEFT JOIN personacliente pc ON p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
WHERE p.`FECHA_ENTREGA` BETWEEN '2019-02-01' AND '2019-02-28'
AND P.`ESTADO` <> 'ANULADO'
AND p.`IDUSUARIO` = 5
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
WHERE v.`FECHA_PEDIDO` BETWEEN '2019-02-01' AND '2019-02-28'
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
WHERE v.`FECHA_PEDIDO` BETWEEN '2019-03-01' AND '2019-03-31'
AND v.`ESTADO` <> 'ANULADO'
-- AND V.`IDUSUARIO` IN (6, 404)
AND v.`IDUSUARIO` <> 5
GROUP BY pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art`, ar.`descri`;
-- ---------------------------------------------------
