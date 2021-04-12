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
where fecha between '2021-02-01' and '2021-02-31'
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
where FECHA_FACTURA between '2021-03-01' and '2021-03-31'
;

-- -------------

	-- Para anular facturas VENTAS CONTADO
	select v.`IDMOVIMIENTO` ,v.fecha_pedido, v.estado, v.observacion, m.`IDMOVIMIENTO`, m.`NROFACTURA`, m.`ESTADO`, v.`id_tmpenc`, e.`tipo_doc`, e.`estado`
	from ventadirecta v
	join movimiento m on v.`IDMOVIMIENTO` = m.`IDMOVIMIENTO`
	join sf_tmpenc e on v.`id_tmpenc` = e.`id_tmpenc`
	where v.`FECHA_PEDIDO` between '2021-03-01' and '2021-03-31'
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
	where p.`FECHA_ENTREGA` between  '2021-03-01' and '2021-03-31'
	and p.`ESTADO` = 'ANULADO'
	and p.`IDMOVIMIENTO` is not null
	-- AND p.`IDMOVIMIENTO` NOT IN (27416, 27417)
	;

update movimiento m set m.`ESTADO` = 'A'
where m.`IDMOVIMIENTO` in (

);

