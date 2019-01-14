-- - 
SELECT e.`id_tmpenc`, d.`id_tmpdet`, e.`fecha`, e.`tipo_doc` AS tipo, E.`no_doc`, d.`no_trans`,  /*e.`glosa`,*/  e.`cod_prov`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, d.`id_tmpenc`, e.`estado`, d.`idpersonacliente`, d.`cod_prov`
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
-- WHERE d.`id_tmpenc` = 29504
WHERE d.`id_tmpenc` IN (

96678

)
-- WHERE e.`tipo_doc` = 'DB' AND e.`no_doc` IN (36,115,325)
;


--
-- Detalle por TipoDoc
SELECT e.`id_tmpenc`, d.`id_tmpdet`, e.`fecha`, e.`tipo_doc` AS tipo, E.`no_doc`, d.`no_trans`,  e.`glosa`,  e.`cod_prov`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, d.`id_tmpenc`, e.`estado`, d.`idpersonacliente`, d.`cod_prov`
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
-- WHERE d.`id_tmpenc` = 29504
WHERE e.`tipo_doc` = 'CV'
AND e.`no_doc` IN (1,2,3,4,5,6)
;

-- Detalle por Glosa
SELECT e.`id_tmpenc`, d.`id_tmpdet`, e.`fecha`, e.`tipo_doc` AS tipo, E.`no_doc`, d.`no_trans`,  e.`glosa`,  e.`cod_prov`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, d.`id_tmpenc`, e.`estado`, d.`idpersonacliente`, d.`cod_prov`
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
WHERE e.`tipo_doc` = 'TR'
AND e.`glosa` LIKE '%RECEPCION, ALMACEN (ALM PRODUCTOS TERMINADOS)%'
-- AND e.`glosa` LIKE '%CONSUMO, EGRESO, ALMACEN (ALM INSUMOS DE PRODUCCION)%'
-- AND e.`glosa` LIKE '%CONSUMO, EGRESO, ALMACEN (ALM MATERIALES DE PRODUCCION)%'
AND e.`fecha` BETWEEN '2017-02-01' AND '2017-02-28'
-- AND e.`estado` <> 'ANL'
;

-- Detalle por Glosa 2
SELECT e.`id_tmpenc`, d.`id_tmpdet`, e.`fecha`, e.`tipo_doc` AS tipo, E.`no_doc`, d.`no_trans`,  e.`glosa`,  e.`cod_prov`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, d.`id_tmpenc`, e.`estado`, d.`idpersonacliente`, d.`cod_prov`
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
WHERE e.`tipo_doc` = 'IA'
-- AND e.`glosa` LIKE '%RECEPCIÓN, RECEPCION, ALMACEN (ALM MATERIALES DE PRODUCCION),%'
-- AND e.`glosa` LIKE '%CONSUMO, EGRESO, ALMACEN (ALM MATERIALES DE PRODUCCION)%'
-- AND e.`glosa` LIKE '%, SEPTIEMBRE, IOC CISC-INV-%'
AND e.`fecha` BETWEEN '2016-09-01' AND '2016-09-30'
AND e.`estado` <> 'ANL'
;

SELECT 	v.`fecha`, v.`no_vale`, v.`no_trans`, v.`estado`, m.`fecha_cre`, m.`fecha_mov`, d.`cod_art`, a.`descri`,
	d.`cantidad`, d.`costounitario`, d.`preciounitcompra`, d.`monto`, m.`descri`
FROM inv_vales v
LEFT JOIN inv_mov m 		ON v.`no_trans` = m.`no_trans`
LEFT JOIN inv_movdet d 		ON v.`no_trans` = d.`no_trans`
LEFT JOIN inv_articulos a 	ON d.`cod_art`  = a.`cod_art`
-- where v.`no_vale` = '1-220'
-- where m.`fecha_mov` between '2016-05-01' and '2016-05-31'
WHERE v.`cod_doc` = 'EGR'
-- and v.`cod_alm` = 1
;

