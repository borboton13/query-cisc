-- ----------------------------------------------------------------
-- ---------------------- RESUMEN PEDIDOS -------------------------
SELECT p.`IDPEDIDOS`, pc.`NOM`, pc.`AP`, pc.`AM`, p.`FECHA_ENTREGA`, p.`CODIGO`, p.`ESTADO`, p.`TOTAL`, p.`TOTALIMPORTE`
FROM pedidos p
LEFT JOIN personacliente pc ON p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
WHERE p.`FECHA_ENTREGA` BETWEEN '2015-10-01' AND '2015-10-31'
-- AND p.`ESTADO` <> 'ANULADO'
-- AND pc.`NOM` LIKE '%LACTE%'
;
-- ----------------------------------------------------------------
-- --------------------- DETALLE DE PEDIDOS -----------------------
SELECT p.`FECHA_ENTREGA` AS FECHA, p.`IDPEDIDOS`, p.`CODIGO` AS COD_PED, CONCAT(pc.`NOM`,' ',pc.`AP`,' ',pc.`AM`) AS NOMB_CLIENTE, a.`cod_art`, a.`IDARTICULOSPEDIDO` AS IdArtP, ar.`descri`, a.`CANTIDAD`, a.`PROMOCION`, a.`REPOSICION`, a.`TOTAL`, a.`PRECIO`, a.`IMPORTE`, p.`ESTADO`, a.POR_REPONER, a.`estado`
FROM articulos_pedido a
LEFT JOIN pedidos p ON a.idpedidos = p.`IDPEDIDOS`
LEFT JOIN personacliente pc ON p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
WHERE p.`FECHA_ENTREGA` BETWEEN '2015-10-01' AND '2015-10-31'
-- WHERE p.`CODIGO` = 2476
AND pc.`NOM` LIKE '%LACTE%'
AND a.`IDPEDIDOS` = 2584
-- AND pc.`AP` LIKE '%Car%'
;


-- -------------------------------------------------------------------
-- --------------------- UPDATE ESTADO PEDIDOS -----------------------
SELECT p.`FECHA_ENTREGA`, p.`CODIGO`, p.`ESTADO`, p.`TOTAL`, p.`TOTALIMPORTE`
UPDATE pedidos p SET p.estado = 'ENTREGADO'
-- FROM pedidos p
WHERE p.`FECHA_ENTREGA` BETWEEN '2015-08-31' AND '2015-11-10'
AND (p.`ESTADO` = 'PREPARAR' OR  p.`ESTADO` = 'PENDIENTE')
;

-- -------------------------------------------------------------------
-- ------------------ DELETE ARTICULOS PEDIDOS -----------------------
-- select * from articulos_pedido
-- DELETE FROM articulos_pedido
WHERE IDPEDIDOS IN (2648);

-- delete from pedidos
WHERE IDPEDIDOS IN (2648);

-- -------------------------------------------
-- - CONTROL ARTICULOS DUPLICADOS EN PEDIDOS -
-- -------------------------------------------
SELECT p.`FECHA_ENTREGA`, pc.`NOM`, p.`IDPEDIDOS`, p.`CODIGO` AS COD_PED, a.`cod_art`, a.`IDARTICULOSPEDIDO`, ar.`descri`, a.`CANTIDAD`, a.`REPOSICION`, a.`TOTAL`, p.`ESTADO`, a.`PRECIO`, a.`IMPORTE`, a.POR_REPONER
FROM articulos_pedido a
LEFT JOIN pedidos p ON a.idpedidos = p.`IDPEDIDOS`
LEFT JOIN personacliente pc ON p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
WHERE p.`FECHA_ENTREGA` = '2015-10-30'
-- AND p.`CODIGO` = 2476
;

