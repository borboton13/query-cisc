-- - 
SELECT 	e.`id_tmpenc`, d.`id_tmpdet`, e.`fecha`, e.`tipo_doc` AS tipo, E.`no_doc`, d.`no_trans`, e.`estado`,  e.`glosa`,  e.`cod_prov`, 
	d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, D.`idcuenta`, d.`idmovimiento`, d.`iddocumentocompra`,
	d.`tc`, d.`moneda`, d.`debeme`, d.`haberme`, 
	d.`id_tmpenc`, e.`estado`, d.`cod_prov`, d.`cod_art`, d.`cant_art`, d.`idpersonacliente`, d.`idcredito`
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
-- WHERE d.`id_tmpenc` = 29504
WHERE d.`id_tmpenc` IN ( 
171755,
171752,
172044,
173899
 ) 
-- where d.`id_tmpdet` in ()
-- where e.`tipo_doc` = 'CB' 
-- and e.`no_doc` in (12)
-- where d.`idpersonacliente` = 2064
-- where e.`fecha` between '2021-01-12' and '2021-04-31'
-- and e.`tipo_doc` = 'NE' AND e.`estado` <> 'ANL'
-- WHERE d.`cuenta` = '1110110205'
-- and d.`cod_art` = 410
;

UPDATE sf_tmpenc e SET e.`estado` = 'PEN' WHERE e.`id_tmpenc` IN (
171755,
171752,
172044,
173899
);

-- update sf_tmpdet d set d.`cuenta` = '1110110205' 
-- update sf_tmpdet d set d.`iddocumentocompra` = null
UPDATE sf_tmpdet d SET d.`idmovimiento` = 92296
WHERE d.`id_tmpdet` IN (
999453
);


UPDATE pedidos p SET p.`IDMOVIMIENTO` = NULL WHERE p.`IDPEDIDOS` = 61604;

SELECT * FROM sf_tmpdet d WHERE d.`id_tmpdet` = 999173;

UPDATE sf_tmpdet d SET d.`idmovimiento` = 92224 WHERE d.`id_tmpdet` = 999173;


DELETE FROM sf_tmpdet WHERE id_tmpenc IN (

);

DELETE FROM sf_tmpenc WHERE id_tmpenc IN (

);

DELETE FROM sf_tmpdet
WHERE id_tmpdet IN (

);

SELECT *
FROM inv_vales i
-- update inv_vales i set i.`idtmpenc` = null
WHERE i.`idtmpenc` IN (

);


DELETE FROM sf_tmpdet WHERE id_tmpdet IN (

);




SELECT *
FROM sf_tmpdet d 
WHERE d.`id_tmpdet` > 15249
;


SELECT *
FROM sf_tmpenc e 
WHERE e.`tipo_doc` = 'CV'
AND E.`no_doc` = 47
AND e.`fecha` >= '2020-10-01'
;


-- -----------------------
--
-- Detalle por TipoDoc
SELECT e.`id_tmpenc`, e.`no_trans`, d.`id_tmpdet`, e.`fecha`, e.`tipo_doc` AS tipo, E.`no_doc`, d.`no_trans`,  e.`glosa`, e.`cod_prov`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, d.`tc`, d.`debeme`, d.`haberme`,
d.`id_tmpenc`, e.`estado`, d.`idcuenta`, d.`idcredito`,
d.`idpersonacliente`, d.`cod_prov`, d.`cod_art`, d.`cant_art`
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
WHERE e.`fecha` BETWEEN '2020-01-01' AND '2021-12-31'
AND e.`estado` <> 'ANL'
-- where d.`debe` = 0 and d.`haber` = 0
-- and d.`id_tmpenc` = 137259
-- and e.`tipo_doc` = 'CB'
AND d.`cuenta` = '1810310100'
-- and e.`no_doc` in (1)
-- and e.`glosa` like '%SUELDOS%'
-- and d.`cod_art`in (277)
-- and d.`idsocio` = 
;


-- Kardex Clientes
SELECT e.`id_tmpenc`,  e.`fecha`, e.`tipo_doc` AS tipo, e.`no_doc`, e.`glosa`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, d.`idpersonacliente`
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
WHERE e.`fecha` BETWEEN '2020-01-01' AND '2021-12-31'
AND e.`estado` <> 'ANL'
AND d.`cuenta` = '1421010200'
AND d.`idpersonacliente` = 205
;