-- -------------------------------------------------
-- ASIENTOS, PEDIDOS COMISION
SELECT e.`id_tmpenc`, d.`id_tmpdet`, e.`fecha`, e.`tipo_doc` AS tipo, e.`no_doc`, d.`no_trans`,  e.`glosa`,  e.`cod_prov`, d.`cuenta`, a.`descri`, p.`TOTALIMPORTE`, p.`PORCENTAJECOMISION`, p.`VALORCOMISION`, d.`debe`, d.`haber`, d.`id_tmpenc`, e.`estado`, d.`idpersonacliente`, d.`cod_prov`
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
LEFT JOIN pedidos p   ON e.`id_tmpenc` = p.`id_tmpenc`
WHERE d.`id_tmpenc` IN (
	SELECT p.`id_tmpenc`
	FROM pedidos p
	WHERE p.`FECHA_ENTREGA` BETWEEN '2016-05-01' AND '2016-08-11'
	-- AND p.`IDMOVIMIENTO` IS NOT NULL
	AND p.`ESTADO` <> 'ANULADO'
	AND p.`VALORCOMISION` > 0
)
;
-- --------------------------------------------------

SELECT d.`id_tmpdet`, e.`tipo_doc`, e.`no_trans`, e.`glosa`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, d.`no_trans`, d.`id_tmpenc`
FROM sftmpdet d
LEFT JOIN sftmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
WHERE d.`id_tmpenc` = 4089;

-- -----------------------------
-- CHECKANDO ASIENTOS
-- -----------------------------
SELECT d.`id_tmpenc`, d.`id_tmpdet`, e.`fecha`, e.`tipo_doc`, e.`no_doc`, e.`estado`, e.`glosa`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, d.`cod_prov`, d.`idpersonacliente`
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
-- WHERE d.`id_tmpenc` = 2
WHERE d.`cuenta` = '2420410200'
-- AND d.`idpersonacliente` IS NULL
AND e.`fecha` BETWEEN '2018-05-01' AND '2018-05-31'
AND e.`estado` <> 'ANL'
;


SELECT d.`id_tmpenc`, d.`id_tmpdet`, e.`fecha`, e.`tipo_doc`, e.`no_doc`, e.`estado`, e.`glosa`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, d.`cod_prov`, d.`idpersonacliente`, p.`IDPEDIDOS`, p.`ESTADO`, p.`IDMOVIMIENTO`, v.`id_tmpenc`, v.`ESTADO`, v.`IDMOVIMIENTO`
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
LEFT JOIN pedidos p   ON e.`id_tmpenc` = p.`id_tmpenc`
LEFT JOIN ventadirecta v ON e.`id_tmpenc` = v.`id_tmpenc`
WHERE d.`cuenta` = '2420410200'
AND e.`fecha` BETWEEN '2018-05-01' AND '2018-05-31'
AND e.`estado` <> 'ANL'
;

SELECT p.`IDPEDIDOS`, pc.`NOM`, pc.`AP`, p.`FECHA_ENTREGA`, p.`ESTADO`, p.`OBSERVACION`, p.`CODIGO`, p.`id_tmpenc`, p.`IDMOVIMIENTO`, m.`FECHA_FACTURA`, m.`NROFACTURA`, m.`ESTADO`
FROM pedidos p
LEFT JOIN personacliente pc ON p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
LEFT JOIN movimiento m ON p.`IDMOVIMIENTO` = m.`IDMOVIMIENTO`
WHERE p.`FECHA_ENTREGA` BETWEEN '2018-05-01' AND '2018-05-31'
AND pc.`NOM` LIKE '%munici%cbba%'
;


SELECT e.`fecha`, d.`id_tmpdet`, e.`tipo_doc`, e.`no_doc`, e.`no_trans`, e.`glosa`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, d.`no_trans`, d.`id_tmpenc`
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
-- WHERE d.`id_tmpenc` = 2
WHERE e.`tipo_doc` = 'CI'
-- AND d.`cuenta` = '1110110100'
-- AND e.`no_doc` = '17'
AND e.`fecha` BETWEEN '2016-01-29' AND '2016-01-29'
;

