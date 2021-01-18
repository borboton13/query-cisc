-- PARA REVISION DE LIBRO COMPRAS
-- ---------------------------
-- From Libro
select 	d.FECHA, d.NIT, d.NOMBRE,d.NUMERO,d.IMPORTE,d.importeneto,d.iva,
	z.idtmpenc, z.iddocumentocompra
from documentocontable d 
left join documentocompra z on d.iddocumentocontable = z.iddocumentocompra
where d.fecha between '2020-12-01' and '2020-12-31'
and z.estado <> 'NULLIFIED'
and z.tipo = 'INVOICE'
and z.`idtmpenc` is not null
;

-- From contab
select e.`id_tmpenc`, d.`id_tmpdet`,e.`tipo_doc`, e.`no_doc`, d.`debe`, d.`haber`
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
where e.`fecha` between '2020-12-01' and '2020-12-31'
and d.`cuenta` = '1420710000'
and e.`estado` <> 'ANL'
and e.`tipo_doc` not in ('NE')
-- and e.`tipo_doc` not in ('NE', 'IA')
-- and e.`tipo_doc` not in ('IA')
;
-- ---------------------------
-- ---------------------------

-- PARA REVISION DE LIBRO VENTAS
-- ---------------------------
-- REVISION LV contado
select 	m.IDMOVIMIENTO,
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
from movimiento m
left join ventadirecta v on m.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
left join sf_tmpdet d on v.`id_tmpenc` = d.`id_tmpenc`
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
where m.FECHA_FACTURA between '2020-12-01' and '2020-12-31'
and m.`IDVENTADIRECTA` is not null
and d.`cuenta` = '2420410200'
and e.`estado` <> 'ANL'
union all
-- REVISION LV pedidos
select 	m.IDMOVIMIENTO,
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
from movimiento m
-- left join ventadirecta v on m.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
left join pedidos p on m.`IDPEDIDOS` = p.`IDPEDIDOS`
left join sf_tmpdet d on p.`id_tmpenc` = d.`id_tmpenc`
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
where m.FECHA_FACTURA between '2020-12-01' and '2020-12-31'
and m.`IDPEDIDOS` is not null
and d.`cuenta` = '2420410200'
and e.`estado` <> 'ANL'
;

-- ASIENTOS NO RELACIONADOS CON MOVIMIENTO
select e.`id_tmpenc`, e.`tipo_doc`, e.`no_doc`, d.`id_tmpdet`, d.`debe`, d.`haber`, d.`idmovimiento`, p.`IDMOVIMIENTO`, p.`IDPEDIDOS`, p.`IMPUESTO`, p.`IDCLIENTE`, pe.`NOM`
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
left join pedidos p on e.`id_tmpenc` = p.`id_tmpenc`
left join personacliente pe on p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
where e.`fecha` between '2020-09-01' and '2020-09-30'
and e.`estado` <> 'ANL'
and d.`cuenta` = '2420410200'
and d.`idmovimiento` is null
;

select *
from pedi
41462, 41466, 41464, 41470

select *
from movimiento m
where m.`FECHA_FACTURA` between '2020-08-01' and '2020-08-31'
and m.`IDPEDIDOS` in (
51691
);





-- ------------------------------------------------

-- embol 1444
-- GOBIERNO AUTONOMO DEPARTAMENTAL DE COCHABAMBA 460
-- ypfb 726
-- TOTAL CONTABILIZADO POR CLIENTE
select d.`idpersonacliente`, sum(d.`debe`)
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
where e.`fecha` between '2020-08-01' and '2020-08-31'
and d.`idpersonacliente` in (726)
and e.`estado` <> 'ANL'
;

select * 
from pedidos p
where p.`FECHA_ENTREGA` between '2020-08-01' and '2020-08-31'
and p.`ESTADO` <> 'ANULADO' and p.`tipoventa` = 'CREDIT'
and p.`id_tmpenc` is null
;


