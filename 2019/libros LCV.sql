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
	, z.idtmpenc,  d.iddocumentocontable 
from documentocontable d 
join documentocompra z on d.iddocumentocontable = z.iddocumentocompra
where fecha between '2019-08-01' and '2019-08-31'
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
where FECHA_FACTURA between '2019-10-01' and '2019-10-30'
;

-- -------------

	-- Para anular facturas VENTAS CONTADO
	select v.`IDMOVIMIENTO` ,v.fecha_pedido, v.estado, v.observacion, m.`IDMOVIMIENTO`, m.`ESTADO`
	from ventadirecta v
	join movimiento m on v.`IDMOVIMIENTO` = m.`IDMOVIMIENTO`
	where v.`FECHA_PEDIDO` between '2019-10-01' and '2019-10-30'
	and v.`ESTADO` = 'ANULADO'
	and v.`IDMOVIMIENTO` is not null;

	-- Para anular facturas PEDIDOS
	    select p.`IDPEDIDOS`, p.`IDMOVIMIENTO`, p.fecha_entrega, p.`CODIGO`, p.`ESTADO`, m.nrofactura, p.`IMPUESTO`, p.observacion, pc.razonsocial , m.`ESTADO`, pc.`IDPERSONACLIENTE`, p.`id_tmpenc`
	-- SELECT p.`IDMOVIMIENTO`
	from pedidos p
	   join personacliente pc on p.idcliente = pc.idpersonacliente
	   join movimiento m      on p.idmovimiento = m.idmovimiento
	where p.`FECHA_ENTREGA` between  '2019-10-01' and '2019-10-30'
	and p.`ESTADO` = 'ANULADO'
	and p.`IDMOVIMIENTO` is not null
	-- AND p.`IDMOVIMIENTO` NOT IN (27416, 27417)
	;

update movimiento M set M.ESTADO = 'A' where M.`IDMOVIMIENTO` in (

);

update pedidos p set p.`ESTADO` = 'PREPARAR' where p.`IDPEDIDOS` in (29033, 29040);

select *
from pedidos p where p.`IDPEDIDOS` in (29033, 29040)
;


-- CRUCE COMPRAS CON ASIENTOS
-- ---------------------------
-- cruzar ambas consultas en excel (id_tmpenc)
select distinct co.*, dc.`idtmpenc`, e.`id_tmpenc`, e.`fecha`, /*d.`cuenta`, d.`debe`, d.`haber`,*/ e.`tipo_doc`, e.`no_doc`
from documentocontable co
join documentocompra dc 	on co.`iddocumentocontable` = dc.`iddocumentocompra`
join sf_tmpenc e  		on dc.`idtmpenc` = e.`id_tmpenc`
-- join sf_tmpdet d 		on e.`id_tmpenc` = d.`id_tmpenc`
where co.`fecha` between '2019-08-01' and '2019-08-31'
-- and d.`cuenta` = '1420710000'
;
-- 
select e.`id_tmpenc`, d.`id_tmpdet`, e.`estado`, e.`tipo_doc`, e.`no_doc`, e.`fecha`, d.`debe`, e.`glosa`
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
where e.`fecha` between '2019-08-01' and '2019-08-31'
and d.`cuenta` = '1420710000'
and d.`debe` > 0
and e.`estado` <> 'ANL'
 -- AND e.`tipo_doc` NOT IN ('NE')
;
-- ---------------------------

select e.`id_tmpenc`, d.`id_tmpdet`, e.`estado`, e.`tipo_doc`, e.`no_doc`, e.`fecha`, d.`debe`, e.`glosa`
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
where e.`fecha` between '2019-01-01' and '2019-01-31'
and d.`cuenta` = '2420410200'and d.haber > 0
;

select * from pedidos p
where p.`id_tmpenc` = 102522;

select * from movimiento m where m.`IDMOVIMIENTO` = 48641;

