-- -------------------
-- PRODUCTOS LACTEOS
-- -------------------
-- ---------------------------------------------------------------
-- ------------- REPORTE 1. VENTAS CLIENTES x PEDIDO (PEDIDOS)-------------
-- ---------------------------------------------------------------
select pc.`IDPERSONACLIENTE` as ID, pc.`NIT`, pc.`NRO_DOC`, CONCAT(pc.`NOM`, ' ', pc.`AP`, ' ', pc.`AM`) as CLIENTE, SUM(a.`IMPORTE`) as TOTAL_BS, COUNT(distinct p.`CODIGO`) as CANT_PEDIDOS
from articulos_pedido a
left join pedidos p on a.idpedidos = p.`IDPEDIDOS`
left join personacliente pc on p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
where p.`FECHA_ENTREGA` between '2019-08-01' and '2019-08-31'
and P.`ESTADO` <> 'ANULADO'
and p.`IDUSUARIO` <> 5
-- AND pc.`NOM` LIKE '%TORRES%'
group by pc.`IDPERSONACLIENTE`, pc.`NIT`, pc.`NRO_DOC`;
-- ---------------------------------------------------

-- --------------------------------------------------------------------------
-- ------------- REPORTE 2. VENTAS CLIENTES x PRODUCTO (PEDIDOS) -------------
-- --------------------------------------------------------------------------
-- SELECT pc.`NOM`, pc.`AP`, pc.`AM`, p.`IDPEDIDOS`, p.`CODIGO` AS COD_PED, a.`IDARTICULOSPEDIDO`, a.`cod_art`, ar.`descri`, a.`CANTIDAD`, a.`REPOSICION`, a.`TOTAL`, p.`ESTADO`, a.`IMPORTE`
select pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, SUM(a.`CANTIDAD`) as CANT_PRODUCTOS, SUM(a.`IMPORTE`) as TOTAL_BS
from articulos_pedido a
left join pedidos p on a.idpedidos = p.`IDPEDIDOS`
left join personacliente pc on p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
where p.`FECHA_ENTREGA` between '2019-08-01' and '2019-08-31'
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
select a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, SUM(a.`CANTIDAD`) as CANT_ARTICULOS, /*SUM(a.total),*/ SUM(a.`IMPORTE`) as TOTAL_BS
from articulos_pedido a
left join pedidos p on a.idpedidos = p.`IDPEDIDOS`
left join personacliente pc on p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
where p.`FECHA_ENTREGA` between '2019-08-01' and '2019-08-31'
and P.`ESTADO` <> 'ANULADO'
and p.`IDUSUARIO` <> 5
and p.`IDTIPOPEDIDO` in (1, 5)
group by a.`cod_art`, ar.`descri`;

-- --------------------------------------------------------------
-- ------------- REPORTE 4. VENTAS x PRODUCTO (CONTADO)-------------
-- --------------------------------------------------------------
-- SELECT pc.`NOM`, pc.`AP`, pc.`AM`, p.`IDPEDIDOS`, p.`CODIGO` AS COD_PED, a.`IDARTICULOSPEDIDO`, a.`cod_art`, ar.`descri`, a.`CANTIDAD`, a.`REPOSICION`, a.`TOTAL`, p.`ESTADO`, a.`IMPORTE`
select a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, SUM(a.`CANTIDAD`) as CANT_ARTICULOS, /*SUM(a.`TOTAL`),*/ SUM(a.`IMPORTE`) as TOTAL_BS
from articulos_pedido a
left join ventadirecta v on a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
left join personacliente pc on v.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
where v.`FECHA_PEDIDO` between '2019-08-01' and '2019-08-31'
and v.`ESTADO` <> 'ANULADO'
-- AND ar.`cuenta_art` = '4420110201'
and v.`IDUSUARIO` <> 5
group by a.`cod_art`, ar.`descri`;

-- ---------------------------------------------------

