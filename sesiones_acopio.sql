SELECT *
FROM sesionacopio;

SELECT *
FROM acopiomateriaprima
WHERE idacopiomateriaprima > 11814
;

SELECT *
FROM ZONAPRODUCTIVA

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
LEFT JOIN zonaproductiva ZO ON ra.idzonaproductiva = zo.idzonaproductiva
-- WHERE pl.fecha between to_date('29/05/2015','dd/mm/yyyy') and to_date('29/05/2015','dd/mm/yyyy')
WHERE pl.fecha BETWEEN '2016-10-16' AND '2016-10-17'
AND zo.numero = 543
ORDER BY pl.fecha
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
WHERE sa.`fecha` BETWEEN '2018-06-01' AND '2018-06-30'
GROUP BY MONTH(sa.`fecha`), zp.`numero`, zp.`nombre`, am.`idproductormateriaprima`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`
;


-- REPORTE DE ACOPIO POR PRODUCTOR X MES + ci
SELECT MONTH(sa.`fecha`) AS MES, zp.`numero`, zp.`nombre`, am.`idproductormateriaprima` AS idprod, e.`noidentificacion` AS ci, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, SUM(am.`cantidad`) AS CANT
FROM acopiomateriaprima am
LEFT JOIN sesionacopio sa ON am.`idsesionacopio` = sa.`idsesionacopio`
LEFT JOIN zonaproductiva zp ON sa.`idzonaproductiva` = zp.`idzonaproductiva`
LEFT JOIN persona p ON am.`idproductormateriaprima` = p.`idpersona`
LEFT JOIN entidad e ON p.`idpersona` = e.`identidad`
WHERE sa.`fecha` BETWEEN '2018-11-01' AND '2018-12-31'
AND am.`cantidad` > 0
GROUP BY MONTH(sa.`fecha`), zp.`numero`, zp.`nombre`, am.`idproductormateriaprima`, e.`noidentificacion`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`
;