select e.`id_tmpenc`, d.`id_tmpdet`, e.`estado`, e.`tipo_doc`, e.`no_doc`, e.`fecha`, d.`debe`, d.`haber`, e.`glosa`, ve.idventadirecta, ve.estado, ve.idmovimiento, pe.idpedidos, pe.estado, pe.idmovimiento
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
left join (
	select v.`IDVENTADIRECTA`, v.`FECHA_PEDIDO`, v.`ESTADO`, v.`CODIGO`, v.`IDMOVIMIENTO`, v.`id_tmpenc`
	from ventadirecta v
	where v.`FECHA_PEDIDO` between '2019-06-01' and '2019-06-30' and v.`ESTADO` <> 'ANULADO'
) ve on e.`id_tmpenc` = ve.id_tmpenc
left join (
	select p.`IDPEDIDOS`, p.`FECHA_ENTREGA`, p.`ESTADO`, p.`CODIGO`, p.`IDMOVIMIENTO`, p.`id_tmpenc`
	from pedidos p
	where p.`FECHA_ENTREGA` between '2019-06-01' and '2019-06-30' and p.estado <> 'ANULADO'
) pe on e.`id_tmpenc` = pe.id_tmpenc
where e.`fecha` between '2019-06-01' and '2019-06-30'
and d.`cuenta` = '2420410200'and d.haber > 0
;


select v.`IDVENTADIRECTA`, v.`FECHA_PEDIDO`, v.`ESTADO`, v.`CODIGO`, v.`IDMOVIMIENTO`, v.`id_tmpenc`
from ventadirecta v
where v.`FECHA_PEDIDO` between '2019-01-01' and '2019-01-31'
;

select p.`IDPEDIDOS`, p.`FECHA_ENTREGA`, p.`ESTADO`, p.`CODIGO`, p.`IDMOVIMIENTO`, p.`id_tmpenc`, p.`IDUSUARIO`, pe.`NOM`, p.`IDTIPOPEDIDO`
from pedidos p
join personacliente pe on p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
where p.`FECHA_ENTREGA` between '2019-01-01' and '2019-01-31'
;



select p.`IDPEDIDOS`, p.`TOTALIMPORTE`, p.`IMPUESTO`, p.`ESTADO`, p.`id_tmpenc`, p.`ESTADO`, p.`CODIGO`, p.`FECHA_ENTREGA`, p.`IDMOVIMIENTO`, p.`OBSERVACION`
from pedidos p
where p.`IDPEDIDOS` in (

);


select *
from sf_tmpenc e
where e.`id_tmpenc` in (

);


-- 11/07/2019 ASIENTOS DEBITO FISCAL
select e.`id_tmpenc`, e.`fecha`, e.`tipo_doc`, e.`no_doc`, e.`estado`, d.`debe`, d.`haber`, e.`glosa`, e.`IDPERSONACLIENTE`
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
where e.`fecha` between '2019-06-01' and '2019-06-30'
and d.`cuenta` = 2420410200
;

-- Facturas Pedidos - Asientos
select m.`IDMOVIMIENTO`, m.`FECHA_FACTURA`, m.`ESTADO`, m.`IMPORTE_TOTAL`, m.`IMPORTE_PARA_DEBITO_FISCAL`, m.`DEBITO_FISCAL`, p.`IDPEDIDOS`, p.`id_tmpenc`, m.`RAZON_SOCIAL`
from movimiento m
left join pedidos p on m.`IDPEDIDOS` = p.`IDPEDIDOS`
where m.`FECHA_FACTURA` between '2019-06-01' and '2019-06-30'
and m.`ESTADO` <> 'A'
;
-- Facturas Contado - Asientos
select m.`IDMOVIMIENTO`, m.`FECHA_FACTURA`, m.`ESTADO`, m.`IMPORTE_TOTAL`, m.`IMPORTE_PARA_DEBITO_FISCAL`, m.`DEBITO_FISCAL`, m.`IDVENTADIRECTA`, v.`id_tmpenc`, m.`RAZON_SOCIAL`
from movimiento m
left join ventadirecta v on m.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
where m.`FECHA_FACTURA` between '2019-06-01' and '2019-06-30'
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


