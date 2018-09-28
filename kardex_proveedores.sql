
/** SALDO PROVEEDORES 1 **/
SELECT d.`cuenta`, a.`descri`, e.`cod_prov`, en.`razon_social`, SUM(d.`debe`) AS Debe, SUM(d.`haber`) AS Haber, SUM(d.`debe`) - SUM(d.`haber`) AS Saldo
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
LEFT JOIN sf_entidades en ON e.`cod_prov` = en.`cod_enti` -- x
WHERE e.`fecha` >= '2016-01-01'
AND d.`cuenta` = '2420910300'
AND e.`estado` <> 'ANL'
GROUP BY d.`cuenta`, a.`descri`, e.`cod_prov`, en.`razon_social`
;

/** FROM TMPENC **/
SELECT e.`id_tmpenc`, e.`tipo_doc`, e.`no_doc`, e.`fecha`, e.`cod_prov`, d.`id_tmpdet`, d.`cuenta`, d.`debe`, d.`haber`, d.`cod_prov`, d.`id_tmpenc`
FROM sf_tmpenc e
JOIN sf_tmpdet d ON e.`id_tmpenc` = d.`id_tmpenc`
WHERE d.`cuenta` = '2420910300'
-- and e.`cod_prov` = 5
;

/** FROM TMPENC **/
SELECT e.`id_tmpenc`, e.`estado`, e.`tipo_doc`, e.`no_doc`, e.`fecha`, e.`cod_prov`, d.`id_tmpdet`, d.`cuenta`, d.`debe`, d.`haber`, d.`cod_prov`, d.`id_tmpenc`, e.`glosa`
FROM sf_tmpenc e
JOIN sf_tmpdet d ON e.`id_tmpenc` = d.`id_tmpenc`
WHERE d.`cuenta` = '2420910300'
AND d.`cod_prov` = 5
AND e.`estado` <> 'ANL'
;



/** FROM TMPDET **/
SELECT e.`id_tmpenc`, e.`tipo_doc`, e.`no_doc`, e.`fecha`, e.`cod_prov`, d.`id_tmpdet`, d.`cuenta`, d.`debe`, d.`haber`, d.`cod_prov`, d.`id_tmpenc`, e.`glosa`
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
-- join sf_entidades en on d.`cod_prov` = en.`cod_enti`
-- WHERE d.`cuenta` = '2420910300'
WHERE d.`cuenta` = '1420310100'
AND d.`cod_prov` IS NULL
-- and e.`cod_prov` is not null
-- and e.`cod_prov` = 115
-- AND e.`estado` <> 'ANL'
;

/** Actualiza COD_PROV en SF_TMPDET de la cuentas Acreedores%Bienes%Servicios **/
-- UPDATE sf_tmpdet d
JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
-- join sf_entidades en on d.`cod_prov` = en.`cod_enti`
SET d.`cod_prov` = e.`cod_prov`
WHERE d.`cuenta` = '2420910300'
-- AND e.`cod_prov` = 116
AND d.`cod_prov` IS NULL
AND e.`cod_prov` IS NOT NULL
;

/** RESUMEN KARDEX PROVEEDORES **/
SELECT d.`cod_prov`, d.`cuenta`, en.`razon_social`, SUM(d.`debe`) AS Debe, SUM(d.`haber`) AS Haber
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e     ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN sf_entidades en ON d.`cod_prov`  = en.`cod_enti`
WHERE d.`cuenta` = '2420910300'
GROUP BY d.`cod_prov`, d.`cuenta`, en.`razon_social`
;

/** RESUMEN KARDEX PROVEEDORES TEST**/
SELECT d.`cod_prov`, d.`cuenta`, en.`razon_social`, SUM(d.`debe`) AS Debe, SUM(d.`haber`) AS Haber
FROM sf_tmpenc e
JOIN sf_tmpdet d     ON e.`id_tmpenc` = d.`id_tmpenc`
JOIN sf_entidades en ON d.`cod_prov`  = en.`cod_enti`
WHERE d.`cuenta` = '2420910300'
AND e.`fecha` BETWEEN '2016-01-01' AND '2016-06-21'
GROUP BY d.`cod_prov`, d.`cuenta`, en.`razon_social`
;
-- 

-- 

/** FROM TMPENC **/
SELECT e.`id_tmpenc`, e.`tipo_doc`, e.`no_doc`, e.`fecha`, e.`cod_prov`, d.`id_tmpdet`, d.`cuenta`, d.`debe`, d.`haber`, d.`cod_prov`, d.`id_tmpenc`
FROM sf_tmpenc e
JOIN sf_tmpdet d ON e.`id_tmpenc` = d.`id_tmpenc`
WHERE d.`cuenta` = '2420910300'
AND e.`cod_prov` = 5
;

