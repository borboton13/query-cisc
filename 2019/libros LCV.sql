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
	, z.idtmpenc
FROM documentocontable d 
JOIN documentocompra z ON d.iddocumentocontable = z.iddocumentocompra
WHERE fecha BETWEEN '2019-07-01' AND '2019-07-31'
AND z.estado <> 'NULLIFIED'
AND z.tipo = 'INVOICE'
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
WHERE d.fecha BETWEEN '2019-04-01' AND '2019-04-30'
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
WHERE FECHA_FACTURA BETWEEN '2019-08-01' AND '2019-08-31'
;

-- -------------

	-- Para anular facturas VENTAS CONTADO
	SELECT v.`IDMOVIMIENTO` ,v.fecha_pedido, v.estado, v.observacion, m.`IDMOVIMIENTO`, m.`ESTADO`
	FROM ventadirecta v
	JOIN movimiento m ON v.`IDMOVIMIENTO` = m.`IDMOVIMIENTO`
	WHERE v.`FECHA_PEDIDO` BETWEEN '2019-08-01' AND '2019-08-31'
	AND v.`ESTADO` = 'ANULADO'
	AND v.`IDMOVIMIENTO` IS NOT NULL;

	-- Para anular facturas PEDIDOS
	    SELECT p.`IDPEDIDOS`, p.`IDMOVIMIENTO`, p.fecha_entrega, p.`CODIGO`, p.`ESTADO`, m.nrofactura, p.`IMPUESTO`, p.observacion, pc.razonsocial , m.`ESTADO`, pc.`IDPERSONACLIENTE`, p.`id_tmpenc`
	-- SELECT p.`IDMOVIMIENTO`
	FROM pedidos p
	   JOIN personacliente pc ON p.idcliente = pc.idpersonacliente
	   JOIN movimiento m      ON p.idmovimiento = m.idmovimiento
	WHERE p.`FECHA_ENTREGA` BETWEEN  '2019-07-01' AND '2019-07-31'
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
select e.`id_tmpenc`, d.`id_tmpdet`, e.`estado`, e.`tipo_doc`, e.`no_doc`, e.`fecha`, d.`debe`, e.`glosa`
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
where e.`fecha` between '2019-02-01' and '2019-02-28'
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
32182,
32232,
32249,
32297,
32299,
32315,
32340,
32400,
32541,
32554,
32573,
32617,
32646,
32667,
32678,
32764
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
and dc.`numero` = 10233
;











