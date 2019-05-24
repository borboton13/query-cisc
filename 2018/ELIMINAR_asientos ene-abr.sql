/** ELIMINANDO registros enero a abril **/
-- 0.- fecha ONUPDATE false
-- 1.-
SELECT *
FROM pago p
-- update pago p set p.`id_tmpenc` = null
WHERE p.`fecha` BETWEEN '2016-01-01 00:00:00' AND '2016-04-30 23:59:59'
;

-- 2.-
SELECT *
FROM pago
UPDATE pago SET id_tmpenc = NULL
WHERE id_tmpenc IN (
	SELECT e.`id_tmpenc`
	FROM sf_tmpenc e
	WHERE e.`fecha` BETWEEN '2016-01-01' AND '2016-04-30'
);

-- 3.-
SELECT *
FROM sf_tmpdet
DELETE FROM sf_tmpdet
WHERE id_tmpenc IN (
	SELECT e.`id_tmpenc`
	FROM sf_tmpenc e
	WHERE e.`fecha` BETWEEN '2016-01-01' AND '2016-04-30'
);

-- 4.-
SELECT *
FROM sf_tmpenc
DELETE FROM sf_tmpenc
WHERE fecha BETWEEN '2016-01-01' AND '2016-04-30'
;

-- 5.- pagos que se modificaron la fecha a Julio
UPDATE pago SET fecha =	'2016-01-15 00:00:01'	 WHERE 	id_pago = 	456	;
UPDATE pago SET fecha =	'2016-02-29 00:00:01'	 WHERE 	id_pago = 	2713	;
UPDATE pago SET fecha =	'2016-02-29 00:00:01'	 WHERE 	id_pago = 	2714	;
UPDATE pago SET fecha =	'2016-02-29 00:00:01'	 WHERE 	id_pago = 	2715	;
UPDATE pago SET fecha =	'2016-02-29 00:00:01'	 WHERE 	id_pago = 	2716	;
UPDATE pago SET fecha =	'2016-02-29 00:00:01'	 WHERE 	id_pago = 	2717	;
UPDATE pago SET fecha =	'2016-02-29 00:00:01'	 WHERE 	id_pago = 	2718	;
-- --------------------------------------------------------------------
-- --------------------------------------------------------------------

SELECT *
FROM sf_tmpenc e
WHERE e.`fecha` BETWEEN '2016-01-01' AND '2016-04-30'
;

SELECT *
FROM pago p
-- where p.`fecha` < '2016-05-01'
WHERE p.`fecha` BETWEEN '2016-01-01 00:00:00' AND '2016-04-30 23:59:59'
;

SELECT e.`id_tmpenc`
FROM sf_tmpenc e
WHERE e.`fecha` BETWEEN '2016-01-01' AND '2016-04-30'
;


SELECT *
FROM pago
WHERE id_tmpenc IN (
	SELECT e.`id_tmpenc`
	FROM sf_tmpenc e
	WHERE e.`fecha` BETWEEN '2016-01-01' AND '2016-04-30'
);

SELECT p.*, e.`fecha`
FROM pago p
JOIN sf_tmpenc e ON p.`id_tmpenc` = e.`id_tmpenc`
WHERE p.id_pago IN (
456	,
2713	,
2714	,
2715	,
2716	,
2717	,
2718
);





SELECT *
FROM sf_tmpenc
-- DELETE FROM sf_tmpenc
-- delete FROM sf_tmpdet
WHERE `id_tmpenc` IN (
29286, 29287
);
