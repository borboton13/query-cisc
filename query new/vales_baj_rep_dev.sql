SELECT DISTINCT v.`fecha`, v.`no_vale`, v.`no_trans`, v.`cod_doc`, v.`estado`, m.`descri`
FROM inv_movdet d 
LEFT JOIN inv_mov m   ON d.`no_trans` = m.`no_trans`
LEFT JOIN inv_vales v ON d.`no_trans` = v.`no_trans`
LEFT JOIN inv_articulos a ON d.`cod_art` = a.`cod_art`
WHERE v.`fecha` BETWEEN '2018-07-01' AND '2018-08-02'
AND v.`cod_doc` IN ('REP', 'BAJ', 'DEV')
AND v.`estado` <> 'ANL'
;

SELECT v.`fecha`, v.`no_vale`, v.`no_trans`, v.`cod_doc`, v.`estado`, m.`descri`, d.`cod_art`, a.`descri`,  d.`cantidad`, d.`preciocompra`, d.`monto`
FROM inv_movdet d 
LEFT JOIN inv_mov m   ON d.`no_trans` = m.`no_trans`
LEFT JOIN inv_vales v ON d.`no_trans` = v.`no_trans`
LEFT JOIN inv_articulos a ON d.`cod_art` = a.`cod_art`
WHERE v.`fecha` BETWEEN '2018-07-01' AND '2018-08-02'
AND v.`cod_doc` IN ('REP', 'BAJ', 'DEV')
;

SELECT v.`cod_doc`, d.`cod_art`, a.`descri`, SUM(d.`cantidad`) AS cantidad
FROM inv_movdet d 
LEFT JOIN inv_mov m   ON d.`no_trans` = m.`no_trans`
LEFT JOIN inv_vales v ON d.`no_trans` = v.`no_trans`
LEFT JOIN inv_articulos a ON d.`cod_art` = a.`cod_art`
WHERE v.`fecha` BETWEEN '2018-07-01' AND '2018-08-02'
AND v.`cod_doc` IN ('REP', 'BAJ', 'DEV')
AND 
GROUP BY v.`cod_doc`, d.`cod_art`, a.`descri`
;



