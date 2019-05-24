-- - 
select e.`id_tmpenc`, d.`id_tmpdet`, e.`fecha`, e.`tipo_doc` as tipo, E.`no_doc`, d.`no_trans`,  e.`glosa`,  e.`cod_prov`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, 
d.`tc`, d.`debeme`, d.`haberme`, d.`id_tmpenc`, e.`estado`, d.`idpersonacliente`, d.`cod_prov`, d.`cod_art`, d.`cant_art`
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
left join arcgms a    on d.`cuenta` = a.`cuenta`
-- WHERE d.`id_tmpenc` = 29504
where d.`id_tmpenc` in (

)
-- WHERE e.`tipo_doc` = 'DB' AND e.`no_doc` IN (36,115,325)
;


update sf_tmpdet d set d.`debe` = 5006.66
where d.`id_tmpdet` = 602273;

--
-- Detalle por TipoDoc
select e.`id_tmpenc`, e.`no_trans`, d.`id_tmpdet`, e.`fecha`, e.`tipo_doc` as tipo, E.`no_doc`, d.`no_trans`,  e.`glosa`,  e.`cod_prov`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, d.`id_tmpenc`, e.`estado`, 
d.`idpersonacliente`, d.`cod_prov`, d.`cod_art`, d.`cant_art`
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
left join arcgms a    on d.`cuenta` = a.`cuenta`
-- WHERE d.`id_tmpenc` = 29504
where e.`tipo_doc` = 'NE'
and e.`estado` <> 'ANL'
and e.`no_doc` in (2763, 2849)
-- AND e.`glosa` LIKE '%2%QUINCENA%'
and e.`fecha` between '2019-01-01' and '2019-12-31'
;


-- update sf_tmpdet d set d.`cuenta` = '1580110200', d.`cod_art` = 96, d.`cant_art` = 7500 where d.`id_tmpdet` = 595184;
-- update sf_tmpdet d SET d.`id_tmpenc` = 106270 where d.`id_tmpdet` in (11778	,11779	,11780	,11781	,11782	,11783	,11784	,11785	,11786	,11787	);
-- update sf_tmpenc e set e.`estado` = 'ANL' where e.`id_tmpenc` in (108968,108980,108981);
-- delete FROM sf_tmpdet where id_tmpdet = 596085;



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

update SECUENCIA set VALOR=(select MAX(e.id_tmpdet)+1 from sf_tmpdet e) where TABLA='sf_tmpdet';

-- delete from sf_tmpdet 
where id_tmpdet in (  

);

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
where d.`cuenta` = '4460310208'
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
SELECT 	e.`id_tmpenc`, 
	d.`id_tmpdet`, 
	e.`fecha`, 
	e.`tipo_doc` AS tipo, 
	d.`cuenta`, 
	a.`descri`, 
	d.`debe`, 
	d.`haber`, 
	d.`idpersonacliente` AS cod_cli, 
	CONCAT(p.`NOM`, " ", p.`AP`, " ", p.`AM`) AS cliente,
	d.`cod_prov`,
	en.`razon_social` AS aux_prov
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
LEFT JOIN personacliente p ON d.`idpersonacliente` = p.`IDPERSONACLIENTE`
LEFT JOIN sf_entidades en  ON d.`cod_prov` = en.`cod_enti`
WHERE d.`id_tmpenc` = 2
;


-- ---------------------------------------------------------------------------------
-- DIFERENCIAS
-- ---------------------------------------------------------------------------------
-- CREATE VIEW diferencias AS (
SELECT e.`fecha`, e.`id_tmpenc`, e.`tipo_doc`, e.`no_doc`, SUM(d.`debe`) AS totald, SUM(d.`haber`) AS totalh, (SUM(d.`debe`) - SUM(d.`haber`)) AS dif
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
WHERE e.`fecha` BETWEEN '2019-01-01' AND '2019-12-31'
AND e.`estado` <> 'ANL'
-- AND e.`tipo_doc` IN ('CI', 'CV', 'NE')
-- AND e.`tipo_doc` IN ('CV')
-- AND a.`cta_niv3` = '4420000000'
GROUP BY e.`fecha`, e.`id_tmpenc`, e.`tipo_doc`, e.`no_doc`
-- )
;


