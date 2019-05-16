SELECT r.`idreportecontrol`, r.`fecha`, r.`mindescuento`, r.`idbandahorariac`, cp.`idcontratopuesto`, em.`idempleado`, e.`noidentificacion`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`
FROM reportecontrol r
LEFT JOIN bandahorariacontrato bc ON r.`idbandahorariac` = bc.`idbandahorariacontrato`
LEFT JOIN contratopuesto cp ON bc.`idcontratopuesto` = cp.`idcontratopuesto`
LEFT JOIN contrato c ON cp.`idcontrato` = c.`idcontrato`
LEFT JOIN empleado em ON c.`idempleado` = em.`idempleado`
LEFT JOIN persona p ON em.`idempleado` = p.`idpersona`
LEFT JOIN entidad e ON p.`idpersona` = e.`identidad`
WHERE r.`fecha` BETWEEN '2018-05-01' AND '2018-05-31'
;

SELECT em.`idempleado`, e.`noidentificacion`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, SUM(r.`mindescuento`) AS min_retraso
FROM reportecontrol r
LEFT JOIN bandahorariacontrato bc ON r.`idbandahorariac` = bc.`idbandahorariacontrato`
LEFT JOIN contratopuesto cp ON bc.`idcontratopuesto` = cp.`idcontratopuesto`
LEFT JOIN contrato c ON cp.`idcontrato` = c.`idcontrato`
LEFT JOIN empleado em ON c.`idempleado` = em.`idempleado`
LEFT JOIN persona p ON em.`idempleado` = p.`idpersona`
LEFT JOIN entidad e ON p.`idpersona` = e.`identidad`
WHERE r.`fecha` BETWEEN '2018-05-01' AND '2018-05-31'
GROUP BY em.`idempleado`, e.`noidentificacion`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`
;

SELECT r.`idreportecontrol`, r.`fecha`, r.`mindescuento`, r.`numerofaltabandas`, r.`idbandahorariac`, cp.`idcontratopuesto`, em.`idempleado`, e.`noidentificacion`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, r.`marcaciones`
FROM reportecontrol r
LEFT JOIN bandahorariacontrato bc ON r.`idbandahorariac` = bc.`idbandahorariacontrato`
LEFT JOIN contratopuesto cp ON bc.`idcontratopuesto` = cp.`idcontratopuesto`
LEFT JOIN contrato c ON cp.`idcontrato` = c.`idcontrato`
LEFT JOIN empleado em ON c.`idempleado` = em.`idempleado`
LEFT JOIN persona p ON em.`idempleado` = p.`idpersona`
LEFT JOIN entidad e ON p.`idpersona` = e.`identidad`
WHERE r.`fecha` BETWEEN '2018-05-01' AND '2018-05-31'
;