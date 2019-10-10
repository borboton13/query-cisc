-- -----------------------------------------------------------------
-- Ventas al contado X articulo
-- -----------------------------------------------------------------
select v.`IDVENTADIRECTA`, v.`FECHA_PEDIDO`, v.`CODIGO`, v.`ESTADO`, a.`CANTIDAD`, a.`REPOSICION`, a.`TOTAL`, a.`PRECIO`, a.`IMPORTE`
from articulos_pedido a
join ventadirecta v on a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
where v.`FECHA_PEDIDO` between '2016-01-01' and	'2016-12-31'
and a.`cod_art` in (237)
;

-- ----------------------------------------------------------------
-- ---------------------- RESUMEN PEDIDOS -------------------------
select p.`IDPEDIDOS`, pc.`NOM`, pc.`AP`, pc.`AM`, p.`FECHA_ENTREGA`, p.`CODIGO`, p.`ESTADO`, p.`TOTAL`, p.`TOTALIMPORTE`, p.`id_tmpenc`
from pedidos p
left join personacliente pc on p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
where p.`FECHA_ENTREGA` between '2019-01-01' and '2019-01-31'
-- AND p.`ESTADO` <> 'ANULADO'
-- AND pc.`NOM` LIKE '%Edelfr%'
;

-- PEDIDOS - ASIENTOS
select p.`IDPEDIDOS`, p.`FECHA_ENTREGA`, p.`CODIGO`, p.`IDTIPOPEDIDO`, t.`NOMBRE`, p.`id_tmpenc`, e.`tipo_doc`, e.`no_doc`, d.`id_tmpdet`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`
from pedidos p
join tipopedido t on p.`IDTIPOPEDIDO` = t.`IDTIPOPEDIDO`
join sf_tmpenc e on p.`id_tmpenc` = e.`id_tmpenc`
join sf_tmpdet d on e.`id_tmpenc` = d.`id_tmpenc`
join arcgms a 	 on d.`cuenta` = a.`cuenta`
where p.`FECHA_ENTREGA` between '2019-01-01' and '2019-03-31'
and p.`ESTADO` <> 'ANULADO'
and p.`IDUSUARIO` <> 5
;



-- ----------------------------------------------------------------
-- --------------------- DETALLE DE PEDIDOS -----------------------
select 	p.`FECHA_ENTREGA`, P.`FECHA_PEDIDO`,
	p.`IDPEDIDOS`, 
	p.`CODIGO`,
	P.`ESTADO`,
	p.`IDCLIENTE`,
	CONCAT(pc.`NOM`,' ',pc.`AP`,' ',pc.`AM`) as CLIENTE, p.`OBSERVACION`, p.`DESCRIPCION`,
	a.`cod_art`, 
	a.`IDARTICULOSPEDIDO` as IdArtP, 
	ar.`descri`, 
	a.`CANTIDAD`, a.`PROMOCION`, a.`REPOSICION`, a.`TOTAL`, a.`PRECIO`, a.`IMPORTE`, 
	p.`VALORCOMISION`, p.`TOTALIMPORTE`,
	-- a.`cu`,
	p.`IDTIPOPEDIDO`, p.`CV`, p.`IDMOVIMIENTO`,
	p.`ESTADO`, p.`id_tmpenc`, p.`TIENEFACTURA`, p.`FACTURA`
from articulos_pedido a
left join pedidos p on a.idpedidos = p.`IDPEDIDOS`
left join personacliente pc on p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
where p.`FECHA_ENTREGA` between '2019-07-01' and '2019-10-31'
-- AND p.`IDPEDIDOS` = 34632
-- AND p.`IDCLIENTE` = 65
and p.`CODIGO` in (6934) -- 3939(8895), 4140(119), 4216(347)
-- 3133
-- AND pc.`NOM` LIKE '%Randy%'
-- AND a.`IDPEDIDOS` = 29988
-- AND pc.`AP` LIKE '%Car%'
-- AND a.`cod_art` IN (669, 668, 642, 134, 643)
-- AND p.`IDUSUARIO` = 5
;



update pedidos p set p.`FECHA_ENTREGA` = '2019-10-01' where p.`IDPEDIDOS`= 35335; -- 2019-10-01

-- update pedidos p set p.`FECHA_ENTREGA` = '2019-08-22', p.descripcion = 'S.PRENATAL Y L.' where p.`IDPEDIDOS`= 34167; -- 2019-08-22
-- update pedidos p set p.`FECHA_ENTREGA` = '2019-08-22', p.descripcion = 'S.PRENATAL Y L.' where p.`IDPEDIDOS`= 34168; -- 2019-08-22

select * from pedidos p where p.`IDPEDIDOS` in (31535, 32340, 32541, 32617);

-- update pedidos p set p.`ESTADO` = 'ANULADO', p.`OBSERVACION` = 'ERROR EN LA PERSONA (OSBY)' where p.`IDPEDIDOS` = 32156;

select *
from movimiento m
-- where m.`NROFACTURA` in (7411,    8895, 119, 347)
where m.`IDPEDIDOS` in (31535, 32340, 32541, 32617)
and m.`FECHA_FACTURA` >= '2019-05-01'
;

-- update pedidos p set p.`PORCENTAJECOMISION` = 10, p.`VALORCOMISION` = (p.`TOTALIMPORTE`*0.10) , p.`IDMOVIMIENTO` = null, p.`ESTADO` = 'PREPARAR', p.`id_tmpenc` = null
where p.`IDPEDIDOS` in (32340, 32541, 32617);

update pedidos p set p.`FECHA_ENTREGA` = '2019-06-14', p.`TIENEFACTURA` = 0, p.`IDMOVIMIENTO` = null, p.`OBSERVACION` = 'FACT: 51 (14/06/2019), REFACT: 2221 (27/07/2019)' 
where p.`IDPEDIDOS`= 32536; -- SEDEM ORURO 14/06/2019 ORIG

-- update pedidos p set p.`FECHA_ENTREGA` = '2019-06-15' where p.`IDPEDIDOS`= 32541; -- 2019-06-15
-- update pedidos p set p.`FECHA_ENTREGA` = '2019-06-19' where p.`IDPEDIDOS`= 32617; -- 2019-06-19

-- update sf_tmpenc e set e.`estado` = 'ANL'
where e.`id_tmpenc` in (112529, 112772, 113046);

-- SEDEM SCZ
-- update pedidos p set p.`FECHA_ENTREGA` = '2019-06-12' where p.`IDPEDIDOS` in (32340); -- 
-- UPDATE pedidos p SET p.`FECHA_ENTREGA` = '2019-05-03' WHERE p.`IDPEDIDOS` = 31254; -- ok
-- UPDATE pedidos p SET p.`FECHA_ENTREGA` = '2019-05-02' WHERE p.`IDPEDIDOS` = 31254; -- pen

-- UPDATE pedidos p SET p.`IDMOVIMIENTO` = null WHERE p.`IDPEDIDOS` IN (31195,31196,31208); -- ok
-- UPDATE pedidos p SET p.`id_tmpenc` = null WHERE p.`IDPEDIDOS` IN (31195,31196,31208); -- ok
-- update movimiento m set m.`ESTADO` = 'A' where m.`IDMOVIMIENTO` in (52023,52022,52011);  -- ok


select *
from ventaarticulo a
where a.`cod_art` in (120, 122);

-- 
-- --------------------- DETALLE DE VENTAS CONTADO -----------------------
select 	v.`FECHA_PEDIDO`,
	v.`IDVENTADIRECTA`,
	v.`CODIGO`,
	CONCAT(pc.`NOM`,' ',pc.`AP`,' ',pc.`AM`) as CLIENTE, 
	a.`cod_art`, 
	a.`IDARTICULOSPEDIDO` as IdArtP, 
	ar.`descri`, 
	a.`CANTIDAD`, a.`PROMOCION`, a.`REPOSICION`, a.`TOTAL`, a.`PRECIO`, a.`IMPORTE`, 
	a.`cu`,
	v.`IDMOVIMIENTO`,
	v.`ESTADO`, v.`id_tmpenc`
from articulos_pedido a
left join ventadirecta v on a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
left join personacliente pc on v.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
where v.`FECHA_PEDIDO` between '2019-01-02' and '2019-12-31'
and v.idventadirecta in (36455)
-- AND p.`IDPEDIDOS` IN (21928)
-- AND p.`IDCLIENTE` = 65
-- and v.`CODIGO` in (2396)
-- AND pc.`NOM` LIKE '%Randy%'
-- AND a.`IDPEDIDOS` = 2584
-- AND pc.`AP` LIKE '%Car%'
-- AND a.`cod_art` = 703
-- and v.`IDUSUARIO` = 5
;

select *
from movimiento m
where m.`IDMOVIMIENTO` in (58387, 58388, 59434);

select zz.cod_art, zz.descri, SUM(zz.total) as cant
from (
	/*SELECT 	a.`cod_art`,  ar.`descri`,  SUM(a.`TOTAL`) AS total
	FROM articulos_pedido a
	LEFT JOIN pedidos p ON a.idpedidos = p.`IDPEDIDOS`
	LEFT JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
	WHERE p.`FECHA_ENTREGA` BETWEEN '2018-06-29' AND '2018-07-31'
	AND p.`IDPEDIDOS` > 23759
	AND p.`ESTADO` <> 'ANULADO'
	AND p.`IDUSUARIO` <> 5
	GROUP BY a.`cod_art`,  ar.`descri`
		UNION ALL*/
	select a.`cod_art`, ar.`descri`, SUM(a.`CANTIDAD`) as total
	from articulos_pedido a
	left join ventadirecta v on a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
	left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
	where v.`FECHA_PEDIDO` between '2019-01-02' and '2019-01-03'
	and v.idventadirecta >= 25681
	and v.`ESTADO` <> 'ANULADO'
	and v.`IDUSUARIO` = 5
	group by a.`cod_art`, ar.`descri`
) zz
group by zz.cod_art, zz.descri
;


--
-- Ventas al contado Xx incompleto
select pc.`NOM`, a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, SUM(a.`CANTIDAD`) as CANTIDAD
from articulos_pedido a
left join ventadirecta v on a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
left join personacliente pc on v.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
where v.`FECHA_PEDIDO` between '2016-09-01' and '2016-09-30'
and v.`ESTADO` <> 'ANULADO'
and ar.`cuenta_art` = '4420110201'
group by a.`cod_art`, ar.`descri`;

-- -------------------------------------------
-- - CONTROL ARTICULOS DUPLICADOS EN PEDIDOS -
-- -------------------------------------------
select p.`FECHA_ENTREGA`, pc.`NOM`, p.`IDPEDIDOS`, p.`CODIGO` as COD_PED, a.`cod_art`, a.`IDARTICULOSPEDIDO`, ar.`descri`, a.`CANTIDAD`, a.`REPOSICION`, a.`TOTAL`, p.`ESTADO`, a.`PRECIO`, a.`IMPORTE`, a.POR_REPONER
from articulos_pedido a
left join pedidos p on a.idpedidos = p.`IDPEDIDOS`
left join personacliente pc on p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
where p.`FECHA_ENTREGA` = '2016-07-25'
-- AND p.`CODIGO` = 164
;

select *
from (
	select p.`FECHA_ENTREGA`, pc.`NOM`, p.`IDPEDIDOS`, p.`CODIGO` as COD_PED, a.`cod_art`, ar.`descri`, COUNT(a.`IDARTICULOSPEDIDO`) as repetido
	from articulos_pedido a
		left join pedidos p on a.idpedidos = p.`IDPEDIDOS`
		left join personacliente pc on p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
		left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
	where p.`FECHA_ENTREGA` between '2016-02-03' and '2017-12-31'
	-- AND p.`CODIGO` = 2476
	and p.`ESTADO` <> 'ANULADO'
	group by pc.`NOM`, p.`IDPEDIDOS`, p.`CODIGO`, a.`cod_art`, ar.`descri`
      ) CONTROL
where CONTROL.repetido >= 2
;



-- ------------- VENTAS CLIENTES x PRODUCTO x MES (PEDIDOS) -------------
-- --------------------------------------------------------------------------
-- SELECT pc.`NOM`, pc.`AP`, pc.`AM`, p.`IDPEDIDOS`, p.`CODIGO` AS COD_PED, a.`IDARTICULOSPEDIDO`, a.`cod_art`, ar.`descri`, a.`CANTIDAD`, a.`REPOSICION`, a.`TOTAL`, p.`ESTADO`, a.`IMPORTE`
select MONTH(p.`FECHA_ENTREGA`) as MES, pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, SUM(a.`CANTIDAD`) as CANTIDAD
from articulos_pedido a
left join pedidos p on a.idpedidos = p.`IDPEDIDOS`
left join personacliente pc on p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
where p.`FECHA_ENTREGA` between '2019-02-01' and '2019-02-28'
and P.`ESTADO` <> 'ANULADO'
and p.`IDCLIENTE` = 180 -- SEMAPA
-- AND pc.`NOM` LIKE '%TORRES%'
group by MONTH(p.`FECHA_ENTREGA`), pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art`, ar.`descri`;
-- ---------------------------------------------------

