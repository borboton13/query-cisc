-- - 
select 	e.`id_tmpenc`, d.`id_tmpdet`, e.`fecha`, e.`tipo_doc` as tipo, E.`no_doc`, d.`no_trans`,  e.`glosa`,  e.`cod_prov`, 
	d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, D.`idcuenta`, d.`idmovimiento`, d.`iddocumentocompra`,
	d.`tc`, d.`moneda`, d.`debeme`, d.`haberme`, 
	d.`id_tmpenc`, e.`estado`, d.`cod_prov`, d.`cod_art`, d.`cant_art`, d.`idpersonacliente`, d.`idcredito`
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
left join arcgms a    on d.`cuenta` = a.`cuenta`
-- WHERE d.`id_tmpenc` = 29504
where d.`id_tmpenc` in (
166265
) 
-- where e.`tipo_doc` = 'IA' and e.`no_doc` in (236)
;



delete from sf_tmpdet where id_tmpenc in (
4325, 4326
);

delete from sf_tmpenc where id_tmpenc in (
4325, 4326
);


select *
from inv_vales i
-- update inv_vales i set i.`idtmpenc` = null
where i.`idtmpenc` in (

);


delete from sf_tmpdet where id_tmpdet in (

);




select *
from sf_tmpdet d 
where d.`id_tmpdet` > 15249
;


select *
from sf_tmpenc e 
where e.`tipo_doc` = 'CV'
and E.`no_doc` = 47
and e.`fecha` >= '2020-10-01'
;


-- -----------------------
--
-- Detalle por TipoDoc
select e.`id_tmpenc`, e.`no_trans`, d.`id_tmpdet`, e.`fecha`, e.`tipo_doc` as tipo, E.`no_doc`, d.`no_trans`,  e.`glosa`, e.`cod_prov`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, d.`tc`, d.`debeme`, d.`haberme`,
d.`id_tmpenc`, e.`estado`, d.`idcuenta`, d.`idcredito`,
d.`idpersonacliente`, d.`cod_prov`, d.`cod_art`, d.`cant_art`
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
left join arcgms a    on d.`cuenta` = a.`cuenta`
where e.`fecha` between '2020-01-01' and '2020-12-31'
-- and e.`estado` <> 'ANL'
-- where d.`debe` = 0 and d.`haber` = 0
-- and d.`id_tmpenc` = 137259
-- and e.`tipo_doc` = 'CB'
and d.`cuenta` = '1810310100'
-- and e.`no_doc` in (1)
-- and e.`glosa` like '%SUELDOS%'
-- and d.`cod_art`in (277)
-- and d.`idsocio` = 
;



