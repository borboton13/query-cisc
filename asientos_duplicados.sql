SELECT *
FROM sf_tmpenc
WHERE tipo_doc = 'TR'
AND FECHA BETWEEN '2014-01-01' AND '2015-12-31'
;


SELECT *
FROM sf_tmpdet
WHERE id_tmpenc IN (
	SELECT id_tmpenc
	FROM sf_tmpenc
	WHERE tipo_doc = 'TR'
	AND FECHA BETWEEN '2014-01-01' AND '2015-12-31'
);


SELECT IDPEDIDOS
FROM pedidos
WHERE FECHA_ENTREGA BETWEEN '2015-01-01' AND '2015-12-31'
;


SELECT COUNT(*)
FROM articulos_pedido
WHERE IDVENTADIRECTA IN (
	SELECT IDVENTADIRECTA
	FROM ventadirecta
	WHERE FECHA_PEDIDO BETWEEN '2015-01-01' AND '2015-12-31'
);



SELECT CODIGO, TOTALIMPORTE, id_tmpenc, id_tmpenc_cv
FROM ventadirecta
WHERE FECHA_PEDIDO BETWEEN '2016-02-13' AND '2016-02-13'
AND IDUSUARIO = 5
;

-- ASIENTOS CI
SELECT e.`id_tmpenc`, d.`debe`, d.`haber`
FROM sf_tmpenc e
JOIN sf_tmpdet d ON e.`id_tmpenc` = d.`id_tmpenc`
WHERE e.FECHA BETWEEN '2016-02-13' AND '2016-02-13'
AND e.tipo_doc = 'CI'
AND e.`idusuario` = 5
AND d.`cuenta` = 5420110100
;

-- ASIENTOS CI
SELECT e.`id_tmpenc`, d.`debe`, d.`haber`
FROM sf_tmpenc e
JOIN sf_tmpdet d ON e.`id_tmpenc` = d.`id_tmpenc`
WHERE e.FECHA BETWEEN '2016-02-13' AND '2016-02-13'
AND e.tipo_doc = 'CV'
AND e.`idusuario` = 5
AND d.`cuenta` = 4430110900
;


-- ASIENTOS CI DUPLICADOS
SELECT e.`id_tmpenc`, e.`fecha`
FROM sf_tmpenc e
JOIN sf_tmpdet d ON e.`id_tmpenc` = d.`id_tmpenc`
WHERE e.FECHA BETWEEN '2016-01-01' AND '2016-02-29'
AND e.tipo_doc = 'CI'
AND e.`idusuario` = 5
AND d.`cuenta` = 5420110100
AND e.`id_tmpenc` NOT IN (
	SELECT id_tmpenc
	FROM ventadirecta
	WHERE FECHA_PEDIDO BETWEEN '2017-01-01' AND '2017-12-31'
	AND IDUSUARIO = 5
);

-- ASIENTOS CV DUPLICADOS
SELECT e.`id_tmpenc`
FROM sf_tmpenc e
JOIN sf_tmpdet d ON e.`id_tmpenc` = d.`id_tmpenc`
WHERE e.FECHA BETWEEN '2016-02-13' AND '2016-02-18'
AND e.tipo_doc = 'CV'
AND e.`idusuario` = 5
AND d.`cuenta` = 4430110900
AND e.`id_tmpenc` NOT IN (
	SELECT id_tmpenc_cv
	FROM ventadirecta
	WHERE FECHA_PEDIDO BETWEEN '2016-02-13' AND '2016-02-18'
	AND IDUSUARIO = 5
);


SELECT *
-- DELETE from sf_tmpdet
-- delete FROM sf_tmpenc
WHERE id_tmpenc IN (

);


