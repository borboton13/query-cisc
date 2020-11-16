-- -------------------
-- PRODUCTOS LACTEOS
-- -------------------
-- ---------------------------------------------------------------
-- ------------- REPORTE 1. VENTAS CLIENTES x PEDIDO (PEDIDOS)-------------
-- ---------------------------------------------------------------
-- select pc.`IDPERSONACLIENTE` as ID, pc.`NIT`, pc.`NRO_DOC`, t.`NOMBRE`, pc.`ESPERSONA`, concat(pc.`NOM`, ' ', pc.`AP`, ' ', pc.`AM`) as CLIENTE, sum(a.`IMPORTE`) as TOTAL_BS, count(distinct p.`CODIGO`) as CANT_PEDIDOS
select pc.`IDPERSONACLIENTE` as ID, pc.`NIT`, pc.`NRO_DOC`, t.`NOMBRE`, pc.`ESPERSONA`, concat(pc.`NOM`, ' ', pc.`AP`, ' ', pc.`AM`) as CLIENTE, sum(a.`IMPORTE`) as TOTAL_BS, count(distinct p.`CODIGO`) as CANT_PEDIDOS
from articulos_pedido a
left join pedidos p on a.idpedidos = p.`IDPEDIDOS`
left join personacliente pc on p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
left join territoriotrabajo t on pc.`IDTERRITORIOTRABAJO` = t.`IDTERRITORIOTRABAJO`
where p.`FECHA_ENTREGA` between '2020-10-01' and '2020-10-31'
and P.`ESTADO` <> 'ANULADO'
and p.`IDUSUARIO` <> 5
and p.`tipoventa` = 'CREDIT'
group by pc.`IDPERSONACLIENTE`, pc.`NIT`, pc.`NRO_DOC`, t.`NOMBRE`, pc.`ESPERSONA`;
-- ---------------------------------------------------

