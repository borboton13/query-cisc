SELECT COUNT(*)
FROM sf_tmpenc e
WHERE e.`fecha` BETWEEN '2016-10-01' AND '2016-10-31'
;



al 20/11/2016 2276

al 17/01/2017 2277
;


SELECT SUM(d.`debe`) AS debe_t, SUM(d.`haber`) AS haber_t, SUM(d.`debe`)-SUM(d.`haber`) AS diferencia
FROM sf_tmpdet d
JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
WHERE e.`fecha` BETWEEN '2016-01-01' AND '2016-12-31' 
AND d.`cuenta` = 1421010100
AND e.`estado` <> 'ANL'
;

-- SELECT SUM(d.`debe`) AS debe_t, SUM(d.`haber`) AS haber_t, SUM(d.`debe`)-SUM(d.`haber`) AS diferencia
SELECT e.`id_tmpenc`, e.`cod_prov`, e.`fecha`, e.`tipo_doc`, e.`no_doc`, e.`estado`, d.`cuenta`, d.`debe`, d.`haber`, d.`idpersonacliente`, d.`cod_prov`
FROM sf_tmpdet d
JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
WHERE e.`fecha` BETWEEN '2016-01-01' AND '2016-12-31' 
AND d.`cuenta` = 1421010100
AND e.`estado` <> 'ANL'
;


SELECT *
FROM 	(
	SELECT d.`id_tmpdet`, e.`fecha`, e.`estado`, e.`tipo_doc`, e.`no_doc`, d.`debe`, d.`haber`
	FROM khipus.sf_tmpdet d
	JOIN khipus.sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
	WHERE e.`fecha` BETWEEN '2016-10-01' AND '2016-10-31' 
	AND d.`cuenta` = 1510110201
	AND e.`estado` <> 'ANL'
	) a
LEFT JOIN (
	SELECT d.`id_tmpdet`, e.`fecha`, e.`estado`, e.`tipo_doc`, e.`no_doc`, d.`debe`, d.`haber`
	FROM khipus2011.sf_tmpdet d
	JOIN khipus2011.sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
	WHERE e.`fecha` BETWEEN '2016-10-01' AND '2016-10-31' 
	AND d.`cuenta` = 1510110201
	AND e.`estado` <> 'ANL'
	) b ON a.id_tmpdet = b.id_tmpdet
;

	
	