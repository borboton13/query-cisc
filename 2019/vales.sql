-- EGRESOS
select *
from inv_vales i
where i.`fecha` between '2020-10-01' and '2020-10-31'
-- and i.`cod_doc` = 'EGR'
and i.`oper` is null
and i.`estado` <> 'ANL'
-- and i.`cod_alm` in (1,3,4,7)
;


select *
from inv_vales i
where i.`no_vale` = '3-4493'
;


-- RECEPCION
select *
from inv_vales i
where i.`fecha` between '2020-09-01' and '2020-09-31'
and i.`cod_doc` = 'REC'
and i.`oper` is not null
-- and i.`cod_alm` in (1,3)
;


-- VALES DETALLE DE ARTICULOS
select i.`fecha`, i.`id_com_encoc`, i.`no_vale`, i.`cod_doc`, i.`estado`, i.`oper`, d.`cod_art`, a.`descri`, d.`cantidad`, a.`cod_med`, d.`costounitario`, d.`monto`, i.`idtmpenc`
from inv_vales i
join inv_movdet d on i.`no_trans` = d.`no_trans`
join inv_articulos a on d.`cod_art` = a.`cod_art`
where i.`fecha` between '2020-12-01' and '2020-12-31'
-- and i.`cod_doc` = 'EGR'
and i.`oper` is null
-- and i.`cod_alm` in (1)
;


-- REVISION CIERRES DIARIOS (revisar si esta contabilizado SA)
select i.`no_trans`, i.`fecha`, i.`cod_doc`, i.`no_vale`, i.`estado`, i.`oper`, i.`id_com_encoc`, i.`idtmpenc`, e.`tipo_doc`, e.`no_doc`
from inv_vales i
left join sf_tmpenc e on i.`idtmpenc` = e.`id_tmpenc`
where i.`fecha` between '2021-05-01' and '2021-05-31'
and i.`cod_doc` = 'EGR' 
and i.`oper` is null
;


select d.`id_tmpdet`, d.`debe`, d.`haber`, d.`id_tmpenc`, d.`cod_art`, d.`cant_art`, e.`estado`
from sf_tmpdet d
left join sf_tmpenc e on d.`id_tmpenc` = e.`id_tmpenc`
where e.`fecha` between '2020-09-01' and '2020-09-30'
and d.`cuenta` = '1810310201'
;


select *
from sf_tmpenc e 
where e.`fecha` between '2021-01-01' and '2021-05-20'
and e.`tipo_doc` = 'SA'
;


select *
from inv_vales i
where i.`no_trans` in (
26513, 26514
);


update inv_movdet i set i.`estado` = 'ANL' where i.`no_trans` in (26608, 26609);
update inv_mov i set i.`estado` = 'ANL' where i.`no_trans` in (26608, 26609);
update inv_vales i set i.`estado` = 'ANL' where i.`no_trans` in (26608, 26609);