-- Detalle por TipoDoc
select e.`id_tmpenc`, e.`no_trans`, d.`id_tmpdet`, e.`fecha`, e.`tipo_doc` as tipo, e.`no_doc`,  s.`nombres`, s.`apellidopaterno`, c.`codigoant`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`,  /*d.`tc`, d.`debeme`, d.`haberme`,*/
e.`estado`, d.`idcredito`
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
left join arcgms a    on d.`cuenta` = a.`cuenta`
left join credito c   on d.`idcredito` = c.`idcredito`
left join socio s     on c.`idsocio` = s.`idsocio`
where e.`estado` <> 'ANL'
-- where d.`debe` = 0 and d.`haber` = 0
-- and d.`id_tmpenc` = 137259
and e.`tipo_doc` = 'CB'
-- and d.`cuenta` = '1310510600'
and e.`no_doc` in (74)
-- and e.`glosa` like '%SUELDOS%'
-- and d.`cod_art`in (118)
-- and d.`idsocio` = 
and e.`fecha` between '2020-01-01' and '2020-12-31'
;




update sf_tmpenc e set e.`estado` = 'PEN'
where e.`id_tmpenc` in (
157479
);

-- update sf_tmpdet d set d.`cuenta` = '1810310301' where d.`id_tmpdet` = 880271;

-- update sf_tmpenc e set e.`estado` = 'PEN' where e.`id_tmpenc` in (141845);
-- update sf_tmpdet d set d.`cuenta` = '4430110300'  where d.`id_tmpdet` = 71025;
-- update sf_tmpdet d set d.`cod_art` = 73, d.`cant_art` = 481.03  where d.`id_tmpdet` = 898302;

-- update sf_tmpdet d set d.`haber` =  where d.`id_tmpdet` = 6067;
-- update sf_tmpdet d set d.`haber` =  where d.`id_tmpdet` = 6068;

select *
from ventadirecta v
where v.`FECHA_PEDIDO` between '2020-01-01' and '2020-12-31'
and v.`CODIGO` = 15291
;


select *
from ventadirecta v
where v.`IDUSUARIO` = 6;

-- update sf_tmpdet d set d.`idpersonacliente` = 1510 where d.`id_tmpdet` = 659725;
-- update sf_tmpdet d set d.`cuenta` = '1420710000' where d.`id_tmpdet` = 663653; -- Cuenta Credito Fiscal
-- update sf_tmpdet d SET d.`id_tmpenc` = 106270 where d.`id_tmpdet` in (11778	,11779	,11780	,11781	,11782	,11783	,11784	,11785	,11786	,11787	);
update sf_tmpenc e set e.`estado` = 'APR' where e.`id_tmpenc` in (128114);


-- PARA REVISION DE DOCUMENTOS
select e.`id_tmpenc`, e.`no_trans`, e.`fecha`, e.`tipo_doc`, e.`no_doc`, e.`estado`, e.`glosa`, e.`ndoc`
from sf_tmpenc e
where e.`tipo_doc` = 'CE'
;

-- SOCIOS NUEVOS
select e.`id_tmpenc`, d.`id_tmpdet`, e.`fecha`, e.`tipo_doc` as tipo, e.`no_doc`,  e.`glosa`,  d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, 
d.`id_tmpenc`, e.`estado`, d.`idsocio`, s.`noidentificacion`, s.`nombres`, s.`apellidopaterno`, s.`apellidomaterno`
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
left join arcgms a    on d.`cuenta` = a.`cuenta`
left join socio s     on d.`idsocio` = s.`idsocio`
where e.`tipo_doc` = 'CI'
and d.`cuenta` = '3110100000'
and e.`fecha` between '2019-01-01' and '2019-08-30'
-- and e.`glosa` like "%nuev%" 
;


-- Detalle por Glosa
select e.`id_tmpenc`, d.`id_tmpdet`, e.`fecha`, e.`tipo_doc` as tipo, e.`no_doc`, d.`no_trans`,  e.`glosa`,  e.`cod_prov`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, d.`id_tmpenc`, e.`estado`, 
-- d.`idpersonacliente`, d.`cod_prov`
d.`idcuenta`
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
left join arcgms a    on d.`cuenta` = a.`cuenta`
where e.`fecha` between '2019-01-01' and '2019-01-31'
-- AND e.`glosa` LIKE '%RECEPCION%ALM PRODUCTOS TERMINADOS)%'
-- AND e.`glosa` LIKE '%CONSUMO, EGRESO, ALMACEN (ALM INSUMOS DE PRODUCCION)%'
-- AND e.`glosa` LIKE '%CONSUMO, EGRESO, ALMACEN (ALM MATERIALES DE PRODUCCION)%'
and d.`cuenta` = 2120110100
and d.`idcuenta` = 2065
-- AND e.`estado` <> 'ANL'
;

-- Detalle por Glosa 2
select e.`id_tmpenc`, d.`id_tmpdet`, e.`fecha`, e.`tipo_doc` as tipo, E.`no_doc`, d.`no_trans`,  e.`glosa`,  e.`cod_prov`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, d.`id_tmpenc`, e.`estado`, d.`idpersonacliente`, d.`cod_prov`
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
left join arcgms a    on d.`cuenta` = a.`cuenta`
where e.`tipo_doc` = 'IA'
-- AND e.`glosa` LIKE '%RECEPCIÓN, RECEPCION, ALMACEN (ALM MATERIALES DE PRODUCCION),%'
-- AND e.`glosa` LIKE '%CONSUMO, EGRESO, ALMACEN (ALM MATERIALES DE PRODUCCION)%'
-- AND e.`glosa` LIKE '%, SEPTIEMBRE, IOC CISC-INV-%'
and e.`fecha` between '2016-09-01' and '2016-09-30'
and e.`estado` <> 'ANL'
;

select 	v.`fecha`, v.`no_vale`, v.`no_trans`, v.`estado`, m.`fecha_cre`, m.`fecha_mov`, d.`cod_art`, a.`descri`,
	d.`cantidad`, d.`costounitario`, d.`preciounitcompra`, d.`monto`, m.`descri`
from inv_vales v
left join inv_mov m 		on v.`no_trans` = m.`no_trans`
left join inv_movdet d 		on v.`no_trans` = d.`no_trans`
left join inv_articulos a 	on d.`cod_art`  = a.`cod_art`
-- where v.`no_vale` = '1-220'
-- where m.`fecha_mov` between '2016-05-01' and '2016-05-31'
where v.`cod_doc` = 'EGR'
-- and v.`cod_alm` = 1
;

-- -----------------------------
-- CHECKANDO ASIENTOS
-- -----------------------------
select d.`id_tmpenc`, d.`id_tmpdet`, e.`fecha`, e.`tipo_doc`, e.`no_doc`, e.`estado`, e.`glosa`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, d.`cod_prov`, d.`idpersonacliente`
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
left join arcgms a    on d.`cuenta` = a.`cuenta`
-- WHERE d.`id_tmpenc` = 2
where d.`cuenta` = '1000000000'
-- AND d.`idpersonacliente` IS NULL
and e.`fecha` between '2019-02-01' and '2019-02-28'
-- AND e.`estado` <> 'ANL'
;


-- MAYOR CAJA GENERAL + VENTA CONTADO
select e.`id_tmpenc`, d.`id_tmpdet`, e.`fecha`, e.`tipo_doc`, e.`no_doc`, e.`glosa`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, v.`IDVENTADIRECTA`, v.`CODIGO`, v.`IDMOVIMIENTO`, m.`NROFACTURA`, m.`FECHA_FACTURA`
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
left join arcgms a    on d.`cuenta` = a.`cuenta`
left join ventadirecta v on e.`id_tmpenc` = v.`id_tmpenc`
left join movimiento m   on v.`IDMOVIMIENTO` = m.`IDMOVIMIENTO`
where d.`cuenta` = '1110110100'
and e.`estado` <> 'ANL'
and e.`fecha` between '2018-11-01' and '2018-11-30'
;



-- 


-- RESUMEN DE RECAUDACION
-- SELECT e.`fecha`, d.`id_tmpdet`, e.`tipo_doc`, e.`no_doc`, e.`no_trans`, e.`glosa`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, d.`no_trans`, d.`id_tmpenc`
-- SELECT e.`fecha`, e.`tipo_doc`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`
select /*e.`fecha`, e.`tipo_doc`,*/ d.`cuenta`, a.`descri`, sum(d.`debe`) as DEBE, sum(d.`haber`) as haber
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
left join arcgms a    on d.`cuenta` = a.`cuenta`
where e.`tipo_doc` = 'CI'
-- where (d.`cuenta` = '1110110100' or e.`tipo_doc` = 'CI')
and e.`fecha` between '2015-12-16' and '2015-12-16'
and e.`estado` <> 'ANL'
group by /*e.`fecha`, e.`tipo_doc`,*/ d.`cuenta`, a.`descri`
;