-- LISTA PERSONAS VENTAS
select distinct pc.`NRO_DOC`, pc.`NOM`, pc.`AP`, pc.`AM`, pc.`DIRECCION`, pc.`TELEFONO`, pc.`NIT`, pc.`RAZONSOCIAL`
from articulos_pedido a
left join ventadirecta v on a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
left join personacliente pc on v.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
where v.`FECHA_PEDIDO` between '2018-01-01' and '2018-04-30'
and v.`ESTADO` <> 'ANULADO'
and V.`IDUSUARIO` in (6, 404)
group by pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art`, ar.`descri`;

select *
from articulos_pedido a
left join pedidos p on a.idpedidos = p.`IDPEDIDOS`
where p.`FECHA_ENTREGA` between '2017-01-01' and '2017-12-31'
and P.`ESTADO` <> 'ANULADO'
and p.`IDCLIENTE` = 180
;
-- ---------------------------------------------------



--
-- CANTIDAD DE ARTICULOS DE PEDIDOS
select a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, SUM(a.`CANTIDAD`) as CANT_PRODUCTOS
from articulos_pedido a
left join pedidos p on a.idpedidos = p.`IDPEDIDOS`
left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
where p.`FECHA_ENTREGA` between '2016-02-01' and '2016-02-02'
and P.`ESTADO` <> 'ANULADO'
group by a.`cod_art`, ar.`descri`;

-- CANTIDAD DE ARTICULOS DE VENTAS AL CONTADO
select a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, SUM(a.`CANTIDAD`) as CANT_PRODUCTOS
from articulos_pedido a
left join ventadirecta v on a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
where v.`FECHA_PEDIDO` between '2016-02-20' and '2016-02-20'
-- AND v.`IDUSUARIO` = 4
and v.`ESTADO` <> 'ANULADO'
-- AND ar.`cuenta_art` = 4420110201
group by a.`cod_art`, ar.`descri`
;


-- 06/07/2018 CANTIDAD DE ARTICULOS POR FECHA X PEDIDO
select p.`FECHA_ENTREGA`, a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, SUM(a.`CANTIDAD`) as CANT_PRODUCTOS
from articulos_pedido a
left join pedidos p on a.idpedidos = p.`IDPEDIDOS`
left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
where p.`FECHA_ENTREGA` between '2019-01-01' and '2019-01-31'
and P.`ESTADO` <> 'ANULADO'
-- AND p.`IDUSUARIO` <> 5
and a.`cod_art` = 151
group by p.`FECHA_ENTREGA`, a.`cod_art`, ar.`descri`;

-- 06/07/2018 CANTIDAD DE ARTICULOS X FECHA X VENTA CONTADO
select v.`FECHA_PEDIDO`, a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, SUM(a.`CANTIDAD`) as CANT_PRODUCTOS
from articulos_pedido a
left join ventadirecta v on a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
where v.`FECHA_PEDIDO` between '2019-01-01' and '2019-01-31'
-- AND v.`IDUSUARIO` <> 5
and v.`ESTADO` <> 'ANULADO'
and a.`cod_art` = 151
group by v.`FECHA_PEDIDO`, a.`cod_art`, ar.`descri`
;



-- 
-- Reporte cantidad, Ventas al contado
--
select a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, SUM(a.`CANTIDAD`) as CANTIDAD
from articulos_pedido a
left join ventadirecta v on a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
where v.`FECHA_PEDIDO` between '2016-09-01' and '2016-09-30'
and v.`ESTADO` <> 'ANULADO'
and ar.`cuenta_art` = '4420110201'
group by a.`cod_art`, ar.`descri`;

-- 
-- Reporte cantidad, Ventas Pedidos
--
select a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, SUM(a.`CANTIDAD`) as CANTIDAD
from articulos_pedido a
left join pedidos p on a.idpedidos = p.`IDPEDIDOS`
left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
where p.`FECHA_ENTREGA` between '2016-09-01' and '2016-09-30'
and P.`ESTADO` <> 'ANULADO'
group by a.`cod_art`, ar.`descri`;

-- Degustacion, Reposicion
select a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, SUM(a.`CANTIDAD`) as CANTIDAD
from articulos_pedido a
left join pedidos p on a.idpedidos = p.`IDPEDIDOS`
left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
where p.`FECHA_ENTREGA` between '2019-01-01' and '2019-01-31'
-- and p.`IDTIPOPEDIDO` = 2 	-- Degustacion
-- and p.`IDTIPOPEDIDO` = 3 	-- Refrigerio
and p.`IDTIPOPEDIDO` = 4 	-- Reposicion
and P.`ESTADO` <> 'ANULADO'
group by a.`cod_art`, ar.`descri`;

--



-- Reporte,  cantidad total de ventas x producto
select 	p.cod_art, p.producto, 
	(p.cantidad + IFNULL(v.cantidad, 0)) as cantidad, 
	i.cu, 
	((p.cantidad + IFNULL(v.cantidad, 0)) * i.cu) as costo,
	((p.cantidad + IFNULL(v.cantidad, 0)) * i.`costo_uni`) as costo_total_uni
from (
	select a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, SUM(a.`CANTIDAD`) as CANTIDAD, SUM(a.`TOTAL`) as cant_total
	from articulos_pedido a
	left join pedidos p on a.idpedidos = p.`IDPEDIDOS`
	left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
	where p.`FECHA_ENTREGA` between '2017-01-01' and '2017-01-31'
	and P.`ESTADO` <> 'ANULADO'
	group by a.`cod_art`, ar.`descri`
	) p
left join (
	select a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, SUM(a.`CANTIDAD`) as CANTIDAD
	from articulos_pedido a
	left join ventadirecta v on a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
	left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
	where v.`FECHA_PEDIDO` between '2017-01-01' and '2017-01-31'
	and v.`ESTADO` <> 'ANULADO'
	and ar.`cuenta_art` = '4420110201'
	group by a.`cod_art`, ar.`descri`
	) v 	on p.cod_art = v.cod_Art
left join inv_articulos i on p.cod_Art = i.cod_art
;

-- Reporte, REPOSICIONES
select 	p.cod_art, p.producto, 
	(p.cantidad + IFNULL(v.cantidad, 0)) as reposicion, 
	i.cu, 
	((p.cantidad + IFNULL(v.cantidad, 0)) * i.cu) as costo,
	((p.cantidad + IFNULL(v.cantidad, 0)) * i.`costo_uni`) as costo_total_uni
from (
	select a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, SUM(a.`REPOSICION`) as CANTIDAD
	from articulos_pedido a
	left join pedidos p on a.idpedidos = p.`IDPEDIDOS`
	left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
	where p.`FECHA_ENTREGA` between '2016-01-01' and '2016-11-30'
	and P.`ESTADO` <> 'ANULADO'
	group by a.`cod_art`, ar.`descri`
	) p
left join (
	select a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, SUM(a.`CANTIDAD`) as CANTIDAD
	from articulos_pedido a
	left join pedidos p on a.idpedidos = p.`IDPEDIDOS`
	left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
	where p.`FECHA_ENTREGA` between '2016-01-01' and '2016-11-30'
	and p.`IDTIPOPEDIDO` = 4
	and P.`ESTADO` <> 'ANULADO'
	group by a.`cod_art`, ar.`descri`
	) v 	on p.cod_art = v.cod_Art
left join inv_articulos i on p.cod_Art = i.cod_art
;

--
-- REPORTE DE FACTURAS ANULADAS
-- PEDIDOS ANULADOS
select p.`IDMOVIMIENTO`, p.fecha_entrega, p.`CODIGO`, p.`ESTADO`, m.nrofactura, m.`FECHA_FACTURA`, p.observacion, m.`RAZON_SOCIAL`, m.`ESTADO`, pc.`IDPERSONACLIENTE`, p.`id_tmpenc`
from pedidos p
join personacliente pc on p.idcliente = pc.idpersonacliente
join movimiento m      on p.idmovimiento = m.idmovimiento
where p.`FECHA_ENTREGA` between '2016-06-16' and '2016-06-16'
-- AND p.`ESTADO` = 'ANULADO'
and p.`IDMOVIMIENTO` is not null
;

select v.`IDMOVIMIENTO`, v.`FECHA_PEDIDO`, v.`CODIGO`, v.`ESTADO`, m.`NROFACTURA`, m.`FECHA_FACTURA`, v.`OBSERVACION`, m.`RAZON_SOCIAL`, v.`IDCLIENTE`
from ventadirecta v
join movimiento m on v.`IDMOVIMIENTO` = m.`IDMOVIMIENTO`
where v.`FECHA_PEDIDO` between '2017-03-01' and '2017-03-31'
and v.`ESTADO` = 'ANULADO'
and v.`IDMOVIMIENTO` is not null
;

--
-- CONTROL DE PEDIDOS SIN CONTABILIZAR
select p.`IDPEDIDOS`, p.`CODIGO`, p.`FECHA_ENTREGA`, p.`ESTADO`, p.`TIENEFACTURA`, pe.`NOM`, p.`IDMOVIMIENTO`, P.`TOTALIMPORTE`, P.`IMPUESTO`
from pedidos p
left join personacliente pe on p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
where p.`FECHA_ENTREGA` between '2019-01-01' and '2019-12-31'
and p.`ESTADO` <> 'CONTABILIZADO' 
and p.`ESTADO` <> 'ANULADO'
;


-- PEDIDOS - DESCUENTOS VETRINARIOS / LACTEOS
set @folio = (select MAX(idmovimientosalarioproductor)+1 from movimientosalarioproductor);
select p.`IDPEDIDOS`, p.`FECHA_ENTREGA`, p.`CODIGO`, p.`ESTADO`, p.`TOTALIMPORTE`, p.`IDCLIENTE`, pe.`NOM`, pe.`AP`, pe.`AM`, pe.`NRO_DOC`, en.`identidad`, en.`noidentificacion`, per.`nombres`, per.`apellidopaterno`, per.`apellidomaterno`, p.`id_tmpenc`
-- INSERT INTO movimientosalarioproductor
-- SELECT (@folio := @folio + 1), p.`FECHA_ENTREGA`, concat('Descuento por venta a credito Nro. ',  p.`CODIGO`) as descri, 'PENDING' AS estado, p.`TOTALIMPORTE` as valor, '1' as idcompania, pr.`idzonaproductiva`, en.`identidad`, '4' AS idtipomovimientoproductor
from pedidos p
left join personacliente pe 	on p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
left join entidad en 		on pe.`NRO_DOC` = en.`noidentificacion`
left join persona per 		on en.`identidad` = per.`idpersona`
left join productormateriaprima pr on per.`idpersona` = pr.`idproductormateriaprima`
where p.`IDUSUARIO` = 404
-- WHERE p.`IDUSUARIO` = 5
and p.`FECHA_ENTREGA` between '2019-03-01' and '2019-03-15'
and p.`IDTIPOPEDIDO` = 5
;

select p.`IDPEDIDOS`, p.`FECHA_ENTREGA`, p.`CODIGO`, p.`ESTADO`, p.`TOTALIMPORTE`, p.`IDCLIENTE`, pe.`NOM`, pe.`AP`, pe.`AM`, pe.`NRO_DOC`, en.`identidad`, en.`noidentificacion`, per.`nombres`, per.`apellidopaterno`, per.`apellidomaterno`, p.`id_tmpenc`
-- INSERT INTO movimientosalarioproductor
-- SELECT (@folio := @folio + 1), p.`FECHA_ENTREGA`, concat('Descuento por venta a credito Nro. ',  p.`CODIGO`) as descri, 'PENDING' AS estado, p.`TOTALIMPORTE` as valor, '1' as idcompania, pr.`idzonaproductiva`, en.`identidad`, '4' AS idtipomovimientoproductor
from pedidos p
left join personacliente pe 	on p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
left join entidad en 		on pe.`NRO_DOC` = en.`noidentificacion`
left join persona per 		on en.`identidad` = per.`idpersona`
left join productormateriaprima pr on per.`idpersona` = pr.`idproductormateriaprima`
where p.`IDUSUARIO` = 404
-- WHERE p.`IDUSUARIO` = 5
and p.`FECHA_ENTREGA` between '2019-01-01' and '2019-01-15'
and p.`IDTIPOPEDIDO` = 5
;

update SECUENCIA set VALOR=(select MAX(E.IDMOVIMIENTOSALARIOPRODUCTOR)+1 from MOVIMIENTOSALARIOPRODUCTOR E) where TABLA='MOVIMIENTOSALARIOPRODUCTOR';

select v.`fecha`,  v.`no_trans`, v.`no_vale`, v.`cod_doc`, v.`estado`, v.`cod_alm`, m.`fecha_cre`, m.`fecha_mov`, m.`descri`, d.`fecha`, d.`cod_art`, a.`descri`, d.`costounitario`, d.`cantidad`, v.`idtmpenc`
from inv_movdet d 
left join inv_articulos a on d.`cod_art` = a.`cod_art`
left join inv_mov m on d.`no_trans` = m.`no_trans`
left join inv_vales v on m.`no_trans` = v.`no_trans`
where m.`no_usr` = 'SUA'
and v.`cod_alm` = 2
and v.`fecha` between '2019-01-01' and '2019-02-28'
and d.`cod_art` in (118, 148, 150, 151, 643)
;





