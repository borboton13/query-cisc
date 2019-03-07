-- ----------------------------------------------------------------------
-- TOTALES PLANILLAS DE PAGO x GAB
-- ----------------------------------------------------------------------
SELECT 
        Z.NUMERO AS GAB,
        Z.NOMBRE AS ZONA_PRODUCTIVA,
        P.IDZONAPRODUCTIVA, 
        P.TOTALPESADOXGAB AS CANT_PESAJE_LT, 
        P.TOTALMONTOACOPIOADOXGAB AS TOTAL_BS, 
        P.TOTALRETENCIONESXGAB AS RET, 
        P.TOTALALCOHOLXGAB AS ALCOHOL, 
        P.TOTALCONCENTRADOSXGAB AS CONCENT,
        P.TOTALCREDITOXGAB AS CREDITO,
        P.TOTALVETERINARIOXGAB AS VETER,
        P.TOTALYOGURDXGAB AS YOG,
        P.TOTALTACHOSXGAB AS TACHOS,
        P.TOTALOTROSDECUENTOSXGAB AS OTROSD,
        P.TOTALAJUSTEXGAB AS AJUSTE,
        P.TOTALOTROSINGRESOSXGAB AS OTROSI,
        P.TOTALIQUIDOXGAB AS LIQUIDO_PAG
FROM PLANILLAPAGOMATERIAPRIMA P
LEFT JOIN ZONAPRODUCTIVA Z ON P.IDZONAPRODUCTIVA = Z.IDZONAPRODUCTIVA
WHERE P.FECHAINICIO = '2018-01-01'
AND   P.FECHAFIN    = '2018-01-15'
;
-- ----------------------------------------------------------------------

SELECT *
FROM REGISTROACOPIO R
LEFT JOIN PLANILLAACOPIO P ON R.IDPLANILLAACOPIO = P.IDPLANILLAACOPIO
WHERE P.FECHA BETWEEN '2018-01-01' AND '2018-01-15'
;

SELECT MONTH(P.FECHA) AS MES, SUM(R.CANTIDADRECIBIDA) AS RECIBIDA, SUM(R.CANTIDADPESADA) AS PESADA, ((SUM(R.CANTIDADPESADA)) * 3) AS PESADA_BS
FROM REGISTROACOPIO R
LEFT JOIN PLANILLAACOPIO P ON R.IDPLANILLAACOPIO = P.IDPLANILLAACOPIO
-- WHERE P.FECHA BETWEEN TO_DATE('01/02/2015','DD/MM/YYYY') AND TO_DATE('28/02/2015','DD/MM/YYYY')
WHERE P.FECHA BETWEEN '2016-05-01' AND '2016-05-15'
GROUP BY MONTH(P.FECHA)
;


SELECT * FROM planillapagomateriaprima;
SELECT * FROM `descuentproductmateriaprima`;

-- ---------------------------------------------------------------
-- --------------- PLANILLA DE PAGO X QUINCENA -------------------
-- ---------------------------------------------------------------
SELECT  r.`idregistropagomateriaprima`, p.`idplanillapagomateriaprima`, z.`idzonaproductiva`, d.`iddescuentproductmateriaprima`,
	p.`fechainicio`,
	z.`nombre`, z.`numero`,
	pe.`idpersona`, e.`noidentificacion` AS ci, pe.`nombres`, pe.`apellidopaterno`, pe.`apellidomaterno`,
	r.`cantidadtotal` 		AS Cant, 
	r.`totalpagoacopio` 		AS Total, 
	r.`ga`,
	d.`retencion`			AS Ret,
	d.`alcohol`,
	d.`concentrados`,
	d.`credito`,
	d.`veterinario`,
	d.`yogurt`,
	d.`tachos`,
	d.`otrosdescuentos` 		AS Otros,
	r.`descuentoreserva`		AS Reser,
	r.`ajustezonaproductiva` 	AS Ajuste,
	d.`otrosingresos`		AS Ingresos,
	r.`liquidopagable`		AS LiquidoP,
	 r.`totalganado` -- 