select *
from sf_tmpenc e
join sf_tmpdet d on e.`id_tmpenc` = d.`id_tmpenc`
join arcgms a    on d.`cuenta` = a.`cuenta`
where e.`fecha` between '2015-12-16' and '2015-12-16'
and e.`tipo_doc` = 'CI'
-- and e.`estado` <> 'ANL'
;

-- ASIENTOS - ORDENES DE COMPRA
-- SELECT e.`fecha`, d.`id_tmpdet`, e.`tipo_doc`, e.`no_doc`, e.`no_trans`, e.`glosa`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, d.`no_trans`, d.`id_tmpenc`
select e.`fecha`, e.`tipo_doc`, d.`id_tmpenc`, d.`cuenta`, a.`descri`, e.`descri`, d.`debe`, d.`haber`, e.cod_prov
-- SELECT d.`cuenta`, a.`descri`, SUM(d.`debe`) AS DEBE, SUM(d.`haber`) AS haber
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
left join arcgms a    on d.`cuenta` = a.`cuenta`
where e.cod_prov is not null
-- AND e.`cod_prov` = 9
-- where (d.`cuenta` = '1110110100' or e.`tipo_doc` = 'CI')
and e.`fecha` between '2016-01-01' and '2016-01-30'
-- AND e.`estado` <> 'ANL'
-- and d.`cuenta` = '2420910300'
-- GROUP BY d.`cuenta`, a.`descri`
;


