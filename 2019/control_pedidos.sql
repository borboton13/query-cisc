-- ACTUALIZAR INVENTARIO LACTEOS
UPDATE inv_inventario i SET i.`saldo_uni` = 1000000000 WHERE i.`cod_alm` = 2;
UPDATE inv_inventario_detalle i SET i.`cantidad` = 1000000000 WHERE i.`cod_alm` = 2;

UPDATE inv_inventario i SET i.`saldo_uni` = 100000 WHERE i.`cod_alm` = 6;
UPDATE inv_inventario_detalle i SET i.`cantidad` = 100000 WHERE i.`cod_alm` = 6;

UPDATE inv_inventario i SET i.`saldo_uni` = 1000000000 WHERE i.`cod_alm` = 8;
UPDATE inv_inventario_detalle i SET i.`cantidad` = 1000000000 WHERE i.`cod_alm` = 8;

UPDATE inv_articulos i SET i.`saldo_mon` = 0, i.`costo_uni` = 0, i.`ct` = 0, i.`cu` = 0
WHERE i.`cod_art` IN (

);

-- -----------------------------------------------------------------
-- Ventas al contado X articulo
-- -----------------------------------------------------------------
SELECT v.`IDVENTADIRECTA`, v.`FECHA_PEDIDO`, v.`CODIGO`, v.`ESTADO`, a.`CANTIDAD`, a.`REPOSICION`, a.`TOTAL`, a.`PRECIO`, a.`IMPORTE`
FROM articulos_pedido a
JOIN ventadirecta v ON a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
WHERE v.`FECHA_PEDIDO` BETWEEN '2016-01-01' AND	'2016-12-31'
AND a.`cod_art` IN (237)
;