-- RESUMEN DE RECAUDACION
-- SELECT e.`fecha`, d.`id_tmpdet`, e.`tipo_doc`, e.`no_doc`, e.`no_trans`, e.`glosa`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, d.`no_trans`, d.`id_tmpenc`
-- SELECT e.`fecha`, e.`tipo_doc`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`
SELECT /*e.`fecha`, e.`tipo_doc`,*/ d.`cuenta`, a.`descri`, SUM(d.`debe`) AS DEBE, SUM(d.`haber`) AS haber
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
WHERE e.`tipo_doc` = 'CI'
-- where (d.`cuenta` = '1110110100' or e.`tipo_doc` = 'CI')
AND e.`fecha` BETWEEN '2015-12-16' AND '2015-12-16'
AND e.`estado` <> 'ANL'
GROUP BY /*e.`fecha`, e.`tipo_doc`,*/ d.`cuenta`, a.`descri`
;

SELECT *
FROM sf_tmpenc e
JOIN sf_tmpdet d ON e.`id_tmpenc` = d.`id_tmpenc`
JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
WHERE e.`fecha` BETWEEN '2015-12-16' AND '2015-12-16'
AND e.`tipo_doc` = 'CI'
-- and e.`estado` <> 'ANL'
;

-- ASIENTOS - ORDENES DE COMPRA
-- SELECT e.`fecha`, d.`id_tmpdet`, e.`tipo_doc`, e.`no_doc`, e.`no_trans`, e.`glosa`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, d.`no_trans`, d.`id_tmpenc`
SELECT e.`fecha`, e.`tipo_doc`, d.`id_tmpenc`, d.`cuenta`, a.`descri`, e.`descri`, d.`debe`, d.`haber`, e.cod_prov
-- SELECT d.`cuenta`, a.`descri`, SUM(d.`debe`) AS DEBE, SUM(d.`haber`) AS haber
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
WHERE e.cod_prov IS NOT NULL
-- AND e.`cod_prov` = 9
-- where (d.`cuenta` = '1110110100' or e.`tipo_doc` = 'CI')
AND e.`fecha` BETWEEN '2016-01-01' AND '2016-01-30'
-- AND e.`estado` <> 'ANL'
-- and d.`cuenta` = '2420910300'
-- GROUP BY d.`cuenta`, a.`descri`
;


/** MAYORIZANDO **/
SELECT d.`cuenta`, a.`descri`, SUM(d.`debe`) AS TOTAL_D, SUM(d.`haber`) AS TOTAL_H
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
WHERE e.`fecha` BETWEEN '2016-05-01' AND '2016-05-31'
GROUP BY d.`cuenta`, a.`descri`
;

-- ASIENTOS VENTAS AL CONTADO
SELECT e.`fecha`, d.`id_tmpdet`, e.`tipo_doc`, e.`no_doc`, e.`no_trans`, e.`glosa`, v.`IDUSUARIO`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, d.`no_trans`, d.`id_tmpenc`, v.`TOTALIMPORTE`, TRUNCATE(v.`TOTALIMPORTE`*0.13,2)
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
LEFT JOIN ventadirecta v ON e.`id_tmpenc` = v.`id_tmpenc`
WHERE e.`tipo_doc` = 'CI'
AND v.`IDUSUARIO` = 5
-- and e.`id_tmpenc` = 4029
-- AND d.`cuenta` = '5420110100'
-- AND e.`no_doc` = '17'
-- and d.`haber` = truncate(v.`TOTALIMPORTE`*0.13,2)
AND e.`fecha` BETWEEN '2016-01-28' AND '2016-01-29'
;



-- UPDATE sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
LEFT JOIN ventadirecta v ON e.`id_tmpenc` = v.`id_tmpenc`
SET d.`cuenta` = 2420410200
WHERE e.`tipo_doc` = 'CI'
AND v.`IDUSUARIO` = 5
AND d.`cuenta` = '5420110100'
AND d.`haber` = TRUNCATE(v.`TOTALIMPORTE`*0.13,2)
AND e.`fecha` BETWEEN '2016-01-27' AND '2016-01-27'
;
-- -----------------------------------------------------------
-- UPDATE PARA USUARIO 5: 28 ENERO
-- UPDATE sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
LEFT JOIN ventadirecta v ON e.`id_tmpenc` = v.`id_tmpenc`
SET d.`cuenta` = 2420410100
WHERE e.`tipo_doc` = 'CI'
AND v.`IDUSUARIO` = 5
AND d.`cuenta` = '2420410200'
AND e.`fecha` BETWEEN '2016-01-28' AND '2016-01-28'
;

-- UPDATE sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
LEFT JOIN ventadirecta v ON e.`id_tmpenc` = v.`id_tmpenc`
SET d.`cuenta` = 2420410200
WHERE e.`tipo_doc` = 'CI'
AND v.`IDUSUARIO` = 5
AND d.`cuenta` = '5420110100'
AND e.`fecha` BETWEEN '2016-01-28' AND '2016-01-28'
;

-- UPDATE sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
LEFT JOIN ventadirecta v ON e.`id_tmpenc` = v.`id_tmpenc`
SET d.`cuenta` = 5420110100
WHERE e.`tipo_doc` = 'CI'
AND v.`IDUSUARIO` = 5
AND d.`cuenta` = '5420110201'
AND e.`fecha` BETWEEN '2016-01-28' AND '2016-01-28'
;
-- -----------------------------------------------------------
-- UPDATE PARA USUARIO 4: 27, 28 ENERO
-- UPDATE sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
LEFT JOIN ventadirecta v ON e.`id_tmpenc` = v.`id_tmpenc`
SET d.`cuenta` = 2420410100
WHERE e.`tipo_doc` = 'CI'
-- and e.`id_tmpenc` = 4070
AND v.`IDUSUARIO` = 4
AND d.`cuenta` = '2420410200'
-- AND e.`no_doc` = '17'
AND e.`fecha` BETWEEN '2016-01-27' AND '2016-01-27'
;

-- UPDATE sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
LEFT JOIN ventadirecta v ON e.`id_tmpenc` = v.`id_tmpenc`
SET d.`cuenta` = 2420410200
WHERE e.`tipo_doc` = 'CI'
-- and e.`id_tmpenc` = 4070
AND v.`IDUSUARIO` = 4
AND d.`cuenta` = '5420110100'
-- AND e.`no_doc` = '17'
AND e.`fecha` BETWEEN '2016-01-27' AND '2016-01-27'
;

-- ----------------------------------------------------------
-- ----------------------------------------------------------

SELECT v.`FECHA_PEDIDO`, v.`IDVENTADIRECTA`, a.`cod_art`, a.`CANTIDAD`, a.`PRECIO`, a.`IMPORTE`, i.`costo_uni`
FROM ventadirecta v
JOIN articulos_pedido a ON v.`IDVENTADIRECTA` = a.`IDVENTADIRECTA`
JOIN inv_articulos i ON a.`cod_art` = i.`cod_art`
WHERE v.`IDUSUARIO` = 5
AND v.`FECHA_PEDIDO` BETWEEN '2016-01-01' AND '2016-01-28'
AND v.`ESTADO` <> 'ANULADO'
;





SELECT MIN(CAST(no_doc AS DECIMAL)) AS MI, MAX(CAST(no_doc AS DECIMAL)) AS MA
FROM sf_tmpenc
WHERE tipo_doc = 'CI'
-- AND fecha BETWEEN '2015-01-01' AND '2016-12-31'
;

SELECT p.`IDPEDIDOS`, p.`FECHA_ENTREGA`, p.`CODIGO`, p.`id_tmpenc`, p.`id_tmpenc_cv`, pc.`NOM`, pc.`AP`, pc.`AM`
FROM pedidos p
JOIN personacliente pc ON p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
WHERE p.`FECHA_ENTREGA` BETWEEN '2016-01-01' AND '2016-02-29'
AND p.`TIENEFACTURA` = 0
AND p.`ESTADO` = 'CONTABILIZADO'
;



SELECT DISTINCT dc.`numerotransaccion`
FROM documentocompra d
JOIN documentocontable dc ON d.`iddocumentocompra` = dc.`iddocumentocontable`
JOIN sf_tmpenc e ON d.`idtmpenc` = e.`id_tmpenc`
WHERE e.fecha BETWEEN '2015-01-01' AND '2015-12-31'
AND dc.`numerotransaccion` IS NOT NULL
;

-- Eliminar lcompras
-- 1.
SELECT *
DELETE FROM cxp_lcompras
WHERE no_trans IN (
	SELECT DISTINCT dc.`numerotransaccion`
	FROM documentocompra d
	JOIN documentocontable dc ON d.`iddocumentocompra` = dc.`iddocumentocontable`
	JOIN sf_tmpenc e ON d.`idtmpenc` = e.`id_tmpenc`
	WHERE e.fecha BETWEEN '2015-01-01' AND '2015-12-31'
	AND dc.`numerotransaccion` IS NOT NULL
);

-- 2.
SELECT *
DELETE FROM documentocontable
WHERE iddocumentocontable IN (
	SELECT d.`iddocumentocompra`
	FROM documentocompra d
	JOIN sf_tmpenc e ON d.`idtmpenc` = e.`id_tmpenc`
	WHERE e.fecha BETWEEN '2015-01-01' AND '2015-12-31'
);

-- 4.
SELECT *
DELETE FROM documentocompra
WHERE idtmpenc IN (
	SELECT id_tmpenc
	FROM sf_tmpenc
	WHERE fecha BETWEEN '2015-01-01' AND '2015-12-31'
);


SELECT *
FROM sf_tmpenc
WHERE id_tmpenc IN (
	SELECT idtmpenc
	FROM documentocompra
);

SELECT v.`FECHA_PEDIDO`, a.`cod_art`, i.`descri`, v.`CODIGO`, a.`CANTIDAD`, a.`PRECIO`, a.`IMPORTE`, a.`TOTAL`, v.`id_tmpenc`, v.`id_tmpenc_cv`
FROM articulos_pedido a
LEFT JOIN ventadirecta v  ON a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
LEFT JOIN inv_articulos i ON a.`cod_art` = i.`cod_art`
WHERE v.`FECHA_PEDIDO` BETWEEN '2016-01-01' AND '2016-02-29'
-- and v.`CODIGO` = 769
AND a.`cod_art` = 436
;


SELECT *
FROM sf_tmpenc
UPDATE sf_tmpenc SET descri = CONCAT("Deuda al 31/12/2015", " " , nombrecliente), GLOSA = CONCAT("Deuda al 31/12/2015", " " , nombrecliente)
WHERE fecha BETWEEN '2015-01-01' AND '2015-12-31'
AND tipo_doc = 'NE'
;

SELECT *
FROM sf_tmpdet
WHERE id_tmpenc IN (
	SELECT id_tmpenc
	FROM sf_tmpenc
	WHERE fecha BETWEEN '2015-01-01' AND '2015-12-31'
	AND tipo_doc = 'TR'
);

SELECT MIN(id_tmpenc)
FROM sf_tmpenc
;

SELECT MIN(CAST(no_trans AS DECIMAL)) AS MI, MAX(CAST(no_trans AS DECIMAL)) AS MA
FROM sf_tmpdet
;

SELECT *
FROM arcgms
WHERE cuenta LIKE '%1130110%'
-- where descri like 'Banco%te%'
;


SELECT * 
FROM sf_tmpenc e
WHERE e.`tipo_doc` = 'NE'
AND e.`no_doc` BETWEEN 1 AND 103;

-- ---------------------------------------------------
-- Para actualizar secuencias
-- ---------------------------------------------------
SELECT e.`tipo_doc`, e.`no_doc`, COUNT(e.`no_doc`)
FROM sf_tmpenc e
WHERE e.`tipo_doc` = 'NE'
GROUP BY e.`tipo_doc`, e.`no_doc`
;

SELECT e.`id_tmpenc`, e.`fecha`, e.`estado`, e.`tipo_doc`, e.`no_doc`, d.`debe`, d.`haber`, e.`glosa`
FROM sf_tmpenc e
JOIN sf_tmpdet d ON e.`id_tmpenc` = d.`id_tmpenc`
WHERE e.`tipo_doc` = 'NE'
AND e.`id_tmpenc` = 1
;


SELECT e.`id_tmpenc`, e.`fecha`, e.`estado`, e.`tipo_doc`, e.`no_doc`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, e.`glosa`, d.`cod_prov`, d.`idpersonacliente`, d.`id_tmpdet`
FROM sf_tmpenc e
JOIN sf_tmpdet d ON e.`id_tmpenc` = d.`id_tmpenc`
JOIN arcgms a ON d.`cuenta` = a.`cuenta`
WHERE e.`tipo_doc` = 'CD'
-- and d.`cuenta` = '1420310100'
;


SELECT e.`id_tmpenc`, e.`fecha`, e.`estado`, e.`tipo_doc`, e.`no_doc`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, e.`glosa`, CONCAT(p.`NOM`, ' ', p.`AP`, ' ', p.`AM`) AS Cliente, en.`razon_social`, d.`cod_prov`, d.`idpersonacliente`, d.`id_tmpdet`
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta`    = a.`cuenta`
LEFT JOIN personacliente p ON d.`idpersonacliente` = p.`IDPERSONACLIENTE`
LEFT JOIN sf_entidades en  ON d.`cod_prov` = en.`cod_enti`
WHERE e.`tipo_doc` = 'CD'
;