/** SALDO PROVEEDORES DETALLE **/
SELECT d.`cuenta`, a.`descri`, e.`cod_prov`, en.`razon_social`, e.`tipo_doc`, e.`no_doc`,  SUM(d.`debe`) AS TOTAL_D, SUM(d.`haber`) AS TOTAL_H
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
LEFT JOIN sf_entidades en ON e.`cod_prov` = en.`cod_enti`
WHERE e.`fecha` >= '2016-01-01'
AND d.`cuenta` = '2420910300'
AND e.`cod_prov` = 5
AND e.`estado` <> 'ANL'
GROUP BY d.`cuenta`, a.`descri`, e.`cod_prov`, en.`razon_social`, e.`tipo_doc`, e.`no_doc`
;


/** CALCULANDO SALDO A UNA FECHA DADA **/
SELECT d.`cuenta`, a.`descri`, SUM(d.`debe`) AS TOTAL_D, SUM(d.`haber`) AS TOTAL_H
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
WHERE e.`fecha` > '2015-09-30'
AND d.`cuenta` = '2420910300'
GROUP BY d.`cuenta`, a.`descri`
;

-- 07-07-2016
-- 1. hecho
SELECT *
FROM sf_tmpdet d
-- update sf_tmpdet d set d.`cuenta` = '2420910300'
WHERE d.`id_tmpdet` IN (

);

-- 2. hecho
UPDATE sf_tmpdet d
JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
-- join sf_entidades en on d.`cod_prov` = en.`cod_enti`
SET d.`cod_prov` = e.`cod_prov`
WHERE d.`cuenta` = '2420910300'
-- AND e.`cod_prov` = 116
AND d.`cod_prov` IS NULL
AND e.`cod_prov` IS NOT NULL
;

-- 3. hecho
SELECT *
FROM cxp_proveedores 
UPDATE cxp_proveedores SET ctaxpagar = '2420910300'
WHERE cod_prov IN (
);

-- 4. hecho
-- select *  from sf_tmpdet 
UPDATE sf_tmpdet SET cod_prov = 402 WHERE id_tmpdet = 125076;
UPDATE sf_tmpdet SET cod_prov = 52 WHERE id_tmpdet = 125079;
UPDATE sf_tmpdet SET cod_prov = 74 WHERE id_tmpdet = 125068;
UPDATE sf_tmpdet SET cod_prov = 86 WHERE id_tmpdet = 125795;
UPDATE sf_tmpdet SET cod_prov = 50 WHERE id_tmpdet = 125674;
UPDATE sf_tmpdet SET cod_prov = 50 WHERE id_tmpdet = 125675;
UPDATE sf_tmpdet SET cod_prov = 89 WHERE id_tmpdet = 126154;
UPDATE sf_tmpdet SET cod_prov = 104 WHERE id_tmpdet = 125905;
UPDATE sf_tmpdet SET cod_prov = 75 WHERE id_tmpdet = 125073;

UPDATE sf_tmpdet SET cod_prov = 61 WHERE id_tmpdet = 25728;
UPDATE sf_tmpdet SET cod_prov =  WHERE id_tmpdet = ;
UPDATE sf_tmpdet SET cod_prov =  WHERE id_tmpdet = ;
UPDATE sf_tmpdet SET cod_prov =  WHERE id_tmpdet = ;

-- 5. hecho
ALTER TABLE cxp_proveedores ADD aux VARCHAR(255) NULL;
UPDATE cxp_proveedores SET aux = ctaxpagar;
UPDATE cxp_proveedores SET ctaxpagar = '2420910300';

SELECT pr.`cod_prov`, en.`razon_social`, pr.`ctaxpagar`, a.`descri`
FROM cxp_proveedores pr
JOIN sf_entidades en ON pr.`cod_prov` = en.`cod_enti`
JOIN arcgms a ON pr.`ctaxpagar` = a.`cuenta`
;


SELECT *
FROM sf_tmpenc e
WHERE e.`tipo_doc` = 'DB'
AND e.`no_doc` IN (43, 86, 2, 3, 4, 10, 11, 12, 525, 7, 625, 626, 627, 628, 629, 630);