-- --------------------------------------------------------------------------
-- ------------- REPORTE 2. VENTAS CLIENTES x PRODUCTO (PEDIDOS) -------------
-- --------------------------------------------------------------------------
-- SELECT pc.`NOM`, pc.`AP`, pc.`AM`, p.`IDPEDIDOS`, p.`CODIGO` AS COD_PED, a.`IDARTICULOSPEDIDO`, a.`cod_art`, ar.`descri`, a.`CANTIDAD`, a.`REPOSICION`, a.`TOTAL`, p.`ESTADO`, a.`IMPORTE`
select pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, sum(a.`CANTIDAD`) as CANT_PRODUCTOS, sum(a.`IMPORTE`) as TOTAL_BS
from articulos_pedido a
left join pedidos p on a.idpedidos = p.`IDPEDIDOS`
left join personacliente pc on p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
where p.`FECHA_ENTREGA` between '2020-10-01' and '2020-10-31'
and P.`ESTADO` <> 'ANULADO'
and p.`IDUSUARIO` <> 5
and p.`tipoventa` = 'CREDIT'
group by pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art`, ar.`descri`;
-- ---------------------------------------------------


-- -----------------------------------------------------------------
-- ------------- *** REPORTE 3. VENTAS x PRODUCTO (PEDIDOS) -------------
-- -----------------------------------------------------------------
-- SELECT pc.`NOM`, pc.`AP`, pc.`AM`, p.`IDPEDIDOS`, p.`CODIGO` AS COD_PED, a.`IDARTICULOSPEDIDO`, a.`cod_art`, ar.`descri`, a.`CANTIDAD`, a.`REPOSICION`, a.`TOTAL`, p.`ESTADO`, a.`IMPORTE`
select a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, sum(a.`CANTIDAD`) as CANT_ARTICULOS, /*SUM(a.total),*/ sum(a.`IMPORTE`) as TOTAL_BS
from articulos_pedido a
left join pedidos p on a.idpedidos = p.`IDPEDIDOS`
left join personacliente pc on p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
where p.`FECHA_ENTREGA` between '2020-10-01' and '2020-10-31'
and P.`ESTADO` <> 'ANULADO'
and p.`IDUSUARIO` <> 5
and p.`IDTIPOPEDIDO` in (1, 5)
and p.`tipoventa` = 'CREDIT'
group by a.`cod_art`, ar.`descri`;

-- --------------------------------------------------------------
-- ------------- REPORTE 4. VENTAS x PRODUCTO (CONTADO)-------------
-- --------------------------------------------------------------
-- SELECT pc.`NOM`, pc.`AP`, pc.`AM`, p.`IDPEDIDOS`, p.`CODIGO` AS COD_PED, a.`IDARTICULOSPEDIDO`, a.`cod_art`, ar.`descri`, a.`CANTIDAD`, a.`REPOSICION`, a.`TOTAL`, p.`ESTADO`, a.`IMPORTE`
select a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, sum(a.`CANTIDAD`) as CANT_ARTICULOS, /*SUM(a.`TOTAL`),*/ sum(a.`IMPORTE`) as TOTAL_BS
from articulos_pedido a
left join ventadirecta v on a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
left join personacliente pc on v.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
where v.`FECHA_PEDIDO` between '2020-10-01' and '2020-10-31'
and v.`ESTADO` <> 'ANULADO'
-- AND ar.`cuenta_art` = '4420110201'
and v.`IDUSUARIO` <> 5
group by a.`cod_art`, ar.`descri`;

-- REPORTE 4. VENTAS x PRODUCTO (CONTADO)
-- PEDIDOS
select COD_ART, DESCRI, sum(CANT_ARTICULOS) as CANT_ARTICULOS, sum(TOTAL_BS) as TOTAL_BS
from (
	select a.`cod_art`, ar.`descri`, sum(a.`CANTIDAD`) as CANT_ARTICULOS, sum(a.`IMPORTE`) as TOTAL_BS
	from articulos_pedido a
	left join pedidos p on a.idpedidos = p.`IDPEDIDOS`
	left join personacliente pc on p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
	left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
	where p.`FECHA_ENTREGA` between '2020-10-01' and '2020-10-31'
	and P.`ESTADO` <> 'ANULADO'
	and p.`IDUSUARIO` <> 5
	and p.`IDTIPOPEDIDO` in (1, 5)
	and p.`tipoventa` = 'CASH'
	group by a.`cod_art`, ar.`descri`
	union all
	-- VENTADIRECTA
	select a.`cod_art`, ar.`descri`, sum(a.`CANTIDAD`) as CANT_ARTICULOS, sum(a.`IMPORTE`) as TOTAL_BS
	from articulos_pedido a
	left join ventadirecta v on a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
	left join personacliente pc on v.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
	left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
	where v.`FECHA_PEDIDO` between '2020-10-01' and '2020-10-31'
	and v.`ESTADO` <> 'ANULADO'
	and v.`IDUSUARIO` <> 5
	group by a.`cod_art`, ar.`descri`
) v
group by cod_art, descri;

-- ---------------------------------------------------

-- ------------------------------------------------------------------------------
-- ------------- REPORTE 5. VENTAS CLIENTES x Producto (VENTA CONTADO) -------------
-- ------------------------------------------------------------------------------
-- SELECT pc.`NOM`, pc.`AP`, pc.`AM`, p.`IDPEDIDOS`, p.`CODIGO` AS COD_PED, a.`IDARTICULOSPEDIDO`, a.`cod_art`, ar.`descri`, a.`CANTIDAD`, a.`REPOSICION`, a.`TOTAL`, p.`ESTADO`, a.`IMPORTE`
select pc.`NRO_DOC`, pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, sum(a.`CANTIDAD`) as CANT_PRODUCTOS, sum(a.`IMPORTE`) as TOTAL_BS
from articulos_pedido a
left join ventadirecta v on a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
left join personacliente pc on v.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
where v.`FECHA_PEDIDO` between '2020-10-01' and '2020-10-31'
and v.`ESTADO` <> 'ANULADO'
-- AND V.`IDUSUARIO` IN (6, 404)
and v.`IDUSUARIO` <> 5
group by pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art`, ar.`descri`;
-- ---------------------------------------------------

