-- -------------
-- -- COMPRAS --
-- -------------
select 	d.FECHA as "FECHA FACTURA O DUI", 
	d.NIT as "NIT PROVEEDOR", 
	d.NOMBRE as "RAZON SOCIAL",
	d.NUMERO as "NUMERO FACTURA",
	"" as "NRO DUI",
	d.numeroautorizacion as "NRO DE AUTORIZACION",
	d.IMPORTE as "IMPORTE TOTAL DE LA COMPRA",
	d.exento as "IMPORTE NO SUJETO A CREDITO FISCAL",
	d.importe - d.exento as "SUBTOTAL",
	"" as "DESCUENTOS",
	d.importeneto as "IMPORTE BASE CREDITO FISCAL",
	d.iva as "CREDITO FISCAL",
	IFNULL(d.CODIGOCONTROL, 0) as CODIGOCONTROL,
	"" as "TIPO DE COMPRA", z.estado
	, z.idtmpenc
from documentocontable d 
join documentocompra z on d.iddocumentocontable = z.iddocumentocompra
where fecha between '2019-05-01' and '2019-05-31'
and z.estado <> 'NULLIFIED'
and z.tipo = 'INVOICE'
;

select 	d.FECHA as "FECHA FACTURA O DUI", 
	d.NIT as "NIT PROVEEDOR", 
	d.NOMBRE as "RAZON SOCIAL",
	d.NUMERO as "NUMERO FACTURA",
	"" as "NRO DUI",
	d.numeroautorizacion as "NRO DE AUTORIZACION",
	d.IMPORTE as "IMPORTE TOTAL DE LA COMPRA",
	d.exento as "IMPORTE NO SUJETO A CREDITO FISCAL",
	d.importe - d.exento as "SUBTOTAL",
	"" as "DESCUENTOS",
	d.importeneto as "IMPORTE BASE CREDITO FISCAL",
	d.iva as "CREDITO FISCAL",
	IFNULL(d.CODIGOCONTROL, 0) as CODIGOCONTROL,
	"" as "TIPO DE COMPRA", z.estado,
	z.idtmpenc, e.tipo_doc, e.no_doc, e.fecha, e.estado
from documentocontable d 
left join documentocompra z on d.iddocumentocontable = z.iddocumentocompra
left join sf_tmpenc e on z.idtmpenc = e.id_tmpenc
where d.fecha between '2019-04-01' and '2019-04-30'
and z.estado <> 'NULLIFIED'
;


-- UPDATE documentocompra d SET d.`estado` = 'NULLIFIED'
where d.`iddocumentocompra` in (

);



-- REV FACT COMPRAS NO APROBADAS -- FALTA APROBAR FACT AGO/2018
select 
  d.FECHA as "FECHA FACTURA O DUI",
  d.NIT as "NIT PROVEEDOR",
  d.NOMBRE as "RAZON SOCIAL",
  d.NUMERO as "NUMERO FACTURA",
  "" as "NRO DUI",
  d.numeroautorizacion as "NRO DE AUTORIZACION",
  d.IMPORTE as "IMPORTE TOTAL DE LA COMPRA",
  d.exento as "IMPORTE NO SUJETO A CREDITO FISCAL",
  d.importe - d.exento as "SUBTOTAL",
  "" as "DESCUENTOS",
  d.importeneto as "IMPORTE BASE CREDITO FISCAL",
  d.iva as "CREDITO FISCAL",
  IFNULL(d.CODIGOCONTROL, 0) as CODIGOCONTROL,
  "" as "TIPO DE COMPRA"
  , dc.estado, dc.idtmpenc, e.tipo_doc, e.no_doc
from documentocontable d 
left join documentocompra dc on d.iddocumentocontable = dc.iddocumentocompra 
left join sf_tmpenc e        on dc.idtmpenc = e.id_tmpenc
where d.fecha between '2018-11-01' and '2018-11-30'
;

-- -------------
-- -- VENTAS ---
-- -------------
select 	IDMOVIMIENTO,
	"" as "N.",
	FECHA_FACTURA as "FECHA FACTURA", 
	NROFACTURA as "N. FACTURA", 
	NRO_AUTORIZACION as "N. AUTORIZACION", 
	ESTADO, 
	IF(ESTADO = 'A', 0, NIT_CLIENTE) as NIT_CLIENTE, 
	IF(ESTADO = 'A', 'ANULADO', RAZON_SOCIAL) as "RAZON SOCIAL", 
	IF(ESTADO = 'A', 0.00, IMPORTE_TOTAL) as "IMPORTE TOTAL DE VENTA", 
	IF(ESTADO = 'A', 0.00, IMPORTE_ICE_IEHD_TASAS) as "IMPORTE ICE/IEHD/TASAS", 
	IF(ESTADO = 'A', 0.00, EXPORT_EXENTAS) as "EXPORTACIONES Y OPERACIONES EXENTAS", 
	IF(ESTADO = 'A', 0.00, VENTAS_GRAB_TASACERO) as "VENTAS GRAB TASA CERO", 
	IF(ESTADO = 'A', 0.00, SUBTOTAL) as SUBTOTAL, 
	IF(ESTADO = 'A', 0.00, DESCUENTOS) as "DESCUENTOS, BONIFICACIONES Y REBAJAS OTORGADAS", 
	IF(ESTADO = 'A', 0.00, IMPORTE_PARA_DEBITO_FISCAL) as "IMPORTE PARA DEBITO FISCAL", 
	IF(ESTADO = 'A', 0.00, DEBITO_FISCAL) as "DEBITO FISCAL", 
	IF(ESTADO = 'A', 0, CODIGOCONTROL) as "CODIGO DE CONTROL",
	IDPEDIDOS, IDVENTADIRECTA, idmovimiento
from movimiento
where FECHA_FACTURA between '2019-05-01' and '2019-05-31'
;

-- -------------

	-- Para anular facturas VENTAS CONTADO
	select v.`IDMOVIMIENTO` ,v.fecha_pedido, v.estado, v.observacion, m.`IDMOVIMIENTO`, m.`ESTADO`
	from ventadirecta v
	join movimiento m on v.`IDMOVIMIENTO` = m.`IDMOVIMIENTO`
	where v.`FECHA_PEDIDO` between '2019-05-01' and '2019-05-31'
	and v.`ESTADO` = 'ANULADO'
	and v.`IDMOVIMIENTO` is not null;

	-- Para anular facturas PEDIDOS
	    select p.`IDPEDIDOS`, p.`IDMOVIMIENTO`, p.fecha_entrega, p.`CODIGO`, p.`ESTADO`, m.nrofactura, p.`IMPUESTO`, p.observacion, pc.razonsocial , m.`ESTADO`, pc.`IDPERSONACLIENTE`, p.`id_tmpenc`
	-- SELECT p.`IDMOVIMIENTO`
	from pedidos p
	   join personacliente pc on p.idcliente = pc.idpersonacliente
	   join movimiento m      on p.idmovimiento = m.idmovimiento
	where p.`FECHA_ENTREGA` between  '2019-05-01' and '2019-05-31'
	and p.`ESTADO` = 'ANULADO'
	and p.`IDMOVIMIENTO` is not null
	-- AND p.`IDMOVIMIENTO` NOT IN (27416, 27417)
	;

update movimiento M set M.ESTADO = 'A' where M.`IDMOVIMIENTO` in (

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