select *
from sf_tmpdet d
where d.`cuenta` = '1000000000'
;

/** MAYORIZANDO **/
select d.`cuenta`, a.`descri`, sum(d.`debe`) as TOTAL_D, sum(d.`haber`) as TOTAL_H
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
left join arcgms a    on d.`cuenta` = a.`cuenta`
where e.`fecha` between '2018-08-01' and '2018-08-15'
and e.`estado` <> 'ANL'
group by d.`cuenta`, a.`descri`
;

select e.`fecha`, d.`cuenta`,  a.`descri`, e.`tipo_doc`, e.`no_doc`, e.`glosa`, d.`debe`, d.`haber`
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
left join arcgms a    on d.`cuenta` = a.`cuenta`
where e.`fecha` between '2019-01-01' and '2019-12-31'
and e.`estado` <> 'ANL'
order by d.`cuenta`, e.`fecha`
;



-- -----------------------------------------------------------
-- -----------------------------------------------------------

-- ---------------------------------------------------------------------------------
-- DIFERENCIAS
-- ---------------------------------------------------------------------------------
-- CREATE VIEW diferencias AS (
select e.`fecha`, e.`id_tmpenc`, e.`tipo_doc`, e.`no_doc`, e.`glosa`, sum(d.`debe`) as totald, sum(d.`haber`) as totalh, (sum(d.`debe`) - sum(d.`haber`)) as dif
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
left join arcgms a    on d.`cuenta` = a.`cuenta`
where e.`fecha` between '2020-01-01' and '2020-12-31'
and e.`estado` <> 'ANL'
-- AND e.`tipo_doc` IN ('CI', 'CV', 'NE')
-- AND e.`tipo_doc` IN ('CV')
-- AND a.`cta_niv3` = '4420000000'
group by e.`fecha`, e.`id_tmpenc`, e.`tipo_doc`, e.`no_doc`, e.`glosa`
-- )
;


select e.`fecha`, e.`id_tmpenc`, e.`tipo_doc`, e.`no_doc`, sum(d.`debe`) as totald, sum(d.`haber`) as totalh, (sum(d.`debe`) - sum(d.`haber`)) as dif,
e.`glosa`
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
left join arcgms a    on d.`cuenta` = a.`cuenta`
where e.`fecha` between '2019-08-01' and '2019-08-31'
and e.`estado` <> 'ANL'
-- AND e.`tipo_doc` IN ('CD')
and a.`cta_niv3` = '4460000000'
group by e.`fecha`, e.`id_tmpenc`, e.`tipo_doc`, e.`no_doc`
-- )
;


select e.`fecha`, e.`id_tmpenc`, e.`tipo_doc`, e.`no_doc`, sum(d.`debe`) as totald, sum(d.`haber`) as totalh, (sum(d.`debe`) - sum(d.`haber`)) as dif
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
left join arcgms a    on d.`cuenta` = a.`cuenta`
where e.`fecha` between '2017-12-01' and '2017-12-31'
and e.`estado` <> 'ANL'
-- AND e.`tipo_doc` IN ('CI', 'CV', 'NE')
-- AND e.`tipo_doc` IN ('NE')
group by e.`fecha`, e.`id_tmpenc`, e.`tipo_doc`, e.`no_doc`
;


select v.`IDVENTADIRECTA`, v.`FECHA_PEDIDO`, v.`CODIGO`, v.`ESTADO`, v.`TOTALIMPORTE`, v.`IMPUESTO`, v.`IDMOVIMIENTO`, v.`id_tmpenc`, v.`id_tmpenc_cv`, v.`IDUSUARIO`
from ventadirecta v
where v.`FECHA_PEDIDO` between '2016-05-01' and '2016-05-31'
;


