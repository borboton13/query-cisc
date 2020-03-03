-- EGRESOS
select *
from inv_vales i
where i.`fecha` between '2020-01-01' and '2020-12-31'
and i.`cod_doc` = 'EGR'
and i.`oper` is null
and i.`cod_alm` in (1,3)
;

-- RECEPCION
select *
from inv_vales i
where i.`fecha` between '2020-01-01' and '2020-12-31'
and i.`cod_doc` = 'REC'
and i.`oper` is null
and i.`cod_alm` in (1,3)
;


select i.`fecha`, i.`no_vale`, i.`cod_doc`, i.`estado`, d.`cod_art`, a.`descri`, d.`cantidad`, a.`cod_med`, d.`costounitario`, d.`monto`, i.`idtmpenc`
from inv_vales i
join inv_movdet d on i.`no_trans` = d.`no_trans`
join inv_articulos a on d.`cod_art` = a.`cod_art`
where i.`fecha` between '2020-01-01' and '2020-01-31'
and i.`cod_doc` = 'EGR'
and i.`oper` is null
and i.`cod_alm` in (1)
;






