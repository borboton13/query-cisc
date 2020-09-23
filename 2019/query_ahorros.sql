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

-- CUENTAS DPF
select c.`idcuenta`, c.`fechaapertura`, c.`fechavence`, c.`nocuenta`, c.`moneda`, c.`saldo`, t.`nombre`, t.`tipo`
from cuenta c
join tipocuenta t on c.`idtipocuenta` = t.`idtipocuenta`
where t.`tipo` = 'DPF'
;

-- CERTIFICADO APORTACION
select e.`id_tmpenc`, d.`id_tmpdet`, e.`fecha`, e.`tipo_doc` as tipo, E.`no_doc`, d.`no_trans`,  e.`glosa`,  e.`cod_prov`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, 
d.`id_tmpenc`, e.`estado`, d.`idsocio`
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
left join arcgms a    on d.`cuenta` = a.`cuenta`
where e.`fecha` between '2018-01-01' and '2020-12-30'
-- and e.`tipo_doc` = 'CI'
-- and d.`cuenta` = '3110100000'
and d.`idsocio` = 222
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
select e.`id_tmpenc`, e.`fecha`, e.`estado`, e.`tipo_doc`, e.`no_doc`, d.`id_tmpdet`, d.`idcuenta`, c.`nocuenta`, 
s.`nombres`, s.`apellidopaterno`, d.`debe`, d.`haber`, d.`debeme`, d.`haberme`
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
left join cuenta c on d.`idcuenta` = c.`idcuenta`
left join socio s on c.`idsocio` = s.`idsocio`
where d.`idcuenta` is not null
and c.`nocuenta` in ( 200519, 100338)
order by e.`fecha`, d.`id_tmpdet`
;

-- CUENTAS DE AHORRO - SALDO
select s.`idsocio`, c.idcuenta, s.`nombres`, s.`apellidopaterno`, s.`apellidopaterno`, c.fechaapertura, c.fechavence,  c.`nocuenta`, c.`codigo`, c.`moneda`, 
	sum(d.`haber`) - sum(d.`debe`) saldoBs,
	sum(d.haberme) - sum(d.`debeme`) saldoME
from sf_tmpdet d
join sf_tmpenc e 	on d.id_tmpenc = e.id_tmpenc
join cuenta c 		on d.`idcuenta` = c.`idcuenta`
join tipocuenta t	on c.idtipocuenta = t.idtipocuenta
join socio s on c.`idsocio` = s.`idsocio`
where e.estado <> 'ANL'
-- and t.tipo = 'DPF'
and c.`nocuenta` in ( 200519, 100338)
group by s.`idsocio`, c.idcuenta, s.`nombres`, s.`apellidopaterno`, s.`apellidopaterno`, c.fechaapertura, c.fechavence, c.`nocuenta`, c.`codigo`, c.`moneda`
;

-- 
delete from sf_tmpdet where id_tmpdet in (580956, 583816, 586694, 589560, 592415, 595244, 598066, 601793 );

select *
from sf_tmpdet d where d.`id_tmpdet` = 578040;

-- Para corregir capitalizacion intereses
update sf_tmpdet d set d.`haber` = 3.27 , d.`haberme` =  0.47 where d.`id_tmpdet` = 578077 ; 
update sf_tmpdet d set d.`debe`  = 0.42 , d.`debeme`  = 0.06  where d.`id_tmpdet` = 578078 ; 

update sf_tmpdet d set d.`haber` = 0.07 , d.`haberme` =  0.01
where d.`id_tmpdet` in (580957, 583817, 586695, 589561,592416,595245, 598067, 601794  );

update sf_tmpdet d set d.`haber` =  where d.`id_tmpdet` =  ; 
update sf_tmpdet d set d.`debe`  =  where d.`id_tmpdet` =  ; 


-- update cuenta c set c.`estado` = 'INACTIVE' where c.`nocuenta` = '100149';
-- update cuenta c set c.`estado` = 'INACTIVE' where c.`nocuenta` = '100079';

-- Anular solo para capitalizar intereses, luego revertir
update sf_tmpenc e set e.`estado` = 'ANL' where e.`id_tmpenc` = 104401;