-- Ventas
select * 
from ventadirecta v
where v.`FECHA_PEDIDO` between '2016-05-01' and '2016-08-07'
and v.`IDMOVIMIENTO` is not null
and v.`ESTADO` <> 'ANULADO'
;

-- Pedidos
select *
from pedidos p
where p.`FECHA_ENTREGA` between '2016-05-01' and '2016-08-11'
-- AND p.`IDMOVIMIENTO` IS NOT NULL
and p.`ESTADO` <> 'ANULADO'
and p.`VALORCOMISION` > 0
;


-- 
select e.`id_tmpenc`, d.`id_tmpdet`, e.`fecha`, e.`tipo_doc` as tipo, E.`no_doc`, d.`no_trans`, /*e.`glosa`,*/ e.`cod_prov`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, d.`id_tmpenc`, e.`estado`, d.`idpersonacliente`, d.`cod_prov`
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
left join arcgms a    on d.`cuenta` = a.`cuenta`
where e.`tipo_doc` = 'TR'
and e.`fecha` between '2016-07-01' and '2016-07-31'
and e.`estado` <> 'ANL'
;

-- PARA ACTUALIZAR INV_VALES, COD_ART
select v.`no_trans`, v.`fecha`, v.`cod_doc`, v.`no_vale`, v.`estado`, v.`idordenproduccion`, v.`idproductobase`, v.`idtmpenc`
from inv_vales	v
where v.`cod_alm` = 2 
and v.`fecha` between '2018-01-01' and '2018-12-31'
and v.`idtmpenc` is null
;


select e.`id_tmpenc`, e.`no_trans`, e.`fecha`, e.`tipo_doc`, e.`no_doc`, e.`estado`, e.`glosa`, d.`cuenta`, d.`debe`, d.`haber`, d.`cod_art`, e.`procedencia`, d.`idpersonacliente`, d.`cod_prov`
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
where d.`cuenta` = '1420710000'
and e.`fecha` between '2019-02-01' and '2019-02-28'
and e.`estado` <> 'ANL'
-- AND d.`idpersonacliente` = 477
-- AND e.`tipo_doc` <> 'NE'
-- AND d.`cod_art` IS NULL
-- AND e.`procedencia` <> 'TRA'
;




select v.`fecha`, v.`estado`, v.`cod_alm`, v.`no_vale`, d.`cod_art`, a.`descri`, d.`cantidad`, d.`costounitario`, d.`monto`  ,
v.`idtmpenc`, e.`no_trans`, e.`tipo_doc`, e.`no_doc`, de.`id_tmpdet`, de.`debe`, de.`haber`
from inv_movdet d
left join inv_mov m on d.`no_trans` = m.`no_trans`
left join inv_vales v on m.`no_trans` = v.`no_trans`
left join inv_articulos a on d.`cod_art` = a.`cod_art`
left join sf_tmpenc e on v.`idtmpenc` = e.`id_tmpenc`
left join sf_tmpdet de on e.`id_tmpenc` = de.`id_tmpenc`
where de.`cuenta` = '1510110201' 
and v.`idtmpenc` in ();


-- select p.`IDPEDIDOS`, p.`FECHA_ENTREGA`, p.`CODIGO`, a.`cod_art`, i.`descri`, a.`CANTIDAD`, a.`cu`, (a.`CANTIDAD` * a.`cu`) AS costo_t,  p.`CV`
select month(P.`FECHA_ENTREGA`), a.`cod_art`, i.`descri`, sum(a.`CANTIDAD` * a.`cu`) as costo_t
from articulos_pedido a
left join pedidos p 		on a.`IDPEDIDOS` = p.`IDPEDIDOS`
left join inv_articulos i 	on a.`cod_art` = i.`cod_art`
where p.`FECHA_ENTREGA` between '2018-01-01' and '2018-12-31'
and p.`ESTADO` <> 'ANULADO'
and p.`IDUSUARIO` <> 5
and p.`CV` = 1
group by month(P.`FECHA_ENTREGA`), a.`cod_art`, i.`descri`
;

