select e.`fecha`, e.`tipo_doc`, e.`no_doc`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, c.`idtipocuenta`, s.`noidentificacion`, s.`nombres`, s.`apellidopaterno`, s.`apellidomaterno`
from sf_tmpdet d
left join sf_tmpenc e 	on d.`id_tmpenc` = e.`id_tmpenc`
left join arcgms a 	on d.`cuenta` = a.`cuenta`
left join cuenta c 	on d.`idcuenta` = c.`idcuenta`
left join socio s 	on c.`idsocio` = s.`idsocio`
where e.`fecha` between '2019-01-01' and '2019-01-31'
and e.`estado` <> 'ANL'
and d.`cuenta` = '2120110200'
and d.`idcuenta` in (29) -- 63
;