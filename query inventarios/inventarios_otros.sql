
SELECT 	i.`cod_art`, i.`nombre`, 
	i.`cantidad` AS inicial, 
	-- i.`costo_uni`, 
	-- (i.`cantidad` * i.`costo_uni`) as totalbs_ini,
	-- IFNULL(co.cant_compras, 0) AS cant_compras,
	-- ifnull(co.totalbs, 0) as totalbs_com, 
	-- IFNULL(ve.cant_ventas, 0) AS cant_ventas
	-- 
	--
	IFNULL(en.cantidad, 0) AS entradas,
	@cant_total:=i.`cantidad` + IFNULL(en.cantidad, 0) AS cant_total,
	-- @costo_total:= ((i.`cantidad` * i.`costo_uni`))+(IFNULL(co.totalbs, 0)) as costo_total,
	@salidas:= IFNULL(sa.cantidad, 0) AS salidas,
	@saldo_final:= (@cant_total - @salidas) AS saldo_final,
	@costo_uni:= IFNULL((((i.`cantidad` * i.`costo_uni`))+(IFNULL(en.totalbs, 0))) / (@cant_total), 0) AS costo_uni,
	@saldo_final * @costo_uni AS saldo_val,
	i.cantx
FROM inv_inicio i
LEFT JOIN (	-- ENTRADAS
		SELECT 	d.`cod_art`, a.`descri`, 
		SUM(d.`cantidad`) AS cantidad,
		SUM(d.preciocompra) AS totalbs
		FROM inv_movdet d
		LEFT JOIN inv_mov m 	  ON d.`no_trans` = m.no_trans
		LEFT JOIN inv_vales v 	  ON d.`no_trans` = v.`no_trans`
		LEFT JOIN inv_articulos a ON d.`cod_art` = a.`cod_art`
		WHERE v.fecha BETWEEN '2017-01-01' AND '2017-12-31'
		AND d.`tipo_mov` = 'E' 
		AND m.`estado` <> 'ANL'
		GROUP BY d.`cod_art`, a.`descri`
	) en 	ON i.`cod_art` = en.cod_art
LEFT JOIN (	-- SALIDAS
		SELECT 	d.`cod_art`, a.`descri`, SUM(d.`cantidad`) AS cantidad
		FROM inv_movdet d
		LEFT JOIN inv_mov m 	  ON d.`no_trans` = m.no_trans
		LEFT JOIN inv_vales v 	  ON d.`no_trans` = v.`no_trans`
		LEFT JOIN inv_articulos a ON d.`cod_art` = a.`cod_art`
		WHERE v.fecha BETWEEN '2017-01-01' AND '2017-12-31'
		AND d.`tipo_mov` = 'S' 
		AND m.`estado` <> 'ANL'
		GROUP BY d.`cod_art`, a.`descri`		
	) sa 	ON i.`cod_art` = sa.cod_art
WHERE i.`alm` = 3
AND i.gestion = 2017
;


-- Compras 2017
SELECT a.`cod_art`, a.`descri`, SUM(d.`cant_sol`) AS cantidad, SUM(d.`total`) AS totalbs
FROM com_detoc d
LEFT JOIN com_encoc c     ON d.`id_com_encoc` = c.`id_com_encoc`
LEFT JOIN inv_articulos a ON d.`cod_art`      = a.`cod_art`
WHERE c.`fecha` BETWEEN '2017-01-01' AND '2017-12-31'
GROUP BY a.`cod_art`, a.`descri`
;

-- Ventas
SELECT a.`cod_art`, a.`descri`, SUM(ar.`CANTIDAD`) AS cantidad
FROM articulos_pedido ar
LEFT JOIN ventadirecta v ON ar.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
LEFT JOIN inv_articulos a  ON ar.`cod_art` = a.`cod_art`
WHERE v.`IDUSUARIO` = 5
AND v.`FECHA_PEDIDO` BETWEEN '2017-01-01' AND '2017-12-31'
GROUP BY a.`cod_art`, a.`descri`
;


-- Vales
SELECT 	d.`cod_art`, a.`descri`, SUM(d.`cantidad`) AS cantidad
FROM inv_movdet d
LEFT JOIN inv_mov m 	  ON d.`no_trans` = m.no_trans
LEFT JOIN inv_vales v 	  ON d.`no_trans` = v.`no_trans`
LEFT JOIN inv_articulos a ON d.`cod_art` = a.`cod_art`
WHERE v.fecha BETWEEN '2017-01-01' AND '2017-12-31'
AND d.`tipo_mov` = 'S' 
AND m.`estado` <> 'ANL'
GROUP BY d.`cod_art`, a.`descri`
;


-- ----------------------------------------------------------------
-- ACTUALIZANDO DATOS ALM 5
-- 1.- INV_INVENTARIO set 0
UPDATE inv_inventario i SET i.`saldo_uni` = 0, i.`version` = 0
WHERE i.`cod_alm` IN (5);

