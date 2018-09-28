-- Vista para Reporte COSTO DE PRODUCCION
CREATE VIEW costoproduccion AS
SELECT e.`id_tmpenc`, d.`id_tmpdet`, e.`fecha`, e.`tipo_doc`, e.`no_doc`, e.`no_trans`, o.`codigo`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`
FROM sf_tmpenc e
JOIN ordenproduccion o ON e.`id_tmpenc` = o.`id_tmpenc`
JOIN sf_tmpdet d ON e.`id_tmpenc` = d.`id_tmpenc`
JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
WHERE e.estado <> 'ANL'
UNION
SELECT e.`id_tmpenc`, d.`id_tmpdet`, e.`fecha`, e.`tipo_doc`, e.`no_doc`, e.`no_trans`, b.`codigo`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`
FROM sf_tmpenc e
JOIN productobase b    ON e.`id_tmpenc` = b.`id_tmpenc`
JOIN sf_tmpdet d ON e.`id_tmpenc` = d.`id_tmpenc`
JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
WHERE e.estado <> 'ANL'
;

--

SELECT d.`cuenta`, a.`descri`, SUM(d.`debe`) AS D, SUM(d.`haber`) AS H
FROM sf_tmpenc e
JOIN ordenproduccion o ON e.`id_tmpenc` = o.`id_tmpenc`
JOIN sf_tmpdet d ON e.`id_tmpenc` = d.`id_tmpenc`
JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
GROUP BY d.`cuenta`, a.`descri`
;

-- 
SELECT c.`cuenta`, c.`descri`, SUM(c.`debe`) AS D, SUM(c.`haber`) AS H
FROM costoproduccion c
GROUP BY c.`cuenta`, c.`descri`
;