-- REPORTE 5. VENTAS CLIENTES x Producto (VENTA CONTADO)
-- PEDIDOS
select NOM, AP, AM, COD_ART, PRODUCTO, sum(CANT_PRODUCTOS) as CANT_PRODUCTOS, sum(TOTAL_BS) as TOTAL_BS
from (
	select pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, sum(a.`CANTIDAD`) as CANT_PRODUCTOS, sum(a.`IMPORTE`) as TOTAL_BS
	from articulos_pedido a
	left join pedidos p on a.idpedidos = p.`IDPEDIDOS`
	left join personacliente pc on p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
	left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
	where p.`FECHA_ENTREGA` between '2020-10-01' and '2020-10-31'
	and P.`ESTADO` <> 'ANULADO'
	and p.`IDUSUARIO` <> 5
	and p.`tipoventa` = 'CASH'
	group by pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art`, ar.`descri`
	union all
	-- VENTADIRECTA
	select pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, sum(a.`CANTIDAD`) as CANT_PRODUCTOS, sum(a.`IMPORTE`) as TOTAL_BS
	from articulos_pedido a
	left join ventadirecta v on a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
	left join personacliente pc on v.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
	left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
	where v.`FECHA_PEDIDO` between '2020-10-01' and '2020-10-31'
	and v.`ESTADO` <> 'ANULADO'
	and v.`IDUSUARIO` <> 5
	group by pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art`, ar.`descri`
	) v
	group by NOM, AP, AM, COD_ART, PRODUCTO
	;







-- ---------------------------------------------------------------------------------
-- ------------- REPORTE 5.1 VENTAS CLIENTES x VENTAS (Para categorizar) -----------
-- ---------------------------------------------------------------------------------
select pc.`NRO_DOC`, concat(pc.`NOM`,' ', pc.`AP`, ' ', pc.`AM`) as nombre , sum(a.`IMPORTE`) as TOTAL_BS, count(v.`IDVENTADIRECTA`) as NRO_VENTAS
from articulos_pedido a
left join ventadirecta v on a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
left join personacliente pc on v.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
where v.`FECHA_PEDIDO` between '2020-07-01' and '2020-07-30'
and v.`ESTADO` <> 'ANULADO'
-- AND V.`IDUSUARIO` IN (6, 404)
and v.`IDUSUARIO` <> 5
group by pc.`NOM`, pc.`AP`, pc.`AM`;
-- ---------------------------------------------------

-- ---------------------------------------------------------------
-- ------------- REPORTE 6 VENTAS CLIENTES x PEDIDO (PEDIDOS DELIVERY)-------------
-- ---------------------------------------------------------------
select pc.`IDPERSONACLIENTE` as ID, pc.`NIT`, pc.`NRO_DOC`, concat(pc.`NOM`, ' ', pc.`AP`, ' ', pc.`AM`) as CLIENTE, sum(a.`IMPORTE`) as TOTAL_BS, count(distinct p.`CODIGO`) as CANT_PEDIDOS
from articulos_pedido a
left join pedidos p on a.idpedidos = p.`IDPEDIDOS`
left join personacliente pc on p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
where p.`FECHA_ENTREGA` between '2020-10-01' and '2020-10-31'
and P.`ESTADO` <> 'ANULADO'
and p.`IDUSUARIO` <> 5
and pc.`IDTERRITORIOTRABAJO` in (19, 20)
group by pc.`IDPERSONACLIENTE`, pc.`NIT`, pc.`NRO_DOC`;
-- ---------------------------------------------------


-- -------------------------------------------------------------------------------------------------------------

-- ------------------------------------
-- PRODUCTOS VETERINARIOS
-- ------------------------------------
-- ---------------------------------------------------------------
-- ------------- REPORTE 1. VENTAS CLIENTES x PEDIDO (PEDIDOS)-------------
-- ---------------------------------------------------------------
select pc.`IDPERSONACLIENTE` as ID, pc.`NIT`, pc.`NRO_DOC`, concat(pc.`NOM`, ' ', pc.`AP`, ' ', pc.`AM`) as CLIENTE, sum(a.`IMPORTE`) as TOTAL_BS, count(distinct p.`CODIGO`) as CANT_PEDIDOS
from articulos_pedido a
left join pedidos p on a.idpedidos = p.`IDPEDIDOS`
left join personacliente pc on p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
where p.`FECHA_ENTREGA` between '2019-01-01' and '2019-01-31'
and P.`ESTADO` <> 'ANULADO'
and p.`IDUSUARIO` = 5
group by pc.`IDPERSONACLIENTE`, pc.`NIT`, pc.`NRO_DOC`;
-- ---------------------------------------------------

