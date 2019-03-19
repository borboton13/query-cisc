-- 11/09/2018
-- CONSIDERANDO QUE CREDITO FISCAN EN O.C. ES CORRECTO (IA)
-- Facturas Y Documento contable
SELECT co.`fecha`, co.`nit`, co.`nombre`, co.`numero`, co.`importe`, co.`exento`, co.`iva` , dc.`idtmpenc`, e.`id_tmpenc`, e.`fecha`, e.`tipo_doc`, e.`no_doc`
FROM documentocontable co
JOIN documentocompra dc 	ON co.`iddocumentocontable` = dc.`iddocumentocompra`
JOIN sf_tmpenc e  		ON dc.`idtmpenc` = e.`id_tmpenc`
WHERE co.`fecha` BETWEEN '2018-08-01' AND '2018-08-31'
;

-- Totalizando CREDITO FISCAL asientos (Todos)
SELECT e.`id_tmpenc`, e.`tipo_doc`, e.`no_doc`, SUM(d.`debe`) AS debe
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
WHERE e.`fecha` BETWEEN '2018-08-01' AND '2018-08-31'
AND d.`cuenta` = '1420710000'
AND d.`debe` > 0
AND e.`estado` <> 'ANL'
GROUP BY e.`id_tmpenc`, e.`tipo_doc`, e.`no_doc`
;


-- Totalizando facturas IVA en Documento contable (No incluye IA, ni NE sedem)
SELECT e.`id_tmpenc`, e.`tipo_doc`, e.`no_doc`, SUM(co.`importe`) AS importe , SUM(co.`exento`) AS exento, SUM(co.`iva`) AS iva
FROM documentocontable co
JOIN documentocompra dc 	ON co.`iddocumentocontable` = dc.`iddocumentocompra`
JOIN sf_tmpenc e  		ON dc.`idtmpenc` = e.`id_tmpenc`
WHERE co.`fecha` BETWEEN '2018-08-01' AND '2018-08-31'
GROUP BY e.`id_tmpenc`, e.`tipo_doc`, e.`no_doc`
;