SELECT e.`fecha`, e.`id_tmpenc`, e.`tipo_doc`, e.`no_doc`, SUM(d.`debe`) AS totald, SUM(d.`haber`) AS totalh, (SUM(d.`debe`) - SUM(d.`haber`)) AS dif,
e.`glosa`
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
WHERE e.`fecha` BETWEEN '2018-01-01' AND '2018-12-31'
AND e.`estado` <> 'ANL'
-- AND e.`tipo_doc` IN ('CD')
AND a.`cta_niv3` = '4460000000'
GROUP BY e.`fecha`, e.`id_tmpenc`, e.`tipo_doc`, e.`no_doc`
-- )
;


SELECT e.`fecha`, e.`id_tmpenc`, e.`tipo_doc`, e.`no_doc`, SUM(d.`debe`) AS totald, SUM(d.`haber`) AS totalh, (SUM(d.`debe`) - SUM(d.`haber`)) AS dif
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
WHERE e.`fecha` BETWEEN '2017-12-01' AND '2017-12-31'
AND e.`estado` <> 'ANL'
-- AND e.`tipo_doc` IN ('CI', 'CV', 'NE')
-- AND e.`tipo_doc` IN ('NE')
GROUP BY e.`fecha`, e.`id_tmpenc`, e.`tipo_doc`, e.`no_doc`
;


SELECT v.`IDVENTADIRECTA`, v.`FECHA_PEDIDO`, v.`CODIGO`, v.`ESTADO`, v.`TOTALIMPORTE`, v.`IMPUESTO`, v.`IDMOVIMIENTO`, v.`id_tmpenc`, v.`id_tmpenc_cv`, v.`IDUSUARIO`
FROM ventadirecta v
WHERE v.`FECHA_PEDIDO` BETWEEN '2016-05-01' AND '2016-05-31'
;


-- Ventas
SELECT * 
FROM ventadirecta v
WHERE v.`FECHA_PEDIDO` BETWEEN '2016-05-01' AND '2016-08-07'
AND v.`IDMOVIMIENTO` IS NOT NULL
AND v.`ESTADO` <> 'ANULADO'
;

-- Pedidos
SELECT *
FROM pedidos p
WHERE p.`FECHA_ENTREGA` BETWEEN '2016-05-01' AND '2016-08-11'
-- AND p.`IDMOVIMIENTO` IS NOT NULL
AND p.`ESTADO` <> 'ANULADO'
AND p.`VALORCOMISION` > 0
;


-- 
SELECT e.`id_tmpenc`, d.`id_tmpdet`, e.`fecha`, e.`tipo_doc` AS tipo, E.`no_doc`, d.`no_trans`, /*e.`glosa`,*/ e.`cod_prov`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, d.`id_tmpenc`, e.`estado`, d.`idpersonacliente`, d.`cod_prov`
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
WHERE e.`tipo_doc` = 'TR'
AND e.`fecha` BETWEEN '2016-07-01' AND '2016-07-31'
AND e.`estado` <> 'ANL'
;

-- PARA ACTUALIZAR INV_VALES, COD_ART
SELECT v.`no_trans`, v.`fecha`, v.`cod_doc`, v.`no_vale`, v.`estado`, v.`idordenproduccion`, v.`idproductobase`, v.`idtmpenc`
FROM inv_vales	v
WHERE v.`cod_alm` = 2 
AND v.`fecha` BETWEEN '2018-01-01' AND '2018-12-31'
AND v.`idtmpenc` IS NULL
;


