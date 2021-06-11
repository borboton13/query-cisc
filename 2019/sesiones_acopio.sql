
SELECT se.idsesionacopio, se.fecha, se.idzonaproductiva, zo.nombre, zo.numero, ac.idacopiomateriaprima, ac.idproductormateriaprima, ac.cantidad
FROM acopiomateriaprima ac
LEFT JOIN sesionacopio se   ON ac.idsesionacopio   = se.idsesionacopio
LEFT JOIN zonaproductiva zo ON se.idzonaproductiva = zo.idzonaproductiva
WHERE se.fecha = to_date('16/02/2015','dd/mm/yyyy')
-- and zo.numero = 543
;

SELECT se.idsesionacopio, se.fecha, se.idzonaproductiva, zo.nombre, zo.numero, ac.idacopiomateriaprima, ac.idproductormateriaprima, ac.cantidad
FROM sesionacopio se
LEFT JOIN acopiomateriaprima ac   ON se.idsesionacopio = ac.idsesionacopio
LEFT JOIN zonaproductiva zo       ON se.idzonaproductiva = zo.idzonaproductiva
WHERE se.fecha = to_date('16/02/2015','dd/mm/yyyy')
-- and zo.numero = 543
;

SELECT se.idsesionacopio, se.fecha, se.idzonaproductiva, zo.nombre, zo.numero, SUM(ac.cantidad) AS cantidad
FROM acopiomateriaprima ac
LEFT JOIN sesionacopio se   ON ac.idsesionacopio   = se.idsesionacopio
LEFT JOIN zonaproductiva zo ON se.idzonaproductiva = zo.idzonaproductiva
WHERE se.fecha BETWEEN '2015-05-29' AND '2015-05-29'
-- and zo.numero = 093
GROUP BY se.idsesionacopio, se.fecha, se.idzonaproductiva, zo.nombre, zo.numero
-- ORDER BY zo.numero
ORDER BY se.fecha
;

-- UPDATE SECUENCIA SET VALOR=(SELECT MAX(E.IDACOPIOMATERIAPRIMA)/10+1 FROM ACOPIOMATERIAPRIMA E) WHERE TABLA='ACOPIOMATERIAPRIMA';

SELECT *
FROM PLANILLAACOPIO;

SELECT *
FROM REGISTROACOPIO RA;

SELECT pl.idplanillaacopio, pl.fecha, pl.totalpesado, ra.idregistroacopio, zo.nombre, zo.numero, ra.cantidadrecibida, ra.cantidadpesada, ra.cantidadrechazada, ra.idzonaproductiva
FROM REGISTROACOPIO RA
LEFT JOIN PLANILLAACOPIO PL ON ra.idplanillaacopio = pl.idplanillaacopio
LEFT JOIN zonaproductiva zo ON ra.idzonaproductiva = zo.idzonaproductiva
WHERE pl.fecha BETWEEN '2019-02-01' AND '2019-02-15'
-- AND zo.numero = 543
ORDER BY pl.fecha
;

SELECT zo.`idzonaproductiva`, zo.nombre, zo.numero, SUM(ra.cantidadrecibida)AS recibida, SUM(ra.cantidadpesada) AS pesada
FROM REGISTROACOPIO RA
LEFT JOIN PLANILLAACOPIO PL ON ra.idplanillaacopio = pl.idplanillaacopio
LEFT JOIN zonaproductiva zo ON ra.idzonaproductiva = zo.idzonaproductiva
WHERE pl.fecha BETWEEN '2019-02-01' AND '2019-02-15'
GROUP BY zo.`idzonaproductiva`, zo.nombre, zo.numero
;


SELECT *
FROM sesionacopio
;

