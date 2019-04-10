-- -------------
-- -- COMPRAS --
-- -------------
SELECT 	d.FECHA AS "FECHA FACTURA O DUI", 
	d.NIT AS "NIT PROVEEDOR", 
	d.NOMBRE AS "RAZON SOCIAL",
	d.NUMERO AS "NUMERO FACTURA",
	"" AS "NRO DUI",
	d.numeroautorizacion AS "NRO DE AUTORIZACION",
	d.IMPORTE AS "IMPORTE TOTAL DE LA COMPRA",
	d.exento AS "IMPORTE NO SUJETO A CREDITO FISCAL",
	d.importe - d.exento AS "SUBTOTAL",
	"" AS "DESCUENTOS",
	d.importeneto AS "IMPORTE BASE CREDITO FISCAL",
	d.iva AS "CREDITO FISCAL",
	IFNULL(d.CODIGOCONTROL, 0) AS CODIGOCONTROL,
	"" AS "TIPO DE COMPRA", z.estado
FROM documentocontable d 
JOIN documentocompra z ON d.iddocumentocontable = z.iddocumentocompra
WHERE fecha BETWEEN '2019-03-01' AND '2019-03-31'
AND z.estado <> 'NULLIFIED'
;

SELECT 	d.FECHA AS "FECHA FACTURA O DUI", 
	d.NIT AS "NIT PROVEEDOR", 
	d.NOMBRE AS "RAZON SOCIAL",
	d.NUMERO AS "NUMERO FACTURA",
	"" AS "NRO DUI",
	d.numeroautorizacion AS "NRO DE AUTORIZACION",
	d.IMPORTE AS "IMPORTE TOTAL DE LA COMPRA",
	d.exento AS "IMPORTE NO SUJETO A CREDITO FISCAL",
	d.importe - d.exento AS "SUBTOTAL",
	"" AS "DESCUENTOS",
	d.importeneto AS "IMPORTE BASE CREDITO FISCAL",
	d.iva AS "CREDITO FISCAL",
	IFNULL(d.CODIGOCONTROL, 0) AS CODIGOCONTROL,
	"" AS "TIPO DE COMPRA", z.estado,
	z.idtmpenc, e.tipo_doc, e.no_doc, e.fecha, e.estado
FROM documentocontable d 
LEFT JOIN documentocompra z ON d.iddocumentocontable = z.iddocumentocompra
LEFT JOIN sf_tmpenc e ON z.idtmpenc = e.id_tmpenc
WHERE d.fecha BETWEEN '2019-01-01' AND '2019-01-31'
AND z.estado <> 'NULLIFIED'
;


-- UPDATE documentocompra d SET d.`estado` = 'NULLIFIED'
WHERE d.`iddocumentocompra` IN (

);



-- REV FACT COMPRAS NO APROBADAS -- FALTA APROBAR FACT AGO/2018
SELECT 
  d.FECHA AS "FECHA FACTURA O DUI",
  d.NIT AS "NIT PROVEEDOR",
  d.NOMBRE AS "RAZON SOCIAL",
  d.NUMERO AS "NUMERO FACTURA",
  "" AS "NRO DUI",
  d.numeroautorizacion AS "NRO DE AUTORIZACION",
  d.IMPORTE AS "IMPORTE TOTAL DE LA COMPRA",
  d.exento AS "IMPORTE NO SUJETO A CREDITO FISCAL",
  d.importe - d.exento AS "SUBTOTAL",
  "" AS "DESCUENTOS",
  d.importeneto AS "IMPORTE BASE CREDITO FISCAL",
  d.iva AS "CREDITO FISCAL",
  IFNULL(d.CODIGOCONTROL, 0) AS CODIGOCONTROL,
  "" AS "TIPO DE COMPRA"
  , dc.estado, dc.idtmpenc, e.tipo_doc, e.no_doc
FROM documentocontable d 
LEFT JOIN documentocompra dc ON d.iddocumentocontable = dc.iddocumentocompra 
LEFT JOIN sf_tmpenc e        ON dc.idtmpenc = e.id_tmpenc
WHERE d.fecha BETWEEN '2018-11-01' AND '2018-11-30'
;