FROM registropagomateriaprima r
JOIN descuentproductmateriaprima d 	ON r.`iddescuentproductmateriaprima` = d.`iddescuentproductmateriaprima`
JOIN persona pe        			ON d.`idproductormateriaprima` = pe.`idpersona`
JOIN entidad e 				ON pe.`idpersona` = e.`identidad`
JOIN planillapagomateriaprima p 	ON r.`idplanillapagomateriaprima` = p.`idplanillapagomateriaprima`
JOIN zonaproductiva z 			ON p.`idzonaproductiva` = z.`idzonaproductiva`
WHERE p.fechainicio = '2018-11-01'
-- AND z.`numero` = 001
-- AND pe.`idpersona` IN (352)
AND r.`liquidopagable` <> 0
;

SELECT * FROM registropagomateriaprima r WHERE r.`idregistropagomateriaprima` = 301640;
SELECT * FROM descuentproductmateriaprima d WHERE d.`iddescuentproductmateriaprima` = 301640;
UPDATE descuentproductmateriaprima d SET d.`veterinario` = 0 WHERE d.`iddescuentproductmateriaprima` = 298903; -- 300bs
UPDATE descuentproductmateriaprima d SET d.`veterinario` = 0 WHERE d.`iddescuentproductmateriaprima` = 301640; -- 300bs

SELECT * FROM planillapagomateriaprima p WHERE p.`idplanillapagomateriaprima` = 38514;
UPDATE planillapagomateriaprima p SET p.`totalveterinarioxgab` = 0, p.`totaliquidoxgab` = 18947.71 WHERE p.`idplanillapagomateriaprima` = 38115; -- 300bs
UPDATE planillapagomateriaprima p SET p.`totalveterinarioxgab` = 0, p.`totaliquidoxgab` = 24827.8 WHERE p.`idplanillapagomateriaprima` = 38514; -- 300bs

-- ---------------------------------------------------------------
-- ---------------------------------------------------------------
-- --------------- REPORTE TOTAL X PRODUCTOR A PARTIR PLANILLA ---
-- ---------------------------------------------------------------
SELECT  
	z.`nombre`, z.`numero`,
	pe.`nombres`, pe.`apellidopaterno`, pe.`apellidomaterno`,
	SUM(r.`cantidadtotal`) 		AS Cant_LT
	-- r.`totalpagoacopio` 		AS Total
FROM registropagomateriaprima r
JOIN descuentproductmateriaprima d 	ON r.`iddescuentproductmateriaprima` = d.`iddescuentproductmateriaprima`
JOIN persona pe        			ON d.`idproductormateriaprima` = pe.`idpersona`
JOIN planillapagomateriaprima p 	ON r.`idplanillapagomateriaprima` = p.`idplanillapagomateriaprima`
JOIN zonaproductiva z 			ON p.`idzonaproductiva` = z.`idzonaproductiva`
WHERE p.fechainicio BETWEEN '2017-08-01' AND '2017-08-31'
-- AND z.`numero` = 074
AND r.`liquidopagable` <> 0
GROUP BY z.`nombre`, z.`numero`, pe.`nombres`, pe.`apellidopaterno`, pe.`apellidomaterno`
;
-- ---------------------------------------------------------------
-- ---------------------------------------------------------------
-- ---------------------------------------------------------------
-- --------------- PLANILLA DE PAGO X QUINCENA (PARA DEVOLUCION) -------------------
-- ---------------------------------------------------------------
SELECT  
	/* z.`nombre`, z.`numero`, */
	pe.`nombres`, pe.`apellidopaterno`, pe.`apellidomaterno`,
	SUM(r.`cantidadtotal`) 		AS Cant, 
	SUM(r.`totalpagoacopio`)	AS TotalBs
FROM registropagomateriaprima r
JOIN descuentproductmateriaprima d 	ON r.`iddescuentproductmateriaprima` = d.`iddescuentproductmateriaprima`
JOIN persona pe        			ON d.`idproductormateriaprima` = pe.`idpersona`
JOIN planillapagomateriaprima p 	ON r.`idplanillapagomateriaprima` = p.`idplanillapagomateriaprima`
JOIN zonaproductiva z 			ON p.`idzonaproductiva` = z.`idzonaproductiva`
WHERE p.fechainicio BETWEEN '2016-09-01' AND '2016-11-15'
-- AND z.`numero` = 091
AND r.`liquidopagable` <> 0
GROUP BY pe.`nombres`, pe.`apellidopaterno`, pe.`apellidomaterno`
;