SELECT *
FROM acopiomateriaprima am
;
-- REPORTE DE ACOPIO POR PRODUCTOR X MES
SELECT MONTH(sa.`fecha`) AS MES, zp.`numero`, zp.`nombre`, am.`idproductormateriaprima` AS id, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, SUM(am.`cantidad`) AS CANT
FROM acopiomateriaprima am
LEFT JOIN sesionacopio sa ON am.`idsesionacopio` = sa.`idsesionacopio`
LEFT JOIN zonaproductiva zp ON sa.`idzonaproductiva` = zp.`idzonaproductiva`
LEFT JOIN persona p ON am.`idproductormateriaprima` = p.`idpersona`
WHERE sa.`fecha` BETWEEN '2020-06-16' AND '2020-06-30'
AND am.`cantidad` > 0
GROUP BY MONTH(sa.`fecha`), zp.`numero`, zp.`nombre`, am.`idproductormateriaprima`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`
;

-- *** REPORTE DE ACOPIO POR PRODUCTOR X MES
SELECT MONTH(sa.`fecha`) AS MES, COUNT(DISTINCT am.`idproductormateriaprima`)AS PRODUCTORES, SUM(am.`cantidad`) AS LITROS
FROM acopiomateriaprima am
LEFT JOIN sesionacopio sa ON am.`idsesionacopio` = sa.`idsesionacopio`
LEFT JOIN zonaproductiva zp ON sa.`idzonaproductiva` = zp.`idzonaproductiva`
LEFT JOIN persona p ON am.`idproductormateriaprima` = p.`idpersona`
WHERE sa.`fecha` BETWEEN '2019-01-01' AND '2019-12-31'
AND am.`cantidad` > 0
GROUP BY MONTH(sa.`fecha`)
;

-- REPORTE DE ACOPIO POR PRODUCTOR X MES/QUINC + ci
SELECT MONTH(sa.`fecha`) AS MES, zp.`numero`, zp.`nombre`, /*am.`idproductormateriaprima` as idprod,*/ e.`noidentificacion` AS ci, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, SUM(am.`cantidad`) AS CANT
FROM acopiomateriaprima am
LEFT JOIN sesionacopio sa ON am.`idsesionacopio` = sa.`idsesionacopio`
LEFT JOIN zonaproductiva zp ON sa.`idzonaproductiva` = zp.`idzonaproductiva`
LEFT JOIN persona p ON am.`idproductormateriaprima` = p.`idpersona`
LEFT JOIN entidad e ON p.`idpersona` = e.`identidad`
WHERE sa.`fecha` BETWEEN '2019-08-01' AND '2019-08-31'
AND am.`cantidad` > 0
GROUP BY MONTH(sa.`fecha`), zp.`numero`, zp.`nombre`, am.`idproductormateriaprima`, e.`noidentificacion`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`
;

-- REPORTE DE ACOPIO POR PRODUCTOR + PROMEDIO
SELECT MONTH(sa.`fecha`) AS MES, zp.`numero`, zp.`nombre`, e.`noidentificacion` AS ci, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, SUM(am.`cantidad`) AS cant, COUNT(sa.`fecha`) AS dias, SUM(am.`cantidad`)/COUNT(sa.`fecha`) AS prom
FROM acopiomateriaprima am
LEFT JOIN sesionacopio sa ON am.`idsesionacopio` = sa.`idsesionacopio`
LEFT JOIN zonaproductiva zp ON sa.`idzonaproductiva` = zp.`idzonaproductiva`
LEFT JOIN persona p ON am.`idproductormateriaprima` = p.`idpersona`
LEFT JOIN entidad e ON p.`idpersona` = e.`identidad`
WHERE sa.`fecha` BETWEEN '2021-05-01' AND '2021-05-31'
AND am.`cantidad` > 0
GROUP BY MONTH(sa.`fecha`), zp.`numero`, zp.`nombre`, am.`idproductormateriaprima`, e.`noidentificacion`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`
;

-- REPORTE DE ACOPIO POR PRODUCTOR X DIA + ci
-- select sa.`fecha`, zp.`numero`, zp.`nombre`, am.`idproductormateriaprima` as idprod, e.`noidentificacion` as ci, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, SUM(am.`cantidad`) as CANT
SELECT sa.`fecha`, zp.`numero`, zp.`nombre`, am.`idproductormateriaprima` AS idprod, e.`noidentificacion` AS ci, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, am.`cantidad`
FROM acopiomateriaprima am
LEFT JOIN sesionacopio sa ON am.`idsesionacopio` = sa.`idsesionacopio`
LEFT JOIN zonaproductiva zp ON sa.`idzonaproductiva` = zp.`idzonaproductiva`
LEFT JOIN persona p ON am.`idproductormateriaprima` = p.`idpersona`
LEFT JOIN entidad e ON p.`idpersona` = e.`identidad`
WHERE sa.`fecha` BETWEEN '2019-07-01' AND '2019-07-31'
AND am.`cantidad` > 0
-- group by sa.`fecha`, zp.`numero`, zp.`nombre`, am.`idproductormateriaprima`, e.`noidentificacion`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`
;