SELECT e.`id_tmpenc`, e.`no_trans`, e.`fecha`, e.`tipo_doc`, e.`no_doc`, e.`estado`, e.`glosa`, d.`cuenta`, d.`debe`, d.`haber`, d.`cod_art`, e.`procedencia`, d.`idpersonacliente`, d.`cod_prov`
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
WHERE d.`cuenta` = '1420710000'
AND e.`fecha` BETWEEN '2019-02-01' AND '2019-02-28'
AND e.`estado` <> 'ANL'
-- AND d.`idpersonacliente` = 477
-- AND e.`tipo_doc` <> 'NE'
-- AND d.`cod_art` IS NULL
-- AND e.`procedencia` <> 'TRA'
;




SELECT v.`fecha`, v.`estado`, v.`cod_alm`, v.`no_vale`, d.`cod_art`, a.`descri`, d.`cantidad`, d.`costounitario`, d.`monto`  ,
v.`idtmpenc`, e.`no_trans`, e.`tipo_doc`, e.`no_doc`, de.`id_tmpdet`, de.`debe`, de.`haber`
FROM inv_movdet d
LEFT JOIN inv_mov m ON d.`no_trans` = m.`no_trans`
LEFT JOIN inv_vales v ON m.`no_trans` = v.`no_trans`
LEFT JOIN inv_articulos a ON d.`cod_art` = a.`cod_art`
LEFT JOIN sf_tmpenc e ON v.`idtmpenc` = e.`id_tmpenc`
LEFT JOIN sf_tmpdet de ON e.`id_tmpenc` = de.`id_tmpenc`
WHERE de.`cuenta` = '1510110201' 
AND v.`idtmpenc` IN ();


-- select p.`IDPEDIDOS`, p.`FECHA_ENTREGA`, p.`CODIGO`, a.`cod_art`, i.`descri`, a.`CANTIDAD`, a.`cu`, (a.`CANTIDAD` * a.`cu`) AS costo_t,  p.`CV`
SELECT MONTH(P.`FECHA_ENTREGA`), a.`cod_art`, i.`descri`, SUM(a.`CANTIDAD` * a.`cu`) AS costo_t
FROM articulos_pedido a
LEFT JOIN pedidos p 		ON a.`IDPEDIDOS` = p.`IDPEDIDOS`
LEFT JOIN inv_articulos i 	ON a.`cod_art` = i.`cod_art`
WHERE p.`FECHA_ENTREGA` BETWEEN '2018-01-01' AND '2018-12-31'
AND p.`ESTADO` <> 'ANULADO'
AND p.`IDUSUARIO` <> 5
AND p.`CV` = 1
GROUP BY MONTH(P.`FECHA_ENTREGA`), a.`cod_art`, i.`descri`
;

SELECT MONTH(v.`FECHA_PEDIDO`), a.`cod_art`, i.`descri`, SUM(a.`CANTIDAD` * a.`cu`) AS costo_t
FROM articulos_pedido a
LEFT JOIN ventadirecta v 	ON a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
LEFT JOIN inv_articulos i 	ON a.`cod_art` = i.`cod_art`
WHERE v.`FECHA_PEDIDO` BETWEEN '2018-01-01' AND '2018-12-31'
AND v.`ESTADO` <> 'ANULADO'
AND v.`IDUSUARIO` <> 5
AND v.`CV` = 1
GROUP BY MONTH(v.`FECHA_PEDIDO`), a.`cod_art`, i.`descri`
;

--
-- CUENTA PRODUCTOS TERMINADOS MIRABEL - VALES
SELECT e.`id_tmpenc`, e.`fecha`, e.`tipo_doc`, e.`no_doc`, d.`id_tmpdet`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, d.`cod_art`, d.`cant_art`,
 e.`cod_prov`, v.`no_trans`, v.`cod_doc`, v.`no_vale`, v.`cod_alm`, v.`id_com_encoc`, e.`glosa`
FROM sf_tmpenc e 
JOIN sf_tmpdet d ON e.`id_tmpenc` = d.`id_tmpenc`
JOIN arcgms a 	 ON d.`cuenta` = a.`cuenta`
JOIN inv_vales v ON e.`id_tmpenc` = v.`idtmpenc`
WHERE e.`fecha` BETWEEN '2019-01-01' AND '2019-02-31'
AND e.`estado` <> 'ANL'
AND e.`tipo_doc` = 'TR'
-- AND d.`cuenta` = '1520110100'
-- and e.`no_doc` in (1819)

