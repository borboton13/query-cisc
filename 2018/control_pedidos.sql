-- -----------------------------------------------------------------
-- Ventas al contado X articulo
-- -----------------------------------------------------------------
select v.`IDVENTADIRECTA`, v.`FECHA_PEDIDO`, v.`CODIGO`, v.`ESTADO`, a.`CANTIDAD`, a.`REPOSICION`, a.`TOTAL`, a.`PRECIO`, a.`IMPORTE`
from articulos_pedido a
join ventadirecta v on a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
where v.`FECHA_PEDIDO` between '2016-01-01' and	'2016-12-31'
and a.`cod_art` in (237)
;

-- ----------------------------------------------------------------
-- ---------------------- RESUMEN PEDIDOS -------------------------
select p.`IDPEDIDOS`, pc.`NOM`, pc.`AP`, pc.`AM`, p.`FECHA_ENTREGA`, p.`CODIGO`, p.`ESTADO`, p.`TOTAL`, p.`TOTALIMPORTE`, p.`id_tmpenc`
from pedidos p
left join personacliente pc on p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
where p.`FECHA_ENTREGA` between '2019-01-01' and '2019-01-31'
-- AND p.`ESTADO` <> 'ANULADO'
-- AND pc.`NOM` LIKE '%Edelfr%'
;

-- PEDIDOS - ASIENTOS
select p.`IDPEDIDOS`, p.`FECHA_ENTREGA`, p.`CODIGO`, p.`IDTIPOPEDIDO`, t.`NOMBRE`, p.`id_tmpenc`, e.`tipo_doc`, e.`no_doc`, d.`id_tmpdet`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`
from pedidos p
join tipopedido t on p.`IDTIPOPEDIDO` = t.`IDTIPOPEDIDO`
join sf_tmpenc e on p.`id_tmpenc` = e.`id_tmpenc`
join sf_tmpdet d on e.`id_tmpenc` = d.`id_tmpenc`
join arcgms a 	 on d.`cuenta` = a.`cuenta`
where p.`FECHA_ENTREGA` between '2019-01-01' and '2019-03-31'
and p.`ESTADO` <> 'ANULADO'
and p.`IDUSUARIO` <> 5
;



-- ----------------------------------------------------------------
-- --------------------- DETALLE DE PEDIDOS -----------------------
select 	p.`FECHA_ENTREGA` as FECHA, 
	p.`IDPEDIDOS`, 
	p.`CODIGO`,
	P.`ESTADO`,
	p.`IDCLIENTE`,
	CONCAT(pc.`NOM`,' ',pc.`AP`,' ',pc.`AM`) as CLIENTE, p.`OBSERVACION`,
	a.`cod_art`, 
	a.`IDARTICULOSPEDIDO` as IdArtP, 
	ar.`descri`, 
	a.`CANTIDAD`, a.`PROMOCION`, a.`REPOSICION`, a.`TOTAL`, a.`PRECIO`, a.`IMPORTE`, 
	a.`cu`,
	p.`IDTIPOPEDIDO`, p.`CV`, p.`IDMOVIMIENTO`,
	p.`ESTADO`, p.`id_tmpenc`, p.`TIENEFACTURA`, p.`FACTURA`
from articulos_pedido a
left join pedidos p on a.idpedidos = p.`IDPEDIDOS`
left join personacliente pc on p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
where p.`FECHA_ENTREGA` between '2019-01-01' and '2019-12-31'
-- AND p.`IDPEDIDOS` >= 23759
-- AND p.`IDCLIENTE` = 65
and p.`CODIGO` in (3099)
-- AND pc.`NOM` LIKE '%Randy%'
-- AND a.`IDPEDIDOS` = 29988
-- AND pc.`AP` LIKE '%Car%'
-- AND a.`cod_art` = 589
-- AND p.`IDUSUARIO` = 5
;

-- SEDEM SCZ
-- UPDATE pedidos p SET p.`FECHA_ENTREGA` = '2019-05-03' WHERE p.`IDPEDIDOS` = 31254; -- ok
-- UPDATE pedidos p SET p.`FECHA_ENTREGA` = '2019-05-02' WHERE p.`IDPEDIDOS` = 31254; -- pen

-- HIPERMAXIS 30/04/2019
-- UPDATE pedidos p SET p.`FECHA_ENTREGA` = '2019-05-04' WHERE p.`IDPEDIDOS` IN (31195,31196,31208); -- ok
 update pedidos p set p.`FECHA_ENTREGA` = '2019-04-30' where p.`IDPEDIDOS` in (31195,31196,31208); -- pen
-- UPDATE pedidos p SET p.`IDMOVIMIENTO` = null WHERE p.`IDPEDIDOS` IN (31195,31196,31208); -- ok
-- UPDATE pedidos p SET p.`id_tmpenc` = null WHERE p.`IDPEDIDOS` IN (31195,31196,31208); -- ok
-- update movimiento m set m.`ESTADO` = 'A' where m.`IDMOVIMIENTO` in (52023,52022,52011);  -- ok


select *
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
	ar.`descri`, 
	a.`CANTIDAD`, a.`PROMOCION`, a.`REPOSICION`, a.`TOTAL`, a.`PRECIO`, a.`IMPORTE`, 
	a.`cu`,
	v.`IDMOVIMIENTO`,
	v.`ESTADO`, v.`id_tmpenc`
FROM articulos_pedido a
LEFT JOIN ventadirecta v ON a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
LEFT JOIN personacliente pc ON v.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
WHERE v.`FECHA_PEDIDO` BETWEEN '2019-01-02' AND '2019-12-31'
-- AND v.idventadirecta >= 25681
-- AND p.`IDPEDIDOS` IN (21928)
-- AND p.`IDCLIENTE` = 65
AND v.`CODIGO` IN (2396)
-- AND pc.`NOM` LIKE '%Randy%'
-- AND a.`IDPEDIDOS` = 2584
-- AND pc.`AP` LIKE '%Car%'
-- AND a.`cod_art` = 703
AND v.`IDUSUARIO` = 5
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

-- LISTA PERSONAS VENTAS
SELECT DISTINCT pc.`NRO_DOC`, pc.`NOM`, pc.`AP`, pc.`AM`, pc.`DIRECCION`, pc.`TELEFONO`, pc.`NIT`, pc.`RAZONSOCIAL`
FROM articulos_pedido a
LEFT JOIN ventadirecta v ON a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
LEFT JOIN personacliente pc ON v.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
WHERE v.`FECHA_PEDIDO` BETWEEN '2018-01-01' AND '2018-04-30'
AND v.`ESTADO` <> 'ANULADO'
AND V.`IDUSUARIO` IN (6, 404)
GROUP BY pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art`, ar.`descri`;