-- 
-- 

SELECT e.`tipo_doc`, e.`no_doc`, d.`cuenta`, a.`descri`, SUM(d.`debe`) AS D, SUM(d.`haber`) AS H
FROM sf_tmpenc e
JOIN sf_tmpdet d ON e.`id_tmpenc` = d.`id_tmpenc`
JOIN arcgms a ON d.`cuenta` = a.`cuenta`
WHERE e.`tipo_doc` = 'CD'
GROUP BY e.`tipo_doc`, e.`no_doc`, d.`cuenta`, a.`descri`
;


-- - 
SELECT 	e.`id_tmpenc`, 
	d.`id_tmpdet`, 
	e.`fecha`, 
	e.`tipo_doc` AS tipo, 
	d.`cuenta`, 
	a.`descri`, 
	d.`debe`, 
	d.`haber`, 
	d.`idpersonacliente` AS cod_cli, 
	CONCAT(p.`NOM`, " ", p.`AP`, " ", p.`AM`) AS cliente,
	d.`cod_prov`,
	en.`razon_social` AS aux_prov
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
LEFT JOIN personacliente p ON d.`idpersonacliente` = p.`IDPERSONACLIENTE`
LEFT JOIN sf_entidades en  ON d.`cod_prov` = en.`cod_enti`
WHERE d.`id_tmpenc` = 2
;