;


SELECT e.`tipo_doc`, e.`no_doc`, d.cod_art, a.descri, a.cod_med,
SUM(d.debe)     AS debe,
SUM(d.haber)    AS haber,
SUM(IF(d.debe>0, d.cant_art, 0))  AS cant_e,
SUM(IF(d.haber>0, d.cant_art, 0)) AS cant_s
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.id_tmpenc = e.id_tmpenc
LEFT JOIN inv_articulos a ON d.cod_art = a.cod_art
WHERE d.cuenta = 1580110200
AND e.fecha BETWEEN '2019-01-01' AND '2019-01-31'
AND e.estado <> 'ANL'
GROUP BY e.`tipo_doc`, e.`no_doc`, d.cod_art, a.descri, a.cod_med
;

-- VALES TRANSFERENCIAS, BAJ, DEV
SELECT v.`fecha`, v.`no_trans`, v.`no_vale`, v.`cod_doc`, v.`oper`, a.`descri`, d.`tipo_mov`, d.`cod_art` , d.`cantidad`, v.`orig`, v.`dest`, v.`cod_alm_dest`, v.`idtmpenc`, m.`descri`
FROM inv_movdet d
LEFT JOIN inv_mov m   ON d.`no_trans` = m.`no_trans` 
LEFT JOIN inv_vales v ON m.`no_trans` = v.`no_trans`
LEFT JOIN inv_articulos a ON d.`cod_art` = a.`cod_art`
WHERE v.`fecha` BETWEEN '2019-04-01' AND '2019-04-30'
AND v.`oper` IS NOT NULL
-- AND v.`cod_alm_dest` IS NOT NULL
-- AND v.`idtmpenc` IS NULL
-- and d.`cod_art` in (703)
;

-- SELECT v.`cod_doc`, v.`oper`, d.`cod_art` , d.`cantidad`, v.`orig`, v.`dest`, v.`cod_alm_dest`, v.`idtmpenc`, m.`descri`, t.`cod_art`, t.`cant_art`, t.`debe`, t.`haber` 
SELECT d.`cod_art`, d.`tipo_mov`, d.`cantidad`, t.`debe`, t.`haber`, IF(t.debe>0, d.cantidad, 0) AS cant_d, IF(t.haber>0, d.cantidad, 0) AS cant_h
FROM inv_movdet d
LEFT JOIN inv_mov m   ON d.`no_trans` = m.`no_trans` 
LEFT JOIN inv_vales v ON m.`no_trans` = v.`no_trans`
LEFT JOIN sf_tmpdet t ON v.`idtmpenc` = t.`id_tmpenc`
WHERE v.`fecha` BETWEEN '2019-01-01' AND '2019-01-31'
AND v.`oper` IS NULL
AND d.`cod_art` = t.`cod_art`
AND d.`cod_art` IN (705)
;

-- REVISION MOVIMIENTO PRODUCTO X CONTABILIDAD
SELECT e.`id_tmpenc`, e.`fecha`, e.`tipo_doc`, e.`no_doc`, e.`estado`, d.`id_tmpdet`, d.`cuenta`, d.`debe`, d.`haber`, d.`cod_art`, d.`cant_art`, e.`glosa`
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
WHERE e.`fecha` BETWEEN '2019-03-01' AND '2019-12-31'
AND d.`cod_art` = 642
;

-- VALES ENTRADAS DE PRODUCCION
SELECT d.cod_art, SUM(d.monto) AS monto, SUM(d.cantidad) AS cantidad, SUM(d.monto) / SUM(d.cantidad) AS costoUni
FROM inv_vales i 
JOIN inv_movdet d ON i.no_trans = d.no_trans
WHERE i.fecha BETWEEN '2019-02-01' AND '2019-02-28'
AND i.cod_alm = 2
AND (i.idordenproduccion IS NOT NULL OR i.idproductobase IS NOT NULL)
AND d.cod_art = 703
GROUP BY d.cod_art
;