-- --------------------------------------------------------------------------
-- ------------- REPORTE 2. VENTAS CLIENTES x PRODUCTO (PEDIDOS) -------------
-- --------------------------------------------------------------------------
-- SELECT pc.`NOM`, pc.`AP`, pc.`AM`, p.`IDPEDIDOS`, p.`CODIGO` AS COD_PED, a.`IDARTICULOSPEDIDO`, a.`cod_art`, ar.`descri`, a.`CANTIDAD`, a.`REPOSICION`, a.`TOTAL`, p.`ESTADO`, a.`IMPORTE`
select pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, sum(a.`CANTIDAD`) as CANT_PRODUCTOS, sum(a.`IMPORTE`) as TOTAL_BS
from articulos_pedido a
left join pedidos p on a.idpedidos = p.`IDPEDIDOS`
left join personacliente pc on p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
where p.`FECHA_ENTREGA` between '2019-03-01' and '2019-03-31'
and P.`ESTADO` <> 'ANULADO'
and p.`IDUSUARIO` <> 5
-- AND p.`IDCLIENTE` = 165
-- AND pc.`NOM` LIKE '%TORRES%'
group by pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art`, ar.`descri`;
-- ---------------------------------------------------


-- -----------------------------------------------------------------
-- ------------- *** REPORTE 3. VENTAS x PRODUCTO (PEDIDOS) -------------
-- -----------------------------------------------------------------
-- SELECT pc.`NOM`, pc.`AP`, pc.`AM`, p.`IDPEDIDOS`, p.`CODIGO` AS COD_PED, a.`IDARTICULOSPEDIDO`, a.`cod_art`, ar.`descri`, a.`CANTIDAD`, a.`REPOSICION`, a.`TOTAL`, p.`ESTADO`, a.`IMPORTE`
select a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, sum(a.`CANTIDAD`) as CANT_ARTICULOS, /*SUM(a.total),*/ sum(a.`IMPORTE`) as TOTAL_BS
from articulos_pedido a
left join pedidos p on a.idpedidos = p.`IDPEDIDOS`
left join personacliente pc on p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
where p.`FECHA_ENTREGA` between '2019-04-01' and '2019-04-30'
and P.`ESTADO` <> 'ANULADO'
and p.`IDUSUARIO` = 5
and p.`IDTIPOPEDIDO` in (1, 6)
group by a.`cod_art`, ar.`descri`;

-- --------------------------------------------------------------
-- ------------- *** REPORTE 4. VENTAS x PRODUCTO (CONTADO)-------------
-- --------------------------------------------------------------
-- SELECT pc.`NOM`, pc.`AP`, pc.`AM`, p.`IDPEDIDOS`, p.`CODIGO` AS COD_PED, a.`IDARTICULOSPEDIDO`, a.`cod_art`, ar.`descri`, a.`CANTIDAD`, a.`REPOSICION`, a.`TOTAL`, p.`ESTADO`, a.`IMPORTE`
select a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, sum(a.`CANTIDAD`) as CANT_ARTICULOS, /*SUM(a.`TOTAL`),*/ sum(a.`IMPORTE`) as TOTAL_BS
from articulos_pedido a
left join ventadirecta v on a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
left join personacliente pc on v.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
where v.`FECHA_PEDIDO` between '2019-08-01' and '2019-08-31'
and v.`ESTADO` <> 'ANULADO'
and v.`IDUSUARIO` = 5
group by a.`cod_art`, ar.`descri`;

-- ---------------------------------------------------

-- ------------------------------------------------------------------------------
-- ------------- REPORTE 5. VENTAS CLIENTES x Producto (VENTA CONTADO) -------------
-- ------------------------------------------------------------------------------
-- SELECT pc.`NOM`, pc.`AP`, pc.`AM`, p.`IDPEDIDOS`, p.`CODIGO` AS COD_PED, a.`IDARTICULOSPEDIDO`, a.`cod_art`, ar.`descri`, a.`CANTIDAD`, a.`REPOSICION`, a.`TOTAL`, p.`ESTADO`, a.`IMPORTE`
select pc.`NRO_DOC`, pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, sum(a.`CANTIDAD`) as CANT_PRODUCTOS, sum(a.`IMPORTE`) as TOTAL_BS
from articulos_pedido a
left join ventadirecta v on a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
left join personacliente pc on v.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
where v.`FECHA_PEDIDO` between '2019-08-01' and '2019-08-31'
and v.`ESTADO` <> 'ANULADO'
-- AND V.`IDUSUARIO` IN (6, 404)
and v.`IDUSUARIO` <> 5
group by pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art`, ar.`descri`;
-- ---------------------------------------------------