-- Detalle por TipoDoc
SELECT e.`id_tmpenc`, e.`no_trans`, d.`id_tmpdet`, e.`fecha`, e.`tipo_doc` AS tipo, e.`no_doc`,  s.`nombres`, s.`apellidopaterno`, c.`codigoant`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`,  /*d.`tc`, d.`debeme`, d.`haberme`,*/
e.`estado`, d.`idcredito`
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
LEFT JOIN credito c   ON d.`idcredito` = c.`idcredito`
LEFT JOIN socio s     ON c.`idsocio` = s.`idsocio`
WHERE e.`estado` <> 'ANL'
-- where d.`debe` = 0 and d.`haber` = 0
-- and d.`id_tmpenc` = 137259
AND e.`tipo_doc` = 'CB'
-- and d.`cuenta` = '1310510600'
AND e.`no_doc` IN (74)
-- and e.`glosa` like '%SUELDOS%'
-- and d.`cod_art`in (118)
-- and d.`idsocio` = 
AND e.`fecha` BETWEEN '2020-01-01' AND '2020-12-31'
;




UPDATE sf_tmpenc e SET e.`estado` = 'PEN'
WHERE e.`id_tmpenc` IN (
157479
);

-- update sf_tmpdet d set d.`cuenta` = '1810310301' where d.`id_tmpdet` = 880271;

-- update sf_tmpenc e set e.`estado` = 'PEN' where e.`id_tmpenc` in (141845);
-- update sf_tmpdet d set d.`cuenta` = '4430110300'  where d.`id_tmpdet` = 71025;
-- update sf_tmpdet d set d.`cod_art` = 73, d.`cant_art` = 481.03  where d.`id_tmpdet` = 898302;

-- update sf_tmpdet d set d.`haber` =  where d.`id_tmpdet` = 6067;
-- update sf_tmpdet d set d.`haber` =  where d.`id_tmpdet` = 6068;

SELECT *
FROM ventadirecta v
WHERE v.`FECHA_PEDIDO` BETWEEN '2020-01-01' AND '2020-12-31'
AND v.`CODIGO` = 15291
;


SELECT *
FROM ventadirecta v
WHERE v.`IDUSUARIO` = 6;

-- update sf_tmpdet d set d.`idpersonacliente` = 1510 where d.`id_tmpdet` = 659725;
-- update sf_tmpdet d set d.`cuenta` = '1420710000' where d.`id_tmpdet` = 663653; -- Cuenta Credito Fiscal
-- update sf_tmpdet d SET d.`id_tmpenc` = 106270 where d.`id_tmpdet` in (11778	,11779	,11780	,11781	,11782	,11783	,11784	,11785	,11786	,11787	);
UPDATE sf_tmpenc e SET e.`estado` = 'APR' WHERE e.`id_tmpenc` IN (128114);


-- PARA REVISION DE DOCUMENTOS
SELECT e.`id_tmpenc`, e.`no_trans`, e.`fecha`, e.`tipo_doc`, e.`no_doc`, e.`estado`, e.`glosa`, e.`ndoc`
FROM sf_tmpenc e
WHERE e.`tipo_doc` = 'CE'
;

-- SOCIOS NUEVOS
SELECT e.`id_tmpenc`, d.`id_tmpdet`, e.`fecha`, e.`tipo_doc` AS tipo, e.`no_doc`,  e.`glosa`,  d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, 
d.`id_tmpenc`, e.`estado`, d.`idsocio`, s.`noidentificacion`, s.`nombres`, s.`apellidopaterno`, s.`apellidomaterno`
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
LEFT JOIN socio s     ON d.`idsocio` = s.`idsocio`
WHERE e.`tipo_doc` = 'CI'
AND d.`cuenta` = '3110100000'
AND e.`fecha` BETWEEN '2019-01-01' AND '2019-08-30'
-- and e.`glosa` like "%nuev%" 
;


-- Detalle por Glosa
SELECT e.`id_tmpenc`, d.`id_tmpdet`, e.`fecha`, e.`tipo_doc` AS tipo, e.`no_doc`, d.`no_trans`,  e.`glosa`,  e.`cod_prov`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, d.`id_tmpenc`, e.`estado`, 
-- d.`idpersonacliente`, d.`cod_prov`
d.`idcuenta`
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
WHERE e.`fecha` BETWEEN '2019-01-01' AND '2019-01-31'
-- AND e.`glosa` LIKE '%RECEPCION%ALM PRODUCTOS TERMINADOS)%'
-- AND e.`glosa` LIKE '%CONSUMO, EGRESO, ALMACEN (ALM INSUMOS DE PRODUCCION)%'
-- AND e.`glosa` LIKE '%CONSUMO, EGRESO, ALMACEN (ALM MATERIALES DE PRODUCCION)%'
AND d.`cuenta` = 2120110100
AND d.`idcuenta` = 2065
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

-- -----------------------------
-- CHECKANDO ASIENTOS
-- -----------------------------
SELECT d.`id_tmpenc`, d.`id_tmpdet`, e.`fecha`, e.`tipo_doc`, e.`no_doc`, e.`estado`, e.`glosa`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, d.`cod_prov`, d.`idpersonacliente`
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
-- WHERE d.`id_tmpenc` = 2
WHERE d.`cuenta` = '1000000000'
-- AND d.`idpersonacliente` IS NULL
AND e.`fecha` BETWEEN '2019-02-01' AND '2019-02-28'
-- AND e.`estado` <> 'ANL'
;


-- MAYOR CAJA GENERAL + VENTA CONTADO
SELECT e.`id_tmpenc`, d.`id_tmpdet`, e.`fecha`, e.`tipo_doc`, e.`no_doc`, e.`glosa`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, v.`IDVENTADIRECTA`, v.`CODIGO`, v.`IDMOVIMIENTO`, m.`NROFACTURA`, m.`FECHA_FACTURA`
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
LEFT JOIN ventadirecta v ON e.`id_tmpenc` = v.`id_tmpenc`
LEFT JOIN movimiento m   ON v.`IDMOVIMIENTO` = m.`IDMOVIMIENTO`
WHERE d.`cuenta` = '1110110100'
AND e.`estado` <> 'ANL'
AND e.`fecha` BETWEEN '2018-11-01' AND '2018-11-30'
;



-- 


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


SELECT *
FROM sf_tmpdet d
WHERE d.`cuenta` = '1000000000'
;

/** MAYORIZANDO **/
SELECT d.`cuenta`, a.`descri`, SUM(d.`debe`) AS TOTAL_D, SUM(d.`haber`) AS TOTAL_H
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
WHERE e.`fecha` BETWEEN '2018-08-01' AND '2018-08-15'
AND e.`estado` <> 'ANL'
GROUP BY d.`cuenta`, a.`descri`
;

SELECT e.`fecha`, d.`cuenta`,  a.`descri`, e.`tipo_doc`, e.`no_doc`, e.`glosa`, d.`debe`, d.`haber`
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
WHERE e.`fecha` BETWEEN '2019-01-01' AND '2019-12-31'
AND e.`estado` <> 'ANL'
ORDER BY d.`cuenta`, e.`fecha`
;



-- -----------------------------------------------------------
-- -----------------------------------------------------------

-- ---------------------------------------------------------------------------------
-- DIFERENCIAS
-- ---------------------------------------------------------------------------------
-- CREATE VIEW diferencias AS (
SELECT e.`fecha`, e.`id_tmpenc`, e.`tipo_doc`, e.`no_doc`, e.`glosa`, SUM(d.`debe`) AS totald, SUM(d.`haber`) AS totalh, (SUM(d.`debe`) - SUM(d.`haber`)) AS dif
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
WHERE e.`fecha` BETWEEN '2020-01-01' AND '2020-12-31'
AND e.`estado` <> 'ANL'
-- AND e.`tipo_doc` IN ('CI', 'CV', 'NE')
-- AND e.`tipo_doc` IN ('CV')
-- AND a.`cta_niv3` = '4420000000'
GROUP BY e.`fecha`, e.`id_tmpenc`, e.`tipo_doc`, e.`no_doc`, e.`glosa`
-- )
;


SELECT e.`fecha`, e.`id_tmpenc`, e.`tipo_doc`, e.`no_doc`, SUM(d.`debe`) AS totald, SUM(d.`haber`) AS totalh, (SUM(d.`debe`) - SUM(d.`haber`)) AS dif,
e.`glosa`
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
WHERE e.`fecha` BETWEEN '2019-08-01' AND '2019-08-31'
AND e.`estado` <> 'ANL'
-- AND e.`tipo_doc` IN ('CD')
AND a.`cta_niv3` = '4460000000'
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

-- PARA ACTUALIZAR INV_VALES, COD_ART
SELECT v.`no_trans`, v.`fecha`, v.`cod_doc`, v.`no_vale`, v.`estado`, v.`idordenproduccion`, v.`idproductobase`, v.`idtmpenc`
FROM inv_vales	v
WHERE v.`cod_alm` = 2 
AND v.`fecha` BETWEEN '2018-01-01' AND '2018-12-31'
AND v.`idtmpenc` IS NULL
;


SELECT e.`id_tmpenc`, e.`no_trans`, e.`fecha`, e.`tipo_doc`, e.`no_doc`, e.`estado`, e.`glosa`, d.`cuenta`, d.`debe`, d.`haber`, d.`cod_art`, e.`procedencia`, d.`idpersonacliente`, d.`cod_prov`
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
WHERE d.`cuenta` = '1420710000'
AND e.`fecha` BETWEEN '2019-02-01' AND '2019-02-28'
AND e.`estado` <> 'ANL'
-- AND d.`idpersonacliente` = 477
-- AND e.`tipo_doc` <> 'NE'
-- AND d.`cod_art` IS NULL
-- AND e.`procedencia` <> 'TRA'
;




SELECT v.`fecha`, v.`estado`, v.`cod_alm`, v.`no_vale`, d.`cod_art`, a.`descri`, d.`cantidad`, d.`costounitario`, d.`monto`  ,
v.`idtmpenc`, e.`no_trans`, e.`tipo_doc`, e.`no_doc`, de.`id_tmpdet`, de.`debe`, de.`haber`
FROM inv_movdet d
LEFT JOIN inv_mov m ON d.`no_trans` = m.`no_trans`
LEFT JOIN inv_vales v ON m.`no_trans` = v.`no_trans`
LEFT JOIN inv_articulos a ON d.`cod_art` = a.`cod_art`
LEFT JOIN sf_tmpenc e ON v.`idtmpenc` = e.`id_tmpenc`
LEFT JOIN sf_tmpdet de ON e.`id_tmpenc` = de.`id_tmpenc`
WHERE de.`cuenta` = '1510110201' 
AND v.`idtmpenc` IN ();


-- select p.`IDPEDIDOS`, p.`FECHA_ENTREGA`, p.`CODIGO`, a.`cod_art`, i.`descri`, a.`CANTIDAD`, a.`cu`, (a.`CANTIDAD` * a.`cu`) AS costo_t,  p.`CV`
SELECT MONTH(P.`FECHA_ENTREGA`), a.`cod_art`, i.`descri`, SUM(a.`CANTIDAD` * a.`cu`) AS costo_t
FROM articulos_pedido a
LEFT JOIN pedidos p 		ON a.`IDPEDIDOS` = p.`IDPEDIDOS`
LEFT JOIN inv_articulos i 	ON a.`cod_art` = i.`cod_art`
WHERE p.`FECHA_ENTREGA` BETWEEN '2018-01-01' AND '2018-12-31'
AND p.`ESTADO` <> 'ANULADO'
AND p.`IDUSUARIO` <> 5
AND p.`CV` = 1
GROUP BY MONTH(P.`FECHA_ENTREGA`), a.`cod_art`, i.`descri`
;

SELECT MONTH(v.`FECHA_PEDIDO`), a.`cod_art`, i.`descri`, SUM(a.`CANTIDAD` * a.`cu`) AS costo_t
FROM articulos_pedido a
LEFT JOIN ventadirecta v 	ON a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
LEFT JOIN inv_articulos i 	ON a.`cod_art` = i.`cod_art`
WHERE v.`FECHA_PEDIDO` BETWEEN '2018-01-01' AND '2018-12-31'
AND v.`ESTADO` <> 'ANULADO'
AND v.`IDUSUARIO` <> 5
AND v.`CV` = 1
GROUP BY MONTH(v.`FECHA_PEDIDO`), a.`cod_art`, i.`descri`
;

--
-- CUENTA PRODUCTOS TERMINADOS MIRABEL - VALES
SELECT e.`id_tmpenc`, e.`fecha`, e.`tipo_doc`, e.`no_doc`, d.`id_tmpdet`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, d.`cod_art`, d.`cant_art`,
 e.`cod_prov`, v.`no_trans`, v.`cod_doc`, v.`no_vale`, v.`cod_alm`, v.`id_com_encoc`, e.`glosa`
FROM sf_tmpenc e 
JOIN sf_tmpdet d ON e.`id_tmpenc` = d.`id_tmpenc`
JOIN arcgms a 	 ON d.`cuenta` = a.`cuenta`
JOIN inv_vales v ON e.`id_tmpenc` = v.`idtmpenc`
WHERE e.`fecha` BETWEEN '2019-01-01' AND '2019-02-31'
AND e.`estado` <> 'ANL'
AND e.`tipo_doc` = 'TR'
-- AND d.`cuenta` = '1520110100'
-- and e.`no_doc` in (1819)

;


-- ASIENTOS - ARTICULOS ENTRADA - SALIDA
SELECT e.`tipo_doc`, e.`no_doc`, d.cod_art, a.descri, a.cod_med,
SUM(d.debe)     AS debe,
SUM(d.haber)    AS haber,
SUM(IF(d.debe>0, d.cant_art, 0))  AS cant_e,
SUM(IF(d.haber>0, d.cant_art, 0)) AS cant_s
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.id_tmpenc = e.id_tmpenc
LEFT JOIN inv_articulos a ON d.cod_art = a.cod_art
WHERE d.cuenta = 1580110200
AND e.fecha BETWEEN '2019-01-01' AND '2019-01-31'
AND e.estado <> 'ANL'
GROUP BY e.`tipo_doc`, e.`no_doc`, d.cod_art, a.descri, a.cod_med
;

-- VALES TRANSFERENCIAS, BAJ, DEV
SELECT v.`fecha`, v.`no_trans`, v.`no_vale`, v.`cod_doc`, v.`oper`, a.`descri`, d.`tipo_mov`, d.`cod_art` , d.`cantidad`, v.`orig`, v.`dest`, v.`cod_alm_dest`, v.`idtmpenc`, m.`descri`
FROM inv_movdet d
LEFT JOIN inv_mov m   ON d.`no_trans` = m.`no_trans` 
LEFT JOIN inv_vales v ON m.`no_trans` = v.`no_trans`
LEFT JOIN inv_articulos a ON d.`cod_art` = a.`cod_art`
WHERE v.`fecha` BETWEEN '2020-05-01' AND '2020-05-31'
AND v.`oper` IS NOT NULL
-- AND v.`cod_alm_dest` IS NOT NULL
-- AND v.`idtmpenc` IS NULL
-- and d.`cod_art` in (703)
;


-- REVISION MOVIMIENTO PRODUCTO X CONTABILIDAD
SELECT e.`id_tmpenc`, e.`fecha`, e.`tipo_doc`, e.`no_doc`, e.`estado`, d.`id_tmpdet`, d.`cuenta`, d.`debe`, d.`haber`, d.`cod_art`, d.`cant_art`, e.`glosa`
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
WHERE e.`fecha` BETWEEN '2019-03-01' AND '2019-12-31'
AND d.`cod_art` = 642
;

-- VALES ENTRADAS DE PRODUCCION
SELECT d.cod_art, SUM(d.monto) AS monto, SUM(d.cantidad) AS cantidad, SUM(d.monto) / SUM(d.cantidad) AS costoUni
FROM inv_vales i 
JOIN inv_movdet d ON i.no_trans = d.no_trans
WHERE i.fecha BETWEEN '2019-02-01' AND '2019-02-28'
AND i.cod_alm = 2
AND (i.idordenproduccion IS NOT NULL OR i.idproductobase IS NOT NULL)
AND d.cod_art = 703
GROUP BY d.cod_art
;

-- VALES DE COMPRAS - ASIENTOS DETALLE
SELECT DISTINCT e.`id_tmpenc`, e.`no_trans`, e.`fecha`, e.`tipo_doc`, e.`no_doc`, d.`cuenta`, d.`id_tmpdet`, d.`debe`, d.`haber`,  de.`tipo_mov`,
e.`glosa`, d.`cod_art`, d.`cant_art`,
 e.`cod_prov`, v.`no_trans`, v.`cod_doc`, v.`no_vale`, v.`cod_alm`, v.`id_com_encoc`, de.`cod_art`, de.`cantidad`, de.`monto`
FROM sf_tmpenc e 
JOIN sf_tmpdet d ON e.`id_tmpenc` = d.`id_tmpenc`
JOIN arcgms a 	 ON d.`cuenta` = a.`cuenta`
JOIN inv_vales v ON e.`id_tmpenc` = v.`idtmpenc`
JOIN inv_movdet de ON v.`no_trans` = de.`no_trans`
WHERE e.`fecha` BETWEEN '2019-01-01' AND '2019-04-31'
AND e.`estado` <> 'ANL'
AND e.`tipo_doc` = 'TR'
AND d.`cuenta` IN ('1580110100', '1580110200')
-- and de.`tipo_mov` = 'E'
;
	
-- 
-- VALES - MOVDET
SELECT i.`no_trans`, i.`fecha`, i.`no_vale`, m.`no_trans`, m.`fecha_cre`, m.`fecha_mov`, d.`id_inv_movdet`, d.`cod_art`, d.`cod_art`, d.`fecha`
FROM inv_movdet d
LEFT JOIN inv_mov m   ON d.`no_trans` = m.`no_trans`
LEFT JOIN inv_vales i ON d.`no_trans` = i.`no_trans`
WHERE d.`fecha` BETWEEN '2019-01-01' AND '2019-07-31'
;


-- VALES - ASIENTOS
SELECT i.`no_trans`, i.`fecha`, i.`no_vale`, e.`id_tmpenc`, e.`fecha`, e.`tipo_doc`, e.`no_doc`
FROM inv_vales i 
LEFT JOIN sf_tmpenc e ON i.`idtmpenc` = e.`id_tmpenc`
WHERE i.`fecha` BETWEEN '2019-01-01' AND '2019-07-31'
;


-- INVENTARIO - CONTABILIDAD
SELECT d.cod_art, a.descri, a.cod_med, 
SUM(d.debe)     AS debe, 
SUM(d.haber)    AS haber, 
SUM(IF(d.debe>0, d.cant_art, 0))  AS cant_e, 
SUM(IF(d.haber>0, d.cant_art, 0)) AS cant_s 
FROM sf_tmpdet d 
LEFT JOIN sf_tmpenc e ON d.id_tmpenc = e.id_tmpenc 
LEFT JOIN inv_articulos a ON d.cod_art = a.cod_art 
WHERE d.cuenta = '1580110200'
AND e.fecha BETWEEN '2019-01-01' AND '2019-05-31'
AND e.estado <> 'ANL' 
GROUP BY d.cod_art, a.descri, a.cod_med ORDER BY a.descri
;
-- 

/** ASIENTO CAPITALIZACION/AHORROS **/
SELECT e.`id_tmpenc`, d.`id_tmpdet`, e.`fecha`, e.`tipo_doc` AS tipo, E.`no_doc`, d.`no_trans`,  
d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, d.`debeme`, d.`haberme`,
d.`id_tmpenc`, d.`idcuenta`, c.`codigo`, s.`nombres`, s.`apellidopaterno`, s.`apellidomaterno`
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
LEFT JOIN cuenta c ON d.`idcuenta` = c.`idcuenta`
LEFT JOIN socio s ON c.`idsocio` = s.`idsocio`
WHERE e.`tipo_doc` = 'CD'
AND e.`no_doc` IN (1)
AND e.`fecha` BETWEEN '2019-01-01' AND '2019-12-31'
;

-- ESTADO DE CARTERA
SELECT d.`idcredito`, c.`codigoant`, d.`cuenta`, SUM(d.`debe`) AS debe, SUM(d.`haber`) AS haber, SUM(d.`debe`)-SUM(d.`haber`) AS saldo
FROM sf_tmpdet d
JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
JOIN credito c ON d.`idcredito` = c.`idcredito`
-- where e.`fecha` between '2019-01-01' and '2019-12-31'
WHERE e.`fecha` <= '2020-01-31'
AND e.`estado` <> 'ANL'
AND d.`cuenta` = '1330410200'
AND d.`idcredito` IS NOT NULL
GROUP BY d.`idcredito`, c.`codigoant`, d.`cuenta`
HAVING saldo > 0
;


-- ESTADO DE APORTES
SELECT d.`idsocio`, s.`nombres`, s.`apellidopaterno`, s.`apellidomaterno`, SUM(d.`debe`) AS debe, SUM(d.`haber`) AS haber
FROM sf_tmpdet d
JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
JOIN socio s     ON d.`idsocio` = s.`idsocio`
WHERE d.`cuenta` = '3110100000'
AND e.`estado` <> 'ANL'
AND d.`idsocio` IS NOT NULL
GROUP BY d.`idsocio`, s.`nombres`, s.`apellidopaterno`, s.`apellidomaterno`
;


-- NUEVOS CREDITOS
SELECT z.`idzonaproductiva`, COUNT(c.`idcredito`) AS cant, SUM(c.`importe`) AS monto
FROM credito c
LEFT JOIN socio s 	   ON c.`idsocio` = s.`idsocio`
LEFT JOIN zonaproductiva z ON s.`idzonaproductiva` = z.`idzonaproductiva`
WHERE c.`fechaconcesion` BETWEEN '2019-07-01' AND '2019-12-31'
GROUP BY z.`idzonaproductiva`
;

-- RECUERACION
SELECT z.`idzonaproductiva`, COUNT(c.`idcredito`) AS cant, SUM(t.`capital`) AS capital, SUM(t.`interes`) AS interes
FROM credito c
LEFT JOIN transaccioncredito t ON c.`idcredito` = t.`idcredito`
LEFT JOIN socio s 	   ON c.`idsocio` = s.`idsocio`
LEFT JOIN zonaproductiva z ON s.`idzonaproductiva` = z.`idzonaproductiva`
WHERE t.`fechatransaccion` BETWEEN '2020-01-01' AND '2020-01-31'
GROUP BY z.`idzonaproductiva`
;



/* fisico valorado */
SELECT d.cod_art, a.descri, a.cod_med,
SUM(d.debe)     AS debe,
SUM(d.haber)    AS haber,
SUM(IF(d.debe>0, d.cant_art, 0))  AS cant_e,
SUM(IF(d.haber>0, d.cant_art, 0)) AS cant_s
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.id_tmpenc = e.id_tmpenc
LEFT JOIN inv_articulos a ON d.cod_art = a.cod_art
WHERE d.cuenta = '1580110100'
AND e.fecha BETWEEN '2020-01-01' AND '2020-01-31'
AND e.estado <> 'ANL'
-- and d.cod_art is not null
GROUP BY d.cod_art, a.descri, a.cod_med ORDER BY a.descri ASC
;

/* Transferencia de PT detalle */
SELECT v.`fecha`, v.`no_trans`, v.`dest`, v.`orig`, v.`no_vale`, v.`oper`, v.`estado`, d.`tipo_mov`, d.`cod_art`, d.`cantidad`, d.`costounitario`, d.`preciounitcompra`, v.`idtmpenc`
FROM inv_movdet d
LEFT JOIN inv_vales v ON d.`no_trans` = v.`no_trans`
WHERE v.`fecha` BETWEEN '2020-07-01' AND '2020-07-31'
-- and d.`cod_art` in (134)
-- and v.`oper` is not null
-- and v.`oper` is null
;

/* Transferencia de PT */
SELECT v.`fecha`, v.`no_trans`, v.`dest`, v.`orig`, v.`no_vale`, v.`oper`, v.`estado`, v.`idtmpenc`, e.`tipo_doc`, e.`no_doc`
FROM inv_vales v 
LEFT JOIN sf_tmpenc e ON v.`idtmpenc` = e.`id_tmpenc`
WHERE v.`fecha` BETWEEN '2020-07-01' AND '2020-07-31'
AND v.`oper` IS NOT NULL
;


-- 
-- Anular Vales

-- UPDATE inv_vales i SET i.`estado` = 'ANL' WHERE i.`no_trans` IN (27123, 27124, 27160, 27161);
-- UPDATE inv_mov i SET i.`estado` = 'ANL' WHERE i.`no_trans` IN (27123, 27124, 27160, 27161);
-- UPDATE inv_movdet i SET i.`estado` = 'ANL' WHERE i.`no_trans` IN (27123, 27124, 27160, 27161);
-- 1014-IVERMIC .3.15 + AD3E X 50 ML (FR), venta al contado (1549) -1



