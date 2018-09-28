-- Productore
SELECT e.`noidentificacion`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`
FROM productormateriaprima pr
LEFT JOIN persona p ON pr.`idproductormateriaprima` = p.`idpersona`
LEFT JOIN entidad e ON p.`idpersona` = e.`identidad`
;

-- Clientes
SELECT p.`NRO_DOC`, p.`NOM`, p.`AP`, p.`AM`, p.`TIPO_PERSONA`, p.`ESPERSONA`, p.`NIT`
FROM personacliente p
;

-- Productores - Clientes
SELECT e.`noidentificacion`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, pc.`IDPERSONACLIENTE`, pc.`NRO_DOC`, pc.`NIT`, z.`nombre`
FROM productormateriaprima pr
LEFT JOIN persona p ON pr.`idproductormateriaprima` = p.`idpersona`
LEFT JOIN entidad e ON p.`idpersona` = e.`identidad`
LEFT JOIN personacliente pc ON e.`noidentificacion` = pc.`NRO_DOC`
LEFT JOIN zonaproductiva z ON pr.`idzonaproductiva` = z.`idzonaproductiva`
WHERE e.`noidentificacion` <> 0
;



SELECT p.
FROM personacliente p
WHERE p.IDPERSONACLIENTE >= 1051 AND p.`IDPERSONACLIENTE` <= 1375
;