-- PEDIDOS - ASIENTOS
SELECT p.`IDPEDIDOS`, p.`FECHA_ENTREGA`, p.`CODIGO`, p.`IDTIPOPEDIDO`, t.`NOMBRE`, p.`id_tmpenc`, e.`tipo_doc`, e.`no_doc`, d.`id_tmpdet`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`
FROM pedidos p
JOIN tipopedido t ON p.`IDTIPOPEDIDO` = t.`IDTIPOPEDIDO`
JOIN sf_tmpenc e ON p.`id_tmpenc` = e.`id_tmpenc`
JOIN sf_tmpdet d ON e.`id_tmpenc` = d.`id_tmpenc`
JOIN arcgms a 	 ON d.`cuenta` = a.`cuenta`
WHERE p.`FECHA_ENTREGA` BETWEEN '2019-01-01' AND '2019-03-31'
AND p.`ESTADO` <> 'ANULADO'
AND p.`IDUSUARIO` <> 5
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
-- AND p.`IDPEDIDOS` IN ()
AND p.`IDCLIENTE` = 2238
-- and p.`CODIGO` in (1090)
AND p.`ESTADO` <> 'ANULADO'
-- and pc.`IDTERRITORIOTRABAJO` = 25
-- and pc.`NOM` like '%Monica Lau%'
-- and a.`IDPEDIDOS` = 58548
-- AND pc.`AP` LIKE '%Car%'
-- and a.`cod_art` in (1090)
-- AND p.`IDUSUARIO` = 5
-- and a.`TOTAL` = 0
;



UPDATE articulos_pedido a 
SET a.`TOTAL` = (a.`CANTIDAD` + a.`PROMOCION` + a.`REPOSICION`)
WHERE a.`IDARTICULOSPEDIDO` IN (

);


UPDATE pedidos p SET p.`ESTADO` = 'ANULADO' 
WHERE P.`IDPEDIDOS` IN (
62954, 63194
);





SELECT DISTINCT i.`cod_alm`
FROM inv_periodo i
WHERE i.`gestion` = 2021
;

SELECT *
FROM pedidos p
-- update pedidos p set p.`ESTADO` = 'ANULADO', p.`OBSERVACION` = 'Entrega anticipada, F-3680 vig, nota ANL'
-- update pedidos p set p.`ESTADO` = 'CONTABILIZADO'
WHERE p.`FECHA_ENTREGA` BETWEEN '2020-01-01' AND '2020-12-31'
AND p.`CODIGO` IN (8061)
;

-- update pedidos p set p.`IDCLIENTE` = 665 where p.`IDPEDIDOS` = 51331;

-- update pedidos p set p.`ESTADO` = 'ANULADO' where p.`IDPEDIDOS`= 35615;
-- update sf_tmpenc e SET e.`estado` = 'ANL' where e.`id_tmpenc` = 123001;
-- update movimiento m set m.`ESTADO` = 'A' WHERE m.`IDMOVIMIENTO` = 60392;
UPDATE pedidos p SET p.`FECHA_ENTREGA` = '2020-11-18' WHERE p.`IDPEDIDOS`= 54958; -- 2020-11-18




SELECT *
FROM movimiento m
-- where m.`NROFACTURA` in (7411,    8895, 119, 347)
WHERE m.`IDPEDIDOS` IN (31535, 32340, 32541, 32617)
AND m.`FECHA_FACTURA` >= '2019-05-01'
;


-- update pedidos p set p.`FECHA_ENTREGA` = '2019-06-15' where p.`IDPEDIDOS`= 32541; -- 2019-06-15
-- update pedidos p set p.`FECHA_ENTREGA` = '2019-06-19' where p.`IDPEDIDOS`= 32617; -- 2019-06-19



SELECT *
FROM ventaarticulo a
WHERE a.`cod_art` IN (120, 122);

-- 
-- --------------------- DETALLE DE VENTAS CONTADO -----------------------
SELECT 	v.`FECHA_PEDIDO`,
	v.`IDVENTADIRECTA`,
	v.`CODIGO`,
	CONCAT(pc.`NOM`,' ',pc.`AP`,' ',pc.`AM`) AS CLIENTE, 
	a.`cod_art`, 
	a.`IDARTICULOSPEDIDO` AS IdArtP, 
	ar.`descri`, -- v.`OBSERVACION`,
	a.`CANTIDAD`, a.`PROMOCION`, a.`REPOSICION`, a.`TOTAL`, a.`PRECIO`, a.`IMPORTE`, 
	a.`cu`,
	v.`IDMOVIMIENTO`,
	v.`ESTADO`, v.`id_tmpenc`
FROM articulos_pedido a
LEFT JOIN ventadirecta v ON a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
LEFT JOIN personacliente pc ON v.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
WHERE v.`FECHA_PEDIDO` BETWEEN '2021-01-01' AND '2021-10-31'
AND v.idventadirecta IN (48441)
-- AND p.`IDPEDIDOS` IN (21928)
-- AND p.`IDCLIENTE` = 65
-- and v.`CODIGO` in (12267)
-- AND pc.`NOM` LIKE '%Randy%'
-- AND a.`IDPEDIDOS` = 2584
-- AND pc.`AP` LIKE '%Car%'
-- and a.`cod_art` = 143
-- and v.`IDUSUARIO` = 5
;


SELECT zz.cod_art, zz.descri, SUM(zz.total) AS cant
FROM (
	/*SELECT 	a.`cod_art`,  ar.`descri`,  SUM(a.`TOTAL`) AS total
	FROM articulos_pedido a
	LEFT JOIN pedidos p ON a.idpedidos = p.`IDPEDIDOS`
	LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
	WHERE p.`FECHA_ENTREGA` BETWEEN '2018-06-29' AND '2018-07-31'
	AND p.`IDPEDIDOS` > 23759
	AND p.`ESTADO` <> 'ANULADO'
	AND p.`IDUSUARIO` <> 5
	GROUP BY a.`cod_art`,  ar.`descri`
		UNION ALL*/
	SELECT a.`cod_art`, ar.`descri`, SUM(a.`CANTIDAD`) AS total
	FROM articulos_pedido a
	LEFT JOIN ventadirecta v ON a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
	LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
	WHERE v.`FECHA_PEDIDO` BETWEEN '2019-01-02' AND '2019-01-03'
	AND v.idventadirecta >= 25681
	AND v.`ESTADO` <> 'ANULADO'
	AND v.`IDUSUARIO` = 5
	GROUP BY a.`cod_art`, ar.`descri`
) zz
GROUP BY zz.cod_art, zz.descri
;


--
-- Ventas al contado Xx incompleto
SELECT pc.`NOM`, a.`cod_art` AS COD_ART, ar.`descri` AS PRODUCTO, SUM(a.`CANTIDAD`) AS CANTIDAD
FROM articulos_pedido a
LEFT JOIN ventadirecta v ON a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
LEFT JOIN personacliente pc ON v.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
WHERE v.`FECHA_PEDIDO` BETWEEN '2016-09-01' AND '2016-09-30'
AND v.`ESTADO` <> 'ANULADO'
AND ar.`cuenta_art` = '4420110201'
GROUP BY a.`cod_art`, ar.`descri`;

-- -------------------------------------------
-- - CONTROL ARTICULOS DUPLICADOS EN PEDIDOS -
-- -------------------------------------------
SELECT p.`FECHA_ENTREGA`, pc.`NOM`, p.`IDPEDIDOS`, p.`CODIGO` AS COD_PED, a.`cod_art`, a.`IDARTICULOSPEDIDO`, ar.`descri`, a.`CANTIDAD`, a.`REPOSICION`, a.`TOTAL`, p.`ESTADO`, a.`PRECIO`, a.`IMPORTE`, a.POR_REPONER
FROM articulos_pedido a
LEFT JOIN pedidos p ON a.idpedidos = p.`IDPEDIDOS`
LEFT JOIN personacliente pc ON p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
WHERE p.`FECHA_ENTREGA` = '2016-07-25'
-- AND p.`CODIGO` = 164
;

SELECT *
FROM (
	SELECT p.`FECHA_ENTREGA`, pc.`NOM`, p.`IDPEDIDOS`, p.`CODIGO` AS COD_PED, a.`cod_art`, ar.`descri`, COUNT(a.`IDARTICULOSPEDIDO`) AS repetido
	FROM articulos_pedido a
		LEFT JOIN pedidos p ON a.idpedidos = p.`IDPEDIDOS`
		LEFT JOIN personacliente pc ON p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
		LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
	WHERE p.`FECHA_ENTREGA` BETWEEN '2016-02-03' AND '2017-12-31'
	-- AND p.`CODIGO` = 2476
	AND p.`ESTADO` <> 'ANULADO'
	GROUP BY pc.`NOM`, p.`IDPEDIDOS`, p.`CODIGO`, a.`cod_art`, ar.`descri`
      ) CONTROL
WHERE CONTROL.repetido >= 2
;



-- ------------- VENTAS CLIENTES x PRODUCTO x MES (PEDIDOS) -------------
-- --------------------------------------------------------------------------
-- SELECT pc.`NOM`, pc.`AP`, pc.`AM`, p.`IDPEDIDOS`, p.`CODIGO` AS COD_PED, a.`IDARTICULOSPEDIDO`, a.`cod_art`, ar.`descri`, a.`CANTIDAD`, a.`REPOSICION`, a.`TOTAL`, p.`ESTADO`, a.`IMPORTE`
SELECT MONTH(p.`FECHA_ENTREGA`) AS MES, pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art` AS COD_ART, ar.`descri` AS PRODUCTO, SUM(a.`CANTIDAD`) AS CANTIDAD
FROM articulos_pedido a
LEFT JOIN pedidos p ON a.idpedidos = p.`IDPEDIDOS`
LEFT JOIN personacliente pc ON p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
WHERE p.`FECHA_ENTREGA` BETWEEN '2019-02-01' AND '2019-02-28'
AND P.`ESTADO` <> 'ANULADO'
AND p.`IDCLIENTE` = 180 -- SEMAPA
-- AND pc.`NOM` LIKE '%TORRES%'
GROUP BY MONTH(p.`FECHA_ENTREGA`), pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art`, ar.`descri`;
-- ---------------------------------------------------


--
-- CANTIDAD DE ARTICULOS DE PEDIDOS
SELECT a.`cod_art` AS COD_ART, ar.`descri` AS PRODUCTO, SUM(a.`CANTIDAD`) AS CANT_PRODUCTOS
FROM articulos_pedido a
LEFT JOIN pedidos p ON a.idpedidos = p.`IDPEDIDOS`
LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
WHERE p.`FECHA_ENTREGA` BETWEEN '2016-02-01' AND '2016-02-02'
AND P.`ESTADO` <> 'ANULADO'
GROUP BY a.`cod_art`, ar.`descri`;

-- CANTIDAD DE ARTICULOS DE VENTAS AL CONTADO
SELECT a.`cod_art` AS COD_ART, ar.`descri` AS PRODUCTO, SUM(a.`CANTIDAD`) AS CANT_PRODUCTOS
FROM articulos_pedido a
LEFT JOIN ventadirecta v ON a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
WHERE v.`FECHA_PEDIDO` BETWEEN '2016-02-20' AND '2016-02-20'
-- AND v.`IDUSUARIO` = 4
AND v.`ESTADO` <> 'ANULADO'
-- AND ar.`cuenta_art` = 4420110201
GROUP BY a.`cod_art`, ar.`descri`
;


-- 06/07/2018 CANTIDAD DE ARTICULOS POR FECHA X PEDIDO
SELECT p.`FECHA_ENTREGA`, a.`cod_art` AS COD_ART, ar.`descri` AS PRODUCTO, SUM(a.`CANTIDAD`) AS CANT_PRODUCTOS
FROM articulos_pedido a
LEFT JOIN pedidos p ON a.idpedidos = p.`IDPEDIDOS`
LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
WHERE p.`FECHA_ENTREGA` BETWEEN '2019-01-01' AND '2019-01-31'
AND P.`ESTADO` <> 'ANULADO'
-- AND p.`IDUSUARIO` <> 5
AND a.`cod_art` = 151
GROUP BY p.`FECHA_ENTREGA`, a.`cod_art`, ar.`descri`;

-- 06/07/2018 CANTIDAD DE ARTICULOS X FECHA X VENTA CONTADO
SELECT v.`FECHA_PEDIDO`, a.`cod_art` AS COD_ART, ar.`descri` AS PRODUCTO, SUM(a.`CANTIDAD`) AS CANT_PRODUCTOS
FROM articulos_pedido a
LEFT JOIN ventadirecta v ON a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
WHERE v.`FECHA_PEDIDO` BETWEEN '2019-01-01' AND '2019-01-31'
-- AND v.`IDUSUARIO` <> 5
AND v.`ESTADO` <> 'ANULADO'
AND a.`cod_art` = 151
GROUP BY v.`FECHA_PEDIDO`, a.`cod_art`, ar.`descri`
;



-- 
-- Reporte cantidad, Ventas al contado
--
SELECT a.`cod_art` AS COD_ART, ar.`descri` AS PRODUCTO, SUM(a.`CANTIDAD`) AS CANTIDAD
FROM articulos_pedido a
LEFT JOIN ventadirecta v ON a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
WHERE v.`FECHA_PEDIDO` BETWEEN '2016-09-01' AND '2016-09-30'
AND v.`ESTADO` <> 'ANULADO'
AND ar.`cuenta_art` = '4420110201'
GROUP BY a.`cod_art`, ar.`descri`;

-- 
-- Reporte cantidad, Ventas Pedidos
--
SELECT a.`cod_art` AS COD_ART, ar.`descri` AS PRODUCTO, SUM(a.`CANTIDAD`) AS CANTIDAD
FROM articulos_pedido a
LEFT JOIN pedidos p ON a.idpedidos = p.`IDPEDIDOS`
LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
WHERE p.`FECHA_ENTREGA` BETWEEN '2016-09-01' AND '2016-09-30'
AND P.`ESTADO` <> 'ANULADO'
GROUP BY a.`cod_art`, ar.`descri`;

-- Degustacion, Reposicion
SELECT a.`cod_art` AS COD_ART, ar.`descri` AS PRODUCTO, SUM(a.`CANTIDAD`) AS CANTIDAD
FROM articulos_pedido a
LEFT JOIN pedidos p ON a.idpedidos = p.`IDPEDIDOS`
LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
WHERE p.`FECHA_ENTREGA` BETWEEN '2019-01-01' AND '2019-01-31'
-- and p.`IDTIPOPEDIDO` = 2 	-- Degustacion
-- and p.`IDTIPOPEDIDO` = 3 	-- Refrigerio
AND p.`IDTIPOPEDIDO` = 4 	-- Reposicion
AND P.`ESTADO` <> 'ANULADO'
GROUP BY a.`cod_art`, ar.`descri`;

--



-- Reporte,  cantidad total de ventas x producto
SELECT 	p.cod_art, p.producto, 
	(p.cantidad + IFNULL(v.cantidad, 0)) AS cantidad, 
	i.cu, 
	((p.cantidad + IFNULL(v.cantidad, 0)) * i.cu) AS costo,
	((p.cantidad + IFNULL(v.cantidad, 0)) * i.`costo_uni`) AS costo_total_uni
FROM (
	SELECT a.`cod_art` AS COD_ART, ar.`descri` AS PRODUCTO, SUM(a.`CANTIDAD`) AS CANTIDAD, SUM(a.`TOTAL`) AS cant_total
	FROM articulos_pedido a
	LEFT JOIN pedidos p ON a.idpedidos = p.`IDPEDIDOS`
	LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
	WHERE p.`FECHA_ENTREGA` BETWEEN '2017-01-01' AND '2017-01-31'
	AND P.`ESTADO` <> 'ANULADO'
	GROUP BY a.`cod_art`, ar.`descri`
	) p
LEFT JOIN (
	SELECT a.`cod_art` AS COD_ART, ar.`descri` AS PRODUCTO, SUM(a.`CANTIDAD`) AS CANTIDAD
	FROM articulos_pedido a
	LEFT JOIN ventadirecta v ON a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
	LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
	WHERE v.`FECHA_PEDIDO` BETWEEN '2017-01-01' AND '2017-01-31'
	AND v.`ESTADO` <> 'ANULADO'
	AND ar.`cuenta_art` = '4420110201'
	GROUP BY a.`cod_art`, ar.`descri`
	) v 	ON p.cod_art = v.cod_Art
LEFT JOIN inv_articulos i ON p.cod_Art = i.cod_art
;

-- Reporte, REPOSICIONES
SELECT 	p.cod_art, p.producto, 
	(p.cantidad + IFNULL(v.cantidad, 0)) AS reposicion, 
	i.cu, 
	((p.cantidad + IFNULL(v.cantidad, 0)) * i.cu) AS costo,
	((p.cantidad + IFNULL(v.cantidad, 0)) * i.`costo_uni`) AS costo_total_uni
FROM (
	SELECT a.`cod_art` AS COD_ART, ar.`descri` AS PRODUCTO, SUM(a.`REPOSICION`) AS CANTIDAD
	FROM articulos_pedido a
	LEFT JOIN pedidos p ON a.idpedidos = p.`IDPEDIDOS`
	LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
	WHERE p.`FECHA_ENTREGA` BETWEEN '2016-01-01' AND '2016-11-30'
	AND P.`ESTADO` <> 'ANULADO'
	GROUP BY a.`cod_art`, ar.`descri`
	) p
LEFT JOIN (
	SELECT a.`cod_art` AS COD_ART, ar.`descri` AS PRODUCTO, SUM(a.`CANTIDAD`) AS CANTIDAD
	FROM articulos_pedido a
	LEFT JOIN pedidos p ON a.idpedidos = p.`IDPEDIDOS`
	LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
	WHERE p.`FECHA_ENTREGA` BETWEEN '2016-01-01' AND '2016-11-30'
	AND p.`IDTIPOPEDIDO` = 4
	AND P.`ESTADO` <> 'ANULADO'
	GROUP BY a.`cod_art`, ar.`descri`
	) v 	ON p.cod_art = v.cod_Art
LEFT JOIN inv_articulos i ON p.cod_Art = i.cod_art
;

--
-- CONTROL DE PEDIDOS SIN CONTABILIZAR
SELECT p.`IDPEDIDOS`, p.`CODIGO`, p.`FECHA_ENTREGA`, p.`ESTADO`, p.`TIENEFACTURA`, pe.`NOM`, p.`IDMOVIMIENTO`, P.`TOTALIMPORTE`, P.`IMPUESTO`
FROM pedidos p
LEFT JOIN personacliente pe ON p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
WHERE p.`FECHA_ENTREGA` BETWEEN '2021-02-01' AND '2021-02-28'
-- and p.`ESTADO` = "PREPARAR" 
AND p.`tipoventa` = 'CREDIT'
AND p.`ESTADO` <> 'ANULADO'
;

SELECT *
FROM pedidos p
WHERE p.`FECHA_ENTREGA` BETWEEN '2021-01-01' AND '2021-01-31'
AND p.`tipoventa` = 'CREDIT'
AND p.`ESTADO` = 'PREPARAR'
;



-- REPORTE DE REPOSICIONES
SELECT p.`FECHA_ENTREGA` AS FECHA, pc.`NOM`, pc.`AP`, pc.`AM`,p.`CODIGO` AS COD, a.`cod_art`, ar.`descri`, a.`CANTIDAD`
FROM articulos_pedido a
LEFT JOIN pedidos p ON a.idpedidos = p.`IDPEDIDOS`
LEFT JOIN personacliente pc ON p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
WHERE p.`FECHA_ENTREGA` BETWEEN '2019-10-01' AND '2020-01-31'
AND p.`IDTIPOPEDIDO` = 4
AND P.`ESTADO` <> 'ANULADO'
UNION
SELECT p.`FECHA_ENTREGA` AS FECHA , pc.`NOM`, pc.`AP`, pc.`AM`,p.`CODIGO` AS COD, a.`cod_art`, ar.`descri`, a.`REPOSICION` AS CANTIDAD
FROM articulos_pedido a
LEFT JOIN pedidos p ON a.idpedidos = p.`IDPEDIDOS`
LEFT JOIN personacliente pc ON p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
WHERE p.`FECHA_ENTREGA` BETWEEN '2019-10-01' AND '2020-01-31'
AND a.`REPOSICION` > 0
AND P.`ESTADO` <> 'ANULADO'
UNION
SELECT v.`FECHA_PEDIDO` AS FECHA, pc.`NOM`, pc.`AP`, pc.`AM`, v.`CODIGO` AS COD, a.`cod_art`, ar.`descri`, a.`REPOSICION`  AS CANTIDAD
FROM articulos_pedido a
LEFT JOIN ventadirecta v ON a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
LEFT JOIN personacliente pc ON v.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
WHERE v.`FECHA_PEDIDO` BETWEEN '2019-10-01' AND '2020-01-31'
AND a.`REPOSICION` > 0
AND v.`ESTADO` <> 'ANULADO'
;




-- Ventas por tipo de cliente 1
SELECT DISTINCT pe.`IDPERSONACLIENTE`, pe.`NOM`, pe.`AP`, pe.`AM`, pe.`IDTIPOCLIENTE`, t.`NOMBRE`
FROM pedidos p
LEFT JOIN personacliente pe ON p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
LEFT JOIN tipocliente t ON pe.`IDTIPOCLIENTE` = t.`IDTIPOCLIENTE`
WHERE p.`FECHA_ENTREGA` >= '2019-01-01'
AND p.`IDUSUARIO` IN (
446, 443, 441
);

-- Ventas por tipo de cliente 1.1
SELECT DISTINCT pe.`IDPERSONACLIENTE`, pe.`NOM`, pe.`AP`, pe.`AM`, pe.`IDTIPOCLIENTE`, t.`NOMBRE`, a.`cod_art`, ar.`descri`, a.`PRECIO`
FROM pedidos p
LEFT JOIN personacliente pe ON p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
LEFT JOIN tipocliente t ON pe.`IDTIPOCLIENTE` = t.`IDTIPOCLIENTE`
LEFT JOIN articulos_pedido a ON p.`IDPEDIDOS` = a.`IDPEDIDOS`
LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
WHERE p.`FECHA_ENTREGA` >= '2020-01-01'
AND p.`IDUSUARIO` IN (446, 443, 441)
AND t.`IDTIPOCLIENTE` IN (6, 8, 2)
;


-- Ventas Delivery x Cliente
SELECT p.`FECHA_ENTREGA`, pe.`NOM`, pe.`AP`, pe.`AM`, p.`CODIGO`, p.`TOTALIMPORTE`, p.`MONTODIST`
-- , p.`VALORCOMISION` ,p.`IMPUESTO`, p.`OBSERVACION` ,p.`ESTADO`, p.`IDMOVIMIENTO`, p.`id_tmpenc`, p.`iddistribuidor`, pe.`IDTIPOCLIENTE`, t.`NOMBRE`, p.`IDCLIENTE`, e.`tipo_doc`, e.`no_doc`, e.`estado`
FROM pedidos p
LEFT JOIN personacliente pe ON p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
LEFT JOIN tipocliente t ON pe.`IDTIPOCLIENTE` = t.`IDTIPOCLIENTE`
LEFT JOIN sf_tmpenc e ON p.`id_tmpenc` = e.`id_tmpenc`
WHERE p.`ESTADO` <> 'ANULADO'
AND p.`FECHA_ENTREGA` BETWEEN '2020-06-01' AND '2021-02-28'
AND p.`tipoventa` = 'CREDIT'
-- and p.`iddistribuidor` is not null
AND p.`IDCLIENTE` IN (
1864	,1722	,1870	,1724	,1737	,1730	,1733	,1908	,1885	,1741	,1872	,1723	,1873	,1727	,2150	,1854	,1842	,1890	,
1736	,2077	,1729	,1860	, 1914	,1735	,1735	,1739	,1898	,1910	,2076	,1734	,1742	,1859	,2066	,2016	,2092	,2079	
)
;

-- Ventas Delivery x Cliente 2
SELECT pe.`NOM`, pe.`AP`, pe.`AM`, COUNT(p.idpedidos) AS RECURRENCIA, SUM(p.`TOTALIMPORTE`) AS IMPORTE
FROM pedidos p
LEFT JOIN personacliente pe ON p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
LEFT JOIN tipocliente t ON pe.`IDTIPOCLIENTE` = t.`IDTIPOCLIENTE`
LEFT JOIN sf_tmpenc e ON p.`id_tmpenc` = e.`id_tmpenc`
WHERE p.`ESTADO` <> 'ANULADO'
AND p.`FECHA_ENTREGA` BETWEEN '2021-01-01' AND '2021-02-28'
AND p.`tipoventa` = 'CREDIT'
-- and p.`iddistribuidor` is not null
AND p.`IDCLIENTE` IN (
1864	,1722	,1870	,1724	,1737	,1730	,1733	,1908	,1885	,1741	,1872	,1723	,1873	,1727	,2150	,1854	,1842	,1890	,
1736	,2077	,1729	,1860	, 1914	,1735	,1735	,1739	,1898	,1910	,2076	,1734	,1742	,1859	,2066	,2016	,2092	,2079	
)
GROUP BY pe.`NOM`, pe.`AP`, pe.`AM`
;

-- Ventas Delivery x Producto
SELECT i.`cod_art`, i.`descri`, SUM(a.`CANTIDAD`) AS cantidad , SUM(a.`IMPORTE`) AS total
FROM pedidos p
LEFT JOIN articulos_pedido a ON p.`IDPEDIDOS` = a.`IDPEDIDOS`
LEFT JOIN inv_articulos i ON a.`cod_art` = i.`cod_art`
LEFT JOIN personacliente pe ON p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
LEFT JOIN tipocliente t ON pe.`IDTIPOCLIENTE` = t.`IDTIPOCLIENTE`
WHERE p.`ESTADO` <> 'ANULADO'
AND p.`FECHA_ENTREGA` BETWEEN '2020-06-01' AND '2021-02-28'
AND p.`tipoventa` = 'CREDIT'
AND p.`iddistribuidor` IS NOT NULL
GROUP BY i.`cod_art`, i.`descri`
;

-- Ventas Delivery x Producto RESUMEN
SELECT i.`cod_art`, i.`descri`, SUM(a.`CANTIDAD`) AS cantidad , SUM(a.`IMPORTE`) AS total
FROM pedidos p
LEFT JOIN articulos_pedido a ON p.`IDPEDIDOS` = a.`IDPEDIDOS`
LEFT JOIN inv_articulos i ON a.`cod_art` = i.`cod_art`
LEFT JOIN personacliente pe ON p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
LEFT JOIN tipocliente t ON pe.`IDTIPOCLIENTE` = t.`IDTIPOCLIENTE`
WHERE p.`ESTADO` <> 'ANULADO'
AND p.`FECHA_ENTREGA` BETWEEN '2020-06-01' AND '2021-02-28'
AND p.`tipoventa` = 'CREDIT'
AND p.`IDCLIENTE` IN ()
GROUP BY i.`cod_art`, i.`descri`;

--

SELECT p.`FECHA_ENTREGA`, p.`CODIGO`, p.`IDCLIENTE`, p.`TOTALIMPORTE`, p.`id_tmpenc`, d.`id_tmpdet`, d.`cuenta`, a.`descri`, e.`glosa`, d.`debe`, d.`haber`
FROM pedidos p
LEFT JOIN sf_tmpdet d ON p.`id_tmpenc` = d.`id_tmpenc`
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
WHERE p.`FECHA_ENTREGA` BETWEEN '2021-04-12' AND '2021-04-31'
AND p.`tipoventa` = 'CASH'
AND p.`IDUSUARIO` = 404 
AND d.`cuenta` = '1110110100'
;


UPDATE sf_tmpdet d SET d.`cuenta` = '1110110400'
WHERE d.`id_tmpdet` IN (
1009307, 1009309
);


