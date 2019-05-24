
-- DELETE CIs
-- 1.-
SELECT *
DELETE FROM sf_tmpdet
WHERE id_tmpenc IN (
	SELECT id_tmpenc
	FROM sf_tmpenc
	WHERE tipo_doc = 'CI'
	AND fecha BETWEEN '2014-01-01' AND '2015-12-31'
)
;

-- 2.- delete pago

SELECT *
DELETE FROM pago
WHERE id_tmpenc IN (
	SELECT id_tmpenc
	FROM sf_tmpenc
	WHERE tipo_doc = 'CI'
	AND fecha BETWEEN '2014-01-01' AND '2015-12-31'
)
;

-- 3.-

	SELECT id_tmpenc
	DELETE FROM sf_tmpenc
	WHERE tipo_doc = 'CI'
	AND fecha BETWEEN '2014-01-01' AND '2015-12-31'
;