-- -----------------------------------
-- REPORTE CD - APERTURA
-- -----------------------------------
SELECT e.`id_tmpenc`, e.`fecha`, e.`estado`, e.`tipo_doc`, e.`no_doc`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, e.`glosa`, CONCAT(p.`NOM`, ' ', p.`AP`, ' ', p.`AM`) AS Cliente, en.`razon_social`, d.`cod_prov`, d.`idpersonacliente`, d.`id_tmpdet`
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta`    = a.`cuenta`
LEFT JOIN personacliente p ON d.`idpersonacliente` = p.`IDPERSONACLIENTE`
LEFT JOIN sf_entidades en  ON d.`cod_prov` = en.`cod_enti`
WHERE e.`tipo_doc` = 'CD'
;

--
-- OJO: HAY ASIENTOS QUE NO ESTAN ASOCIADO CON SU AUXILIAR
/** RESUMEN AUXILIAR ANALITICO TODAS LAS CUENTAS **/
SELECT d.`cod_prov`, d.`cuenta`, a.`descri`, en.`razon_social`, SUM(d.`debe`) AS Debe, SUM(d.`haber`) AS Haber
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e     ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN sf_entidades en ON d.`cod_prov`  = en.`cod_enti`
LEFT JOIN arcgms a 	  ON d.`cuenta`    = a.`cuenta`
WHERE e.`fecha` BETWEEN '2016-05-01' AND '2016-07-31'
AND d.`cuenta` IN ('9550110000')
AND e.`estado` <> 'ANL'
-- and d.`cod_prov` is not null
GROUP BY d.`cod_prov`, d.`cuenta`, en.`razon_social`
;

/** RESUMEN AUXILIAR ANALITICO TODAS LAS CUENTAS **/
SELECT d.`cod_prov`, d.`cuenta`, a.`descri`, en.`razon_social`, SUM(d.`debe`) AS Debe, SUM(d.`haber`) AS Haber
FROM sf_tmpenc e
LEFT JOIN sf_tmpdet d     ON e.`id_tmpenc` = d.`id_tmpenc`
LEFT JOIN sf_entidades en ON d.`cod_prov`  = en.`cod_enti`
LEFT JOIN arcgms a 	  ON d.`cuenta`    = a.`cuenta`
WHERE e.`fecha` BETWEEN '2016-05-01' AND '2016-07-31'
AND d.`cuenta` >= '1420310700' AND d.`cuenta` <= '1420310700'
AND e.`estado` <> 'ANL'
-- AND d.`cod_prov` IS NOT NULL
GROUP BY d.`cod_prov`, d.`cuenta`, en.`razon_social`
;

-- OJO: HAY ASIENTOS QUE NO ESTAN ASOCIADO CON SU AUXILIAR -- det
/** RESUMEN AUXILIAR ANALITICO TODAS LAS CUENTAS **/
SELECT d.`cod_prov`, e.`id_tmpenc`, e.`tipo_doc`, e.`no_doc`, d.`cuenta`, a.`descri`, en.`razon_social`, SUM(d.`debe`) AS Debe, SUM(d.`haber`) AS Haber
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e     ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN sf_entidades en ON d.`cod_prov`  = en.`cod_enti`
LEFT JOIN arcgms a 	  ON d.`cuenta`    = a.`cuenta`
WHERE e.`fecha` BETWEEN '2016-05-01' AND '2016-07-31'
AND d.`cuenta` IN ('4470510900')
AND e.`estado` <> 'ANL'
-- and d.`cod_prov` is not null
GROUP BY d.`cod_prov`, d.`cuenta`, en.`razon_social`
;


SELECT e.`fecha`, e.`tipo_doc`, e.`no_doc`, e.`estado`, d.`cuenta`, d.`debe`, d.`haber`, d.`cod_prov`
FROM sf_tmpdet d
JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
WHERE e.`tipo_doc` = 'CP' AND e.`no_doc` = '330' AND d.`cuenta` = '1420310100'
;

-- hecho en prod
UPDATE sf_tmpdet d JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
SET d.`cod_prov` = 196
WHERE e.`tipo_doc` = 'CB' AND e.`no_doc` = '214' AND d.`cuenta` = '1420310100'
;

-- SQL REPORTE COSTOS UNITARIOS ALAMCENES
SELECT ia.`cod_gru`, gr.`descri`, ia.`cod_sub`, su.`descri`, ia.`cod_art`, ia.`descri`, ia.`saldo_mon`, ia.`saldo_fis`, ia.`costo_uni`
FROM inv_inventario i
LEFT JOIN inv_articulos ia ON i.`cod_art` = ia.`cod_art`
LEFT JOIN inv_almacenes al ON i.`cod_alm` = al.`cod_alm`
LEFT JOIN unidadnegocio un ON al.`idunidadnegocio` = un.`idunidadnegocio`
LEFT JOIN inv_subgrupos su ON ia.`cod_sub` = su.`cod_sub`
LEFT JOIN inv_grupos gr    ON ia.`cod_gru` = gr.`cod_gru`
WHERE su.`cod_gru` = gr.`cod_gru` 
AND un.`idunidadnegocio` = 470
AND al.`cod_alm` = 2
;


-- REVISION
/** SALDO PROVEEDORES 1 **/
SELECT d.`cuenta`, a.`descri`, en.`cod_enti`, en.`razon_social`, SUM(d.`debe`) AS Debe, SUM(d.`haber`) AS Haber, SUM(d.`debe`) - SUM(d.`haber`) AS SALDO
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
-- LEFT JOIN sf_entidades en ON e.`cod_prov` = en.`cod_enti` -- x
LEFT JOIN sf_entidades en ON d.`cod_prov` = en.`cod_enti` -- x
WHERE e.`fecha` >= '2016-01-01'
AND d.`cuenta` = '2420910300'
AND e.`estado` <> 'ANL'
-- and en.`cod_enti` = 169
GROUP BY d.`cuenta`, a.`descri`, en.`cod_enti`, en.`razon_social`
;