-- DETALLE CONTABLE DEBITO FISCAL
select e.`id_tmpenc`, e.`fecha`, e.`glosa`, d.`id_tmpdet`,e.`tipo_doc`, e.`no_doc`, d.`debe`, d.`haber`
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
where e.`fecha` between '2020-01-01' and '2020-01-31'
and d.`cuenta` = '2420410200'
and e.`estado` <> 'ANL'
-- and e.`tipo_doc` not in ('NE', 'IA')
;

-- --------------------

-- PEDIDOS, Para actualizar IDs movimiento, sf_tmpenc
select p.`FECHA_ENTREGA`, m.`FECHA_FACTURA`, m.`NROFACTURA`, m.`IDMOVIMIENTO`, m.`IDPEDIDOS`, p.`id_tmpenc`, d.`id_tmpdet`
from movimiento m
left join pedidos p on m.`IDPEDIDOS` = p.`IDPEDIDOS`
left join sf_tmpdet d on p.`id_tmpenc` = d.`id_tmpenc`
where m.`FECHA_FACTURA` between '2020-03-01' and '2020-03-31'
and m.idpedidos is not null
and d.`cuenta` = '2420410200'
;

-- VENTADIRECTA, Para actualizar IDs movimiento, sf_tmpenc
select v.`FECHA_PEDIDO`, m.`FECHA_FACTURA`, m.`NROFACTURA`, m.`IDMOVIMIENTO`, m.`IDVENTADIRECTA`, v.`id_tmpenc`, d.`id_tmpdet`, m.`id_tmpdet`
from movimiento m
left join ventadirecta v on m.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
left join sf_tmpdet d on v.`id_tmpenc` = d.`id_tmpenc`
where m.`FECHA_FACTURA` between '2020-02-01' and '2020-02-29'
and m.`IDVENTADIRECTA` is not null
and d.`cuenta` = '2420410200'
;

-- REVISION, CUENTA DEBITO FISCAL SIN FACTURA (MOVIMIENTO)
select e.`id_tmpenc`, e.`fecha`, e.`tipo_doc`, e.`no_doc`, e.`glosa`, d.`cuenta`, d.`debe`, d.`haber`, d.`idmovimiento`
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
-- where e.`fecha` between '2020-02-01' and '2020-02-29'
where e.`fecha` between '2020-03-01' and '2020-03-31'
and e.`estado` <> 'ANL'
and d.`cuenta` = '2420410200'
;

-- REVISION FACT VENTAS - CRUCE MOVIMIENTO - SF_TMPDET
select m.`IDMOVIMIENTO`, m.`FECHA_FACTURA`, m.`ESTADO`, m.`IMPORTE_TOTAL`, m.`DESCUENTOS`, m.`IMPORTE_PARA_DEBITO_FISCAL`, m.`DEBITO_FISCAL`, m.`IDPEDIDOS`, m.`IDVENTADIRECTA`, d.`debe`, d.`haber`
from movimiento m
left join sf_tmpdet d on m.`IDMOVIMIENTO` = d.`idmovimiento`
where m.`FECHA_FACTURA` between '2020-03-01' and '2020-03-31'
-- and m.`ESTADO` <> 'A'
;

-- 
-- -------------
-- -- REV COMPRAS, RELACION CON ID_TMPDET
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
	, z.idtmpenc, z.id_tmpdet,  d.iddocumentocontable, z.iddocumentocompra, oc.no_orden
from documentocontable d 
left join documentocompra z on d.iddocumentocontable = z.iddocumentocompra
left join com_encoc oc 	    on z.idordencompra = oc.id_com_encoc
where d.fecha between '2020-02-01' and '2020-02-29'
and z.estado <> 'NULLIFIED'
and z.tipo = 'INVOICE'
;


delete from documentocompra where iddocumentocompra = 10113;
delete from documentocontable where iddocumentocontable = 10113;

update documentocompra d set d.`estado` = 'NULLIFIED' where d.`iddocumentocompra` in (
);

