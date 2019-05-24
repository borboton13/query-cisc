SELECT * FROM articulos_pedido
-- update articulos_pedido set COD_ART = 468
WHERE COD_ART = 446;

SELECT *
FROM ventaarticulo
-- update ventaarticulo set cod_art = 468
WHERE COD_ART = 446
;

SELECT *
FROM com_detoc
WHERE COD_ART = 446;
;

SELECT *
FROM inv_movdet
WHERE COD_ART = 446;

SELECT *
FROM inv_articulos
WHERE COD_ART IN (334, 441);


SELECT a.`IDARTICULOSPEDIDO`, a.`cod_art`, v.`FECHA_PEDIDO`, v.`CODIGO`, a.`CANTIDAD`, a.`PRECIO`, a.`PRECIO_INV`
FROM articulos_pedido a
JOIN ventadirecta v ON a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
WHERE a.`cod_art` = 225
AND a.`PRECIO` = 10
;


