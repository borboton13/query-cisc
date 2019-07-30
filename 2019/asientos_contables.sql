-- - 
/*select e.`id_tmpenc`, d.`id_tmpdet`, e.`fecha`, e.`tipo_doc` as tipo, E.`no_doc`, d.`no_trans`,  e.`glosa`,  e.`cod_prov`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, 
d.`tc`, d.`debeme`, d.`haberme`, d.`id_tmpenc`, e.`estado`, d.`idpersonacliente`, d.`cod_prov`, d.`cod_art`, d.`cant_art`*/
select e.`id_tmpenc`, d.`id_tmpdet`, e.`fecha`, e.`tipo_doc` as tipo, E.`no_doc`, d.`no_trans`,  e.`glosa`,  e.`cod_prov`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, 
d.`id_tmpenc`, e.`estado`, d.`cod_prov`, d.`cod_art`, d.`cant_art`
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
left join arcgms a    on d.`cuenta` = a.`cuenta`
-- WHERE d.`id_tmpenc` = 29504
where d.`id_tmpenc` in (
104304
) -- WHERE e.`tipo_doc` = 'DB' AND e.`no_doc` IN (36,115,325)
;


update sf_tmpdet d set d.`cant_art` =  where d.`id_tmpdet` = ;
update sf_tmpdet d set d.`cant_art` =  where d.`id_tmpdet` = ;
update sf_tmpdet d set d.`cant_art` =  where d.`id_tmpdet` = ;
update sf_tmpdet d set d.`cant_art` =  where d.`id_tmpdet` = ;
update sf_tmpdet d set d.`cant_art` =  where d.`id_tmpdet` = ;
update sf_tmpdet d set d.`cant_art` =  where d.`id_tmpdet` = ;
update sf_tmpdet d set d.`cant_art` =  where d.`id_tmpdet` = ;
update sf_tmpdet d set d.`cant_art` =  where d.`id_tmpdet` = ;
update sf_tmpdet d set d.`cant_art` =  where d.`id_tmpdet` = ;

-- update sf_tmpenc e set e.`estado` = 'APR' where e.`id_tmpenc` in (111869);
-- update sf_tmpenc e set e.`fecha` = '2019-05-01' where e.`id_tmpenc` in (109066);
-- update sf_tmpdet set cant_art =	1.1	 where id_tmpdet =	13272	;



--
-- Detalle por TipoDoc
select e.`id_tmpenc`, e.`no_trans`, d.`id_tmpdet`, e.`fecha`, e.`tipo_doc` as tipo, E.`no_doc`, d.`no_trans`,  e.`glosa`,  e.`cod_prov`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, d.`id_tmpenc`, e.`estado`, 
d.`idpersonacliente`, d.`cod_prov`, d.`cod_art`, d.`cant_art`, d.`idpersonacliente`
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
left join arcgms a    on d.`cuenta` = a.`cuenta`
-- where d.`debe` = 0 and d.`haber` = 0
-- WHERE d.`id_tmpenc` = 29504
where e.`tipo_doc` = 'PD'
-- and e.`estado` <> 'ANL'
-- and e.`no_doc` in (202)
-- AND e.`glosa` LIKE '%2%QUINCENA%'
-- where d.`cod_art`= 79
and e.`fecha` between '2019-05-01' and '2019-07-31'
;


-- update sf_tmpdet d set d.`cuenta` = '1580110100' where d.`id_tmpdet` = 609142;
-- update sf_tmpdet d SET d.`id_tmpenc` = 106270 where d.`id_tmpdet` in (11778	,11779	,11780	,11781	,11782	,11783	,11784	,11785	,11786	,11787	);
-- update sf_tmpenc e set e.`estado` = 'PEN' where e.`id_tmpenc` in (100334);
-- delete FROM sf_tmpdet where id_tmpdet in ();



