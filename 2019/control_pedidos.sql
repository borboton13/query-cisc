-- -----------------------------------------------------------------
-- Ventas al contado X articulo
-- -----------------------------------------------------------------
select v.`IDVENTADIRECTA`, v.`FECHA_PEDIDO`, v.`CODIGO`, v.`ESTADO`, a.`CANTIDAD`, a.`REPOSICION`, a.`TOTAL`, a.`PRECIO`, a.`IMPORTE`
from articulos_pedido a
join ventadirecta v on a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
where v.`FECHA_PEDIDO` between '2016-01-01' and	'2016-12-31'
and a.`cod_art` in (237)
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
	P.`tipoventa`,
	P.`ESTADO`,
	p.`IDCLIENTE`,
	concat(pc.`NOM`,' ',pc.`AP`,' ',pc.`AM`) as CLIENTE, p.`OBSERVACION`, p.`DESCRIPCION`,
	a.`cod_art`, 
	a.`IDARTICULOSPEDIDO` as IdArtP, 
	ar.`descri`, 
	a.`CANTIDAD`, a.`PROMOCION`, a.`REPOSICION`, a.`TOTAL`, a.`PRECIO`, a.`IMPORTE`, 
	p.`VALORCOMISION`, p.`TOTALIMPORTE`,
	-- a.`cu`,
	p.`IDTIPOPEDIDO`, p.`CV`, p.`IDMOVIMIENTO`,
	p.`ESTADO`, p.`id_tmpenc`, p.`TIENEFACTURA`, p.`FACTURA`, p.`id_tmpenc`
from articulos_pedido a
left join pedidos p on a.idpedidos = p.`IDPEDIDOS`
left join personacliente pc on p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
where p.`FECHA_ENTREGA` between '2021-01-01' and '2021-12-31'
-- and p.`IDPEDIDOS` = 52247
-- and p.`IDCLIENTE` = 726
-- and p.`CODIGO` in (1090)
and p.`ESTADO` <> 'ANULADO'
-- and pc.`NOM` like '%Monica Lau%'
 and a.`IDPEDIDOS` = 58548
-- AND pc.`AP` LIKE '%Car%'
-- and a.`cod_art` in (1090)
-- AND p.`IDUSUARIO` = 5
-- and a.`TOTAL` = 0
;


update articulos_pedido a 
set a.`TOTAL` = (a.`CANTIDAD` + a.`PROMOCION` + a.`REPOSICION`)
where a.`IDARTICULOSPEDIDO` in (
453534, 453535, 453543
);



select distinct i.`cod_alm`
from inv_periodo i
where i.`gestion` = 2021
;

select *
from pedidos p
-- update pedidos p set p.`ESTADO` = 'ANULADO', p.`OBSERVACION` = 'Entrega anticipada, F-3680 vig, nota ANL'
-- update pedidos p set p.`ESTADO` = 'CONTABILIZADO'
where p.`FECHA_ENTREGA` between '2020-01-01' and '2020-12-31'
and p.`CODIGO` in (8061)
;

-- update pedidos p set p.`IDCLIENTE` = 665 where p.`IDPEDIDOS` = 51331;

-- update pedidos p set p.`ESTADO` = 'ANULADO' where p.`IDPEDIDOS`= 35615;
-- update sf_tmpenc e SET e.`estado` = 'ANL' where e.`id_tmpenc` = 123001;
-- update movimiento m set m.`ESTADO` = 'A' WHERE m.`IDMOVIMIENTO` = 60392;
update pedidos p set p.`FECHA_ENTREGA` = '2020-11-18' where p.`IDPEDIDOS`= 54958; -- 2020-11-18




select *
from movimiento m
-- where m.`NROFACTURA` in (7411,    8895, 119, 347)
where m.`IDPEDIDOS` in (31535, 32340, 32541, 32617)
and m.`FECHA_FACTURA` >= '2019-05-01'
;


-- update pedidos p set p.`FECHA_ENTREGA` = '2019-06-15' where p.`IDPEDIDOS`= 32541; -- 2019-06-15
-- update pedidos p set p.`FECHA_ENTREGA` = '2019-06-19' where p.`IDPEDIDOS`= 32617; -- 2019-06-19



select *
from ventaarticulo a
where a.`cod_art` in (120, 122);

-- 
-- --------------------- DETALLE DE VENTAS CONTADO -----------------------
select 	v.`FECHA_PEDIDO`,
	v.`IDVENTADIRECTA`,
	v.`CODIGO`,
	concat(pc.`NOM`,' ',pc.`AP`,' ',pc.`AM`) as CLIENTE, 
	a.`cod_art`, 
	a.`IDARTICULOSPEDIDO` as IdArtP, 
	ar.`descri`, -- v.`OBSERVACION`,
	a.`CANTIDAD`, a.`PROMOCION`, a.`REPOSICION`, a.`TOTAL`, a.`PRECIO`, a.`IMPORTE`, 
	a.`cu`,
	v.`IDMOVIMIENTO`,
	v.`ESTADO`, v.`id_tmpenc`
