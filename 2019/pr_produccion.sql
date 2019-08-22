SELECT pl.`fecha`, pro.`codigo`, pro.`costototal`, pr.`cod_art`, i.`descri`, pr.`cantidad`, pr.`costo_a`, pr.`costo_b`, pr.`costo_c`, pr.`costo`, pr.`costouni`
FROM pr_producto pr
LEFT JOIN pr_produccion pro ON pr.`idproduccion` = pro.`idproduccion`
LEFT JOIN pr_plan pl ON pr.`idplan` = pl.`idplan`
LEFT JOIN inv_articulos i ON pr.`cod_art` = i.`cod_art`
WHERE pl.`fecha` BETWEEN '2019-05-01' AND '2019-05-31'
;

SELECT pr.`cod_art`, i.`descri`, SUM(pr.`cantidad`) AS cantidad, SUM(pr.`costo`) AS costo
FROM pr_producto pr
LEFT JOIN pr_plan pl ON pr.`idplan` = pl.`idplan`
LEFT JOIN inv_articulos i ON pr.`cod_art` = i.`cod_art`
WHERE pl.`fecha` BETWEEN '2019-07-01' AND '2019-07-31'
GROUP BY pr.`cod_art`, i.`descri`
;


-- CAMBIAR ESTADO EN PR_PRODUCCION
-- update pr_produccion pr
JOIN pr_plan pl ON pr.`idplan` = pl.`idplan`
SET pr.`estado` = 'APR'
WHERE pl.`fecha` BETWEEN '2019-05-01' AND '2019-06-30'
;

UPDATE pr_plan p SET p.`estado` = 'APR' WHERE p.`fecha` BETWEEN '2019-05-01' AND '2019-06-30';
UPDATE periodocostoindirecto p SET p.`contab` = 0, p.`procesado` = 0 WHERE p.`idperiodocostoindirecto` = 37;


-- PRODUCCION INSUMOS
SELECT pl.`fecha`, pl.`estado`, p.`codigo`, p.`costototal`, p.`totalmp`, i.`cod_art`, a.`descri`, i.`cantidad`, i.`costouni`, i.`tipo`
FROM pr_insumo i 
LEFT JOIN inv_articulos a ON i.`cod_art` = a.`cod_art`
LEFT JOIN pr_produccion p ON i.`idproduccion` = p.`idproduccion`
LEFT JOIN pr_plan pl ON p.`idplan` = pl.`idplan`
WHERE pl.`fecha` BETWEEN '2019-05-01' AND '2019-05-31'
-- and i.`idproduccion` = 101
-- and i.`cod_art` = 1
;

SELECT pl.`fecha`, p.`codigo`, p.`totalmp`, i.`cod_art`, a.`descri`, i.`cantidad`, i.`costouni`, i.`tipo`
FROM pr_insumo i 
LEFT JOIN inv_articulos a ON i.`cod_art` = a.`cod_art`
LEFT JOIN pr_produccion p ON i.`idproduccion` = p.`idproduccion`
LEFT JOIN pr_plan pl ON p.`idplan` = pl.`idplan`
WHERE pl.`fecha` BETWEEN '2019-05-01' AND '2019-05-31'
;



UPDATE sf_tmpenc e SET e.`estado` = 'ANL'
WHERE e.`tipo_doc` = 'PD'
AND e.`fecha` BETWEEN '2019-05-01' AND '2019-05-31'
;


-- delete from sf_tmpdet
WHERE id_tmpenc IN (
SELECT e.`id_tmpenc`
FROM sf_tmpenc e
WHERE e.`tipo_doc` = 'PD'
AND e.`fecha` BETWEEN '2019-05-01' AND '2019-06-30'
);


SELECT 
SUM(pr.`totalmp`)
FROM pr_produccion pr
LEFT JOIN pr_plan pl ON pr.`idplan` = pl.`idplan`
WHERE pl.`fecha` BETWEEN '2019-05-01' AND '2019-05-31'
;




