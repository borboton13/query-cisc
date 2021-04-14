-- PARA REVISION DE LIBRO COMPRAS
-- ---------------------------
-- From Libro
select 	d.FECHA, d.NIT, d.NOMBRE,d.NUMERO,d.IMPORTE,d.importeneto,d.iva,
	z.idtmpenc, z.iddocumentocompra
from documentocontable d 
left join documentocompra z on d.iddocumentocontable = z.iddocumentocompra
where d.fecha between '2021-03-01' and '2021-03-31'
and z.estado <> 'NULLIFIED'
and z.tipo = 'INVOICE'
-- and z.`idtmpenc` is not null
;

-- From contab
select e.`id_tmpenc`, d.`id_tmpdet`,e.`tipo_doc`, e.`no_doc`, d.`debe`, d.`haber`
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
where e.`fecha` between '2021-03-01' and '2021-03-31'
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
where m.FECHA_FACTURA between '2021-03-01' and '2021-03-31'
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
where m.FECHA_FACTURA between '2021-03-01' and '2021-03-31'
and m.`IDPEDIDOS` is not null
and d.`cuenta` = '2420410200'
and e.`estado` <> 'ANL'
;



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


-- DEBITO FISCAL, MAYOR Y FACTURAS
-- DETALLE CONTABLE DEBITO FISCAL
select e.`id_tmpenc`, e.`fecha`, e.`glosa`, d.`id_tmpdet`,e.`tipo_doc`, e.`no_doc`, d.`debe`, d.`haber`, d.`idmovimiento`, m.`NROFACTURA`, m.`ESTADO`, m.`DEBITO_FISCAL`
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
left join movimiento m on d.`idmovimiento` = m.`IDMOVIMIENTO`
where e.`fecha` between '2021-03-01' and '2021-03-31'
and d.`cuenta` = '2420410200'
and e.`estado` <> 'ANL'
-- and e.`tipo_doc` not in ('NE', 'IA')
;

-- VENTAS, CRUCE FACTURAS (MOVIMIENTO) Y ASIENTOS
select m.`IDMOVIMIENTO`, m.`FECHA_FACTURA`, m.`ESTADO`, m.`IMPORTE_TOTAL`, m.`DESCUENTOS`, m.`IMPORTE_PARA_DEBITO_FISCAL`, m.`DEBITO_FISCAL`, m.`IDPEDIDOS`, m.`IDVENTADIRECTA`, d.`debe`, d.`haber`
from movimiento m
left join sf_tmpdet d on m.`IDMOVIMIENTO` = d.`idmovimiento`
where m.`FECHA_FACTURA` between '2021-02-01' and '2021-02-28'
and m.`ESTADO` <> 'A'
;

-- --------------------



-- Actualizado 12.03.2021
-- Ordenes de Compra con Factura
-- Revision de facturas, fechas, asiento
select e.`id_com_encoc`, e.`fecha_recepcion`, e.`glosa`, e.`no_orden`, e.`estado`, e.`total`, dc.`iddocumentocompra`, d.`iddocumentocontable` , d.`fecha`, dc.`estado`, d.`numero`, d.`nombre`, d.`iva`, dc.`idtmpenc`,
s.`fecha`, s.`tipo_doc`, s.`no_doc`, s.`estado`
from com_encoc e 
left join documentocompra dc on e.`id_com_encoc` = dc.`idordencompra`
left join documentocontable d on dc.`iddocumentocompra` = d.`iddocumentocontable`
left join sf_tmpenc s on dc.`idtmpenc` = s.`id_tmpenc`
where e.`fecha_recepcion` between '2021-02-01' and '2021-02-28'
and e.`confactura` = 'CONFACTURA'
;

