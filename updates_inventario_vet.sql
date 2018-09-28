SELECT *
FROM ventadirecta
WHERE IDUSUARIO = 5
;

-- Articulos Veterinarios en VENTADIRECTA
-- select *
SELECT DISTINCT a.`IDARTICULOSPEDIDO`, a.`cod_art`, a.`PRECIO`, a.`PRECIO_INV`, ar.`descri`, ar.`costo_uni`, ar.`precio_uni`, ar.`cuenta_art`
FROM articulos_pedido a
JOIN ventadirecta v ON a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
JOIN inv_articulos ar ON a.`cod_art` = ar.`cod_art`
WHERE v.`IDUSUARIO` = 5
-- where ar.`cuenta_art` = '4430110900'
;

SELECT DISTINCT a.`IDARTICULOSPEDIDO`, a.`cod_art`, a.`PRECIO`, a.`PRECIO_INV` -- , ar.`descri`, ar.`costo_uni`, ar.`precio_uni`, ar.`cuenta_art`
FROM articulos_pedido a
JOIN ventadirecta v ON a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
WHERE v.`IDUSUARIO` = 5
-- where ar.`cuenta_art` = '4430110900'
;

SELECT *
FROM inv_articulos
WHERE cuenta_art = '4430111000'
;

-- 1. Eliminar articulos de VENTAARTICULO
SELECT *
FROM ventaarticulo
WHERE COD_ART IN (
	SELECT COD_ART
	FROM inv_articulos
	WHERE cuenta_art = '4430110900'
	-- and aux = 0
)
;

-- 2. Eliminar articulos de INV_INVENTARIO
SELECT *
FROM inv_inventario
WHERE COD_ART IN (
	SELECT COD_ART
	FROM inv_articulos
	WHERE cuenta_art = '4430110900'
)
;

-- 3. Eliminar articulos de INV_INVENTARIO_DETALLE
SELECT *
FROM inv_inventario_detalle
WHERE COD_ART IN (
	SELECT COD_ART
	FROM inv_articulos
	WHERE cuenta_art = '4430110900'
)
;

-- 4. Eliminar articulos de INV_ARRICULOS
SELECT *
FROM inv_articulos
WHERE cuenta_art = '4430110900'
;

-- CHECK vendidos
SELECT *
FROM inv_articulos
-- update inv_articulos set aux = '1'
WHERE cuenta_art = '4430110900'
AND cod_art IN (
	SELECT DISTINCT a.`cod_art`
	FROM articulos_pedido a
	JOIN ventadirecta v ON a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
	WHERE v.`IDUSUARIO` = 5
)
;

SELECT *
FROM inv_articulos
WHERE aux IS NOT NULL
AND COD_ART > 414
;

-- Para eliminar
SELECT *
FROM inv_articulos
-- where aux = 1
WHERE cod_art_eq IS NOT NULL
;


SELECT *
FROM inv_articulos
-- WHERE aux = 1
WHERE cod_art > 414
;




SELECT *
FROM inv_articulos
WHERE COD_ART > 414
AND cod_gru = 8
;

SELECT *
FROM articulos_pedido
WHERE COD_ART > 414
;

SELECT *
FROM ventaarticulo
WHERE COD_ART > 197;