-- -------------
-- -- VENTAS ---
-- -------------
SELECT 	IDMOVIMIENTO,
	"" AS "N.",
	FECHA_FACTURA AS "FECHA FACTURA", 
	NROFACTURA AS "N. FACTURA", 
	NRO_AUTORIZACION AS "N. AUTORIZACION", 
	ESTADO, 
	IF(ESTADO = 'A', 0, NIT_CLIENTE) AS NIT_CLIENTE, 
	IF(ESTADO = 'A', 'ANULADO', RAZON_SOCIAL) AS "RAZON SOCIAL", 
	IF(ESTADO = 'A', 0.00, IMPORTE_TOTAL) AS "IMPORTE TOTAL DE VENTA", 
	IF(ESTADO = 'A', 0.00, IMPORTE_ICE_IEHD_TASAS) AS "IMPORTE ICE/IEHD/TASAS", 
	IF(ESTADO = 'A', 0.00, EXPORT_EXENTAS) AS "EXPORTACIONES Y OPERACIONES EXENTAS", 
	IF(ESTADO = 'A', 0.00, VENTAS_GRAB_TASACERO) AS "VENTAS GRAB TASA CERO", 
	IF(ESTADO = 'A', 0.00, SUBTOTAL) AS SUBTOTAL, 
	IF(ESTADO = 'A', 0.00, DESCUENTOS) AS "DESCUENTOS, BONIFICACIONES Y REBAJAS OTORGADAS", 
	IF(ESTADO = 'A', 0.00, IMPORTE_PARA_DEBITO_FISCAL) AS "IMPORTE PARA DEBITO FISCAL", 
	IF(ESTADO = 'A', 0.00, DEBITO_FISCAL) AS "DEBITO FISCAL", 
	IF(ESTADO = 'A', 0, CODIGOCONTROL) AS "CODIGO DE CONTROL",
	IDPEDIDOS, IDVENTADIRECTA, idmovimiento
FROM movimiento
WHERE FECHA_FACTURA BETWEEN '2019-03-01' AND '2019-03-31'
;

-- -------------

	-- Para anular facturas VENTAS CONTADO
	SELECT v.`IDMOVIMIENTO` ,v.fecha_pedido, v.estado, v.observacion, m.`IDMOVIMIENTO`, m.`ESTADO`
	FROM ventadirecta v
	JOIN movimiento m ON v.`IDMOVIMIENTO` = m.`IDMOVIMIENTO`
	WHERE v.`FECHA_PEDIDO` BETWEEN '2019-03-01' AND '2019-03-31'
	AND v.`ESTADO` = 'ANULADO'
	AND v.`IDMOVIMIENTO` IS NOT NULL;

	-- Para anular facturas PEDIDOS
	    SELECT p.`IDPEDIDOS`, p.`IDMOVIMIENTO`, p.fecha_entrega, p.`CODIGO`, p.`ESTADO`, m.nrofactura, p.`IMPUESTO`, p.observacion, pc.razonsocial , m.`ESTADO`, pc.`IDPERSONACLIENTE`, p.`id_tmpenc`
	-- SELECT p.`IDMOVIMIENTO`
	FROM pedidos p
	   JOIN personacliente pc ON p.idcliente = pc.idpersonacliente
	   JOIN movimiento m      ON p.idmovimiento = m.idmovimiento
	WHERE p.`FECHA_ENTREGA` BETWEEN '2019-03-01' AND '2019-03-31'
	AND p.`ESTADO` = 'ANULADO'
	AND p.`IDMOVIMIENTO` IS NOT NULL
	-- AND p.`IDMOVIMIENTO` NOT IN (27416, 27417)
	;

UPDATE movimiento M SET M.ESTADO = 'A' WHERE M.`IDMOVIMIENTO` IN (
);

UPDATE pedidos p SET p.`ESTADO` = 'PREPARAR' WHERE p.`IDPEDIDOS` IN (29033, 29040);

SELECT *
FROM pedidos p WHERE p.`IDPEDIDOS` IN (29033, 29040)
;


