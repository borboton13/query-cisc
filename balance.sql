-- 1. ACTIVO
SELECT e.`fecha`, e.`tipo_doc`, e.`no_doc`, e.`estado`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
-- where a.`cuenta` >= '1000000000' and a.`cuenta` < '2000000000'
WHERE a.`tipo` = 'A'
;

SELECT d.`cuenta`, a.`descri`, SUM(d.`debe`) AS D , SUM(d.`haber`) AS H
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
-- WHERE a.`cuenta` >= '1000000000' AND a.`cuenta` < '2000000000'
WHERE a.`tipo` = 'A'
AND e.`estado` <> 'ANL'
AND e.`fecha` BETWEEN '2017-04-05' AND '2017-04-05'
GROUP BY d.`cuenta`, a.`descri`
;

--
--
-- REPORTE BASE DETALLE
SELECT a.`cta_raiz`, e.`tipo_doc`, e.`no_doc`, a.`cuenta`, a.`descri`, d.`debe`, d.`haber`
FROM arcgms a
LEFT JOIN sf_tmpdet d ON a.`cuenta` = d.`cuenta`
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
WHERE a.`tipo` = 'A'
;

--
-- REPORTE BASE
SELECT a.`cta_raiz`, b.`descri`, SUM(d.`debe`) AS D, SUM(d.`haber`) AS H
FROM arcgms a
LEFT JOIN sf_tmpdet d ON a.`cuenta` = d.`cuenta`
-- LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms b ON a.`cta_raiz` = b.`cuenta`
WHERE a.`tipo` = 'A'
GROUP BY a.`cta_raiz`, b.`descri`
;

-- REPORTE BASE desde SF_TMPDet
SELECT b.`cta_raiz` AS cuentaR, b.`descri`, SUM(d.`debe`) AS D, SUM(d.`haber`) AS H
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e   ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a ON d.`cuenta` = a.`cuenta`
LEFT JOIN arcgms b ON a.`cta_raiz` = b.`cuenta`
WHERE a.`tipo` = 'C'
AND e.`fecha` BETWEEN '2016-05-01' AND '2016-05-31'
GROUP BY a.`cta_raiz`, b.`descri`
;

-- REPORTE BASE desde SF_TMPDet (nivel 3)
SELECT c.`cta_niv3`, c.`descri`, SUM(d.`debe`) AS D, SUM(d.`haber`) AS H, SUM(d.`debe`) - SUM(d.`haber`) AS D_H
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e   ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a ON d.`cuenta` = a.`cuenta`
-- LEFT JOIN arcgms b ON a.`cta_raiz` = b.`cuenta`
LEFT JOIN arcgms c ON a.`cta_niv3` = c.`cuenta`
WHERE a.`tipo` = 'E'
AND e.`fecha` BETWEEN '2018-03-01' AND '2018-03-31'
AND e.`estado` <> 'ANL'
-- and c.`cta_niv3` = '4420000000'
GROUP BY c.`cta_niv3`, c.`descri`
;


-- REPORTE BASE desde SF_TMPDet (nivel 3) DETALLE
-- SELECT c.`cta_niv3`, c.`descri`, SUM(d.`debe`) AS D, SUM(d.`haber`) AS H
SELECT c.`cta_niv3`, c.`descri`, b.`descri`, e.`glosa`, e.`tipo_doc`, e.`no_doc`, e.`estado`, d.`cuenta`, a.`descri`,  d.`debe`, d.`haber`
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e   ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a ON d.`cuenta` = a.`cuenta`
LEFT JOIN arcgms b ON a.`cta_raiz` = b.`cuenta`
LEFT JOIN arcgms c ON a.`cta_niv3` = c.`cuenta`
WHERE a.`tipo` = 'E'
AND e.`fecha` BETWEEN '2018-03-01' AND '2018-03-31'
AND e.`estado` <> 'ANL'
AND c.`cta_niv3` = '4460000000'
-- GROUP BY c.`cta_niv3`, c.`descri`
;


SELECT *
FROM arcgms a
-- WHERE a.`tipo` IN ('A', 'P', 'C', 'E', 'I')
WHERE a.`tipo` IN ('I')
-- AND a.`cn_nivel` = 2
AND a.`cn_nivel` IN (1, 2, 3, 4)
;

--
ALTER TABLE arcgms ADD COLUMN cta_niv3 VARCHAR(20) NULL AFTER cta_raiz;
-- INSERTAR LA CUENTA 443XXXXXX

SELECT *
FROM arcgms a
WHERE a.`cuenta` >= '4400000000' AND a.`cuenta` < '4500000000'
-- AND a.`cn_nivel` IN (1, 2, 3, 4)
;


SELECT * FROM arcgms a
-- update arcgms a set cta_niv3 = '4420000000' 
WHERE a.`cuenta` >= '4420000000' AND a.`cuenta` < '4430000000';

SELECT * FROM arcgms a
-- update arcgms a set cta_niv3 = '4430000000' 
WHERE a.`cuenta` >= '4430000000' AND a.`cuenta` < '4440000000';

SELECT * FROM arcgms a
-- update arcgms a set cta_niv3 = '4450000000' 
WHERE a.`cuenta` >= '4450000000' AND a.`cuenta` < '4460000000';

SELECT * FROM arcgms a
-- update arcgms a set cta_niv3 = '4460000000' 
WHERE a.`cuenta` >= '4460000000' AND a.`cuenta` < '4470000000';

SELECT * FROM arcgms a
-- update arcgms a set cta_niv3 = '4470000000' 
WHERE a.`cuenta` >= '4470000000' AND a.`cuenta` < '4480000000';


--
-- Para: Comprobacion Sumas y Saldos
--
SELECT d.`cuenta`, a.`descri`, SUM(d.`debe`) AS D , SUM(d.`haber`) AS H, SUM(d.`debe`) - SUM(d.`haber`) AS D_H
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
-- WHERE a.`cuenta` >= '1000000000' AND a.`cuenta` < '2000000000'
WHERE a.`tipo` = 'A'
AND e.`estado` <> 'ANL'
AND e.`fecha` BETWEEN '2017-04-05' AND '2017-04-05'
GROUP BY d.`cuenta`, a.`descri`
;



-- VERIFICACION Asientos, montos Debe - Haber
SELECT e.id_tmpenc, e.tipo_doc, e.no_doc, e.estado, SUM(d.`debe`) AS D , SUM(d.`haber`) AS H, SUM(d.`debe`) - SUM(d.`haber`) AS D_H
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
WHERE e.`estado` <> 'ANL'
AND e.`fecha` BETWEEN '2017-01-01' AND '2017-04-30'
GROUP BY e.id_tmpenc, e.tipo_doc, e.no_doc, e.estado
;






