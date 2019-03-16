SELECT *
FROM sf_tmpenc e
WHERE e.`fecha` BETWEEN '2018-01-01' AND '2018-12-31'
AND e.`estado` = 'PEN'
;


SELECT e.`id_tmpenc`, d.`id_tmpdet`, e.`fecha`, e.`no_trans`, e.`tipo_doc`, e.`no_doc`, d.`cuenta`, d.`debe`, d.`haber`, d.`idpersonacliente`, d.`cod_prov`, e.`glosa`
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
WHERE e.`fecha` BETWEEN '2016-01-01' AND '2019-12-31'
AND e.`estado` <> 'ANL'
AND d.`cuenta` = '2429910600'
AND d.`cod_prov` IS NOT NULL
-- and e.`tipo_doc` = 'CD'
-- and d.`cod_prov` = 746
-- and d.`idpersonacliente` is null
;


SELECT e.`tipo_doc`, d.`cuenta`, d.`idpersonacliente`, SUM(d.`debe`), SUM(d.`haber`)
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
WHERE e.`fecha` BETWEEN '2016-01-01' AND '2018-12-31'
AND e.`estado` <> 'ANL'
AND d.`cuenta` = '5210110000'
-- and d.`cod_prov` is null
-- and e.`tipo_doc` = 'CD'
-- AND d.`idpersonacliente` IS NULL
GROUP BY e.`tipo_doc`, d.`cuenta`, d.`idpersonacliente`
;

SELECT *
FROM personacliente p
WHERE p.`NOM` LIKE '%cliza%'
-- where p.`IDPERSONACLIENTE` = 312
-- where p.`RAZONSOCIAL`like "%lechero%"
;

-- update sf_tmpdet d set d.`cod_prov` = 780, d.`idpersonacliente` = NULL
WHERE d.`id_tmpdet` IN (

);


SELECT *
FROM pedidos p
WHERE p.`CODIGO` = 7683
-- where p.`IDCLIENTE` = 428
;


SELECT *
FROM documentocompra d
WHERE d.`iddocumentocompra` IN (
7497
);




