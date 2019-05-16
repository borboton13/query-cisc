SELECT *
FROM personacliente p
WHERE p.`TIPO_PERSONA` = 'cliente'
AND (p.`NIT` = '' OR p.`NIT` IS NULL)
;

SELECT *
FROM personacliente p
WHERE p.`TIPO_PERSONA` = 'cliente'
AND (p.`RAZONSOCIAL` = '' OR p.`RAZONSOCIAL` IS NULL)
;

-- Update 1 NIT clientes
UPDATE personacliente p SET p.`NIT` = p.`NRO_DOC`
WHERE p.`TIPO_PERSONA` = 'cliente'
AND (p.`NIT` = '' OR p.`NIT` IS NULL)
;

-- Update 2 RAZONSOCIAL cleintes
UPDATE personacliente p SET p.`RAZONSOCIAL` = CONCAT(p.`AP`, ' ', p.`AM`, ' ',p.`NOM`)
WHERE p.`TIPO_PERSONA` = 'cliente'
AND (p.`RAZONSOCIAL` = '' OR p.`RAZONSOCIAL` IS NULL)
;