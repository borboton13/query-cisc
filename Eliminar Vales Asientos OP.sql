-- 0.- Elimina Asientos CV 1,2,3,4,5
-- delete from sf_tmpdet where id_tmpenc in (105555, 105556, 105557, 105558, 105565);
-- DELETE FROM sf_tmpenc WHERE id_tmpenc in (105555, 105556, 105557, 105558, 105565);

UPDATE _sequence s SET s.`seq_val` = 0 WHERE s.`seq_name` = 'CV';

-- 1.- Para eliminar vales, asientos

SELECT *
FROM inv_vales i
WHERE i.`fecha` BETWEEN '2019-01-01' AND '2019-02-28'
AND i.`cod_alm` = 2
AND (i.`idordenproduccion` IS NOT NULL
OR i.`idproductobase` IS NOT NULL)
;


SELECT i.`no_trans`, i.`no_vale`, i.`fecha`, i.`idordenproduccion`, i.`idproductobase`, d.`tipo_mov`, d.`cod_art`, d.`monto`, d.`preciocompra`, d.`cantidad`, d.`costounitario`, d.`preciounitcompra`
FROM inv_vales i
LEFT JOIN inv_movdet d ON i.`no_trans` = d.`no_trans`
WHERE i.`fecha` BETWEEN '2019-01-01' AND '2019-01-31'
AND i.`cod_alm` = 2
AND (i.`idordenproduccion` IS NOT NULL OR i.`idproductobase` IS NOT NULL)
;


-- delete from sf_tmpdet where id_tmpenc in ();
-- DELETE FROM sf_tmpenc WHERE id_tmpenc in ();

SELECT *
FROM inv_vales i
WHERE i.`no_vale` IN (

);

-- delete from inv_movdet 
-- delete from inv_mov
-- DELETE FROM inv_vales
WHERE no_trans IN (

);

-- delete from sf_tmpdet 
-- DELETE FROM sf_tmpenc
WHERE id_tmpenc IN (

);