UPDATE inv_inventario_detalle i SET i.`cantidad` = 0, i.`version` = 0
WHERE i.`cod_alm` IN (5);

-- 2.- Fijar INV_ARTICULO set 0
-- fijando en CERO
UPDATE inv_articulos ia
JOIN inv_inventario iv ON ia.`cod_art` = iv.`cod_art`
SET ia.`cu` = 0, ia.`costo_uni` = 0, ia.`saldo_mon` = 0, ia.`ct` = 0
WHERE iv.`cod_alm` IN (5);

-- 3.- Actualizando costo_uni, cu en INV_ARTICULOS
UPDATE inv_articulos i
JOIN auxinv a ON i.`cod_art` = a.`cod_art`
SET i.`costo_uni` = a.`costo_prom`*0.87 , i.`cu` = a.`costo_prom`
WHERE a.`alm` IN (5);

-- 4.- Actualizando inv_inventario, inv_inventario_detalle
UPDATE inv_inventario i
JOIN auxinv a ON i.`cod_art` = a.`cod_art`
SET i.`saldo_uni` = a.`cantidad`
WHERE a.`alm` IN (5);

UPDATE inv_inventario_detalle i
JOIN auxinv a ON i.`cod_art` = a.`cod_art`
SET i.`cantidad` = a.`cantidad`
WHERE a.`alm` IN (5);

-- 5. Actualizando saldo_mon en inv_articulos
UPDATE inv_articulos i
JOIN auxinv a ON i.`cod_art` = a.`cod_art`
SET i.`saldo_mon` = (a.`cantidad` * i.`costo_uni`) , i.`ct` = (a.`cantidad` * i.`cu`)
WHERE a.`alm` IN (5);
-- END
-- END


-- Reporte Costo de Ventas Detalle -> AUXINV
SELECT a.`IDARTICULOSPEDIDO`, v.`FECHA_PEDIDO`, a.`cod_art`, a.`CANTIDAD`, a.`PRECIO`, a.`PRECIO_INV`, a.`cu`, ai.`costo_prom`
FROM articulos_pedido a
JOIN ventadirecta v ON a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
JOIN auxinv ai 	    ON a.`cod_art` = ai.`cod_art` 
WHERE v.`FECHA_PEDIDO` BETWEEN '2017-01-01' AND '2017-01-31'
AND v.`ESTADO` <> 'ANULADO'
AND v.`IDUSUARIO` = 5
;

-- Reporte Costo de Ventas X Mes -> AUXINV
SELECT z.mes, SUM(z.costo_100) AS costo_100, SUM(z.costo_87) AS costo_87
FROM 	(
	SELECT MONTH(v.`FECHA_PEDIDO`) AS mes, a.`IDARTICULOSPEDIDO`, v.`FECHA_PEDIDO`, a.`cod_art`, a.`CANTIDAD`, ai.`costo_prom` AS cu, (a.`CANTIDAD`*ai.`costo_prom`) AS costo_100, (a.`CANTIDAD`*ai.`costo_prom`*0.87) AS costo_87
	FROM articulos_pedido a
	JOIN ventadirecta v ON a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
	JOIN auxinv ai 	    ON a.`cod_art` = ai.`cod_art` 
	WHERE v.`FECHA_PEDIDO` BETWEEN '2016-01-01' AND '2016-12-31'
	AND v.`ESTADO` <> 'ANULADO'
	AND v.`IDUSUARIO` = 5
	) z
GROUP BY z.mes
;





-- 1.- 
UPDATE articulos_pedido a
JOIN ventadirecta v ON a.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
JOIN auxinv ai 	    ON a.`cod_art` = ai.`cod_art` 
SET a.`cu` = ai.`costo_prom`
WHERE v.`FECHA_PEDIDO` BETWEEN '2016-12-01' AND '2016-12-31'
AND v.`IDUSUARIO` = 5
;

-- 2.- 
UPDATE ventadirecta v SET v.`CV` = 0
WHERE v.`FECHA_PEDIDO` BETWEEN '2016-12-01' AND '2016-12-31'
AND v.`IDUSUARIO` = 5
;


SELECT i.`cod_art`, i.`descri`, a.`PRECIO`, a.`PRECIO_INV`, a.`CANTIDAD`, a.`PROMOCION`, a.`REPOSICION`, a.`TOTAL`, a.`IMPORTE`, a.`cu`
FROM articulos_pedido a
JOIN pedidos p 		ON a.`IDPEDIDOS` = p.`IDPEDIDOS`
JOIN inv_articulos i 	ON a.`cod_art` = i.`cod_art` 
WHERE p.`FECHA_ENTREGA` BETWEEN '2017-02-01' AND '2017-02-28'
;



SELECT *
FROM inv_inventario i
WHERE i.`cod_alm` = 5
AND i.`cod_art` NOT IN (
	SELECT i.`cod_art`
	FROM inv_inicio i
	WHERE i.`alm` = 5
);

SELECT i.`cod_art`
FROM inv_inicio i
WHERE i.`alm` = 5
;