-- REPORTE DE ACOPIO POR PRODUCTOR GRAL + ci
SELECT zp.`idzonaproductiva`, zp.`numero`, zp.`nombre`, am.`idproductormateriaprima` AS id, e.`noidentificacion` AS ci, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, SUM(am.`cantidad`) AS CANT
FROM acopiomateriaprima am
LEFT JOIN sesionacopio sa ON am.`idsesionacopio` = sa.`idsesionacopio`
LEFT JOIN zonaproductiva zp ON sa.`idzonaproductiva` = zp.`idzonaproductiva`
LEFT JOIN persona p ON am.`idproductormateriaprima` = p.`idpersona`
LEFT JOIN entidad e ON p.`idpersona` = e.`identidad`
WHERE sa.`fecha` BETWEEN '2020-12-01' AND '2021-02-28'
AND am.`cantidad` > 0
-- and p.`nombres` like '%FELICIDA%'
-- AND am.`idproductormateriaprima` IN (/*94, 524, 539, 102, 570, 526*/    107, 109, 105, 113, 112, 111, 91, 108)
GROUP BY zp.`idzonaproductiva`, zp.`numero`, zp.`nombre`, am.`idproductormateriaprima`, e.`noidentificacion`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`
;

-- REPORTE DE ACOPIO POR PRODUCTORES (PARA SOL CASCARILLA) X MESES
SELECT am.`idproductormateriaprima` AS id, e.`noidentificacion` AS ci, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, MONTH(sa.`fecha`) AS mes, SUM(am.`cantidad`) AS cant
FROM acopiomateriaprima am
LEFT JOIN sesionacopio sa ON am.`idsesionacopio` = sa.`idsesionacopio`
LEFT JOIN zonaproductiva zp ON sa.`idzonaproductiva` = zp.`idzonaproductiva`
LEFT JOIN persona p ON am.`idproductormateriaprima` = p.`idpersona`
LEFT JOIN entidad e ON p.`idpersona` = e.`identidad`
WHERE sa.`fecha` BETWEEN '2019-06-01' AND '2019-11-30'
-- and am.`cantidad` > 0
AND E.`noidentificacion` IN (8804935,	2890182,	5295951,	4442330,	3565335,	3588392,	859557,	5225910,	4389392,	3787676,	3562707,	3584420,	3130328,	4499629,	8008046,	2902741,	6498257,	3587562,	4418347,	5210751,	6479621,	3560702,	3013295,	818053,	3560711,	4424142,	4438154,	6408655,	5909313,	2868329,	4513674,	3812055,	5920932,	4400847,	6443376,	3580789,	4529955,	8725507,	3567711,	2903504)
GROUP BY am.`idproductormateriaprima`, e.`noidentificacion`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, MONTH(sa.`fecha`)
;

-- LISTA DE PRODUCTORES ACTIVOS
SELECT am.`idproductormateriaprima` AS id, zp.numero, zp.nombre, e.`noidentificacion` AS ci, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, pr.`numerocuenta`, SUM(am.`cantidad`) AS CANT, MAX(sa.`fecha`)
FROM acopiomateriaprima am
LEFT JOIN sesionacopio sa ON am.`idsesionacopio` = sa.`idsesionacopio`
LEFT JOIN zonaproductiva zp ON sa.`idzonaproductiva` = zp.`idzonaproductiva`
LEFT JOIN persona p ON am.`idproductormateriaprima` = p.`idpersona`
LEFT JOIN productormateriaprima pr ON p.`idpersona` = pr.`idproductormateriaprima`
LEFT JOIN entidad e ON p.`idpersona` = e.`identidad`
WHERE sa.`fecha` BETWEEN '2021-04-01' AND '2021-04-30'
AND am.`cantidad` > 0
-- and p.`nombres` like '%FELICIDA%'
-- AND am.`idproductormateriaprima` IN (/*94, 524, 539, 102, 570, 526*/    107, 109, 105, 113, 112, 111, 91, 108)
-- group by am.`idproductormateriaprima`, e.`noidentificacion`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, pr.`numerocuenta`
GROUP BY am.`idproductormateriaprima`, zp.numero, zp.nombre, e.`noidentificacion`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, pr.`numerocuenta`
;

-- REPORTE DE ACOPIO POR PRODUCTOR X MES + ci
-- SELECT day(sa.`fecha`) AS dia, zp.`numero`, zp.`nombre`, am.`idproductormateriaprima` AS idprod, e.`noidentificacion` AS ci, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, SUM(am.`cantidad`) AS CANT
SELECT DAY(sa.`fecha`) AS dia, zp.`numero`, zp.`nombre`, SUM(am.`cantidad`) AS CANT
FROM acopiomateriaprima am
LEFT JOIN sesionacopio sa ON am.`idsesionacopio` = sa.`idsesionacopio`
LEFT JOIN zonaproductiva zp ON sa.`idzonaproductiva` = zp.`idzonaproductiva`
LEFT JOIN persona p ON am.`idproductormateriaprima` = p.`idpersona`
LEFT JOIN entidad e ON p.`idpersona` = e.`identidad`
WHERE sa.`fecha` BETWEEN '2020-08-01' AND '2020-08-31'
AND am.`cantidad` > 0
-- and zp.`numero` = 074
GROUP BY DAY(sa.`fecha`), zp.`numero`, zp.`nombre`
;

