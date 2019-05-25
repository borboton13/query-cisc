SELECT e.`fecha`, e.`tipo_doc`, e.`no_doc`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, c.`idtipocuenta`, s.`nombres`, s.`apellidopaterno`
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e 	ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a 	ON d.`cuenta` = a.`cuenta`
LEFT JOIN cuenta c 	ON d.`idcuenta` = c.`idcuenta`
LEFT JOIN socio s 	ON c.`idsocio` = s.`idsocio`
WHERE e.`fecha` >= '2018-12-01'
-- and d.`cuenta` = '2120110200'
AND d.`idcuenta` = 4
;