select month(v.`FECHA_PEDIDO`), a.`cod_art`, i.`descri`, sum(a.`CANTIDAD` * a.`cu`) as costo_t
from articulos_pedido a
left join ventadirecta v 	on a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
left join inv_articulos i 	on a.`cod_art` = i.`cod_art`
where v.`FECHA_PEDIDO` between '2018-01-01' and '2018-12-31'
and v.`ESTADO` <> 'ANULADO'
and v.`IDUSUARIO` <> 5
and v.`CV` = 1
group by month(v.`FECHA_PEDIDO`), a.`cod_art`, i.`descri`
;

--
-- CUENTA PRODUCTOS TERMINADOS MIRABEL - VALES
select e.`id_tmpenc`, e.`fecha`, e.`tipo_doc`, e.`no_doc`, d.`id_tmpdet`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, d.`cod_art`, d.`cant_art`,
 e.`cod_prov`, v.`no_trans`, v.`cod_doc`, v.`no_vale`, v.`cod_alm`, v.`id_com_encoc`, e.`glosa`
from sf_tmpenc e 
join sf_tmpdet d on e.`id_tmpenc` = d.`id_tmpenc`
join arcgms a 	 on d.`cuenta` = a.`cuenta`
join inv_vales v on e.`id_tmpenc` = v.`idtmpenc`
where e.`fecha` between '2019-01-01' and '2019-02-31'
and e.`estado` <> 'ANL'
and e.`tipo_doc` = 'TR'
-- AND d.`cuenta` = '1520110100'
-- and e.`no_doc` in (1819)

;


-- ASIENTOS - ARTICULOS ENTRADA - SALIDA
select e.`tipo_doc`, e.`no_doc`, d.cod_art, a.descri, a.cod_med,
sum(d.debe)     as debe,
sum(d.haber)    as haber,
sum(if(d.debe>0, d.cant_art, 0))  as cant_e,
sum(if(d.haber>0, d.cant_art, 0)) as cant_s
from sf_tmpdet d
left join sf_tmpenc e on d.id_tmpenc = e.id_tmpenc
left join inv_articulos a on d.cod_art = a.cod_art
where d.cuenta = 1580110200
and e.fecha between '2019-01-01' and '2019-01-31'
and e.estado <> 'ANL'
group by e.`tipo_doc`, e.`no_doc`, d.cod_art, a.descri, a.cod_med
;

-- VALES TRANSFERENCIAS, BAJ, DEV
select v.`fecha`, v.`no_trans`, v.`no_vale`, v.`cod_doc`, v.`oper`, a.`descri`, d.`tipo_mov`, d.`cod_art` , d.`cantidad`, v.`orig`, v.`dest`, v.`cod_alm_dest`, v.`idtmpenc`, m.`descri`
from inv_movdet d
left join inv_mov m   on d.`no_trans` = m.`no_trans` 
left join inv_vales v on m.`no_trans` = v.`no_trans`
left join inv_articulos a on d.`cod_art` = a.`cod_art`
where v.`fecha` between '2020-05-01' and '2020-05-31'
and v.`oper` is not null
-- AND v.`cod_alm_dest` IS NOT NULL
-- AND v.`idtmpenc` IS NULL
-- and d.`cod_art` in (703)
;


-- REVISION MOVIMIENTO PRODUCTO X CONTABILIDAD
select e.`id_tmpenc`, e.`fecha`, e.`tipo_doc`, e.`no_doc`, e.`estado`, d.`id_tmpdet`, d.`cuenta`, d.`debe`, d.`haber`, d.`cod_art`, d.`cant_art`, e.`glosa`
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
where e.`fecha` between '2019-03-01' and '2019-12-31'
and d.`cod_art` = 642
;

-- VALES ENTRADAS DE PRODUCCION
select d.cod_art, sum(d.monto) as monto, sum(d.cantidad) as cantidad, sum(d.monto) / sum(d.cantidad) as costoUni
from inv_vales i 
join inv_movdet d on i.no_trans = d.no_trans
where i.fecha between '2019-02-01' and '2019-02-28'
and i.cod_alm = 2
and (i.idordenproduccion is not null or i.idproductobase is not null)
and d.cod_art = 703
group by d.cod_art
;

