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
	ifnull(d.CODIGOCONTROL, 0) as CODIGOCONTROL,
	"" as "TIPO DE COMPRA", z.estado
	, z.idtmpenc, z.id_tmpdet,  d.iddocumentocontable 
from documentocontable d 
join documentocompra z on d.iddocumentocontable = z.iddocumentocompra
where fecha between '2020-12-01' and '2020-12-31'
and z.estado <> 'NULLIFIED'
and z.tipo = 'INVOICE'
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
	if(ESTADO = 'A', 0, NIT_CLIENTE) as NIT_CLIENTE, 
	if(ESTADO = 'A', 'ANULADO', RAZON_SOCIAL) as "RAZON SOCIAL", 
	if(ESTADO = 'A', 0.00, IMPORTE_TOTAL) as "IMPORTE TOTAL DE VENTA", 
	if(ESTADO = 'A', 0.00, IMPORTE_ICE_IEHD_TASAS) as "IMPORTE ICE/IEHD/TASAS", 
	if(ESTADO = 'A', 0.00, EXPORT_EXENTAS) as "EXPORTACIONES Y OPERACIONES EXENTAS", 
	if(ESTADO = 'A', 0.00, VENTAS_GRAB_TASACERO) as "VENTAS GRAB TASA CERO", 
	if(ESTADO = 'A', 0.00, SUBTOTAL) as SUBTOTAL, 
	if(ESTADO = 'A', 0.00, DESCUENTOS) as "DESCUENTOS, BONIFICACIONES Y REBAJAS OTORGADAS", 
	if(ESTADO = 'A', 0.00, IMPORTE_PARA_DEBITO_FISCAL) as "IMPORTE PARA DEBITO FISCAL", 
	if(ESTADO = 'A', 0.00, DEBITO_FISCAL) as "DEBITO FISCAL", 
	if(ESTADO = 'A', 0, CODIGOCONTROL) as "CODIGO DE CONTROL",
	IDPEDIDOS, IDVENTADIRECTA, idmovimiento, id_tmpdet
from movimiento
where FECHA_FACTURA between '2020-12-01' and '2020-12-31'
;

-- -------------

	-- Para anular facturas VENTAS CONTADO
	select v.`IDMOVIMIENTO` ,v.fecha_pedido, v.estado, v.observacion, m.`IDMOVIMIENTO`, m.`NROFACTURA`, m.`ESTADO`, v.`id_tmpenc`, e.`tipo_doc`, e.`estado`
	from ventadirecta v
	join movimiento m on v.`IDMOVIMIENTO` = m.`IDMOVIMIENTO`
	join sf_tmpenc e on v.`id_tmpenc` = e.`id_tmpenc`
	where v.`FECHA_PEDIDO` between '2020-12-01' and '2020-12-31'
	and v.`ESTADO` = 'ANULADO'
	and v.`IDMOVIMIENTO` is not null;

	-- Para anular facturas PEDIDOS
	    select p.`IDMOVIMIENTO`, p.`IDPEDIDOS`, p.fecha_entrega, p.`CODIGO`, p.`ESTADO`, m.nrofactura, p.`IMPUESTO`, p.observacion, pc.razonsocial , 
	    m.`ESTADO`, pc.`IDPERSONACLIENTE`, p.`id_tmpenc`, e.`tipo_doc`, e.`no_doc`,  e.`estado`
	-- SELECT p.`IDMOVIMIENTO`
	from pedidos p
	left join personacliente pc on p.idcliente = pc.idpersonacliente
	left join movimiento m      on p.idmovimiento = m.idmovimiento
	left join sf_tmpenc e 	on p.`id_tmpenc` = e.`id_tmpenc`
	where p.`FECHA_ENTREGA` between  '2020-12-01' and '2020-12-31'
	and p.`ESTADO` = 'ANULADO'
	and p.`IDMOVIMIENTO` is not null
	-- AND p.`IDMOVIMIENTO` NOT IN (27416, 27417)
	;

update movimiento m set m.`ESTADO` = 'A'
where m.`IDMOVIMIENTO` in (

);