-- AUX
-- -----------------------------------------------------------------
-- ------------- *** REPORTE 3. VENTAS x PRODUCTO (PEDIDOS) -------------
-- -----------------------------------------------------------------
select a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, sum(a.`CANTIDAD`) as CANT, /*SUM(a.`PROMOCION`) AS PROMO,*/  sum(a.`IMPORTE`) as TOTAL_BS
from articulos_pedido a
left join pedidos p on a.idpedidos = p.`IDPEDIDOS`
left join personacliente pc on p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
where p.`FECHA_ENTREGA` between '2019-01-01' and '2019-06-31'
and P.`ESTADO` <> 'ANULADO'
and p.`IDUSUARIO` <> 5
and p.`IDTIPOPEDIDO` in (1, 5) -- Normal, Desc_Lacteo
and a.`cod_art` in (128, 129, 130, 131, 132)
group by a.`cod_art`, ar.`descri`;

-- AUX ------------------------------------------------------------------
-- ------------- *** REPORTE 4. VENTAS x PRODUCTO (CONTADO)--------------
-- ----------------------------------------------------------------------
select a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, sum(a.`CANTIDAD`) as CANT_ARTICULOS, sum(a.`IMPORTE`) as TOTAL_BS
from articulos_pedido a
left join ventadirecta v on a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
left join personacliente pc on v.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
where v.`FECHA_PEDIDO` between '2019-10-07' and '2019-10-12'
and v.`ESTADO` <> 'ANULADO'
and a.`cod_art` in (128, 129, 130, 131, 132)
and v.`IDUSUARIO` <> 5
group by a.`cod_art`, ar.`descri`;

-- *** CONTADO: CANTIDAD PRODUCTOS X DIA
select v.`FECHA_PEDIDO`, a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, sum(a.`CANTIDAD`) as CANT_ARTICULOS
from articulos_pedido a
left join ventadirecta v on a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
left join personacliente pc on v.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
where v.`FECHA_PEDIDO` between '2019-09-01' and '2019-09-07'
and v.`ESTADO` <> 'ANULADO'
and v.`IDUSUARIO` <> 5
group by v.`FECHA_PEDIDO`, a.`cod_art`, ar.`descri`;

-- *** CREDITO: CANTIDAD PRODUCTOS X DIA
select P.`FECHA_ENTREGA`, a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, sum(a.`CANTIDAD`) as CANTIDAD
from articulos_pedido a
left join pedidos p on a.idpedidos = p.`IDPEDIDOS`
left join personacliente pc on p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
where p.`FECHA_ENTREGA` between '2019-09-01' and '2019-09-07'
and P.`ESTADO` <> 'ANULADO'
and p.`IDUSUARIO` <> 5
and p.`IDTIPOPEDIDO` in (1, 5) -- Normal, Desc_Lacteo
and p.`IDCLIENTE` not in (911,1463,1468,1464,1472,1557,1466,1465) -- sin SEDEM
-- AND a.`cod_art` IN (128, 129, 130, 131, 132)
group by P.`FECHA_ENTREGA`, a.`cod_art`, ar.`descri`;

