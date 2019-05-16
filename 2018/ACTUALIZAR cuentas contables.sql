SELECT *
FROM inv_articulos
WHERE cuenta_art = '40301001001001'
;

-- 1
UPDATE inv_articulos SET cuenta_art = '4420110201'
WHERE cuenta_art = '40301001001001'
;

-- 2
UPDATE arcgms SET moneda = 'P';

UPDATE arcgms SET exije_cc = 'N';

-- 

SELECT cod_gru, cod_sub, cod_art, descri, cuenta_art
FROM inv_articulos
WHERE cod_gru = 
;

SELECT *
FROM arcgms
WHERE cuenta = '4460114500'
;