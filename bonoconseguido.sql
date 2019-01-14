SELECT bc.`idbonoconseguido`, b.`tipobono`, b.`idbono`, b.`nombre`, bc.`monto`, c.`mes`, bc.`idcontratopuesto`
FROM bonoconseguido bc
JOIN bono b 			ON bc.`idbono` = b.`idbono`
JOIN ciclogeneracionplanilla c 	ON bc.`idciclogeneracionplanilla` = c.`idciclogeneracionplanilla`
;

SELECT b.*, bo.`nombre`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`
FROM bonoconseguido b
LEFT JOIN contratopuesto cp 	ON b.`idcontratopuesto` = cp.`idcontratopuesto`
LEFT JOIN contrato c 		ON cp.`idcontrato` = c.`idcontrato`
LEFT JOIN empleado e 		ON c.`idempleado` = e.`idempleado`
LEFT JOIN persona p 		ON e.`idempleado` = p.`idpersona`
LEFT JOIN entidad en 		ON p.`idpersona` = en.`identidad`
LEFT JOIN bono bo 		ON b.`idbono` = bo.`idbono`
WHERE b.`idciclogeneracionplanilla` = 13
;