-- VALES DE COMPRAS - ASIENTOS DETALLE
select distinct e.`id_tmpenc`, e.`no_trans`, e.`fecha`, e.`tipo_doc`, e.`no_doc`, d.`cuenta`, d.`id_tmpdet`, d.`debe`, d.`haber`,  de.`tipo_mov`,
e.`glosa`, d.`cod_art`, d.`cant_art`,
 e.`cod_prov`, v.`no_trans`, v.`cod_doc`, v.`no_vale`, v.`cod_alm`, v.`id_com_encoc`, de.`cod_art`, de.`cantidad`, de.`monto`
from sf_tmpenc e 
join sf_tmpdet d on e.`id_tmpenc` = d.`id_tmpenc`
join arcgms a 	 on d.`cuenta` = a.`cuenta`
join inv_vales v on e.`id_tmpenc` = v.`idtmpenc`
join inv_movdet de on v.`no_trans` = de.`no_trans`
where e.`fecha` between '2019-01-01' and '2019-04-31'
and e.`estado` <> 'ANL'
and e.`tipo_doc` = 'TR'
and d.`cuenta` in ('1580110100', '1580110200')
-- and de.`tipo_mov` = 'E'
;
	
-- 
-- VALES - MOVDET
select i.`no_trans`, i.`fecha`, i.`no_vale`, m.`no_trans`, m.`fecha_cre`, m.`fecha_mov`, d.`id_inv_movdet`, d.`cod_art`, d.`cod_art`, d.`fecha`
from inv_movdet d
left join inv_mov m   on d.`no_trans` = m.`no_trans`
left join inv_vales i on d.`no_trans` = i.`no_trans`
where d.`fecha` between '2019-01-01' and '2019-07-31'
;


-- VALES - ASIENTOS
select i.`no_trans`, i.`fecha`, i.`no_vale`, e.`id_tmpenc`, e.`fecha`, e.`tipo_doc`, e.`no_doc`
from inv_vales i 
left join sf_tmpenc e on i.`idtmpenc` = e.`id_tmpenc`
where i.`fecha` between '2019-01-01' and '2019-07-31'
;


-- INVENTARIO - CONTABILIDAD
select d.cod_art, a.descri, a.cod_med, 
sum(d.debe)     as debe, 
sum(d.haber)    as haber, 
sum(if(d.debe>0, d.cant_art, 0))  as cant_e, 
sum(if(d.haber>0, d.cant_art, 0)) as cant_s 
from sf_tmpdet d 
left join sf_tmpenc e on d.id_tmpenc = e.id_tmpenc 
left join inv_articulos a on d.cod_art = a.cod_art 
where d.cuenta = '1580110200'
and e.fecha between '2019-01-01' and '2019-05-31'
and e.estado <> 'ANL' 
group by d.cod_art, a.descri, a.cod_med order by a.descri
;
-- 

/** ASIENTO CAPITALIZACION/AHORROS **/
select e.`id_tmpenc`, d.`id_tmpdet`, e.`fecha`, e.`tipo_doc` as tipo, E.`no_doc`, d.`no_trans`,  
d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, d.`debeme`, d.`haberme`,
d.`id_tmpenc`, d.`idcuenta`, c.`codigo`, s.`nombres`, s.`apellidopaterno`, s.`apellidomaterno`
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
left join arcgms a    on d.`cuenta` = a.`cuenta`
left join cuenta c on d.`idcuenta` = c.`idcuenta`
left join socio s on c.`idsocio` = s.`idsocio`
where e.`tipo_doc` = 'CD'
and e.`no_doc` in (1)
and e.`fecha` between '2019-01-01' and '2019-12-31'
;

-- ESTADO DE CARTERA
select d.`idcredito`, c.`codigoant`, d.`cuenta`, sum(d.`debe`) as debe, sum(d.`haber`) as haber, sum(d.`debe`)-sum(d.`haber`) as saldo
from sf_tmpdet d
join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
join credito c on d.`idcredito` = c.`idcredito`
-- where e.`fecha` between '2019-01-01' and '2019-12-31'
where e.`fecha` <= '2020-01-31'
and e.`estado` <> 'ANL'
and d.`cuenta` = '1330410200'
and d.`idcredito` is not null
group by d.`idcredito`, c.`codigoant`, d.`cuenta`
having saldo > 0
;


