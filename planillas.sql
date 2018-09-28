SELECT cp.`idcontratopuesto`, c.`idcontrato`, en.`identidad`, en.`noidentificacion`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, c.`fechainicio`, c.`fechafin`
FROM contratopuesto cp
JOIN contrato c ON cp.`idcontrato` = c.`idcontrato`
JOIN empleado e ON c.`idempleado` = e.`idempleado`
JOIN persona p  ON e.`idempleado` = p.`idpersona`
JOIN entidad en ON p.`idpersona`  = en.`identidad`
;

SELECT c.`idcontrato`, c.`fechafin`
FROM contrato c
UPDATE contrato c SET c.`fechafin` = '2018-12-31'
WHERE c.`idcontrato` IN (	
);

-- update contrato c set c.`activogenplan` = 0

SELECT en.`noidentificacion`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, bc.`fechainicio`, bc.`fechafin`, bh.`horainicio`, bh.`horafin`
FROM bandahoraria bh
LEFT JOIN bandahorariacontrato bc ON bh.`idbandahoraria` = bc.`idbandahoraria`
LEFT JOIN contratopuesto cp ON bc.`idcontratopuesto` = cp.`idcontratopuesto`
LEFT JOIN contrato c ON cp.`idcontrato` = c.`idcontrato`
LEFT JOIN empleado e ON c.`idempleado` = e.`idempleado`
LEFT JOIN persona p  ON e.`idempleado` = p.`idpersona`
LEFT JOIN entidad en ON p.`idpersona` = en.`identidad`
WHERE en.`noidentificacion` = 815059
;


-- UPDATE bandahoraria bh 
LEFT JOIN bandahorariacontrato bc ON bh.`idbandahoraria` = bc.`idbandahoraria`
LEFT JOIN contratopuesto cp ON bc.`idcontratopuesto` = cp.`idcontratopuesto`
LEFT JOIN contrato c ON cp.`idcontrato` = c.`idcontrato`
LEFT JOIN empleado e ON c.`idempleado` = e.`idempleado`
LEFT JOIN persona p  ON e.`idempleado` = p.`idpersona`
LEFT JOIN entidad en ON p.`idpersona` = en.`identidad`
SET bh.`horainicio` = '01:00', bh.`horafin` = '09:00'
WHERE en.`noidentificacion` = 5207299
;

