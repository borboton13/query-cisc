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
WHERE fecha BETWEEN '2018-08-01' AND '2018-08-31'
AND z.estado <> 'NULLIFIED'
;

SELECT * 
FROM cxp_lcompras c WHERE c.`fecha` BETWEEN '2018-07-01' AND '2018-07-31';

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
WHERE d.fecha BETWEEN '2018-08-01' AND '2018-08-31'
;

-- -------------
-- -- VENTAS ---
-- No Anular Dic: 168, 169, 113, 86* (YPFB)
--    Anular Dic: 86(ok), 
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
	IDPEDIDOS, IDVENTADIRECTA
FROM movimiento
WHERE FECHA_FACTURA BETWEEN '2018-09-01' AND '2018-09-30'
;

-- -------------

	-- Para anular facturas VENTAS CONTADO
	SELECT v.`IDMOVIMIENTO` ,v.fecha_pedido, v.estado, v.observacion
	FROM ventadirecta v
	WHERE v.`FECHA_PEDIDO` BETWEEN '2018-09-01' AND '2018-09-30'
	AND v.`ESTADO` = 'ANULADO'
	AND v.`IDMOVIMIENTO` IS NOT NULL;

	
	-- Para anular facturas PEDIDOS
	    SELECT p.`IDMOVIMIENTO`, p.fecha_entrega, p.`CODIGO`, p.`ESTADO`, m.nrofactura, p.observacion, pc.razonsocial , m.`ESTADO`, pc.`IDPERSONACLIENTE`
	-- SELECT p.`IDMOVIMIENTO`
	FROM pedidos p
	   JOIN personacliente pc ON p.idcliente = pc.idpersonacliente
	   JOIN movimiento m      ON p.idmovimiento = m.idmovimiento
	WHERE p.`FECHA_ENTREGA` BETWEEN '2018-09-01' AND '2018-09-30'
	AND p.`ESTADO` = 'ANULADO'
	AND p.`IDMOVIMIENTO` IS NOT NULL
	-- AND p.`IDMOVIMIENTO` NOT IN (27416, 27417)
	;

UPDATE movimiento M SET M.ESTADO = 'A' WHERE M.`IDMOVIMIENTO` IN (

);

-- CRUCE COMPRAS CON ASIENTOS
-- ---------------------------
-- cruzar ambas consultas en excel (id_tmpenc)
SELECT DISTINCT co.*, dc.`idtmpenc`, e.`id_tmpenc`, e.`fecha`, /*d.`cuenta`, d.`debe`, d.`haber`,*/ e.`tipo_doc`, e.`no_doc`
FROM documentocontable co
JOIN documentocompra dc 	ON co.`iddocumentocontable` = dc.`iddocumentocompra`
JOIN sf_tmpenc e  		ON dc.`idtmpenc` = e.`id_tmpenc`
-- join sf_tmpdet d 		on e.`id_tmpenc` = d.`id_tmpenc`
WHERE co.`fecha` BETWEEN '2018-08-01' AND '2018-08-31'
-- and d.`cuenta` = '1420710000'
;

SELECT e.`id_tmpenc`, e.`estado`, e.`tipo_doc`, e.`no_doc`, e.`fecha`, d.`debe`
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
WHERE e.`fecha` BETWEEN '2018-08-01' AND '2018-08-31' 
AND d.`cuenta` = '1420710000'
AND d.`debe` > 0
;
-- ---------------------------
SELECT m.`FECHA_FACTURA`, m.`ESTADO`, m.`IMPORTE_TOTAL`, m.`DESCUENTOS`, m.`IMPORTE_PARA_DEBITO_FISCAL`, m.`DEBITO_FISCAL`, m.`IDVENTADIRECTA`, m.`IDPEDIDOS`
FROM movimiento m
WHERE m.`FECHA_FACTURA` BETWEEN '2018-07-01' AND '2018-07-31'
AND m.`IDPEDIDOS` IS NOT NULL
;

SELECT p.`FECHA_ENTREGA`, p.`IDTIPOPEDIDO`, p.`CODIGO`, p.`TOTALIMPORTE`, p.`IMPUESTO`, p.`ESTADO`, p.`IDMOVIMIENTO`, p.`id_tmpenc`, e.`tipo_doc`, e.`no_doc`, e.`estado`, e.`fecha`
FROM pedidos p
LEFT JOIN sf_tmpenc e ON p.`id_tmpenc` = e.`id_tmpenc`
WHERE p.`FECHA_ENTREGA` BETWEEN '2018-07-01' AND '2018-07-31'
-- and p.`ESTADO` <> 'ANULADO'
AND p.`IDMOVIMIENTO` IS NOT NULL
;

SELECT v.`FECHA_PEDIDO`, v.`CODIGO`, v.`TOTALIMPORTE`, v.`IMPUESTO`, v.`ESTADO`, e.`tipo_doc`, e.`no_doc`, e.`estado`, e.`fecha`
FROM ventadirecta v
LEFT JOIN sf_tmpenc e ON v.`id_tmpenc` = e.`id_tmpenc`
WHERE v.`FECHA_PEDIDO` BETWEEN '2018-07-01' AND '2018-07-31'
;