SELECT *
FROM articulos_pedido a
LEFT JOIN pedidos p ON a.idpedidos = p.`IDPEDIDOS`
WHERE p.`FECHA_ENTREGA` BETWEEN '2017-01-01' AND '2017-12-31'
AND P.`ESTADO` <> 'ANULADO'
AND p.`IDCLIENTE` = 180
;
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
-- REPORTE DE FACTURAS ANULADAS
-- PEDIDOS ANULADOS
SELECT p.`IDMOVIMIENTO`, p.fecha_entrega, p.`CODIGO`, p.`ESTADO`, m.nrofactura, m.`FECHA_FACTURA`, p.observacion, m.`RAZON_SOCIAL`, m.`ESTADO`, pc.`IDPERSONACLIENTE`, p.`id_tmpenc`
FROM pedidos p
JOIN personacliente pc ON p.idcliente = pc.idpersonacliente
JOIN movimiento m      ON p.idmovimiento = m.idmovimiento
WHERE p.`FECHA_ENTREGA` BETWEEN '2016-06-16' AND '2016-06-16'
-- AND p.`ESTADO` = 'ANULADO'
AND p.`IDMOVIMIENTO` IS NOT NULL
;

SELECT v.`IDMOVIMIENTO`, v.`FECHA_PEDIDO`, v.`CODIGO`, v.`ESTADO`, m.`NROFACTURA`, m.`FECHA_FACTURA`, v.`OBSERVACION`, m.`RAZON_SOCIAL`, v.`IDCLIENTE`
FROM ventadirecta v
JOIN movimiento m ON v.`IDMOVIMIENTO` = m.`IDMOVIMIENTO`
WHERE v.`FECHA_PEDIDO` BETWEEN '2017-03-01' AND '2017-03-31'
AND v.`ESTADO` = 'ANULADO'
AND v.`IDMOVIMIENTO` IS NOT NULL
;

--
-- CONTROL DE PEDIDOS SIN CONTABILIZAR
SELECT p.`IDPEDIDOS`, p.`CODIGO`, p.`FECHA_ENTREGA`, p.`ESTADO`, p.`TIENEFACTURA`, pe.`NOM`, p.`IDMOVIMIENTO`, P.`TOTALIMPORTE`, P.`IMPUESTO`
FROM pedidos p
LEFT JOIN personacliente pe ON p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
WHERE p.`FECHA_ENTREGA` BETWEEN '2019-01-01' AND '2019-07-31'
AND p.`ESTADO` <> 'CONTABILIZADO' 
AND p.`ESTADO` <> 'ANULADO'
;