-- SET @folio = (SELECT MAX(id_tmpdet) FROM sf_tmpdet);
-- INSERT INTO sf_tmpdet (id_tmpdet, cuenta, no_cia, debe, haber, debeme, haberme, tc, no_trans, id_tmpenc, idpersonacliente) 
select (@folio := @folio + 1), '1421010100', '01', 0, p.`TOTALIMPORTE`, 0, 0, 1, 107212, 107174, p.`IDCLIENTE`
from pedidos p
left join personacliente pe 	on p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
left join entidad en 		on pe.`NRO_DOC` = en.`noidentificacion`
left join persona per 		on en.`identidad` = per.`idpersona`
left join productormateriaprima pr on per.`idpersona` = pr.`idproductormateriaprima`
-- WHERE p.`IDUSUARIO` = 5
where p.`IDUSUARIO` = 404
and p.`FECHA_ENTREGA` between '2019-03-16' and '2019-03-31'
-- AND p.`IDTIPOPEDIDO` = 6
and p.`IDTIPOPEDIDO` = 5
and p.`ESTADO` <> 'ANULADO'
;



-- Detalle por Glosa
select e.`id_tmpenc`, d.`id_tmpdet`, e.`fecha`, e.`tipo_doc` as tipo, e.`no_doc`, d.`no_trans`,  e.`glosa`,  e.`cod_prov`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, d.`id_tmpenc`, e.`estado`, d.`idpersonacliente`, d.`cod_prov`
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
left join arcgms a    on d.`cuenta` = a.`cuenta`
where e.`tipo_doc` = 'CV'
-- AND e.`glosa` LIKE '%RECEPCION%ALM PRODUCTOS TERMINADOS)%'
-- AND e.`glosa` LIKE '%CONSUMO, EGRESO, ALMACEN (ALM INSUMOS DE PRODUCCION)%'
-- AND e.`glosa` LIKE '%CONSUMO, EGRESO, ALMACEN (ALM MATERIALES DE PRODUCCION)%'
and e.`fecha` between '2019-01-01' and '2019-03-31'
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

-- -------------------------------------------------
-- ASIENTOS, PEDIDOS 
select e.`id_tmpenc`, d.`id_tmpdet`, e.`fecha`, e.`tipo_doc` as tipo, e.`no_doc`, d.`no_trans`,  e.`glosa`,  e.`cod_prov`, d.`cuenta`, a.`descri`, p.`TOTALIMPORTE`, p.`PORCENTAJECOMISION`, p.`VALORCOMISION`, d.`debe`, d.`haber`, d.`id_tmpenc`, e.`estado`, d.`idpersonacliente`, d.`cod_prov`
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
left join arcgms a    on d.`cuenta` = a.`cuenta`
left join pedidos p   on e.`id_tmpenc` = p.`id_tmpenc`
where d.`id_tmpenc` in (
	select p.`id_tmpenc`
	from pedidos p
	where p.`FECHA_ENTREGA` between '2019-01-01' and '2019-12-31'
	and p.`CODIGO` = 1935
	and p.`ESTADO` <> 'ANULADO'
	-- AND p.`VALORCOMISION` > 0
)
;

-- --------------------------------------------------

select d.`id_tmpdet`, e.`tipo_doc`, e.`no_trans`, e.`glosa`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, d.`no_trans`, d.`id_tmpenc`
from sftmpdet d
left join sftmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
left join arcgms a    on d.`cuenta` = a.`cuenta`
where d.`id_tmpenc` = 4089;

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


select d.`id_tmpenc`, d.`id_tmpdet`, e.`fecha`, e.`tipo_doc`, e.`no_doc`, e.`estado`, e.`glosa`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, d.`cod_prov`, d.`idpersonacliente`, p.`IDPEDIDOS`, p.`ESTADO`, p.`IDMOVIMIENTO`, v.`id_tmpenc`, v.`ESTADO`, v.`IDMOVIMIENTO`
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
left join arcgms a    on d.`cuenta` = a.`cuenta`
left join pedidos p   on e.`id_tmpenc` = p.`id_tmpenc`
left join ventadirecta v on e.`id_tmpenc` = v.`id_tmpenc`
where d.`cuenta` = '2420410200'
and e.`fecha` between '2018-05-01' and '2018-05-31'
and e.`estado` <> 'ANL'
;

