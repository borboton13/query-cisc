SELECT p.*, pe.`NOM`, pe.`AP`, d.*, a.`descri`
FROM pago p
JOIN personacliente pe ON p.`IDPERSONACLIENTE` = pe.`IDPERSONACLIENTE`
JOIN sf_tmpenc e ON p.`id_tmpenc` = e.`id_tmpenc`
JOIN sf_tmpdet d ON e.`id_tmpenc` = d.`id_tmpenc`
JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
WHERE p.`fecha` BETWEEN '2017-11-22 00:00:00' AND '2017-11-22 23:59:00'
AND P.`idusuario` = 404
;