-- ---------------------------------------------------
-- ---------- PESAJE X FECHA -------------------------
-- ---------------------------------------------------
-- SELECT pl.idplanillaacopio, pl.fecha, pl.totalpesado, ra.idregistroacopio, zo.nombre, zo.numero, ra.cantidadrecibida, ra.cantidadpesada, ra.cantidadrechazada, ra.idzonaproductiva
SELECT zo.nombre, zo.numero, SUM(ra.cantidadrecibida) AS cantidadrecibida, SUM(ra.cantidadpesada) AS cantidadpesada
FROM REGISTROACOPIO RA
LEFT JOIN PLANILLAACOPIO PL ON ra.idplanillaacopio = pl.idplanillaacopio
LEFT JOIN zonaproductiva ZO ON ra.idzonaproductiva = zo.idzonaproductiva
WHERE pl.fecha BETWEEN '2018-12-16' AND '2018-12-31'
GROUP BY zo.nombre, zo.numero
;

SELECT se.idzonaproductiva, zo.nombre, zo.numero, SUM(ac.cantidad) AS cantidad
FROM acopiomateriaprima ac
LEFT JOIN sesionacopio se   ON ac.idsesionacopio   = se.idsesionacopio
LEFT JOIN zonaproductiva zo ON se.idzonaproductiva = zo.idzonaproductiva
WHERE se.fecha BETWEEN '2018-12-16' AND '2018-12-31'
GROUP BY se.idzonaproductiva, zo.nombre, zo.numero
;



SELECT SUM(totalga)
FROM planillapagomateriaprima p
WHERE p.`fechainicio` = '2016-05-01'
;

-- SQL PLANILLA
SELECT zp.`nombre`, p.`idpersona`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, ppm.`preciounitario`, 
	SUM(rpm.cantidadtotal) AS cantidadtotal, 
	SUM(rpm.`totalpagoacopio`) AS totalpagoacopio, 
	SUM(rpm.`liquidopagable`) AS liquidopagable,
	SUM(dpm.RETENCION) AS RETENCION,
	SUM(dpm.ALCOHOL) AS ALCOHOL,
	SUM(dpm.CONCENTRADOS) AS CONCENTRADOS,
	SUM(dpm.CREDITO) AS CREDITO,
	SUM(dpm.VETERINARIO) AS VETERINARIO,
	SUM(dpm.YOGURT) AS YOGURT,
	SUM(dpm.TACHOS) AS TACHOS,
	SUM(dpm.OTROSDESCUENTOS) AS OTROSDESCUENTOS,
	SUM(rpm.AJUSTEZONAPRODUCTIVA) AS AJUSTEZONAPRODUCTIVA,
	SUM(dpm.OTROSINGRESOS) AS OTROSINGRESOS,
	SUM(rpm.DESCUENTORESERVA) AS DESCUENTORESERVA,
	SUM(rpm.GA) AS GA
FROM PLANILLAPAGOMATERIAPRIMA ppm
JOIN REGISTROPAGOMATERIAPRIMA rpm 	ON ppm.`idplanillapagomateriaprima`    = rpm.`idplanillapagomateriaprima`
JOIN DESCUENTPRODUCTMATERIAPRIMA dpm 	ON rpm.`iddescuentproductmateriaprima` = dpm.`iddescuentproductmateriaprima` 
JOIN PRODUCTORMATERIAPRIMA pm 		ON dpm.`idproductormateriaprima`       = pm.`idproductormateriaprima` 
JOIN ZONAPRODUCTIVA zp 			ON ppm.`idzonaproductiva` 	       = zp.`idzonaproductiva`
JOIN persona p 				ON pm.`idproductormateriaprima`        = p.`idpersona`
WHERE ppm.`fechainicio` >= '2016-09-01' 
AND   ppm.`fechafin`    <= '2016-11-01'
AND rpm.`totalpagoacopio` > 0
-- and zp.`numero` = 074
GROUP BY zp.`nombre`, p.`idpersona`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, ppm.`preciounitario`
;


--

