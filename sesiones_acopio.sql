
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
SELECT MONTH(sa.`fecha`) AS MES, zp.`numero`, zp.`nombre`, am.`idproductormateriaprima` AS idprod, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, SUM(am.`cantidad`) AS CANT
FROM acopiomateriaprima am
LEFT JOIN sesionacopio sa ON am.`idsesionacopio` = sa.`idsesionacopio`
LEFT JOIN zonaproductiva zp ON sa.`idzonaproductiva` = zp.`idzonaproductiva`
LEFT JOIN persona p ON am.`idproductormateriaprima` = p.`idpersona`
WHERE sa.`fecha` BETWEEN '2019-02-01' AND '2019-02-15'
GROUP BY MONTH(sa.`fecha`), zp.`numero`, zp.`nombre`, am.`idproductormateriaprima`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`
;


-- REPORTE DE ACOPIO POR PRODUCTOR X MES + ci
SELECT MONTH(sa.`fecha`) AS MES, zp.`numero`, zp.`nombre`, am.`idproductormateriaprima` AS idprod, e.`noidentificacion` AS ci, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, SUM(am.`cantidad`) AS CANT
FROM acopiomateriaprima am
LEFT JOIN sesionacopio sa ON am.`idsesionacopio` = sa.`idsesionacopio`
LEFT JOIN zonaproductiva zp ON sa.`idzonaproductiva` = zp.`idzonaproductiva`
LEFT JOIN persona p ON am.`idproductormateriaprima` = p.`idpersona`
LEFT JOIN entidad e ON p.`idpersona` = e.`identidad`
WHERE sa.`fecha` BETWEEN '2019-04-01' AND '2019-04-30'
AND am.`cantidad` > 0
GROUP BY MONTH(sa.`fecha`), zp.`numero`, zp.`nombre`, am.`idproductormateriaprima`, e.`noidentificacion`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`
;

-- REPORTE DE ACOPIO POR PRODUCTOR X MES + ci
-- SELECT day(sa.`fecha`) AS dia, zp.`numero`, zp.`nombre`, am.`idproductormateriaprima` AS idprod, e.`noidentificacion` AS ci, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, SUM(am.`cantidad`) AS CANT
SELECT DAY(sa.`fecha`) AS dia, zp.`numero`, zp.`nombre`, SUM(am.`cantidad`) AS CANT
FROM acopiomateriaprima am
LEFT JOIN sesionacopio sa ON am.`idsesionacopio` = sa.`idsesionacopio`
LEFT JOIN zonaproductiva zp ON sa.`idzonaproductiva` = zp.`idzonaproductiva`
LEFT JOIN persona p ON am.`idproductormateriaprima` = p.`idpersona`
LEFT JOIN entidad e ON p.`idpersona` = e.`identidad`
WHERE sa.`fecha` BETWEEN '2019-02-01' AND '2019-02-15'
AND am.`cantidad` > 0
AND zp.`numero` = 074
GROUP BY DAY(sa.`fecha`), zp.`numero`, zp.`nombre`
;