select p.`IDPEDIDOS`, pc.`NOM`, pc.`AP`, p.`FECHA_ENTREGA`, p.`ESTADO`, p.`OBSERVACION`, p.`CODIGO`, p.`id_tmpenc`, p.`IDMOVIMIENTO`, m.`FECHA_FACTURA`, m.`NROFACTURA`, m.`ESTADO`
from pedidos p
left join personacliente pc on p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
left join movimiento m on p.`IDMOVIMIENTO` = m.`IDMOVIMIENTO`
where p.`FECHA_ENTREGA` between '2018-05-01' and '2018-05-31'
and pc.`NOM` like '%munici%cbba%'
;


select e.`fecha`, d.`id_tmpdet`, e.`tipo_doc`, e.`no_doc`, e.`no_trans`, e.`glosa`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, d.`no_trans`, d.`id_tmpenc`, d.`idpersonacliente`
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
left join arcgms a    on d.`cuenta` = a.`cuenta`
-- WHERE d.`id_tmpenc` = 2
-- WHERE e.`tipo_doc` = 'CI'
where d.`cuenta` = '1421010100'
-- AND e.`no_doc` = '17'
and d.`idpersonacliente` = 984
and e.`fecha` between '2018-01-01' and '2019-12-31'
;

-- RESUMEN DE RECAUDACION
-- SELECT e.`fecha`, d.`id_tmpdet`, e.`tipo_doc`, e.`no_doc`, e.`no_trans`, e.`glosa`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, d.`no_trans`, d.`id_tmpenc`
-- SELECT e.`fecha`, e.`tipo_doc`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`
select /*e.`fecha`, e.`tipo_doc`,*/ d.`cuenta`, a.`descri`, SUM(d.`debe`) as DEBE, SUM(d.`haber`) as haber
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
select d.`cuenta`, a.`descri`, SUM(d.`debe`) as TOTAL_D, SUM(d.`haber`) as TOTAL_H
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
left join arcgms a    on d.`cuenta` = a.`cuenta`
where e.`fecha` between '2018-01-01' and '2018-12-31'
and e.`estado` <> 'ANL	'
group by d.`cuenta`, a.`descri`
;

select e.`id_tmpenc`, d.`id_tmpdet`, d.`cuenta`, a.`descri`, e.`tipo_doc`, e.`no_doc`, e.`glosa`, d.`debe`, d.`haber`
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
left join arcgms a    on d.`cuenta` = a.`cuenta`
where e.`fecha` between '2018-01-01' and '2018-12-31'
and e.`estado` <> 'ANL'
order by d.`cuenta`
;


-- -----------------------------------------------------------
-- -----------------------------------------------------------
-- ----------------------------------------------------
-- ----------------------------------------------------------


select MIN(CAST(no_doc as decimal)) as MI, MAX(CAST(no_doc as decimal)) as MA
from sf_tmpenc
where tipo_doc = 'CD'
and fecha between '2018-01-01' and '2018-12-31'
;



select distinct dc.`numerotransaccion`
from documentocompra d
join documentocontable dc on d.`iddocumentocompra` = dc.`iddocumentocontable`
join sf_tmpenc e on d.`idtmpenc` = e.`id_tmpenc`
where e.fecha between '2015-01-01' and '2015-12-31'
and dc.`numerotransaccion` is not null
;

select *
from sf_tmpdet
where id_tmpenc in (
	select id_tmpenc
	from sf_tmpenc
	where fecha between '2015-01-01' and '2015-12-31'
	and tipo_doc = 'TR'
);

-- ---------------------------------------------------
-- Para actualizar secuencias
-- ---------------------------------------------------
select e.`tipo_doc`, e.`no_doc`, COUNT(e.`no_doc`)
from sf_tmpenc e
where e.`tipo_doc` = 'NE'
group by e.`tipo_doc`, e.`no_doc`
;

select e.`id_tmpenc`, e.`fecha`, e.`estado`, e.`tipo_doc`, e.`no_doc`, d.`debe`, d.`haber`, e.`glosa`
from sf_tmpenc e
join sf_tmpdet d on e.`id_tmpenc` = d.`id_tmpenc`
where e.`tipo_doc` = 'NE'
and e.`id_tmpenc` = 1
;


select e.`id_tmpenc`, e.`fecha`, e.`estado`, e.`tipo_doc`, e.`no_doc`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, e.`glosa`, d.`cod_prov`, d.`idpersonacliente`, d.`id_tmpdet`
from sf_tmpenc e
join sf_tmpdet d on e.`id_tmpenc` = d.`id_tmpenc`
join arcgms a on d.`cuenta` = a.`cuenta`
-- WHERE e.`tipo_doc` = 'CD'
where d.`cuenta` = '2420910300'
and e.`fecha` between '2016-01-01' and '2018-12-31'
and e.`estado` <> 'ANL'
;


select e.`id_tmpenc`, e.`fecha`, e.`estado`, e.`tipo_doc`, e.`no_doc`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, e.`glosa`, CONCAT(p.`NOM`, ' ', p.`AP`, ' ', p.`AM`) as Cliente, en.`razon_social`, d.`cod_prov`, d.`idpersonacliente`, d.`id_tmpdet`
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
left join arcgms a    on d.`cuenta`    = a.`cuenta`
left join personacliente p on d.`idpersonacliente` = p.`IDPERSONACLIENTE`
left join sf_entidades en  on d.`cod_prov` = en.`cod_enti`
where e.`tipo_doc` = 'CD'
;


-- 
-- 

select e.`tipo_doc`, e.`no_doc`, d.`cuenta`, a.`descri`, SUM(d.`debe`) as D, SUM(d.`haber`) as H
from sf_tmpenc e
join sf_tmpdet d on e.`id_tmpenc` = d.`id_tmpenc`
join arcgms a on d.`cuenta` = a.`cuenta`
where e.`tipo_doc` = 'CD'
group by e.`tipo_doc`, e.`no_doc`, d.`cuenta`, a.`descri`
;


-- - 
select 	e.`id_tmpenc`, 
	d.`id_tmpdet`, 
	e.`fecha`, 
	e.`tipo_doc` as tipo, 
	d.`cuenta`, 
	a.`descri`, 
	d.`debe`, 
	d.`haber`, 
	d.`idpersonacliente` as cod_cli, 
	CONCAT(p.`NOM`, " ", p.`AP`, " ", p.`AM`) as cliente,
	d.`cod_prov`,
	en.`razon_social` as aux_prov
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
left join arcgms a    on d.`cuenta` = a.`cuenta`
left join personacliente p on d.`idpersonacliente` = p.`IDPERSONACLIENTE`
left join sf_entidades en  on d.`cod_prov` = en.`cod_enti`
where d.`id_tmpenc` = 2
;


-- ---------------------------------------------------------------------------------
-- DIFERENCIAS
-- ---------------------------------------------------------------------------------
-- CREATE VIEW diferencias AS (
select e.`fecha`, e.`id_tmpenc`, e.`tipo_doc`, e.`no_doc`, SUM(d.`debe`) as totald, SUM(d.`haber`) as totalh, (SUM(d.`debe`) - SUM(d.`haber`)) as dif
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
left join arcgms a    on d.`cuenta` = a.`cuenta`
where e.`fecha` between '2019-01-01' and '2019-12-31'
and e.`estado` <> 'ANL'
-- AND e.`tipo_doc` IN ('CI', 'CV', 'NE')
-- AND e.`tipo_doc` IN ('CV')
-- AND a.`cta_niv3` = '4420000000'
group by e.`fecha`, e.`id_tmpenc`, e.`tipo_doc`, e.`no_doc`
-- )
;


select e.`fecha`, e.`id_tmpenc`, e.`tipo_doc`, e.`no_doc`, SUM(d.`debe`) as totald, SUM(d.`haber`) as totalh, (SUM(d.`debe`) - SUM(d.`haber`)) as dif,
e.`glosa`
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
left join arcgms a    on d.`cuenta` = a.`cuenta`
where e.`fecha` between '2018-01-01' and '2018-12-31'
and e.`estado` <> 'ANL'
-- AND e.`tipo_doc` IN ('CD')
and a.`cta_niv3` = '4460000000'
group by e.`fecha`, e.`id_tmpenc`, e.`tipo_doc`, e.`no_doc`
-- )
;


select e.`fecha`, e.`id_tmpenc`, e.`tipo_doc`, e.`no_doc`, SUM(d.`debe`) as totald, SUM(d.`haber`) as totalh, (SUM(d.`debe`) - SUM(d.`haber`)) as dif
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
select MONTH(P.`FECHA_ENTREGA`), a.`cod_art`, i.`descri`, SUM(a.`CANTIDAD` * a.`cu`) as costo_t
from articulos_pedido a
left join pedidos p 		on a.`IDPEDIDOS` = p.`IDPEDIDOS`
left join inv_articulos i 	on a.`cod_art` = i.`cod_art`
where p.`FECHA_ENTREGA` between '2018-01-01' and '2018-12-31'
and p.`ESTADO` <> 'ANULADO'
and p.`IDUSUARIO` <> 5
and p.`CV` = 1
group by MONTH(P.`FECHA_ENTREGA`), a.`cod_art`, i.`descri`
;

select MONTH(v.`FECHA_PEDIDO`), a.`cod_art`, i.`descri`, SUM(a.`CANTIDAD` * a.`cu`) as costo_t
from articulos_pedido a
left join ventadirecta v 	on a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
left join inv_articulos i 	on a.`cod_art` = i.`cod_art`
where v.`FECHA_PEDIDO` between '2018-01-01' and '2018-12-31'
and v.`ESTADO` <> 'ANULADO'
and v.`IDUSUARIO` <> 5
and v.`CV` = 1
group by MONTH(v.`FECHA_PEDIDO`), a.`cod_art`, i.`descri`
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


select e.`tipo_doc`, e.`no_doc`, d.cod_art, a.descri, a.cod_med,
SUM(d.debe)     as debe,
SUM(d.haber)    as haber,
SUM(IF(d.debe>0, d.cant_art, 0))  as cant_e,
SUM(IF(d.haber>0, d.cant_art, 0)) as cant_s
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
where v.`fecha` between '2019-04-01' and '2019-04-30'
and v.`oper` is not null
-- AND v.`cod_alm_dest` IS NOT NULL
-- AND v.`idtmpenc` IS NULL
-- and d.`cod_art` in (703)
;

-- SELECT v.`cod_doc`, v.`oper`, d.`cod_art` , d.`cantidad`, v.`orig`, v.`dest`, v.`cod_alm_dest`, v.`idtmpenc`, m.`descri`, t.`cod_art`, t.`cant_art`, t.`debe`, t.`haber` 
select d.`cod_art`, d.`tipo_mov`, d.`cantidad`, t.`debe`, t.`haber`, IF(t.debe>0, d.cantidad, 0) as cant_d, IF(t.haber>0, d.cantidad, 0) as cant_h
from inv_movdet d
left join inv_mov m   on d.`no_trans` = m.`no_trans` 
left join inv_vales v on m.`no_trans` = v.`no_trans`
left join sf_tmpdet t on v.`idtmpenc` = t.`id_tmpenc`
where v.`fecha` between '2019-01-01' and '2019-01-31'
and v.`oper` is null
and d.`cod_art` = t.`cod_art`
and d.`cod_art` in (705)
;

-- REVISION MOVIMIENTO PRODUCTO X CONTABILIDAD
select e.`id_tmpenc`, e.`fecha`, e.`tipo_doc`, e.`no_doc`, e.`estado`, d.`id_tmpdet`, d.`cuenta`, d.`debe`, d.`haber`, d.`cod_art`, d.`cant_art`, e.`glosa`
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
where e.`fecha` between '2019-03-01' and '2019-12-31'
and d.`cod_art` = 642
;

-- VALES ENTRADAS DE PRODUCCION
select d.cod_art, SUM(d.monto) as monto, SUM(d.cantidad) as cantidad, SUM(d.monto) / SUM(d.cantidad) as costoUni
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

select *
from sf_tmpenc e 
join sf_tmpdet d on e.`id_tmpenc` = d.`id_tmpenc`
where e.`fecha` >= '2019-01-01'
and e.`tipo_doc` = 'CD'
and e.`no_doc` = 3
-- and d.`cuenta` IN ('1580110100', '1580110200')
;


-- Insertar de INV_INICIO a INV_PERIODO
set @folio = (select MAX(id_inv_periodo)+1 from inv_periodo);
insert into inv_periodo
select (@folio := @folio + 1), i.cod_art, i.cantidad, /*ROUND((i.costo_uni * i.cantidad),2)*/ (i.costo_uni * i.cantidad) as saldo_val, i.costo_uni, 1, 2019, 1, 0
from inv_inicio i
where i.gestion = 2019
and i.alm = 1
and i.cantidad > 0
;
	
-- SELECT p.cod_art, (p.saldofis * p.costouni) AS monto, p.saldofis AS cantidad 
select *
from inv_periodo p 
where p.cod_alm in (1, 3)
and p.mes = 1
and p.gestion = 2019
and p.saldofis > 0 
;


-- 
select * from inv_vales v
-- update inv_vales v set v.`cod_alm_dest` = v.`oper`
-- UPDATE inv_vales v SET v.`oper` = null
where v.`fecha` between '2019-02-01' and '2019-02-28'
and v.`oper` is not null
;


select *
from sf_tmpenc e 
where e.`fecha` > '2019-01-01'
and e.`tipo_doc` = 'CD'
;


select *
from sf_tmpdet d
where d.`cod_art` = 745;


select i.`no_trans`, i.`fecha`, i.`no_vale`, m.`no_trans`, m.`fecha_cre`, m.`fecha_mov`, d.`id_inv_movdet`, d.`cod_art`, d.`cod_art`, d.`fecha`
from inv_movdet d
left join inv_mov m   on d.`no_trans` = m.`no_trans`
left join inv_vales i on d.`no_trans` = i.`no_trans`
where d.`fecha` between '2019-01-01' and '2019-07-31'
;



select i.`no_trans`, i.`fecha`, i.`no_vale`, e.`id_tmpenc`, e.`fecha`, e.`tipo_doc`, e.`no_doc`
from inv_vales i 
left join sf_tmpenc e on i.`idtmpenc` = e.`id_tmpenc`
where i.`fecha` between '2019-01-01' and '2019-07-31'
;


-- INVENTARIO - CONTABILIDAD
select d.cod_art, a.descri, a.cod_med, 
SUM(d.debe)     as debe, 
SUM(d.haber)    as haber, 
SUM(IF(d.debe>0, d.cant_art, 0))  as cant_e, 
SUM(IF(d.haber>0, d.cant_art, 0)) as cant_s 
from sf_tmpdet d 
left join sf_tmpenc e on d.id_tmpenc = e.id_tmpenc 
left join inv_articulos a on d.cod_art = a.cod_art 
where d.cuenta = '1580110100'
and e.fecha between '2019-01-01' and '2019-04-31'
and e.estado <> 'ANL' 
group by d.cod_art, a.descri, a.cod_med order by a.descri
;