-- CRUCE COMPRAS CON ASIENTOS
-- ---------------------------
-- cruzar ambas consultas en excel (id_tmpenc)
SELECT DISTINCT co.*, dc.`idtmpenc`, e.`id_tmpenc`, e.`fecha`, /*d.`cuenta`, d.`debe`, d.`haber`,*/ e.`tipo_doc`, e.`no_doc`
FROM documentocontable co
JOIN documentocompra dc 	ON co.`iddocumentocontable` = dc.`iddocumentocompra`
JOIN sf_tmpenc e  		ON dc.`idtmpenc` = e.`id_tmpenc`
-- join sf_tmpdet d 		on e.`id_tmpenc` = d.`id_tmpenc`
WHERE co.`fecha` BETWEEN '2019-02-01' AND '2019-02-28'
-- and d.`cuenta` = '1420710000'
;
-- 
SELECT e.`id_tmpenc`, d.`id_tmpdet`, e.`estado`, e.`tipo_doc`, e.`no_doc`, e.`fecha`, d.`debe`, e.`glosa`
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
WHERE e.`fecha` BETWEEN '2019-02-01' AND '2019-02-28'
AND d.`cuenta` = '1420710000'
AND d.`debe` > 0
AND e.`estado` <> 'ANL'
 -- AND e.`tipo_doc` NOT IN ('NE')
;
-- ---------------------------

SELECT e.`id_tmpenc`, d.`id_tmpdet`, e.`estado`, e.`tipo_doc`, e.`no_doc`, e.`fecha`, d.`debe`, e.`glosa`
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
WHERE e.`fecha` BETWEEN '2019-01-01' AND '2019-01-31'
AND d.`cuenta` = '2420410200'AND d.haber > 0
;

SELECT * FROM pedidos p
WHERE p.`id_tmpenc` = 102522;

SELECT * FROM movimiento m WHERE m.`IDMOVIMIENTO` = 48641;

SELECT e.`id_tmpenc`, d.`id_tmpdet`, e.`estado`, e.`tipo_doc`, e.`no_doc`, e.`fecha`, d.`debe`, d.`haber`, e.`glosa`, ve.idventadirecta, ve.estado, ve.idmovimiento, pe.idpedidos, pe.estado, pe.idmovimiento
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN (
	SELECT v.`IDVENTADIRECTA`, v.`FECHA_PEDIDO`, v.`ESTADO`, v.`CODIGO`, v.`IDMOVIMIENTO`, v.`id_tmpenc`
	FROM ventadirecta v
	WHERE v.`FECHA_PEDIDO` BETWEEN '2019-01-01' AND '2019-01-31'
) ve ON e.`id_tmpenc` = ve.id_tmpenc
LEFT JOIN (
	SELECT p.`IDPEDIDOS`, p.`FECHA_ENTREGA`, p.`ESTADO`, p.`CODIGO`, p.`IDMOVIMIENTO`, p.`id_tmpenc`
	FROM pedidos p
	WHERE p.`FECHA_ENTREGA` BETWEEN '2019-01-01' AND '2019-01-31'
) pe ON e.`id_tmpenc` = pe.id_tmpenc
WHERE e.`fecha` BETWEEN '2019-01-01' AND '2019-01-31'
AND d.`cuenta` = '2420410200'AND d.haber > 0
;


SELECT v.`IDVENTADIRECTA`, v.`FECHA_PEDIDO`, v.`ESTADO`, v.`CODIGO`, v.`IDMOVIMIENTO`, v.`id_tmpenc`
FROM ventadirecta v
WHERE v.`FECHA_PEDIDO` BETWEEN '2019-01-01' AND '2019-01-31'
;

SELECT p.`IDPEDIDOS`, p.`FECHA_ENTREGA`, p.`ESTADO`, p.`CODIGO`, p.`IDMOVIMIENTO`, p.`id_tmpenc`, p.`IDUSUARIO`, pe.`NOM`, p.`IDTIPOPEDIDO`
FROM pedidos p
JOIN personacliente pe ON p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
WHERE p.`FECHA_ENTREGA` BETWEEN '2019-01-01' AND '2019-01-31'
;
