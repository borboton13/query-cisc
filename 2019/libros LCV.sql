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
	, z.idtmpenc, z.id_tmpdet,  d.iddocumentocontable 
FROM documentocontable d 
JOIN documentocompra z ON d.iddocumentocontable = z.iddocumentocompra
WHERE fecha BETWEEN '2021-04-01' AND '2021-04-30'
AND z.estado <> 'NULLIFIED'
AND z.tipo = 'INVOICE'
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
	IDPEDIDOS, IDVENTADIRECTA, idmovimiento, id_tmpdet
FROM movimiento
WHERE FECHA_FACTURA BETWEEN '2021-04-01' AND '2021-04-30'
;

-- -------------

	-- Para anular facturas VENTAS CONTADO
	SELECT v.`IDMOVIMIENTO` ,v.fecha_pedido, v.estado, v.observacion, m.`IDMOVIMIENTO`, m.`NROFACTURA`, m.`ESTADO`, v.`id_tmpenc`, e.`tipo_doc`, e.`estado`
	FROM ventadirecta v
	JOIN movimiento m ON v.`IDMOVIMIENTO` = m.`IDMOVIMIENTO`
	JOIN sf_tmpenc e ON v.`id_tmpenc` = e.`id_tmpenc`
	WHERE v.`FECHA_PEDIDO` BETWEEN '2021-04-01' AND '2021-04-30'
	AND v.`ESTADO` = 'ANULADO'
	AND v.`IDMOVIMIENTO` IS NOT NULL;

	-- Para anular facturas PEDIDOS
	    SELECT p.`IDMOVIMIENTO`, p.`IDPEDIDOS`, p.fecha_entrega, p.`CODIGO`, p.`ESTADO`, m.nrofactura, p.`IMPUESTO`, p.observacion, pc.razonsocial , 
	    m.`ESTADO`, pc.`IDPERSONACLIENTE`, p.`id_tmpenc`, e.`tipo_doc`, e.`no_doc`,  e.`estado`
	-- SELECT p.`IDMOVIMIENTO`
	FROM pedidos p
	LEFT JOIN personacliente pc ON p.idcliente = pc.idpersonacliente
	LEFT JOIN movimiento m      ON p.idmovimiento = m.idmovimiento
	LEFT JOIN sf_tmpenc e 	ON p.`id_tmpenc` = e.`id_tmpenc`
	WHERE p.`FECHA_ENTREGA` BETWEEN  '2021-04-01' AND '2021-04-30'
	AND p.`ESTADO` = 'ANULADO'
	AND p.`IDMOVIMIENTO` IS NOT NULL
	-- AND p.`IDMOVIMIENTO` NOT IN (27416, 27417)
	;

UPDATE movimiento m SET m.`ESTADO` = 'A'
WHERE m.`IDMOVIMIENTO` IN (

);