-- ESTADO DE APORTES
select d.`idsocio`, s.`nombres`, s.`apellidopaterno`, s.`apellidomaterno`, sum(d.`debe`) as debe, sum(d.`haber`) as haber
from sf_tmpdet d
join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
join socio s     on d.`idsocio` = s.`idsocio`
where d.`cuenta` = '3110100000'
and e.`estado` <> 'ANL'
and d.`idsocio` is not null
group by d.`idsocio`, s.`nombres`, s.`apellidopaterno`, s.`apellidomaterno`
;


-- NUEVOS CREDITOS
select z.`idzonaproductiva`, count(c.`idcredito`) as cant, sum(c.`importe`) as monto
from credito c
left join socio s 	   on c.`idsocio` = s.`idsocio`
left join zonaproductiva z on s.`idzonaproductiva` = z.`idzonaproductiva`
where c.`fechaconcesion` between '2019-07-01' and '2019-12-31'
group by z.`idzonaproductiva`
;

-- RECUERACION
select z.`idzonaproductiva`, count(c.`idcredito`) as cant, sum(t.`capital`) as capital, sum(t.`interes`) as interes
from credito c
left join transaccioncredito t on c.`idcredito` = t.`idcredito`
left join socio s 	   on c.`idsocio` = s.`idsocio`
left join zonaproductiva z on s.`idzonaproductiva` = z.`idzonaproductiva`
where t.`fechatransaccion` between '2020-01-01' and '2020-01-31'
group by z.`idzonaproductiva`
;

select * -- e.`id_tmpenc`, d.`cuenta`, d.`idcuenta`
from sf_tmpenc e
where e.`glosa` like '%RETIRO%AHO%'
;


/* fisico valorado */
select d.cod_art, a.descri, a.cod_med,
sum(d.debe)     as debe,
sum(d.haber)    as haber,
sum(if(d.debe>0, d.cant_art, 0))  as cant_e,
sum(if(d.haber>0, d.cant_art, 0)) as cant_s
from sf_tmpdet d
left join sf_tmpenc e on d.id_tmpenc = e.id_tmpenc
left join inv_articulos a on d.cod_art = a.cod_art
where d.cuenta = '1580110100'
and e.fecha between '2020-01-01' and '2020-01-31'
and e.estado <> 'ANL'
-- and d.cod_art is not null
group by d.cod_art, a.descri, a.cod_med order by a.descri asc
;

/* Transferencia de PT detalle */
select v.`fecha`, v.`no_trans`, v.`dest`, v.`orig`, v.`no_vale`, v.`oper`, v.`estado`, d.`tipo_mov`, d.`cod_art`, d.`cantidad`, d.`costounitario`, d.`preciounitcompra`, v.`idtmpenc`
from inv_movdet d
left join inv_vales v on d.`no_trans` = v.`no_trans`
where v.`fecha` between '2020-07-01' and '2020-07-31'
-- and d.`cod_art` in (134)
-- and v.`oper` is not null
-- and v.`oper` is null
;

/* Transferencia de PT */
select v.`fecha`, v.`no_trans`, v.`dest`, v.`orig`, v.`no_vale`, v.`oper`, v.`estado`, v.`idtmpenc`, e.`tipo_doc`, e.`no_doc`
from inv_vales v 
left join sf_tmpenc e on v.`idtmpenc` = e.`id_tmpenc`
where v.`fecha` between '2020-07-01' and '2020-07-31'
and v.`oper` is not null
;

-- Para revision productos saldo (-)
-- 781
select *
from com_detoc d
where d.`cod_art` in (
695, 781
);

select *
from articulos_pedido a
where a.`cod_art` in (
695, 781
);


select *
from sf_tmpdet d
where d.`cod_art` in (
695, 781
);


select *
from inv_movdet d
where d.`cod_art` in (
695, 781
);

-- End





-- Vales anulados por error en anulacion de pedidos
-- no_trans: 25247, 25249, 25020

-- select * from inv_vales 
-- update inv_vales d set d.`estado` = 'ANL'
where d.`no_trans` in (
25247, 25249, 25020
);

-- select * from inv_mov d
-- UPDATE inv_mov d set d.`estado` = 'ANL'
where d.`no_trans` in (
25247, 25249, 25020
);

select *
from inv_movdet d
update inv_movdet d set d.`estado` = 'ANL'
where d.`no_trans` in (
25247, 25249, 25020
);

-- -------------




