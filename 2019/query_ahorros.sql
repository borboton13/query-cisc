select e.`fecha`, e.`tipo_doc`, e.`no_doc`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, c.`idtipocuenta`, s.`noidentificacion`, s.`nombres`, s.`apellidopaterno`, s.`apellidomaterno`
from sf_tmpdet d
left join sf_tmpenc e 	on d.`id_tmpenc` = e.`id_tmpenc`
left join arcgms a 	on d.`cuenta` = a.`cuenta`
left join cuenta c 	on d.`idcuenta` = c.`idcuenta`
left join socio s 	on c.`idsocio` = s.`idsocio`
where e.`fecha` between '2019-02-01' and '2019-02-28'
and e.`estado` <> 'ANL'
and d.`cuenta` = '2120110100'
and d.`idcuenta` in (2065)
;


select d.`cuenta`, sum(d.`debe`) as salida, sum(d.`haber`) as entrada, sum(d.`haber`) - sum(d.`debe`) as saldo
from sf_tmpdet d
left join sf_tmpenc e 	on d.`id_tmpenc` = e.`id_tmpenc`
left join arcgms a 	on d.`cuenta` = a.`cuenta`
left join cuenta c 	on d.`idcuenta` = c.`idcuenta`
left join socio s 	on c.`idsocio` = s.`idsocio`
where e.`fecha` between '2019-01-01' and '2019-01-31'
and e.`estado` <> 'ANL'
and d.`cuenta` = '2120110100'
and d.`idcuenta` in (2065)
group by d.`cuenta`
;

select sum(d.`haber`) - sum(d.`debe`) as saldo
from sf_tmpdet d
left join sf_tmpenc e 	on d.`id_tmpenc` = e.`id_tmpenc`
where e.`fecha` between '2019-01-01' and '2017-01-31'
and e.`estado` <> 'ANL'
and d.`cuenta` = '2120110100'
and d.`idcuenta` in (2065)
-- group by d.`cuenta`
;

-- CERTIFICADO APORTACION
select e.`id_tmpenc`, d.`id_tmpdet`, e.`fecha`, e.`tipo_doc` as tipo, E.`no_doc`, d.`no_trans`,  e.`glosa`,  e.`cod_prov`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, 
d.`id_tmpenc`, e.`estado`, d.`idsocio`
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
left join arcgms a    on d.`cuenta` = a.`cuenta`
where e.`tipo_doc` = 'CI'
and d.`cuenta` = '3110100000'
and e.`fecha` between '2019-01-01' and '2019-08-30'
;

select e.`fecha`, e.`glosa`, s.`nombres`, s.`apellidopaterno`, s.`apellidomaterno`, d.`cuenta`, d.`debe`, d.`haber`, d.`idsocio`
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
left join socio s on d.`idsocio` = s.`idsocio`
where d.`cuenta` = '3110100000'
;

select s.idsocio, s.`nombres`, s.`apellidopaterno`, s.`apellidomaterno`, d.`cuenta`, sum(d.`debe`) as debe, sum(d.`haber`) as haber, sum(d.`haber`)-sum(d.`debe`) as saldo
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
left join socio s on d.`idsocio` = s.`idsocio`
where d.`cuenta` = '3110100000'
group by s.idsocio, s.`nombres`, s.`apellidopaterno`, s.`apellidomaterno`, d.`cuenta`
;

-- 
-- socios - personas - por ci
select s.`idsocio`, s.`nombres`, s.`apellidopaterno`, s.`apellidomaterno`, s.`noidentificacion`, e.`identidad`, e.`noidentificacion`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`
from socio s
join entidad e on s.`noidentificacion` = e.`noidentificacion`
join persona p on e.`identidad` = p.`idpersona`
;

--
-- socios - personas - por nombres
select s.`idsocio`, s.`nombres`, s.`apellidopaterno`, s.`apellidomaterno`, s.`noidentificacion`, p.`idpersona`, e.`noidentificacion`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`
from socio s, persona p, entidad e
where s.`nombres` = p.`nombres`
and s.`apellidopaterno` = p.`apellidopaterno`
and s.`apellidomaterno` = p.`apellidomaterno`
and p.`idpersona` = e.`identidad`
;

--
-- CUENTAS DE AHORRO - MOVIMIENTOS
select e.`id_tmpenc`, e.`fecha`, e.`estado`, e.`tipo_doc`, e.`no_doc`, d.`id_tmpdet`, d.`idcuenta`, c.`nocuenta`, s.`nombres`, s.`apellidopaterno`, d.`debe`, d.`haber`
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
left join cuenta c on d.`idcuenta` = c.`idcuenta`
left join socio s on c.`idsocio` = s.`idsocio`
where d.`idcuenta` is not null
;

-- CUENTAS DE AHORRO - SALDO
select d.`idcuenta`, c.`nocuenta`, s.`nombres`, s.`apellidopaterno`, sum(d.`debe`) as debit , sum(d.`haber`) as credit, sum(d.`haber`) - sum(d.`debe`) as saldo
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
left join cuenta c on d.`idcuenta` = c.`idcuenta`
left join socio s on c.`idsocio` = s.`idsocio`
where d.`idcuenta` is not null
group by d.`idcuenta`, c.`nocuenta`, s.`nombres`, s.`apellidopaterno`
;