-- AUX
-- --------------------------------------------------------------------------
-- ------------- REPORTE 2. VENTAS CLIENTES x PRODUCTO (PEDIDOS) -------------
-- --------------------------------------------------------------------------
-- SELECT pc.`NOM`, pc.`AP`, pc.`AM`, p.`IDPEDIDOS`, p.`CODIGO` AS COD_PED, a.`IDARTICULOSPEDIDO`, a.`cod_art`, ar.`descri`, a.`CANTIDAD`, a.`REPOSICION`, a.`TOTAL`, p.`ESTADO`, a.`IMPORTE`
select pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, sum(a.`CANTIDAD`) as CANT_PRODUCTOS, sum(a.`IMPORTE`) as TOTAL_BS
from articulos_pedido a
left join pedidos p on a.idpedidos = p.`IDPEDIDOS`
left join personacliente pc on p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
where p.`FECHA_ENTREGA` between '2019-05-01' and '2019-05-31'
and P.`ESTADO` <> 'ANULADO'
and p.`IDUSUARIO` <> 5
-- and p.`IDCLIENTE` in (911	,1463	,1464	,1465	,1466	,1468	,1472	,1557	) -- SEDEM
and A.`cod_art` in (808)
group by pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art`, ar.`descri`;
-- ---------------------------------------------------



-- --------------------------------------------------------------------------
-- ------------- REPORTE ANUAL. VENTAS CLIENTES x PRODUCTO (SEMAPA) -------------
-- --------------------------------------------------------------------------
select p.`FECHA_ENTREGA`, pc.`NOM`, a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, p.`CODIGO`, p.`IDMOVIMIENTO`, M.`NROFACTURA`, sum(a.`CANTIDAD`) as CANT_PRODUCTOS, sum(a.`IMPORTE`) as TOTAL_BS
from articulos_pedido a
left join pedidos p on a.idpedidos = p.`IDPEDIDOS`
left join personacliente pc on p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
left join movimiento m on p.`IDMOVIMIENTO` = m.`IDMOVIMIENTO`
where p.`FECHA_ENTREGA` between '2019-01-01' and '2019-12-31'
and P.`ESTADO` <> 'ANULADO'
and p.`IDUSUARIO` <> 5
-- AND p.`IDCLIENTE` = 165
and pc.`NOM` like '%SEMAPA%'
group by p.`FECHA_ENTREGA`, pc.`NOM`, a.`cod_art`, ar.`descri`, p.`CODIGO`, p.`IDMOVIMIENTO`, M.`NROFACTURA`;
-- ---------------------------------------------------

select *
from personacliente p
where p.`NOM` like '%SEDEM%'
;

-- VENTAS
select month(v.`FECHA`) as mes, v.`cod_art`, a.`descri`, sum(v.`CANTIDAD`) as cantidad, sum(v.`importe`) as montobs
from ventas v
left join inv_articulos a on v.`cod_art` = a.`cod_art`
where v.`FECHA` between '2019-01-01' and '2019-12-31'
and v.`idusuario` <> 5
group by mes, v.`cod_art`, a.`descri`
;

-- Reporte general ventas x Producto x Cantidad x Monto
select v.`cod_art`, a.`descri`, sum(v.`CANTIDAD`) as cantidad, sum(v.`importe`) as montobs
from ventas v
left join inv_articulos a on v.`cod_art` = a.`cod_art`
where v.`FECHA` between '2019-01-01' and '2019-12-31'
and v.`idusuario` <> 5
and v.`idtipopedido` in (1, 5)
group by v.`cod_art`, a.`descri`
;

-- Reporte ventas x Tipo Cliente x Cantidad x Monto
select t.`IDTIPOCLIENTE`, t.`NOMBRE`, sum(v.`CANTIDAD`) as cantidad, sum(v.`importe`) as montobs
from ventas v
left join inv_articulos a on v.`cod_art` = a.`cod_art`
left join personacliente p on v.`idcliente` = p.`IDPERSONACLIENTE`
left join tipocliente t on p.`IDTIPOCLIENTE` = t.`IDTIPOCLIENTE`
where v.`FECHA` between '2019-01-01' and '2019-12-31'
and v.`idusuario` <> 5
and v.`idtipopedido` in (1, 5)
-- and v.`idcliente` in (911,1463,1464,1465,1466,1468,1472,1557) -- sedem
-- and v.`idcliente` in (176,177,178,405,444,731,732,733,734,735,736,737,934) -- Hipermaxi
-- AND V.`idcliente` IN (174,175) -- ICNORTE
-- AND v.`idcliente` in (363, 460) -- Desayuno
and v.`IDVENTADIRECTA` is not null -- contado
-- AND t.`IDTIPOCLIENTE` in (5, 11)
group by t.`IDTIPOCLIENTE`, t.`NOMBRE`
;


select p.`IDPERSONACLIENTE` as id, concat(p.`NOM`, ' ', p.`AP`, ' ', p.`AM`) as cliente,  sum(v.`CANTIDAD`) as cantidad, sum(v.`importe`) as montobs
from ventas v
left join inv_articulos a on v.`cod_art` = a.`cod_art`
left join personacliente p on v.`idcliente` = p.`IDPERSONACLIENTE`
left join tipocliente t on p.`IDTIPOCLIENTE` = t.`IDTIPOCLIENTE`
where v.`FECHA` between '2019-01-01' and '2019-12-31'
and v.`idusuario` <> 5
and v.`idtipopedido` in (1, 5)
and v.`IDVENTADIRECTA` is null
and t.`IDTIPOCLIENTE` not in (2, 6, 8, 13)
group by id, cliente
;



-- Reporte de Botellas 2L x Mes
select month(v.`FECHA`) as mes, sum(v.`CANTIDAD`) as cantidad, sum(v.`importe`) as montobs
from ventas v
left join inv_articulos a on v.`cod_art` = a.`cod_art`
where v.`FECHA` between '2019-01-01' and '2019-12-31'
and v.`idusuario` <> 5
and v.`idtipopedido` in (1, 5)
and v.`cod_art` in (128, 129, 130, 131, 132)
group by mes
;


-- Reporte ventas Queso SUBSIDIO
select month(v.`FECHA`) as mes, p.`NOM`,  v.`cod_art`, a.`descri`, sum(v.`CANTIDAD`) as cantidad, sum(v.`importe`) as montobs
from ventas v
left join inv_articulos a  on v.`cod_art` = a.`cod_art`
left join personacliente p on v.`idcliente` = p.`IDPERSONACLIENTE`
where v.`FECHA` between '2019-01-01' and '2019-12-31'
and v.`idusuario` <> 5
and v.`idtipopedido` in (1, 5)
and v.`cod_art` in (148, 150)
and v.`idcliente` in (911,1463,1464,1465,1466,1468,1472,1557)
group by mes, p.`NOM`, v.`cod_art`, a.`descri`
;


-- Revision de Ventas por cliente
select p.`FECHA_ENTREGA`, p.`ESTADO`, p.`CODIGO`, pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, sum(a.`CANTIDAD`) as CANT_PRODUCTOS, sum(a.`IMPORTE`) as TOTAL_BS
from articulos_pedido a
left join pedidos p on a.idpedidos = p.`IDPEDIDOS`
left join personacliente pc on p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
where p.`FECHA_ENTREGA` between '2020-07-01' and '2020-07-31'
and P.`ESTADO` <> 'ANULADO'
and p.`IDUSUARIO` <> 5
and p.`IDCLIENTE` in (66)
group by p.`FECHA_ENTREGA`, p.`ESTADO`, p.`CODIGO`, pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art`, ar.`descri`;


select pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, sum(a.`CANTIDAD`) as CANT_PRODUCTOS, sum(a.`IMPORTE`) as TOTAL_BS
from articulos_pedido a
left join pedidos p on a.idpedidos = p.`IDPEDIDOS`
left join personacliente pc on p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
where p.`FECHA_ENTREGA` between '2020-08-01' and '2020-08-31'
and P.`ESTADO` <> 'ANULADO'
and p.`IDUSUARIO` <> 5
and p.`IDCLIENTE` in (66)
group by pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art`, ar.`descri`;