-- ---------------------------------------------------------------------------------
-- DIFERENCIAS
-- ---------------------------------------------------------------------------------
-- CREATE VIEW diferencias AS (
SELECT e.`fecha`, e.`id_tmpenc`, e.`tipo_doc`, e.`no_doc`, SUM(d.`debe`) AS totald, SUM(d.`haber`) AS totalh, (SUM(d.`debe`) - SUM(d.`haber`)) AS dif
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
WHERE e.`fecha` BETWEEN '2018-01-01' AND '2018-08-31'
AND e.`estado` <> 'ANL'
-- AND e.`tipo_doc` IN ('CI', 'CV', 'NE')
-- AND e.`tipo_doc` IN ('CV')
GROUP BY e.`fecha`, e.`id_tmpenc`, e.`tipo_doc`, e.`no_doc`
-- )
;


SELECT e.`fecha`, e.`id_tmpenc`, e.`tipo_doc`, e.`no_doc`, SUM(d.`debe`) AS totald, SUM(d.`haber`) AS totalh, (SUM(d.`debe`) - SUM(d.`haber`)) AS dif
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
WHERE e.`fecha` BETWEEN '2017-12-01' AND '2017-12-31'
AND e.`estado` <> 'ANL'
-- AND e.`tipo_doc` IN ('CI', 'CV', 'NE')
-- AND e.`tipo_doc` IN ('NE')
GROUP BY e.`fecha`, e.`id_tmpenc`, e.`tipo_doc`, e.`no_doc`
;

