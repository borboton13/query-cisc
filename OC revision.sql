SELECT d.`id_tmpdet`, e.`tipo_doc`, e.`no_trans`, e.`glosa`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, d.`no_trans`, d.`id_tmpenc`, d.`cod_prov`, e.`cod_prov`
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
-- WHERE d.`id_tmpenc` = 2
WHERE d.`cuenta` = '2420910300'
;

SELECT oc.`id_com_encoc`, oc.`fecha`, oc.`no_orden`, oc.`cod_prov`, oc.`estado`, po.`id_tmpenc`, d.`id_tmpdet`, d.`cuenta`, d.`debe`, d.`haber`, d.`cod_prov`, oc.`glosa`
FROM com_encoc oc
LEFT JOIN pagoordencompra po ON oc.`id_com_encoc` = po.`idordencompra`
LEFT JOIN sf_tmpdet d ON po.`id_tmpenc` = d.`id_tmpenc`
WHERE oc.`fecha` BETWEEN '2017-01-01' AND '2017-12-31'
AND d.`cuenta` = '2420910300'
;


-- compras detalle
SELECT e.`id_com_encoc`, e.`fecha`, e.`no_orden`, d.`cod_art`, d.`cant_sol`,  e.`glosa`
FROM com_detoc d
LEFT JOIN com_encoc e ON d.`id_com_encoc` = e.`id_com_encoc`
WHERE e.`fecha` BETWEEN '2017-01-2017' AND '2017-12-31'
AND d.`cod_art` = 624
;

--



-- REVISION COMPARA IMPORTE FACTURAS Y SUS ASIENTOS
SELECT f.*, a.*
FROM 	(
	SELECT d.`idtmpenc`, SUM(dc.`importe`) AS importe
	FROM documentocompra d
	JOIN documentocontable dc ON d.`iddocumentocompra` = dc.`iddocumentocontable`
	WHERE d.`idtmpenc` IS NOT NULL
	AND dc.`fecha` BETWEEN '2018-05-01' AND '2018-05-31'
	GROUP BY d.`idtmpenc`
	) f
LEFT JOIN (
	SELECT e.`id_tmpenc`, e.`tipo_doc`, e.`no_doc`, e.`estado`,  SUM(d.`debe`) AS debe, SUM(d.`haber`) AS haber
	FROM sf_tmpdet d 
	JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
	WHERE e.`fecha` BETWEEN '2018-05-01' AND '2018-05-31'
	AND e.`estado` <> 'ANL'
	GROUP BY e.`id_tmpenc`, e.`tipo_doc`, e.`no_doc`, e.`estado`
	) a ON f.idtmpenc = a.id_tmpenc
;