SELECT *
FROM (
	SELECT p.`FECHA_ENTREGA`, pc.`NOM`, p.`IDPEDIDOS`, p.`CODIGO` AS COD_PED, a.`cod_art`, ar.`descri`, COUNT(a.`IDARTICULOSPEDIDO`) AS repetido, SUM(a.`TOTAL`) AS cant_total
	FROM articulos_pedido a
		LEFT JOIN pedidos p ON a.idpedidos = p.`IDPEDIDOS`
		LEFT JOIN personacliente pc ON p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
		LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
	WHERE p.`FECHA_ENTREGA` BETWEEN '2015-11-03' AND '2015-11-07'
	-- AND p.`CODIGO` = 2476
	GROUP BY pc.`NOM`, p.`IDPEDIDOS`, p.`CODIGO`, a.`cod_art`, ar.`descri`
      ) CONTROL
WHERE CONTROL.repetido >= 2
;


-- ---------------------------------------------------
-- ------------- REPORTE 1 VENTAS CLIENTES -------------
-- ---------------------------------------------------
SELECT pc.`IDPERSONACLIENTE` AS ID, pc.`NIT`, pc.`NRO_DOC`, CONCAT(pc.`NOM`, ' ', pc.`AP`, ' ', pc.`AM`) AS CLIENTE, SUM(a.`IMPORTE`) AS TOTAL_BS, COUNT(DISTINCT p.`CODIGO`) AS CANT_PEDIDOS
FROM articulos_pedido a
LEFT JOIN pedidos p ON a.idpedidos = p.`IDPEDIDOS`
LEFT JOIN personacliente pc ON p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
WHERE p.`FECHA_ENTREGA` BETWEEN '2015-10-01' AND '2015-10-31'
AND P.`ESTADO` <> 'ANULADO'
-- AND pc.`NOM` LIKE '%TORRES%'
GROUP BY pc.`IDPERSONACLIENTE`, pc.`NIT`, pc.`NRO_DOC`;
-- ---------------------------------------------------

-- --------------------------------------------------------------
-- ------------- REPORTE 2 VENTAS CLIENTES x Producto -------------
-- --------------------------------------------------------------
-- SELECT pc.`NOM`, pc.`AP`, pc.`AM`, p.`IDPEDIDOS`, p.`CODIGO` AS COD_PED, a.`IDARTICULOSPEDIDO`, a.`cod_art`, ar.`descri`, a.`CANTIDAD`, a.`REPOSICION`, a.`TOTAL`, p.`ESTADO`, a.`IMPORTE`
SELECT pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art` AS COD_ART, ar.`descri` AS PRODUCTO, SUM(a.`CANTIDAD`) AS CANT_PRODUCTOS, SUM(a.`IMPORTE`) AS TOTAL_BS
FROM articulos_pedido a
LEFT JOIN pedidos p ON a.idpedidos = p.`IDPEDIDOS`
LEFT JOIN personacliente pc ON p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
WHERE p.`FECHA_ENTREGA` BETWEEN '2015-10-01' AND '2015-10-31'
AND P.`ESTADO` <> 'ANULADO'
-- AND pc.`NOM` LIKE '%TORRES%'
GROUP BY pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art`, ar.`descri`;
-- ---------------------------------------------------


-- --------------------------------------------------------------
-- ------------- REPORTE 3 VENTAS x Producto -------------
-- --------------------------------------------------------------
-- SELECT pc.`NOM`, pc.`AP`, pc.`AM`, p.`IDPEDIDOS`, p.`CODIGO` AS COD_PED, a.`IDARTICULOSPEDIDO`, a.`cod_art`, ar.`descri`, a.`CANTIDAD`, a.`REPOSICION`, a.`TOTAL`, p.`ESTADO`, a.`IMPORTE`
SELECT a.`cod_art` AS COD_ART, ar.`descri` AS PRODUCTO, SUM(a.`CANTIDAD`) AS CANT_ARTICULOS, SUM(a.`IMPORTE`) AS TOTAL_BS
FROM articulos_pedido a
LEFT JOIN pedidos p ON a.idpedidos = p.`IDPEDIDOS`
LEFT JOIN personacliente pc ON p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
WHERE p.`FECHA_ENTREGA` BETWEEN '2015-10-01' AND '2015-10-31'
AND P.`ESTADO` <> 'ANULADO'
-- AND pc.`NOM` LIKE '%TORRES%'
GROUP BY a.`cod_art`, ar.`descri`;
-- ---------------------------------------------------

