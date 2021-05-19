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
WHERE P.FECHAINICIO = '2020-09-01'
AND   P.FECHAFIN    = '2020-09-15'
;
-- ----------------------------------------------------------------------

SELECT *
FROM REGISTROACOPIO R
LEFT JOIN PLANILLAACOPIO P ON R.IDPLANILLAACOPIO = P.IDPLANILLAACOPIO
WHERE P.FECHA BETWEEN '2018-01-01' AND '2018-01-15'
;

SELECT MONTH(P.FECHA) AS MES, SUM(R.CANTIDADRECIBIDA) AS RECIBIDA, SUM(R.CANTIDADPESADA) AS PESADA, ((SUM(R.CANTIDADPESADA)) * 3.2) AS PESADA_BS
FROM REGISTROACOPIO R
LEFT JOIN PLANILLAACOPIO P ON R.IDPLANILLAACOPIO = P.IDPLANILLAACOPIO
-- WHERE P.FECHA BETWEEN TO_DATE('01/02/2015','DD/MM/YYYY') AND TO_DATE('28/02/2015','DD/MM/YYYY')
WHERE P.FECHA BETWEEN '2020-01-01' AND '2020-02-'
GROUP BY MONTH(P.FECHA)
;

SELECT DAY(P.FECHA) AS dia, z.`idzonaproductiva`, z.`numero`, z.`nombre`, SUM(R.CANTIDADRECIBIDA) AS RECIBIDA, SUM(R.CANTIDADPESADA) AS PESADA
FROM REGISTROACOPIO R
LEFT JOIN PLANILLAACOPIO P ON R.IDPLANILLAACOPIO = P.IDPLANILLAACOPIO
LEFT JOIN zonaproductiva z ON r.`idzonaproductiva` = z.`idzonaproductiva`
WHERE P.FECHA BETWEEN '2019-02-01' AND '2019-02-15'
AND z.`numero` = 074
GROUP BY DAY(P.FECHA), z.`idzonaproductiva`, z.`numero`, z.`nombre`
;

SELECT p.`fecha`, SUM(R.CANTIDADRECIBIDA) AS RECIBIDA, SUM(R.CANTIDADPESADA) AS PESADA
FROM REGISTROACOPIO R
LEFT JOIN PLANILLAACOPIO P ON R.IDPLANILLAACOPIO = P.IDPLANILLAACOPIO
WHERE P.FECHA BETWEEN '2019-10-01' AND '2019-10-31'
GROUP BY p.`fecha`
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
	d.`comision`, 
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
WHERE p.fechainicio = '2020-09-01'
-- AND z.`numero` = 001
-- AND pe.`idpersona` IN (352)
AND r.`liquidopagable` <> 0
;


-- ---------------------------------------------------------------
-- --------------- PLANILLA DE PAGO X QUINCENA + CUENTAS -------------------
-- ---------------------------------------------------------------
SELECT  /* r.`idregistropagomateriaprima`, p.`idplanillapagomateriaprima`, z.`idzonaproductiva`, d.`iddescuentproductmateriaprima`,*/
	/*p.`fechainicio`,*/
	z.`nombre` AS gab, 
	-- z.`numero`,
	-- pe.`idpersona`, 
	e.`noidentificacion` AS ci, pe.`nombres`, pe.`apellidopaterno`, pe.`apellidomaterno`,
	r.`cantidadtotal` 		AS Cant, 
	r.`totalpagoacopio` 		AS Total, 
	/*r.`ga`,
	d.`retencion`			as Ret,
	d.`alcohol`,
	d.`concentrados`,
	d.`credito`,
	d.`veterinario`,
	d.`yogurt`,
	d.`tachos`,
	d.`otrosdescuentos` 		as Otros,
	r.`descuentoreserva`		as Reser,
	r.`ajustezonaproductiva` 	as Ajuste,
	d.`otrosingresos`		as Ingresos,*/
	r.`liquidopagable`		AS LiquidoP,
	pr.`numerocuenta`
	-- r.`totalganado` -- 
FROM registropagomateriaprima r
JOIN descuentproductmateriaprima d 	ON r.`iddescuentproductmateriaprima` = d.`iddescuentproductmateriaprima`
JOIN persona pe        			ON d.`idproductormateriaprima` = pe.`idpersona`
JOIN productormateriaprima pr 		ON pe.`idpersona` = pr.`idproductormateriaprima`
JOIN entidad e 				ON pe.`idpersona` = e.`identidad`
JOIN planillapagomateriaprima p 	ON r.`idplanillapagomateriaprima` = p.`idplanillapagomateriaprima`
JOIN zonaproductiva z 			ON p.`idzonaproductiva` = z.`idzonaproductiva`
WHERE p.fechainicio = '2021-03-16'
AND r.`liquidopagable` <> 0
ORDER BY z.`nombre`, pe.`nombres`
;


