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