SELECT *
FROM diferencias d
WHERE d.`tipo_doc` = 'NE'
AND d.`dif` <> 0
;



SELECT v.`IDVENTADIRECTA`, v.`FECHA_PEDIDO`, v.`CODIGO`, v.`ESTADO`, v.`TOTALIMPORTE`, v.`IMPUESTO`, v.`IDMOVIMIENTO`, v.`id_tmpenc`, v.`id_tmpenc_cv`, v.`IDUSUARIO`
FROM ventadirecta v
WHERE v.`FECHA_PEDIDO` BETWEEN '2016-05-01' AND '2016-05-31'
;


-- Ventas
SELECT * 
FROM ventadirecta v
WHERE v.`FECHA_PEDIDO` BETWEEN '2016-05-01' AND '2016-08-07'
AND v.`IDMOVIMIENTO` IS NOT NULL
AND v.`ESTADO` <> 'ANULADO'
;

-- Pedidos
SELECT *
FROM pedidos p
WHERE p.`FECHA_ENTREGA` BETWEEN '2016-05-01' AND '2016-08-11'
-- AND p.`IDMOVIMIENTO` IS NOT NULL
AND p.`ESTADO` <> 'ANULADO'
AND p.`VALORCOMISION` > 0
;


-- 
SELECT e.`id_tmpenc`, d.`id_tmpdet`, e.`fecha`, e.`tipo_doc` AS tipo, E.`no_doc`, d.`no_trans`, /*e.`glosa`,*/ e.`cod_prov`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, d.`id_tmpenc`, e.`estado`, d.`idpersonacliente`, d.`cod_prov`
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
WHERE e.`tipo_doc` = 'TR'
AND e.`fecha` BETWEEN '2016-07-01' AND '2016-07-31'
AND e.`estado` <> 'ANL'
;

--