-- VALES DE COMPRAS - ASIENTOS DETALLE
SELECT DISTINCT e.`id_tmpenc`, e.`no_trans`, e.`fecha`, e.`tipo_doc`, e.`no_doc`, d.`cuenta`, d.`id_tmpdet`, d.`debe`, d.`haber`,  de.`tipo_mov`,
e.`glosa`, d.`cod_art`, d.`cant_art`,
 e.`cod_prov`, v.`no_trans`, v.`cod_doc`, v.`no_vale`, v.`cod_alm`, v.`id_com_encoc`, de.`cod_art`, de.`cantidad`, de.`monto`
FROM sf_tmpenc e 
JOIN sf_tmpdet d ON e.`id_tmpenc` = d.`id_tmpenc`
JOIN arcgms a 	 ON d.`cuenta` = a.`cuenta`
JOIN inv_vales v ON e.`id_tmpenc` = v.`idtmpenc`
JOIN inv_movdet de ON v.`no_trans` = de.`no_trans`
WHERE e.`fecha` BETWEEN '2019-01-01' AND '2019-04-31'
AND e.`estado` <> 'ANL'
AND e.`tipo_doc` = 'TR'
AND d.`cuenta` IN ('1580110100', '1580110200')
-- and de.`tipo_mov` = 'E'
;

SELECT *
FROM sf_tmpenc e 
JOIN sf_tmpdet d ON e.`id_tmpenc` = d.`id_tmpenc`
WHERE e.`fecha` >= '2019-01-01'
AND e.`tipo_doc` = 'CD'
AND e.`no_doc` = 3
-- and d.`cuenta` IN ('1580110100', '1580110200')
;


-- Insertar de INV_INICIO a INV_PERIODO
SET @folio = (SELECT MAX(id_inv_periodo)+1 FROM inv_periodo);
INSERT INTO inv_periodo
SELECT (@folio := @folio + 1), i.cod_art, i.cantidad, /*ROUND((i.costo_uni * i.cantidad),2)*/ (i.costo_uni * i.cantidad) AS saldo_val, i.costo_uni, 1, 2019, 1, 0
FROM inv_inicio i
WHERE i.gestion = 2019
AND i.alm = 1
AND i.cantidad > 0
;
	
-- SELECT p.cod_art, (p.saldofis * p.costouni) AS monto, p.saldofis AS cantidad 
SELECT *
FROM inv_periodo p 
WHERE p.cod_alm IN (1, 3)
AND p.mes = 1
AND p.gestion = 2019
AND p.saldofis > 0 
;


-- 
SELECT * FROM inv_vales v
-- update inv_vales v set v.`cod_alm_dest` = v.`oper`
-- UPDATE inv_vales v SET v.`oper` = null
WHERE v.`fecha` BETWEEN '2019-02-01' AND '2019-02-28'
AND v.`oper` IS NOT NULL
;

-- OJO
-- Eliminar estos vales y actualizar secuencia de vales
SELECT * FROM inv_vales i 
-- UPDATE inv_vales i SET i.`estado` = 'ANL', i.`oper` = NULL, i.`cod_alm_dest` = NULL, i.`cod_doc` = 'REC'
WHERE i.`no_trans` IN (17392,17393,17497,17497,17735,17749,17951,17958);




SELECT *
FROM sf_tmpenc e 
WHERE e.`fecha` > '2019-01-01'
AND e.`tipo_doc` = 'CD'
;


-- delete from sf_tmpdet 
-- DELETE FROM sf_tmpenc 
WHERE id_tmpenc IN (
106205
);

-- delete from sf_tmpdet 
WHERE id_tmpdet IN (
613232, 613233, 614226, 614227
);

-- UPDATE inv_vales i SET i.`idtmpenc` = NULL
WHERE i.`no_trans` IN (

);

2-6705
2-6706