/** 1.- PARA REVISION LIBRO DE VENTAS **/
select e.`id_tmpenc`, d.`id_tmpdet`, e.`estado`, e.`tipo_doc`, e.`no_doc`, e.`fecha`, d.`debe`, d.`haber`, e.`glosa`, ve.idventadirecta, ve.estado, ve.idmovimiento, pe.idpedidos, pe.estado, pe.idmovimiento
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
left join (
	select v.`IDVENTADIRECTA`, v.`FECHA_PEDIDO`, v.`ESTADO`, v.`CODIGO`, v.`IDMOVIMIENTO`, v.`id_tmpenc`
	from ventadirecta v
	where v.`FECHA_PEDIDO` between '2020-01-01' and '2020-01-31' and v.`ESTADO` <> 'ANULADO'
) ve on e.`id_tmpenc` = ve.id_tmpenc
left join (
	select p.`IDPEDIDOS`, p.`FECHA_ENTREGA`, p.`ESTADO`, p.`CODIGO`, p.`IDMOVIMIENTO`, p.`id_tmpenc`
	from pedidos p
	where p.`FECHA_ENTREGA` between '2020-01-01' and '2020-01-31' and p.estado <> 'ANULADO'
) pe on e.`id_tmpenc` = pe.id_tmpenc
where e.`fecha` between '2020-01-01' and '2020-01-31'
and d.`cuenta` = '2420410200'and d.haber > 0
and e.`estado` <> 'ANL'
;

/** PARA REVISAR FECHA DE FACTURAS EN ASIENTOS CONTABLES **/
select d.`iddocumentocompra`, dc.`fecha`, dc.`importe`, dc.`iva`, e.`id_tmpenc`, e.`fecha`, e.`estado`
from documentocompra d
join documentocontable dc on d.`iddocumentocompra` = dc.`iddocumentocontable`
join sf_tmpenc e on d.`idtmpenc` = e.`id_tmpenc`
where e.`fecha` between '2019-12-01' and '2019-12-31'
;



-- 11/07/2019 ASIENTOS DEBITO FISCAL
select e.`id_tmpenc`, e.`fecha`, e.`tipo_doc`, e.`no_doc`, e.`estado`, d.`debe`, d.`haber`, e.`glosa`, e.`IDPERSONACLIENTE`
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
where e.`fecha` between '2019-10-01' and '2019-10-31'
and d.`cuenta` = 2420410200
and e.`estado` <> 'ANL'
;


-- Facturas Pedidos - Asientos
select m.`IDMOVIMIENTO`, m.`FECHA_FACTURA`, m.`ESTADO`, m.`IMPORTE_TOTAL`, m.`IMPORTE_PARA_DEBITO_FISCAL`, m.`DEBITO_FISCAL`, p.`IDPEDIDOS`, p.`id_tmpenc`, m.`RAZON_SOCIAL`, P.`ESTADO`
from movimiento m
left join pedidos p on m.`IDPEDIDOS` = p.`IDPEDIDOS`
where m.`FECHA_FACTURA` between '2019-12-01' and '2019-12-31'
and m.`ESTADO` <> 'A'
-- and m.`ESTADO` = 'A'
;
-- Facturas Contado - Asientos
select m.`IDMOVIMIENTO`, m.`FECHA_FACTURA`, m.`ESTADO`, m.`IMPORTE_TOTAL`, m.`IMPORTE_PARA_DEBITO_FISCAL`, m.`DEBITO_FISCAL`, m.`IDVENTADIRECTA`, v.`id_tmpenc`, m.`RAZON_SOCIAL`
from movimiento m
left join ventadirecta v on m.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
where m.`FECHA_FACTURA` between '2019-12-01' and '2019-12-31'
and m.`ESTADO` <> 'A'
;

-- COMPRAS, IDENTIFICAR FACTURAS ASIENTO
select dc.*, e.`fecha`, e.`tipo_doc`, e.`no_doc`, e.`estado`, e.`glosa`
from documentocompra d
join documentocontable dc on d.`iddocumentocompra` = dc.`iddocumentocontable`
join sf_tmpenc e on d.`idtmpenc` = e.`id_tmpenc`
-- and dc.`numero` = 10233
;


select e.`id_com_encoc`, e.`fecha_recepcion`, e.`glosa`, e.`no_orden`, e.`total`, dc.`iddocumentocompra`, d.`iddocumentocontable` , d.`fecha`, d.`numero`, d.`nombre`, d.`iva`, dc.`idtmpenc`
from com_encoc e 
left join documentocompra dc on e.`id_com_encoc` = dc.`idordencompra`
left join documentocontable d on dc.`iddocumentocompra` = d.`iddocumentocontable`
where e.`fecha_recepcion` between '2019-08-01' and '2019-08-31'
and e.`confactura` = 'CONFACTURA'
;

