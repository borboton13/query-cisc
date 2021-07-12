-- PARA REVISION DE LIBRO COMPRAS
-- ---------------------------
-- From Libro
SELECT 	d.FECHA, d.NIT, d.NOMBRE,d.NUMERO,d.IMPORTE,d.importeneto,d.iva,
	z.idtmpenc, z.iddocumentocompra
FROM documentocontable d 
LEFT JOIN documentocompra z ON d.iddocumentocontable = z.iddocumentocompra
WHERE d.fecha BETWEEN '2021-05-01' AND '2021-05-31'
AND z.estado <> 'NULLIFIED'
AND z.tipo = 'INVOICE'
-- and z.`idtmpenc` is not null
;

-- From contab
SELECT e.`id_tmpenc`, d.`id_tmpdet`,e.`tipo_doc`, e.`no_doc`, d.`debe`, d.`haber`
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
WHERE e.`fecha` BETWEEN '2021-05-01' AND '2021-05-31'
AND d.`cuenta` = '1420710000'
AND e.`estado` <> 'ANL'
AND e.`tipo_doc` NOT IN ('NE')
-- and e.`tipo_doc` not in ('NE', 'IA')
-- and e.`tipo_doc` not in ('IA')
;
-- ---------------------------
-- ---------------------------

-- PARA REVISION DE LIBRO VENTAS
-- ---------------------------
-- REVISION LV contado
SELECT 	m.IDMOVIMIENTO,
	m.FECHA_FACTURA, 
	m.`NROFACTURA`,
	m.ESTADO, 
	m.NIT_CLIENTE, 
	m.RAZON_SOCIAL,
	m.IMPORTE_TOTAL, 
	m.DEBITO_FISCAL, 
	m.IDPEDIDOS, m.IDVENTADIRECTA, 
	v.`id_tmpenc`, 
	m.`id_tmpdet`, d.`id_tmpdet`, d.`debe`, d.`haber`, e.`tipo_doc`, e.`no_doc`, e.`estado`
FROM movimiento m
LEFT JOIN ventadirecta v ON m.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
LEFT JOIN sf_tmpdet d ON v.`id_tmpenc` = d.`id_tmpenc`
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
WHERE m.FECHA_FACTURA BETWEEN '2021-06-01' AND '2021-06-30'
AND m.`IDVENTADIRECTA` IS NOT NULL
AND d.`cuenta` = '2420410200'
AND e.`estado` <> 'ANL'
UNION ALL
-- REVISION LV pedidos
SELECT 	m.IDMOVIMIENTO,
	m.FECHA_FACTURA, 
	m.`NROFACTURA`,
	m.ESTADO, 
	m.NIT_CLIENTE, 
	m.RAZON_SOCIAL,
	m.IMPORTE_TOTAL, 
	m.DEBITO_FISCAL, 
	m.IDPEDIDOS, m.IDVENTADIRECTA, 
	-- v.`id_tmpenc`, 
	p.`id_tmpenc`,
	m.`id_tmpdet`, d.`id_tmpdet`, d.`debe`, d.`haber`, e.`tipo_doc`, e.`no_doc`, e.`estado`
FROM movimiento m
-- left join ventadirecta v on m.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
LEFT JOIN pedidos p ON m.`IDPEDIDOS` = p.`IDPEDIDOS`
LEFT JOIN sf_tmpdet d ON p.`id_tmpenc` = d.`id_tmpenc`
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
WHERE m.FECHA_FACTURA BETWEEN '2021-06-01' AND '2021-06-30'
AND m.`IDPEDIDOS` IS NOT NULL
AND d.`cuenta` = '2420410200'
AND e.`estado` <> 'ANL'
;


-- From contab
SELECT e.`id_tmpenc`, d.`id_tmpdet`, e.`fecha`, e.`tipo_doc`, e.`no_doc`, d.`debe`, d.`haber`, d.`idmovimiento`, e.`fac`, e.`glosa`
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
WHERE e.`fecha` BETWEEN '2021-04-01' AND '2021-04-30'
AND d.`cuenta` = '2420410200'
AND e.`estado` <> 'ANL'
;


-- ------------------------------------------------

-- embol 1444
-- GOBIERNO AUTONOMO DEPARTAMENTAL DE COCHABAMBA 460
-- ypfb 726
-- TOTAL CONTABILIZADO POR CLIENTE
SELECT d.`idpersonacliente`, SUM(d.`debe`)
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
WHERE e.`fecha` BETWEEN '2020-08-01' AND '2020-08-31'
AND d.`idpersonacliente` IN (726)
AND e.`estado` <> 'ANL'
;


-- DEBITO FISCAL, MAYOR Y FACTURAS
-- DETALLE CONTABLE DEBITO FISCAL
SELECT e.`id_tmpenc`, e.`fecha`, e.`glosa`, d.`id_tmpdet`,e.`tipo_doc`, e.`no_doc`, d.`debe`, d.`haber`, d.`idmovimiento`, m.`NROFACTURA`, m.`ESTADO`, m.`DEBITO_FISCAL`
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN movimiento m ON d.`idmovimiento` = m.`IDMOVIMIENTO`
WHERE e.`fecha` BETWEEN '2021-03-01' AND '2021-03-31'
AND d.`cuenta` = '2420410200'
AND e.`estado` <> 'ANL'
-- and e.`tipo_doc` not in ('NE', 'IA')
;

