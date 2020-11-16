-- 1. ACTIVO
select e.`fecha`, e.`tipo_doc`, e.`no_doc`, e.`estado`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
left join arcgms a    on d.`cuenta` = a.`cuenta`
-- where a.`cuenta` >= '1000000000' and a.`cuenta` < '2000000000'
where a.`tipo` = 'A'
and e.`fecha` between '2020-01-01' and '2020-10-31'
;

select d.`cuenta`, a.`descri`, sum(d.`debe`) as D , sum(d.`haber`) as H
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
left join arcgms a    on d.`cuenta` = a.`cuenta`
-- WHERE a.`cuenta` >= '1000000000' AND a.`cuenta` < '2000000000'
where a.`tipo` = 'A'
and e.`estado` <> 'ANL'
and e.`fecha` between '2017-04-05' and '2017-04-05'
group by d.`cuenta`, a.`descri`
;

--
--
-- REPORTE BASE DETALLE
select a.`cta_raiz`, e.`tipo_doc`, e.`no_doc`, a.`cuenta`, a.`descri`, d.`debe`, d.`haber`
from arcgms a
left join sf_tmpdet d on a.`cuenta` = d.`cuenta`
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
where a.`tipo` = 'A'
;

--
-- REPORTE BASE
select a.`cta_raiz`, b.`descri`, sum(d.`debe`) as D, sum(d.`haber`) as H
from arcgms a
left join sf_tmpdet d on a.`cuenta` = d.`cuenta`
-- LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
left join arcgms b on a.`cta_raiz` = b.`cuenta`
where a.`tipo` = 'A'
group by a.`cta_raiz`, b.`descri`
;

-- REPORTE BASE Nivel 2
-- Reporte para Balance General
select b.`cta_raiz` as cuentaR, b.`descri`, sum(d.`debe`) as D, sum(d.`haber`) as H, sum(d.`debe`) - sum(d.`haber`) as Saldo
from sf_tmpdet d
left join sf_tmpenc e   on d.`id_tmpenc` = e.`id_tmpenc`
left join arcgms a on d.`cuenta` = a.`cuenta`
left join arcgms b on a.`cta_raiz` = b.`cuenta`
where a.`tipo` = 'A'
and e.`fecha` between '2020-01-01' and '2020-10-31'
and e.estado <> 'ANL'
group by a.`cta_raiz`, b.`descri`
;

-- REPORTE BASE desde SF_TMPDet (nivel 3)
select c.`cta_niv3`, c.`descri`, sum(d.`debe`) as D, sum(d.`haber`) as H, sum(d.`debe`) - sum(d.`haber`) as D_H
from sf_tmpdet d
left join sf_tmpenc e   on d.`id_tmpenc` = e.`id_tmpenc`
left join arcgms a on d.`cuenta` = a.`cuenta`
-- LEFT JOIN arcgms b ON a.`cta_raiz` = b.`cuenta`
left join arcgms c on a.`cta_niv3` = c.`cuenta`
where a.`tipo` = 'A'
and e.`fecha` between '2020-01-01' and '2020-10-31'
and e.`estado` <> 'ANL'
-- and c.`cta_niv3` = '4420000000'
group by c.`cta_niv3`, c.`descri`
;


-- REPORTE BASE desde SF_TMPDet (nivel 3) DETALLE
-- SELECT c.`cta_niv3`, c.`descri`, SUM(d.`debe`) AS D, SUM(d.`haber`) AS H
select c.`cta_niv3`, c.`descri`, b.`descri`, e.`glosa`, e.`tipo_doc`, e.`no_doc`, e.`estado`, d.`cuenta`, a.`descri`,  d.`debe`, d.`haber`
from sf_tmpdet d
left join sf_tmpenc e   on d.`id_tmpenc` = e.`id_tmpenc`
left join arcgms a on d.`cuenta` = a.`cuenta`
left join arcgms b on a.`cta_raiz` = b.`cuenta`
left join arcgms c on a.`cta_niv3` = c.`cuenta`
where a.`tipo` = 'E'
and e.`fecha` between '2018-03-01' and '2018-03-31'
and e.`estado` <> 'ANL'
and c.`cta_niv3` = '4460000000'
-- GROUP BY c.`cta_niv3`, c.`descri`
;


select *
from arcgms a
-- WHERE a.`tipo` IN ('A', 'P', 'C', 'E', 'I')
where a.`tipo` in ('I')
-- AND a.`cn_nivel` = 2
and a.`cn_nivel` in (1, 2, 3, 4)
;

--
alter table arcgms add column cta_niv3 varchar(20) null after cta_raiz;
-- INSERTAR LA CUENTA 443XXXXXX

select *
from arcgms a
where a.`cuenta` >= '4400000000' and a.`cuenta` < '4500000000'
-- AND a.`cn_nivel` IN (1, 2, 3, 4)
;


select * from arcgms a
-- update arcgms a set cta_niv3 = '4420000000' 
where a.`cuenta` >= '4420000000' and a.`cuenta` < '4430000000';

select * from arcgms a
-- update arcgms a set cta_niv3 = '4430000000' 
where a.`cuenta` >= '4430000000' and a.`cuenta` < '4440000000';

select * from arcgms a
-- update arcgms a set cta_niv3 = '4450000000' 
where a.`cuenta` >= '4450000000' and a.`cuenta` < '4460000000';

select * from arcgms a
-- update arcgms a set cta_niv3 = '4460000000' 
where a.`cuenta` >= '4460000000' and a.`cuenta` < '4470000000';

select * from arcgms a
-- update arcgms a set cta_niv3 = '4470000000' 
where a.`cuenta` >= '4470000000' and a.`cuenta` < '4480000000';

-- -------------------------------------------------------------
update arcgms a set cta_niv3 = '1310000000' 
where a.`cuenta` >= '1310000000' and a.`cuenta` < '1320000000';

update arcgms a set cta_niv3 = '1320000000' 
where a.`cuenta` >= '1320000000' and a.`cuenta` < '1330000000';

update arcgms a set cta_niv3 = '1330000000' 
where a.`cuenta` >= '1330000000' and a.`cuenta` < '1340000000';

update arcgms a set cta_niv3 = '1380000000' 
where a.`cuenta` >= '1380000000' and a.`cuenta` < '1390000000';

update arcgms a set cta_niv3 = '1390000000' 
where a.`cuenta` >= '1390000000' and a.`cuenta` < '1400000000';

--
-- Para: Comprobacion Sumas y Saldos
--
select d.`cuenta`, a.`descri`, sum(d.`debe`) as D , sum(d.`haber`) as H, sum(d.`debe`) - sum(d.`haber`) as D_H
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
left join arcgms a    on d.`cuenta` = a.`cuenta`
-- WHERE a.`cuenta` >= '1000000000' AND a.`cuenta` < '2000000000'
where a.`tipo` = 'A'
and e.`estado` <> 'ANL'
and e.`fecha` between '2017-04-05' and '2017-04-05'
group by d.`cuenta`, a.`descri`
;



-- VERIFICACION Asientos, montos Debe - Haber
select e.id_tmpenc, e.tipo_doc, e.no_doc, e.estado, sum(d.`debe`) as D , sum(d.`haber`) as H, sum(d.`debe`) - sum(d.`haber`) as D_H
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
left join arcgms a    on d.`cuenta` = a.`cuenta`
where e.`estado` <> 'ANL'
and e.`fecha` between '2017-01-01' and '2017-04-30'
group by e.id_tmpenc, e.tipo_doc, e.no_doc, e.estado
;






