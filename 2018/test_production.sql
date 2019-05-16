SELECT *
FROM inv_articulos
WHERE cod_art IN(
134,
131,
136,
118
)
;

-- update inv_articulos
SET saldo_mon = 0.00
WHERE saldo_mon IS NULL;

UPDATE inv_articulos
SET control_valorado = 'S';


SELECT *
FROM costosindirectos
WHERE idordenproduccion = 301
;