-- ------------------------------------------------------------------------------
-- ------------- REPORTE 5. VENTAS CLIENTES x Producto (VENTA CONTADO) -------------
-- ------------------------------------------------------------------------------
-- SELECT pc.`NOM`, pc.`AP`, pc.`AM`, p.`IDPEDIDOS`, p.`CODIGO` AS COD_PED, a.`IDARTICULOSPEDIDO`, a.`cod_art`, ar.`descri`, a.`CANTIDAD`, a.`REPOSICION`, a.`TOTAL`, p.`ESTADO`, a.`IMPORTE`
select pc.`NRO_DOC`, pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, SUM(a.`CANTIDAD`) as CANT_PRODUCTOS, SUM(a.`IMPORTE`) as TOTAL_BS
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

-- -------------------------------------------------------------------------------------------------------------

-- ------------------------------------
-- PRODUCTOS VETERINARIOS
-- ------------------------------------
-- ---------------------------------------------------------------
-- ------------- REPORTE 1. VENTAS CLIENTES x PEDIDO (PEDIDOS)-------------
-- ---------------------------------------------------------------
select pc.`IDPERSONACLIENTE` as ID, pc.`NIT`, pc.`NRO_DOC`, CONCAT(pc.`NOM`, ' ', pc.`AP`, ' ', pc.`AM`) as CLIENTE, SUM(a.`IMPORTE`) as TOTAL_BS, COUNT(distinct p.`CODIGO`) as CANT_PEDIDOS
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
select pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, SUM(a.`CANTIDAD`) as CANT_PRODUCTOS, SUM(a.`IMPORTE`) as TOTAL_BS
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
select a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, SUM(a.`CANTIDAD`) as CANT_ARTICULOS, /*SUM(a.total),*/ SUM(a.`IMPORTE`) as TOTAL_BS
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
select a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, SUM(a.`CANTIDAD`) as CANT_ARTICULOS, /*SUM(a.`TOTAL`),*/ SUM(a.`IMPORTE`) as TOTAL_BS
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
select pc.`NRO_DOC`, pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, SUM(a.`CANTIDAD`) as CANT_PRODUCTOS, SUM(a.`IMPORTE`) as TOTAL_BS
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
select a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, SUM(a.`CANTIDAD`) as CANT, SUM(a.`PROMOCION`) as PROMO,  SUM(a.`IMPORTE`) as TOTAL_BS
from articulos_pedido a
left join pedidos p on a.idpedidos = p.`IDPEDIDOS`
left join personacliente pc on p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
where p.`FECHA_ENTREGA` between '2019-09-02' and '2019-09-07'
and P.`ESTADO` <> 'ANULADO'
and p.`IDUSUARIO` <> 5
and p.`IDTIPOPEDIDO` in (1, 5) -- Normal, Desc_Lacteo
and a.`cod_art` in (128, 129, 130, 131, 132)
group by a.`cod_art`, ar.`descri`;

-- AUX ------------------------------------------------------------------
-- ------------- *** REPORTE 4. VENTAS x PRODUCTO (CONTADO)--------------
-- ----------------------------------------------------------------------
select a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, SUM(a.`CANTIDAD`) as CANT_ARTICULOS, SUM(a.`IMPORTE`) as TOTAL_BS
from articulos_pedido a
left join ventadirecta v on a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
left join personacliente pc on v.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
left join inv_articulos ar on a.`cod_art` = ar.`cod_art`
where v.`FECHA_PEDIDO` between '2019-09-02' and '2019-09-07'
and v.`ESTADO` <> 'ANULADO'
and a.`cod_art` in (128, 129, 130, 131, 132)
and v.`IDUSUARIO` <> 5
group by a.`cod_art`, ar.`descri`;

-- AUX
-- --------------------------------------------------------------------------
-- ------------- REPORTE 2. VENTAS CLIENTES x PRODUCTO (PEDIDOS) -------------
-- --------------------------------------------------------------------------
-- SELECT pc.`NOM`, pc.`AP`, pc.`AM`, p.`IDPEDIDOS`, p.`CODIGO` AS COD_PED, a.`IDARTICULOSPEDIDO`, a.`cod_art`, ar.`descri`, a.`CANTIDAD`, a.`REPOSICION`, a.`TOTAL`, p.`ESTADO`, a.`IMPORTE`
select pc.`NOM`, pc.`AP`, pc.`AM`, a.`cod_art` as COD_ART, ar.`descri` as PRODUCTO, SUM(a.`CANTIDAD`) as CANT_PRODUCTOS, SUM(a.`IMPORTE`) as TOTAL_BS
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