-- VENTAS, CRUCE FACTURAS (MOVIMIENTO) Y ASIENTOS
SELECT m.`IDMOVIMIENTO`, m.`FECHA_FACTURA`, m.`ESTADO`, m.`IMPORTE_TOTAL`, m.`DESCUENTOS`, m.`IMPORTE_PARA_DEBITO_FISCAL`, m.`DEBITO_FISCAL`, m.`IDPEDIDOS`, m.`IDVENTADIRECTA`, d.`debe`, d.`haber`
FROM movimiento m
LEFT JOIN sf_tmpdet d ON m.`IDMOVIMIENTO` = d.`idmovimiento`
WHERE m.`FECHA_FACTURA` BETWEEN '2021-02-01' AND '2021-02-28'
AND m.`ESTADO` <> 'A'
;

-- --------------------



-- Actualizado 12.03.2021
-- Ordenes de Compra con Factura
-- Revision de facturas, fechas, asiento
SELECT e.`id_com_encoc`, e.`fecha_recepcion`, e.`glosa`, e.`no_orden`, e.`estado`, e.`total`, dc.`iddocumentocompra`, d.`iddocumentocontable` , d.`fecha`, dc.`estado`, d.`numero`, d.`nombre`, d.`iva`, dc.`idtmpenc`,
s.`fecha`, s.`tipo_doc`, s.`no_doc`, s.`estado`
FROM com_encoc e 
LEFT JOIN documentocompra dc ON e.`id_com_encoc` = dc.`idordencompra`
LEFT JOIN documentocontable d ON dc.`iddocumentocompra` = d.`iddocumentocontable`
LEFT JOIN sf_tmpenc s ON dc.`idtmpenc` = s.`id_tmpenc`
WHERE e.`fecha_recepcion` BETWEEN '2021-02-01' AND '2021-02-28'
AND e.`confactura` = 'CONFACTURA'
;

-- ---------------------------------------------------------------
-- 11.05.2021
SELECT *
FROM pedidos p
WHERE p.`FECHA_ENTREGA` BETWEEN '2021-04-01' AND '2021-04-30'
AND p.`IDUSUARIO` IN (5, 408)
AND p.`id_tmpenc` IS NULL
;


-- Pedidos con asiento contable
SELECT p.`IDPEDIDOS`, p.`FECHA_ENTREGA`, p.`CODIGO`, p.`ESTADO`, p.`IDTIPOPEDIDO`, p.`idtipoventa`, p.`TOTALIMPORTE`, p.`IMPUESTO`, p.`id_tmpenc`, p.`IDMOVIMIENTO`
FROM pedidos p
WHERE p.`FECHA_ENTREGA` BETWEEN '2021-05-01' AND '2021-05-31'
AND p.`id_tmpenc` IS NOT NULL
AND p.`ESTADO` <> 'ANULADO'
;

-- Para revisar pedidos contabilizados
SELECT p.`IDPEDIDOS`, p.`FECHA_ENTREGA`, p.`CODIGO`, p.`ESTADO`, p.`IDTIPOPEDIDO`, p.`idtipoventa`, p.`TOTALIMPORTE`, p.`IMPUESTO`, p.`id_tmpenc`, p.`IDMOVIMIENTO`, pe.`NOM`, pe.`AP`
FROM pedidos p
LEFT JOIN personacliente pe ON p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
WHERE p.`FECHA_ENTREGA` BETWEEN '2021-06-01' AND '2021-06-30'
AND p.`ESTADO` <> 'ANULADO'
AND p.`id_tmpenc` IS NULL
AND p.`IDTIPOPEDIDO` IN (5, 6)
;

-- Pedidos con asiento contable y sin factura
-- Para Verificar si los asientos tienen cedito fiscal
SELECT p.`IDPEDIDOS`, p.`FECHA_ENTREGA`, p.`CODIGO`, p.`ESTADO`, p.`IDTIPOPEDIDO`, p.`idtipoventa`, p.`TOTALIMPORTE`, p.`IMPUESTO`, p.`id_tmpenc`, e.`tipo_doc`, e.`no_doc`, e.`estado`, p.`IDMOVIMIENTO`, 
p.`IDUSUARIO`, p.`IDCLIENTE`, pc.`NOM`, pc.`AP`, PC.`RAZONSOCIAL`
FROM pedidos p
LEFT JOIN personacliente pc ON p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
LEFT JOIN sf_tmpenc e ON p.`id_tmpenc` = e.`id_tmpenc`
WHERE p.`FECHA_ENTREGA` BETWEEN '2021-05-01' AND '2021-05-31'
AND p.`id_tmpenc` IS NOT NULL
AND p.`IDMOVIMIENTO` IS NULL
AND p.`ESTADO` <> 'ANULADO'
;

-- ---------------------------------------------------------------



