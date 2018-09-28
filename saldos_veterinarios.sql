-- Articulos Veterinarios
SELECT i.`cod_art`, i.`descri`, precio_uni, saldo_fis
FROM inv_articulos i
WHERE i.cuenta_art = '4430110900'
;

-- Articulos Veterinarios y Ventas
SELECT i.`cod_art`, i.`descri`, SUM(ap.`TOTAL`) AS total
FROM inv_articulos i
LEFT JOIN articulos_pedido ap ON i.`cod_art` = ap.`cod_art`
WHERE i.cuenta_art = '4430110900'
GROUP BY i.`cod_art`, i.`descri`
;

-- VENTAS de articulos veterinarios
SELECT a.`cod_art`, i.`descri`, SUM(a.`TOTAL`) AS cant_venta
FROM articulos_pedido a
JOIN ventadirecta v  ON a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
JOIN inv_articulos i ON a.`cod_art` = i.`cod_art`
WHERE v.IDUSUARIO = 5
AND v.FECHA_PEDIDO BETWEEN '2016-01-01' AND '2016-12-31'
GROUP BY a.`cod_art`, i.`descri`
;

-- COMPRAS de articulos veterinarios
SELECT i.`cod_art`, i.`descri`, det.`cod_art`, SUM(det.`cant_sol`) AS cant_compra
FROM inv_articulos i
LEFT JOIN com_detoc det ON i.`cod_art` = det.`cod_art`
LEFT JOIN com_encoc com ON det.`id_com_encoc` = com.`id_com_encoc`
WHERE i.cuenta_art = '4430110900'
AND com.`fecha_recepcion`  BETWEEN '2016-01-01' AND '2016-12-31'
GROUP BY i.`cod_art`, i.`descri`, det.`cod_art`
;

-- -- SALDO FINAL PRODUCTOS VETERINARIOS
SELECT art_vet.cod_art, art_vet.descri, art_vet.precio_uni, IFNULL(art_vet.saldo_fis, 0) AS saldo_fis, IFNULL(com_vet.cant_compra, 0) AS cant_compra, IFNULL(ven_vet.cant_venta, 0 ) AS cant_venta, 
       (IFNULL(art_vet.saldo_fis, 0) + IFNULL(com_vet.cant_compra, 0) - IFNULL(ven_vet.cant_venta, 0 )) AS saldo_final
FROM (  -- Articulos Veterinarios
	SELECT i.`cod_art`, i.`descri`, precio_uni, saldo_fis
	FROM inv_articulos i WHERE i.cuenta_art = '4430110900'
     ) art_vet
LEFT JOIN ( -- COMPRAS de articulos veterinarios
		SELECT i.`cod_art`, i.`descri`, SUM(det.`cant_sol`) AS cant_compra
		FROM inv_articulos i
		LEFT JOIN com_detoc det ON i.`cod_art` = det.`cod_art`
		LEFT JOIN com_encoc com ON det.`id_com_encoc` = com.`id_com_encoc`
		WHERE i.cuenta_art = '4430110900'
		AND com.`fecha_recepcion`  BETWEEN '2016-01-01' AND '2016-12-31'
		GROUP BY i.`cod_art`, i.`descri`
	   ) com_vet ON art_vet.cod_art = com_vet.cod_art
LEFT JOIN (-- VENTAS de articulos veterinarios
		SELECT a.`cod_art`, i.`descri`, SUM(a.`TOTAL`) AS cant_venta
		FROM articulos_pedido a
		JOIN ventadirecta v  ON a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
		JOIN inv_articulos i ON a.`cod_art` = i.`cod_art`
		WHERE v.IDUSUARIO = 5
		AND v.FECHA_PEDIDO BETWEEN '2016-01-01' AND '2016-12-31'
		GROUP BY a.`cod_art`, i.`descri`
           ) ven_vet ON art_vet.cod_art = ven_vet.cod_art
;



SELECT v.`FECHA_PEDIDO`, v.`CODIGO`, a.`CANTIDAD`, a.`PRECIO`, a.`PRECIO_INV`, v.`id_tmpenc`, v.`id_tmpenc_cv`
FROM articulos_pedido a
JOIN ventadirecta v ON a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
WHERE a.`cod_art` = 441
;


-- COMPRAS de articulos veterinarios
SELECT i.`cod_art`, i.`descri`, com.`fecha_recepcion`, det.`cod_art`, com.`no_orden`, det.`costo_uni`, det.`cant_sol`
FROM inv_articulos i
LEFT JOIN com_detoc det ON i.`cod_art` = det.`cod_art`
LEFT JOIN com_encoc com ON det.`id_com_encoc` = com.`id_com_encoc`
WHERE i.cuenta_art = '4430110900'
AND com.`fecha_recepcion`  BETWEEN '2016-01-01' AND '2016-12-31'
-- GROUP BY i.`cod_art`, i.`descri`, det.`cod_art`
AND det.`cod_art` = 446
;

-- 

SELECT *
FROM inv_inventario
WHERE cod_alm = 5
AND cod_art NOT IN (
	SELECT i.`cod_art`
	FROM inv_articulos i
	WHERE i.cuenta_art = '4430110900'
)
;



