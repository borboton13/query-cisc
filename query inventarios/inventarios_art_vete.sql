-- delete from auxinv where alm = 5;

INSERT INTO auxinv (cod_art, nombre, cantidad, alm, costo_prom)
SELECT inv.cod_art, inv.nombre, inv.saldo_final, 5, inv.costo_uni FROM (
SELECT 	i.`cod_art`, i.`nombre`, 
	i.`cantidad` AS inicial, 
	IFNULL(co.cant_compras, 0) AS compras,
	@entradas:= IFNULL(ent.cantidad, 0) AS entradas,
	@salidas:= IFNULL(sal.cantidad, 0) AS salidas,
	@cant_total:=i.`cantidad` + IFNULL(co.cant_compras, 0) + @entradas - @salidas AS cant_total,
	-- @costo_total:= ((i.`cantidad` * i.`costo_uni`))+(IFNULL(co.totalbs, 0)) as costo_total,
	@ventas:= IFNULL(ve.cant_ventas, 0) AS ventas,
	@saldo_final:= (@cant_total - @ventas) AS saldo_final,
	@costo_uni:= IFNULL((((i.`cantidad` * i.`costo_uni`))+(IFNULL(co.totalbs, 0))) / (@cant_total), 0) AS costo_uni,
	@saldo_final * @costo_uni AS saldo_val
	-- ,i.cantx,a.costo_uni, a.cu
FROM inv_inicio i
LEFT JOIN (	-- COMPRAS
		SELECT 	a.`cod_art`, a.`descri`, 
			SUM(d.`cant_sol`) AS cant_compras, 
			SUM(d.`total`) AS totalbs
			-- (SUM(d.`total`) / SUM(d.`cant_sol`)) AS costo_unit
		FROM com_detoc d
		LEFT JOIN com_encoc c     ON d.`id_com_encoc` = c.`id_com_encoc`
		LEFT JOIN inv_articulos a ON d.`cod_art`      = a.`cod_art`
		AND c.estado <> 'ANL'
		-- WHERE c.`fecha` BETWEEN '2017-01-01' AND '2017-12-31'
		WHERE c.fecha_recepcion BETWEEN '2017-01-01' AND '2018-02-28'
		GROUP BY a.`cod_art`, a.`descri`	
	
	) co 	ON i.`cod_art` = co.cod_art
LEFT JOIN (	-- VENTAS
		SELECT a.`cod_art`, a.`descri`, SUM(ar.`CANTIDAD`) AS cant_ventas
		FROM articulos_pedido ar
		LEFT JOIN ventadirecta v ON ar.`IDVENTADIRECTA` = v.`IDVENTADIRECTA`
		LEFT JOIN inv_articulos a  ON ar.`cod_art` = a.`cod_art`
		WHERE v.`IDUSUARIO` = 5
		AND v.estado <> 'ANULADO'
		AND v.`FECHA_PEDIDO` BETWEEN '2017-01-01' AND '2018-02-28'
		GROUP BY a.`cod_art`, a.`descri`
		
	) ve 	ON i.`cod_art` = ve.cod_art
LEFT JOIN (	-- Vales Entrada
		SELECT d.`cod_art`, SUM(d.`cantidad`) AS cantidad
		FROM inv_movdet d
		LEFT JOIN inv_mov m   ON d.`no_trans` = m.`no_trans`
		LEFT JOIN inv_vales v ON m.`no_trans` = v.`no_trans`
		WHERE v.fecha BETWEEN '2017-01-01' AND '2018-02-28'
		AND d.`cod_alm` = 5
		AND d.`tipo_mov` = 'E'
		AND v.`id_com_encoc` IS NULL
		AND v.`estado` <> 'ANL'
		GROUP BY d.`cod_art`
	)ent ON i.cod_art = ent.cod_art
LEFT JOIN (	-- Vales Salida
		SELECT d.`cod_art`, SUM(d.`cantidad`) AS cantidad
		FROM inv_movdet d
		LEFT JOIN inv_mov m   ON d.`no_trans` = m.`no_trans`
		LEFT JOIN inv_vales v ON m.`no_trans` = v.`no_trans`
		WHERE v.fecha BETWEEN '2017-01-01' AND '2018-02-28'
		AND d.`cod_alm` = 5
		AND d.`tipo_mov` = 'S'
		AND v.`id_com_encoc` IS NULL
		AND v.`estado` <> 'ANL'
		GROUP BY d.`cod_art`
	)sal ON i.cod_art = sal.cod_art
LEFT JOIN inv_articulos a ON i.cod_art = a.cod_art
WHERE i.`alm` = 5
) inv 
;


SELECT d.`cod_art`, SUM(d.`cantidad`) AS cantidad
FROM inv_movdet d
LEFT JOIN inv_mov m   ON d.`no_trans` = m.`no_trans`
LEFT JOIN inv_vales v ON m.`no_trans` = v.`no_trans`
WHERE d.`cod_alm` = 5
AND d.`tipo_mov` = 'E'
AND v.`id_com_encoc` IS NULL
AND v.`estado` <> 'ANL'
GROUP BY d.`cod_art`
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