-- PEDIDOS - DESCUENTOS VETRINARIOS / LACTEOS
SET @folio = (SELECT MAX(idmovimientosalarioproductor)+1 FROM movimientosalarioproductor);
SELECT p.`IDPEDIDOS`, p.`FECHA_ENTREGA`, p.`CODIGO`, p.`ESTADO`, p.`TOTALIMPORTE`, p.`IDCLIENTE`, pe.`NOM`, pe.`AP`, pe.`AM`, pe.`NRO_DOC`, en.`identidad`, en.`noidentificacion`, per.`nombres`, per.`apellidopaterno`, per.`apellidomaterno`, p.`id_tmpenc`
-- INSERT INTO movimientosalarioproductor
-- SELECT (@folio := @folio + 1), p.`FECHA_ENTREGA`, concat('Descuento por venta a credito Nro. ',  p.`CODIGO`) as descri, 'PENDING' AS estado, p.`TOTALIMPORTE` as valor, '1' as idcompania, pr.`idzonaproductiva`, en.`identidad`, '4' AS idtipomovimientoproductor
FROM pedidos p
LEFT JOIN personacliente pe 	ON p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
LEFT JOIN entidad en 		ON pe.`NRO_DOC` = en.`noidentificacion`
LEFT JOIN persona per 		ON en.`identidad` = per.`idpersona`
LEFT JOIN productormateriaprima pr ON per.`idpersona` = pr.`idproductormateriaprima`
WHERE p.`IDUSUARIO` = 404
-- WHERE p.`IDUSUARIO` = 5
AND p.`FECHA_ENTREGA` BETWEEN '2019-03-01' AND '2019-03-15'
AND p.`IDTIPOPEDIDO` = 5
;

SELECT p.`IDPEDIDOS`, p.`FECHA_ENTREGA`, p.`CODIGO`, p.`ESTADO`, p.`TOTALIMPORTE`, p.`IDCLIENTE`, pe.`NOM`, pe.`AP`, pe.`AM`, pe.`NRO_DOC`, en.`identidad`, en.`noidentificacion`, per.`nombres`, per.`apellidopaterno`, per.`apellidomaterno`, p.`id_tmpenc`
-- INSERT INTO movimientosalarioproductor
-- SELECT (@folio := @folio + 1), p.`FECHA_ENTREGA`, concat('Descuento por venta a credito Nro. ',  p.`CODIGO`) as descri, 'PENDING' AS estado, p.`TOTALIMPORTE` as valor, '1' as idcompania, pr.`idzonaproductiva`, en.`identidad`, '4' AS idtipomovimientoproductor
FROM pedidos p
LEFT JOIN personacliente pe 	ON p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
LEFT JOIN entidad en 		ON pe.`NRO_DOC` = en.`noidentificacion`
LEFT JOIN persona per 		ON en.`identidad` = per.`idpersona`
LEFT JOIN productormateriaprima pr ON per.`idpersona` = pr.`idproductormateriaprima`
WHERE p.`IDUSUARIO` = 404
-- WHERE p.`IDUSUARIO` = 5
AND p.`FECHA_ENTREGA` BETWEEN '2019-01-01' AND '2019-01-15'
AND p.`IDTIPOPEDIDO` = 5
;

UPDATE SECUENCIA SET VALOR=(SELECT MAX(E.IDMOVIMIENTOSALARIOPRODUCTOR)+1 FROM MOVIMIENTOSALARIOPRODUCTOR E) WHERE TABLA='MOVIMIENTOSALARIOPRODUCTOR';

SELECT v.`fecha`,  v.`no_trans`, v.`no_vale`, v.`cod_doc`, v.`estado`, v.`cod_alm`, m.`fecha_cre`, m.`fecha_mov`, m.`descri`, d.`fecha`, d.`cod_art`, a.`descri`, d.`costounitario`, d.`cantidad`, v.`idtmpenc`
FROM inv_movdet d 
LEFT JOIN inv_articulos a ON d.`cod_art` = a.`cod_art`
LEFT JOIN inv_mov m ON d.`no_trans` = m.`no_trans`
LEFT JOIN inv_vales v ON m.`no_trans` = v.`no_trans`
WHERE m.`no_usr` = 'SUA'
AND v.`cod_alm` = 2
AND v.`fecha` BETWEEN '2019-01-01' AND '2019-02-28'
AND d.`cod_art` IN (118, 148, 150, 151, 643)
;