from articulos_pedido a
left join ventadirecta v on a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
left join personacliente pc on v.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
where v.`FECHA_PEDIDO` between '2020-01-01' and '2020-10-31'
and v.idventadirecta in (44761)
-- AND p.`IDPEDIDOS` IN (21928)
-- AND p.`IDCLIENTE` = 65
-- and v.`CODIGO` in (12267)
-- AND pc.`NOM` LIKE '%Randy%'
-- AND a.`IDPEDIDOS` = 2584
-- AND pc.`AP` LIKE '%Car%'
-- and a.`cod_art` = 143
-- and v.`IDUSUARIO` = 5
;


select zz.cod_art, zz.descri, sum(zz.total) as cant
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
	select a.`cod_art`, ar.`descri`, sum(a.`CANTIDAD`) as total
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
select pc.`NOM`, a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, sum(a.`CANTIDAD`) as CANTIDAD
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
	select p.`FECHA_ENTREGA`, pc.`NOM`, p.`IDPEDIDOS`, p.`CODIGO` as COD_PED, a.`cod_art`, ar.`descri`, count(a.`IDARTICULOSPEDIDO`) as repetido
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
select month(p.`FECHA_ENTREGA`) as MES, pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, sum(a.`CANTIDAD`) as CANTIDAD
from articulos_pedido a
left join pedidos p on a.idpedidos = p.`IDPEDIDOS`
left join personacliente pc on p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
where p.`FECHA_ENTREGA` between '2019-02-01' and '2019-02-28'
and P.`ESTADO` <> 'ANULADO'
and p.`IDCLIENTE` = 180 -- SEMAPA
-- AND pc.`NOM` LIKE '%TORRES%'
group by month(p.`FECHA_ENTREGA`), pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art`, ar.`descri`;
-- ---------------------------------------------------


--
-- CANTIDAD DE ARTICULOS DE PEDIDOS
select a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, sum(a.`CANTIDAD`) as CANT_PRODUCTOS
from articulos_pedido a
left join pedidos p on a.idpedidos = p.`IDPEDIDOS`
left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
where p.`FECHA_ENTREGA` between '2016-02-01' and '2016-02-02'
and P.`ESTADO` <> 'ANULADO'
group by a.`cod_art`, ar.`descri`;

-- CANTIDAD DE ARTICULOS DE VENTAS AL CONTADO
select a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, sum(a.`CANTIDAD`) as CANT_PRODUCTOS
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
select p.`FECHA_ENTREGA`, a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, sum(a.`CANTIDAD`) as CANT_PRODUCTOS
from articulos_pedido a
left join pedidos p on a.idpedidos = p.`IDPEDIDOS`
left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
where p.`FECHA_ENTREGA` between '2019-01-01' and '2019-01-31'
and P.`ESTADO` <> 'ANULADO'
-- AND p.`IDUSUARIO` <> 5
and a.`cod_art` = 151
group by p.`FECHA_ENTREGA`, a.`cod_art`, ar.`descri`;

-- 06/07/2018 CANTIDAD DE ARTICULOS X FECHA X VENTA CONTADO
select v.`FECHA_PEDIDO`, a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, sum(a.`CANTIDAD`) as CANT_PRODUCTOS
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
select a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, sum(a.`CANTIDAD`) as CANTIDAD
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
select a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, sum(a.`CANTIDAD`) as CANTIDAD
from articulos_pedido a
left join pedidos p on a.idpedidos = p.`IDPEDIDOS`
left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
where p.`FECHA_ENTREGA` between '2016-09-01' and '2016-09-30'
and P.`ESTADO` <> 'ANULADO'
group by a.`cod_art`, ar.`descri`;

-- Degustacion, Reposicion
select a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, sum(a.`CANTIDAD`) as CANTIDAD
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
	(p.cantidad + ifnull(v.cantidad, 0)) as cantidad, 
	i.cu, 
	((p.cantidad + ifnull(v.cantidad, 0)) * i.cu) as costo,
	((p.cantidad + ifnull(v.cantidad, 0)) * i.`costo_uni`) as costo_total_uni
from (
	select a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, sum(a.`CANTIDAD`) as CANTIDAD, sum(a.`TOTAL`) as cant_total
	from articulos_pedido a
	left join pedidos p on a.idpedidos = p.`IDPEDIDOS`
	left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
	where p.`FECHA_ENTREGA` between '2017-01-01' and '2017-01-31'
	and P.`ESTADO` <> 'ANULADO'
	group by a.`cod_art`, ar.`descri`
	) p
left join (
	select a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, sum(a.`CANTIDAD`) as CANTIDAD
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
	(p.cantidad + ifnull(v.cantidad, 0)) as reposicion, 
	i.cu, 
	((p.cantidad + ifnull(v.cantidad, 0)) * i.cu) as costo,
	((p.cantidad + ifnull(v.cantidad, 0)) * i.`costo_uni`) as costo_total_uni
from (
	select a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, sum(a.`REPOSICION`) as CANTIDAD
	from articulos_pedido a
	left join pedidos p on a.idpedidos = p.`IDPEDIDOS`
	left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
	where p.`FECHA_ENTREGA` between '2016-01-01' and '2016-11-30'
	and P.`ESTADO` <> 'ANULADO'
	group by a.`cod_art`, ar.`descri`
	) p
left join (
	select a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, sum(a.`CANTIDAD`) as CANTIDAD
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
-- CONTROL DE PEDIDOS SIN CONTABILIZAR
select p.`IDPEDIDOS`, p.`CODIGO`, p.`FECHA_ENTREGA`, p.`ESTADO`, p.`TIENEFACTURA`, pe.`NOM`, p.`IDMOVIMIENTO`, P.`TOTALIMPORTE`, P.`IMPUESTO`
from pedidos p
left join personacliente pe on p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
where p.`FECHA_ENTREGA` between '2021-02-01' and '2021-02-28'
-- and p.`ESTADO` = "PREPARAR" 
and p.`tipoventa` = 'CREDIT'
and p.`ESTADO` <> 'ANULADO'
;

select *
from pedidos p
where p.`FECHA_ENTREGA` between '2021-01-01' and '2021-01-31'
and p.`tipoventa` = 'CREDIT'
and p.`ESTADO` = 'PREPARAR'
;



-- REPORTE DE REPOSICIONES
select p.`FECHA_ENTREGA` as FECHA, pc.`NOM`, pc.`AP`, pc.`AM`,p.`CODIGO` as COD, a.`cod_art`, ar.`descri`, a.`CANTIDAD`
from articulos_pedido a
left join pedidos p on a.idpedidos = p.`IDPEDIDOS`
left join personacliente pc on p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
where p.`FECHA_ENTREGA` between '2019-10-01' and '2020-01-31'
and p.`IDTIPOPEDIDO` = 4
and P.`ESTADO` <> 'ANULADO'
union
select p.`FECHA_ENTREGA` as FECHA , pc.`NOM`, pc.`AP`, pc.`AM`,p.`CODIGO` as COD, a.`cod_art`, ar.`descri`, a.`REPOSICION` as CANTIDAD
from articulos_pedido a
left join pedidos p on a.idpedidos = p.`IDPEDIDOS`
left join personacliente pc on p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
where p.`FECHA_ENTREGA` between '2019-10-01' and '2020-01-31'
and a.`REPOSICION` > 0
and P.`ESTADO` <> 'ANULADO'
union
select v.`FECHA_PEDIDO` as FECHA, pc.`NOM`, pc.`AP`, pc.`AM`, v.`CODIGO` as COD, a.`cod_art`, ar.`descri`, a.`REPOSICION`  as CANTIDAD
from articulos_pedido a
left join ventadirecta v on a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
left join personacliente pc on v.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
where v.`FECHA_PEDIDO` between '2019-10-01' and '2020-01-31'
and a.`REPOSICION` > 0
and v.`ESTADO` <> 'ANULADO'
;




-- Ventas por tipo de cliente 1
select distinct pe.`IDPERSONACLIENTE`, pe.`NOM`, pe.`AP`, pe.`AM`, pe.`IDTIPOCLIENTE`, t.`NOMBRE`
from pedidos p
left join personacliente pe on p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
left join tipocliente t on pe.`IDTIPOCLIENTE` = t.`IDTIPOCLIENTE`
where p.`FECHA_ENTREGA` >= '2019-01-01'
and p.`IDUSUARIO` in (
446, 443, 441
);

-- Ventas por tipo de cliente 1.1
select distinct pe.`IDPERSONACLIENTE`, pe.`NOM`, pe.`AP`, pe.`AM`, pe.`IDTIPOCLIENTE`, t.`NOMBRE`, a.`cod_art`, ar.`descri`, a.`PRECIO`
from pedidos p
left join personacliente pe on p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
left join tipocliente t on pe.`IDTIPOCLIENTE` = t.`IDTIPOCLIENTE`
left join articulos_pedido a on p.`IDPEDIDOS` = a.`IDPEDIDOS`
left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
where p.`FECHA_ENTREGA` >= '2020-01-01'
and p.`IDUSUARIO` in (446, 443, 441)
and t.`IDTIPOCLIENTE` in (6, 8, 2)
;


-- Ventas Delivery x Cliente
select p.`FECHA_ENTREGA`, pe.`NOM`, pe.`AP`, pe.`AM`, p.`CODIGO`, p.`TOTALIMPORTE`, p.`MONTODIST`
-- , p.`VALORCOMISION` ,p.`IMPUESTO`, p.`OBSERVACION` ,p.`ESTADO`, p.`IDMOVIMIENTO`, p.`id_tmpenc`, p.`iddistribuidor`, pe.`IDTIPOCLIENTE`, t.`NOMBRE`, p.`IDCLIENTE`, e.`tipo_doc`, e.`no_doc`, e.`estado`
from pedidos p
left join personacliente pe on p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
left join tipocliente t on pe.`IDTIPOCLIENTE` = t.`IDTIPOCLIENTE`
left join sf_tmpenc e on p.`id_tmpenc` = e.`id_tmpenc`
where p.`ESTADO` <> 'ANULADO'
and p.`FECHA_ENTREGA` between '2020-06-01' and '2021-02-28'
and p.`tipoventa` = 'CREDIT'
-- and p.`iddistribuidor` is not null
and p.`IDCLIENTE` in (
1864	,1722	,1870	,1724	,1737	,1730	,1733	,1908	,1885	,1741	,1872	,1723	,1873	,1727	,2150	,1854	,1842	,1890	,
1736	,2077	,1729	,1860	, 1914	,1735	,1735	,1739	,1898	,1910	,2076	,1734	,1742	,1859	,2066	,2016	,2092	,2079	
)
;

-- Ventas Delivery x Cliente 2
select pe.`NOM`, pe.`AP`, pe.`AM`, count(p.idpedidos) as RECURRENCIA, sum(p.`TOTALIMPORTE`) as IMPORTE
from pedidos p
left join personacliente pe on p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
left join tipocliente t on pe.`IDTIPOCLIENTE` = t.`IDTIPOCLIENTE`
left join sf_tmpenc e on p.`id_tmpenc` = e.`id_tmpenc`
where p.`ESTADO` <> 'ANULADO'
and p.`FECHA_ENTREGA` between '2021-01-01' and '2021-02-28'
and p.`tipoventa` = 'CREDIT'
-- and p.`iddistribuidor` is not null
and p.`IDCLIENTE` in (
1864	,1722	,1870	,1724	,1737	,1730	,1733	,1908	,1885	,1741	,1872	,1723	,1873	,1727	,2150	,1854	,1842	,1890	,
1736	,2077	,1729	,1860	, 1914	,1735	,1735	,1739	,1898	,1910	,2076	,1734	,1742	,1859	,2066	,2016	,2092	,2079	
)
group by pe.`NOM`, pe.`AP`, pe.`AM`
;

-- Ventas Delivery x Producto
select i.`cod_art`, i.`descri`, sum(a.`CANTIDAD`) as cantidad , sum(a.`IMPORTE`) as total
from pedidos p
left join articulos_pedido a on p.`IDPEDIDOS` = a.`IDPEDIDOS`
left join inv_articulos i on a.`cod_art` = i.`cod_art`
left join personacliente pe on p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
left join tipocliente t on pe.`IDTIPOCLIENTE` = t.`IDTIPOCLIENTE`
where p.`ESTADO` <> 'ANULADO'
and p.`FECHA_ENTREGA` between '2020-06-01' and '2021-02-28'
and p.`tipoventa` = 'CREDIT'
and p.`iddistribuidor` is not null
group by i.`cod_art`, i.`descri`
;

-- Ventas Delivery x Producto RESUMEN
select i.`cod_art`, i.`descri`, sum(a.`CANTIDAD`) as cantidad , sum(a.`IMPORTE`) as total
from pedidos p
left join articulos_pedido a on p.`IDPEDIDOS` = a.`IDPEDIDOS`
left join inv_articulos i on a.`cod_art` = i.`cod_art`
left join personacliente pe on p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
left join tipocliente t on pe.`IDTIPOCLIENTE` = t.`IDTIPOCLIENTE`
where p.`ESTADO` <> 'ANULADO'
and p.`FECHA_ENTREGA` between '2020-06-01' and '2021-02-28'
and p.`tipoventa` = 'CREDIT'
and p.`IDCLIENTE` in (
1864	,1722	,1870	,1724	,1737	,1730	,1733	,1908	,1885	,1741	,1872	,1723	,1873	,1727	,2150	,1854	,1842	,1890	,
1736	,2077	,1729	,1860	, 1914	,1735	,1735	,1739	,1898	,1910	,2076	,1734	,1742	,1859	,2066	,2016	,2092	,2079	
)
group by i.`cod_art`, i.`descri`
;