SELECT -- zp.`nombre`, p.`idpersona`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, ppm.`preciounitario`, 
	SUM(rpm.cantidadtotal) AS cantidadtotal, 
	SUM(rpm.`totalpagoacopio`) AS totalpagoacopio, 
	SUM(rpm.`liquidopagable`) AS liquidopagable,
	SUM(dpm.RETENCION) AS RETENCION,
	SUM(dpm.ALCOHOL) AS ALCOHOL,
	SUM(dpm.CONCENTRADOS) AS CONCENTRADOS,
	SUM(dpm.CREDITO) AS CREDITO,
	SUM(dpm.VETERINARIO) AS VETERINARIO,
	SUM(dpm.YOGURT) AS YOGURT,
	SUM(dpm.TACHOS) AS TACHOS,
	SUM(dpm.OTROSDESCUENTOS) AS OTROSDESCUENTOS,
	SUM(rpm.AJUSTEZONAPRODUCTIVA) AS AJUSTEZONAPRODUCTIVA,
	SUM(dpm.OTROSINGRESOS) AS OTROSINGRESOS,
	SUM(rpm.DESCUENTORESERVA) AS DESCUENTORESERVA,
	SUM(rpm.GA) AS GA
FROM PLANILLAPAGOMATERIAPRIMA ppm
JOIN REGISTROPAGOMATERIAPRIMA rpm 	ON ppm.`idplanillapagomateriaprima`    = rpm.`idplanillapagomateriaprima`
JOIN DESCUENTPRODUCTMATERIAPRIMA dpm 	ON rpm.`iddescuentproductmateriaprima` = dpm.`iddescuentproductmateriaprima` 
JOIN PRODUCTORMATERIAPRIMA pm 		ON dpm.`idproductormateriaprima`       = pm.`idproductormateriaprima` 
JOIN ZONAPRODUCTIVA zp 			ON ppm.`idzonaproductiva` 	       = zp.`idzonaproductiva`
JOIN persona p 				ON pm.`idproductormateriaprima`        = p.`idpersona`
WHERE ppm.`fechainicio` >= '2018-02-01' 
AND   ppm.`fechafin`    <= '2018-02-15'
AND rpm.`totalpagoacopio` > 0
-- GROUP BY -- zp.`nombre`, p.`idpersona`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, ppm.`preciounitario`
;



-- --------------------------------------------------------------------------------
-- --------------- PLANILLA DE PAGO X QUINCENA + RETENCION 0.20 -------------------
-- --------------------------------------------------------------------------------
SELECT  
	z.`nombre` AS GAB, z.`numero` AS Nro, e.`noidentificacion` AS CI, pe.`Nombres`, pe.`ApellidoPaterno`, pe.`ApellidoMaterno`,
	r.`cantidadtotal` 		AS Cantidad,
	@ret:=r.`cantidadtotal` * 0.2 	AS Retenc, 
	-- r.`totalpagoacopio` 		AS Total, 
	-- r.`ga`,
	-- d.`retencion`			AS Ret,
	-- d.`alcohol`,
	-- d.`concentrados`,
	-- d.`credito`,
	-- d.`veterinario`,
	-- d.`yogurt`,
	-- d.`tachos`,
	-- d.`otrosdescuentos` 		AS Otros,
	-- r.`descuentoreserva`		AS Reser,
	-- r.`ajustezonaproductiva` 	AS Ajuste,
	-- d.`otrosingresos`		AS Ingresos,
	r.`liquidopagable`		AS TotalBP,
	r.`liquidopagable` - @ret 	AS Total_Pagar
	-- r.`totalganado` 
FROM registropagomateriaprima r
JOIN descuentproductmateriaprima d 	ON r.`iddescuentproductmateriaprima` = d.`iddescuentproductmateriaprima`
JOIN persona pe        			ON d.`idproductormateriaprima` = pe.`idpersona`
JOIN entidad e 				ON pe.`idpersona` = e.`identidad`
JOIN planillapagomateriaprima p 	ON r.`idplanillapagomateriaprima` = p.`idplanillapagomateriaprima`
JOIN zonaproductiva z 			ON p.`idzonaproductiva` = z.`idzonaproductiva`
WHERE p.fechainicio = '2018-09-16'
-- AND z.`numero` = 001
AND r.`liquidopagable` <> 0
ORDER BY z.`nombre`, pe.`nombres`
;
-- ---------------------------------------------------------------
