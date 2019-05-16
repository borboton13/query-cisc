SELECT *
FROM sf_tmpdet d
-- update sf_tmpdet d set d.`idpersonacliente` = null
-- update sf_tmpdet d set d.`cod_prov` = null
-- update sf_tmpdet d set d.`timemillis` = null, d.`cod_uni` = null, d.`cod_cc` = null, d.`glosa` = null
WHERE d.`id_tmpdet` >= 400
AND   d.`id_tmpdet` <= 800
-- and d.`idpersonacliente` = 0
-- and d.`cod_prov` = ''
;


SELECT *
DELETE FROM sf_tmpdet
WHERE `id_tmpdet` >= 400
AND   `id_tmpdet` <= 800;


SELECT *
FROM sf_tmpenc e
WHERE e.`fecha` BETWEEN '2016-01-01' AND '2016-04-30'
;