SELECT  z.`idzonaproductiva`, z.`nombre`, z.`numero`, SUM(r.`cantidadtotal`) AS cantidad
FROM registropagomateriaprima r
JOIN descuentproductmateriaprima d 	ON r.`iddescuentproductmateriaprima` = d.`iddescuentproductmateriaprima`
JOIN persona pe        			ON d.`idproductormateriaprima` = pe.`idpersona`
JOIN entidad e 				ON pe.`idpersona` = e.`identidad`
JOIN planillapagomateriaprima p 	ON r.`idplanillapagomateriaprima` = p.`idplanillapagomateriaprima`
JOIN zonaproductiva z 			ON p.`idzonaproductiva` = z.`idzonaproductiva`
WHERE p.fechainicio = '2019-02-01'
-- AND r.`liquidopagable` <> 0
GROUP BY z.`idzonaproductiva`, z.`nombre`, z.`numero`
;



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
WHERE pl.fecha BETWEEN '2019-02-01' AND '2019-02-15'
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
WHERE ppm.`fechainicio` >= '2019-02-01' 
AND   ppm.`fechafin`    <= '2019-02-15'
AND rpm.`totalpagoacopio` > 0
-- and zp.`numero` = 074
GROUP BY zp.`nombre`, p.`idpersona`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, ppm.`preciounitario`
;


--

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
WHERE ppm.`fechainicio` >= '2020-06-01' 
AND   ppm.`fechafin`    <= '2020-06-30'
AND rpm.`totalpagoacopio` > 0
GROUP BY zp.`nombre`, p.`idpersona`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, ppm.`preciounitario`
;



-- --------------------------------------------------------------------------------
-- --------------- PLANILLA DE PAGO X QUINCENA + RETENCION 0.20 -------------------
-- --------------------------------------------------------------------------------
SELECT  d.`idproductormateriaprima`,
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
WHERE p.fechainicio = '2019-02-01'
-- AND z.`numero` = 001
AND r.`liquidopagable` <> 0
ORDER BY z.`nombre`, pe.`nombres`
;
-- ---------------------------------------------------------------


SELECT *
FROM zonaproductiva z
WHERE z.`nombre` LIKE '%ENE%'
;

SELECT p.`idproductormateriaprima`, pe.`nombres`, pe.`apellidopaterno`, pe.`apellidomaterno`, p.`idzonaproductiva`
FROM productormateriaprima p
JOIN persona pe ON p.`idproductormateriaprima` = pe.`idpersona`
-- where pe.`nombres` like '%TANI%' and pe.`apellidopaterno` like '%CA%'
WHERE p.`idzonaproductiva` = 83
;




SELECT DISTINCT /* r.`idregistropagomateriaprima`, p.`idplanillapagomateriaprima`, z.`idzonaproductiva`, d.`iddescuentproductmateriaprima`,*/
	/*p.`fechainicio`,*/
	z.`nombre` AS gab, 
	-- z.`numero`,
	-- pe.`idpersona`, 
	e.`noidentificacion` AS ci, pe.`nombres`, pe.`apellidopaterno`, pe.`apellidomaterno`
	-- r.`cantidadtotal` 		as Cant, 
	-- r.`totalpagoacopio` 		as Total, 
	/*r.`ga`,
	d.`retencion`			as Ret,
	d.`alcohol`,
	d.`concentrados`,
	d.`credito`,
	d.`veterinario`,
	d.`yogurt`,
	d.`tachos`,
	d.`otrosdescuentos` 		as Otros,
	r.`descuentoreserva`		as Reser,
	r.`ajustezonaproductiva` 	as Ajuste,
	d.`otrosingresos`		as Ingresos,*/
	-- r.`liquidopagable`		as LiquidoP,
	-- pr.`numerocuenta`
	-- r.`totalganado` -- 
FROM registropagomateriaprima r
JOIN descuentproductmateriaprima d 	ON r.`iddescuentproductmateriaprima` = d.`iddescuentproductmateriaprima`
JOIN persona pe        			ON d.`idproductormateriaprima` = pe.`idpersona`
JOIN productormateriaprima pr 		ON pe.`idpersona` = pr.`idproductormateriaprima`
JOIN entidad e 				ON pe.`idpersona` = e.`identidad`
JOIN planillapagomateriaprima p 	ON r.`idplanillapagomateriaprima` = p.`idplanillapagomateriaprima`
JOIN zonaproductiva z 			ON p.`idzonaproductiva` = z.`idzonaproductiva`
WHERE p.fechainicio BETWEEN '2021-04-01' AND '2021-04-30'
AND r.`liquidopagable` <> 0
;




