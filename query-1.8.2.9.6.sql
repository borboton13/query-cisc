ALTER TABLE ordenproduccion ADD id_tmpenc BIGINT(20) NULL AFTER porcentajegrasa;

ALTER TABLE productobase ADD id_tmpenc BIGINT(20) NULL AFTER codigo;

-- Vista para Reporte COSTO DE PRODUCCION
CREATE VIEW costoproduccion AS
SELECT e.`id_tmpenc`, d.`id_tmpdet`, e.`fecha`, e.`tipo_doc`, e.`no_doc`, e.`no_trans`, o.`codigo`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`
FROM sf_tmpenc e
JOIN ordenproduccion o ON e.`id_tmpenc` = o.`id_tmpenc`
JOIN sf_tmpdet d ON e.`id_tmpenc` = d.`id_tmpenc`
JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
UNION
SELECT e.`id_tmpenc`, d.`id_tmpdet`, e.`fecha`, e.`tipo_doc`, e.`no_doc`, e.`no_trans`, b.`codigo`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`
FROM sf_tmpenc e
JOIN productobase b    ON e.`id_tmpenc` = b.`id_tmpenc`
JOIN sf_tmpdet d ON e.`id_tmpenc` = d.`id_tmpenc`
JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
;
--
--

