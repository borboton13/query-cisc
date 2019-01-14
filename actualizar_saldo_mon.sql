UPDATE articulos_pedido a SET a.`cu` = 16.982300 WHERE a.`cod_art` = 251 AND a.`cu` < 30;

SELECT *
FROM articulos_pedido a
WHERE a.`cod_art` = 251
;


SELECT * FROM com_detoc d WHERE d.`cod_art` = 17;

UPDATE inv_articulos i 
SET 	i.cu = 0,
	i.`costo_uni` = i.`cu` * 0.87, 
	i.`saldo_mon` = i.`costo_uni` * (0),
	i.`ct` = i.`cu` * (0)
WHERE i.`cod_art` = 
;


SELECT i.`cod_art`, i.`descri`, i.`cu`, i.`costo_uni`, i.`saldo_mon`, i.`ct`, o.`saldo_uni`
FROM inv_articulos i 
JOIN inv_inventario o ON i.`cod_art` = o.`cod_art`
AND i.`cod_art` IN (184)
;

UPDATE inv_articulos i
JOIN inv_inventario o ON i.`cod_art` = o.`cod_art`
SET 	i.`saldo_mon` = i.`costo_uni` * o.`saldo_uni`,
	i.`ct` = i.`cu` * o.`saldo_uni`
WHERE i.`cod_art` IN (

)
;


SELECT * FROM tabla ORDER BY id DESC LIMIT 1;

SELECT d.`cod_art`, d.`id_com_detoc`, d.`costo_uni`
FROM com_detoc d
ORDER BY d.`cod_art`, d.`id_com_detoc` DESC
;

SELECT t.cod_art, t.costo_uni AS cu
FROM (SELECT d.`cod_art`, d.`id_com_detoc`, d.`costo_uni` FROM com_detoc d ORDER BY d.`cod_art`, d.`id_com_detoc` DESC) t
GROUP BY t.cod_art
;

-- OBTIENE EL ULTIMO REGISTRO DE LAS COMPRAS POR ARTICULO
SELECT a.`cod_art`, a.`descri`, a.`cu`, i.cu
FROM inv_articulos a
JOIN (	SELECT t.cod_art, t.costo_uni AS cu
	FROM (SELECT d.`cod_art`, d.`id_com_detoc`, d.`costo_uni` FROM com_detoc d ORDER BY d.`cod_art`, d.`id_com_detoc` DESC) t
	GROUP BY t.cod_art ) i ON a.`cod_art` = i.cod_art
WHERE a.`cod_alm` = 1
;



SELECT *
FROM inv_inicio i
WHERE i.`alm` = 5
AND i.`gestion` = 2019
;

DELETE FROM inv_inicio
WHERE alm = 5
AND gestion = 2019
;


