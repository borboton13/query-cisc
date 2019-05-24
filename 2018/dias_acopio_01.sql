-- -----------------------------------------------------------------------------------------------------------------------------------------------------
-- CONSULTA OPTIMIZADA - SESIONES DE ACOPIO QUINCENA
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 	p.idzonaproductiva, p.productor, 
	/*d1.cantidad D01, d2.cantidad D02, d3.cantidad D03, d4.cantidad D04, d5.cantidad D05, 
	d6.cantidad D06, d7.cantidad D07, d8.cantidad D08, d9.cantidad D09, d10.cantidad D10, 
	d11.cantidad D11, d12.cantidad D12, d13.cantidad D13, d14.cantidad D14, d15.cantidad D15,*/
	
	IFNULL(d1.cantidad, 0) D01, IFNULL(d2.cantidad, 0) D02, IFNULL(d3.cantidad, 0) D03, IFNULL(d4.cantidad, 0) D04, IFNULL(d5.cantidad, 0) D05, 
	IFNULL(d6.cantidad, 0) D06, IFNULL(d7.cantidad, 0) D07, IFNULL(d8.cantidad, 0) D08, IFNULL(d9.cantidad, 0) D09, IFNULL(d10.cantidad, 0) D10, 
	IFNULL(d11.cantidad, 0) D11, IFNULL(d12.cantidad, 0) D12, IFNULL(d13.cantidad, 0) D13, IFNULL(d14.cantidad, 0) D14, IFNULL(d15.cantidad, 0) D15,
	
	IFNULL(d1.cantidad, 0)+IFNULL(d2.cantidad, 0) +IFNULL(d3.cantidad, 0) +IFNULL(d4.cantidad, 0) +IFNULL(d5.cantidad, 0) +IFNULL(d6.cantidad, 0) +IFNULL(d7.cantidad, 0)+IFNULL(d8.cantidad, 0)+
	IFNULL(d9.cantidad, 0)+IFNULL(d10.cantidad, 0)+IFNULL(d11.cantidad, 0)+IFNULL(d12.cantidad, 0)+IFNULL(d13.cantidad, 0)+IFNULL(d14.cantidad, 0)+IFNULL(d15.cantidad, 0) TOTAL
FROM
(	SELECT pm.`idzonaproductiva`, pm.`idproductormateriaprima`, CONCAT(pe.`apellidopaterno`,' ',pe.`apellidomaterno`,' ',pe.`nombres`) AS productor, 0 AS cantidad
	FROM productormateriaprima pm                             
	LEFT JOIN persona pe ON pm.`idproductormateriaprima` = pe.idpersona
)p
LEFT JOIN 
	(	SELECT sa.`fecha`, sa.`idzonaproductiva`, am.`idproductormateriaprima`, am.`cantidad`
		FROM acopiomateriaprima am
			LEFT JOIN sesionacopio sa ON am.`idsesionacopio` 	  = sa.`idsesionacopio`
			LEFT JOIN persona pe      ON am.`idproductormateriaprima` = pe.`idpersona`
		WHERE sa.`fecha` = '2016-10-16'
	) d1 	ON p.idproductormateriaprima = d1.idproductormateriaprima
LEFT JOIN
	(	SELECT sa.`fecha`, sa.`idzonaproductiva`, am.`idproductormateriaprima`, am.`cantidad`
		FROM acopiomateriaprima am
			LEFT JOIN sesionacopio sa ON am.`idsesionacopio` 	  = sa.`idsesionacopio`
			LEFT JOIN persona pe      ON am.`idproductormateriaprima` = pe.`idpersona`
		WHERE sa.`fecha` = '2016-10-17'
	) d2 	ON p.idproductormateriaprima = d2.idproductormateriaprima
LEFT JOIN
	(	SELECT sa.`fecha`, sa.`idzonaproductiva`, am.`idproductormateriaprima`, am.`cantidad`
		FROM acopiomateriaprima am
			LEFT JOIN sesionacopio sa ON am.`idsesionacopio` 	  = sa.`idsesionacopio`
			LEFT JOIN persona pe      ON am.`idproductormateriaprima` = pe.`idpersona`
		WHERE sa.`fecha` = '2016-10-18'
	) d3 	ON p.idproductormateriaprima = d3.idproductormateriaprima
LEFT JOIN
	(	SELECT sa.`fecha`, sa.`idzonaproductiva`, am.`idproductormateriaprima`, am.`cantidad`
		FROM acopiomateriaprima am
			LEFT JOIN sesionacopio sa ON am.`idsesionacopio` 	  = sa.`idsesionacopio`
			LEFT JOIN persona pe      ON am.`idproductormateriaprima` = pe.`idpersona`
		WHERE sa.`fecha` = '2016-10-19'
	) d4 	ON p.idproductormateriaprima = d4.idproductormateriaprima
LEFT JOIN
	(	SELECT sa.`fecha`, sa.`idzonaproductiva`, am.`idproductormateriaprima`, am.`cantidad`
		FROM acopiomateriaprima am
			LEFT JOIN sesionacopio sa ON am.`idsesionacopio` 	  = sa.`idsesionacopio`
			LEFT JOIN persona pe      ON am.`idproductormateriaprima` = pe.`idpersona`
		WHERE sa.`fecha` = '2016-10-20'
	) d5 	ON p.idproductormateriaprima = d5.idproductormateriaprima
LEFT JOIN
	(	SELECT sa.`fecha`, sa.`idzonaproductiva`, am.`idproductormateriaprima`, am.`cantidad`
		FROM acopiomateriaprima am
			LEFT JOIN sesionacopio sa ON am.`idsesionacopio` 	  = sa.`idsesionacopio`
			LEFT JOIN persona pe      ON am.`idproductormateriaprima` = pe.`idpersona`
		WHERE sa.`fecha` = '2016-10-21'
	) d6 	ON p.idproductormateriaprima = d6.idproductormateriaprima
LEFT JOIN
	(	SELECT sa.`fecha`, sa.`idzonaproductiva`, am.`idproductormateriaprima`, am.`cantidad`
		FROM acopiomateriaprima am
			LEFT JOIN sesionacopio sa ON am.`idsesionacopio` 	  = sa.`idsesionacopio`
			LEFT JOIN persona pe      ON am.`idproductormateriaprima` = pe.`idpersona`
		WHERE sa.`fecha` = '2016-10-22'
	) d7 	ON p.idproductormateriaprima = d7.idproductormateriaprima	
LEFT JOIN
	(	SELECT sa.`fecha`, sa.`idzonaproductiva`, am.`idproductormateriaprima`, am.`cantidad`
		FROM acopiomateriaprima am
			LEFT JOIN sesionacopio sa ON am.`idsesionacopio` 	  = sa.`idsesionacopio`
			LEFT JOIN persona pe      ON am.`idproductormateriaprima` = pe.`idpersona`
		WHERE sa.`fecha` = '2016-10-23'
	) d8 	ON p.idproductormateriaprima = d8.idproductormateriaprima
LEFT JOIN
	(	SELECT sa.`fecha`, sa.`idzonaproductiva`, am.`idproductormateriaprima`, am.`cantidad`
		FROM acopiomateriaprima am
			LEFT JOIN sesionacopio sa ON am.`idsesionacopio` 	  = sa.`idsesionacopio`
			LEFT JOIN persona pe      ON am.`idproductormateriaprima` = pe.`idpersona`
		WHERE sa.`fecha` = '2016-10-24'
	) d9 	ON p.idproductormateriaprima = d9.idproductormateriaprima
LEFT JOIN
	(	SELECT sa.`fecha`, sa.`idzonaproductiva`, am.`idproductormateriaprima`, am.`cantidad`
		FROM acopiomateriaprima am
			LEFT JOIN sesionacopio sa ON am.`idsesionacopio` 	  = sa.`idsesionacopio`
			LEFT JOIN persona pe      ON am.`idproductormateriaprima` = pe.`idpersona`
		WHERE sa.`fecha` = '2016-10-25'
	) d10 	ON p.idproductormateriaprima = d10.idproductormateriaprima
LEFT JOIN
	(	SELECT sa.`fecha`, sa.`idzonaproductiva`, am.`idproductormateriaprima`, am.`cantidad`
		FROM acopiomateriaprima am
			LEFT JOIN sesionacopio sa ON am.`idsesionacopio` 	  = sa.`idsesionacopio`
			LEFT JOIN persona pe      ON am.`idproductormateriaprima` = pe.`idpersona`
		WHERE sa.`fecha` = '2016-10-26'
	) d11 	ON p.idproductormateriaprima = d11.idproductormateriaprima
LEFT JOIN
	(	SELECT sa.`fecha`, sa.`idzonaproductiva`, am.`idproductormateriaprima`, am.`cantidad`
		FROM acopiomateriaprima am
			LEFT JOIN sesionacopio sa ON am.`idsesionacopio` 	  = sa.`idsesionacopio`
			LEFT JOIN persona pe      ON am.`idproductormateriaprima` = pe.`idpersona`
		WHERE sa.`fecha` = '2016-10-27'
	) d12 	ON p.idproductormateriaprima = d12.idproductormateriaprima
LEFT JOIN
	(	SELECT sa.`fecha`, sa.`idzonaproductiva`, am.`idproductormateriaprima`, am.`cantidad`
		FROM acopiomateriaprima am
			LEFT JOIN sesionacopio sa ON am.`idsesionacopio` 	  = sa.`idsesionacopio`
			LEFT JOIN persona pe      ON am.`idproductormateriaprima` = pe.`idpersona`
		WHERE sa.`fecha` = '2016-10-28'
	) d13 	ON p.idproductormateriaprima = d13.idproductormateriaprima
LEFT JOIN
	(	SELECT sa.`fecha`, sa.`idzonaproductiva`, am.`idproductormateriaprima`, am.`cantidad`
		FROM acopiomateriaprima am
			LEFT JOIN sesionacopio sa ON am.`idsesionacopio` 	  = sa.`idsesionacopio`
			LEFT JOIN persona pe      ON am.`idproductormateriaprima` = pe.`idpersona`
		WHERE sa.`fecha` = '2016-10-29'
	) d14 	ON p.idproductormateriaprima = d14.idproductormateriaprima
LEFT JOIN
	(	SELECT sa.`fecha`, sa.`idzonaproductiva`, am.`idproductormateriaprima`, am.`cantidad`
		FROM acopiomateriaprima am
			LEFT JOIN sesionacopio sa ON am.`idsesionacopio` 	  = sa.`idsesionacopio`
			LEFT JOIN persona pe      ON am.`idproductormateriaprima` = pe.`idpersona`
		WHERE sa.`fecha` = '2015-03-15'
	) d15 	ON p.idproductormateriaprima = d15.idproductormateriaprima
WHERE p.idzonaproductiva = 66
;




-- ----------------------------------------
-- query no termina
-- ----------------------------------------
SELECT 
 A1.productor AS productor 
      , A1.CANTIDAD AS D1
      , A2.CANTIDAD AS D2
      , A3.CANTIDAD AS D3
      , A4.CANTIDAD AS D4
      , A5.CANTIDAD AS D5
      , A6.CANTIDAD AS D6
      , A7.CANTIDAD AS D7
      , A8.CANTIDAD AS D8
      , A9.CANTIDAD AS D9
      , A10.CANTIDAD AS D10
      , A11.CANTIDAD AS D11
      , A12.CANTIDAD AS D12
      , A13.CANTIDAD AS D13
      , A14.CANTIDAD AS D14
      , A15.CANTIDAD AS D15
      , 0.0 AS D16
, A1.CANTIDAD+ A2.CANTIDAD+ A3.CANTIDAD+ A4.CANTIDAD+ A5.CANTIDAD+ A6.CANTIDAD+ A7.CANTIDAD+ A8.CANTIDAD+ A9.CANTIDAD+ A10.CANTIDAD+ A11.CANTIDAD+ A12.CANTIDAD+ A13.CANTIDAD+ A14.CANTIDAD+ A15.CANTIDAD AS TOTAL 
 FROM 
    (SELECT 0.0 AS CANTIDAD , pe.nombres||' '||pe.apellidopaterno ||' '||pe.apellidomaterno AS productor, PM.IDPRODUCTORMATERIAPRIMA
  FROM PRODUCTORMATERIAPRIMA PM                             
                              INNER JOIN persona pe 
                              ON PM.IDPRODUCTORMATERIAPRIMA=pe.idpersona                               
                              WHERE PM.idzonaproductiva = 66
                              ORDER BY pe.nombres      ) A1
 ,    (SELECT am.cantidad , pe.nombres||' '||pe.apellidopaterno ||' '||pe.apellidomaterno AS productor, am.IDPRODUCTORMATERIAPRIMA
  FROM sesionacopio sa
                              INNER JOIN acopiomateriaprima am
                              ON am.idsesionacopio = sa.idsesionacopio
                              INNER JOIN persona pe 
                              ON am.IDPRODUCTORMATERIAPRIMA=pe.idpersona 
                              INNER JOIN zonaproductiva zp
                              ON zp.idzonaproductiva = sa.idzonaproductiva
                              WHERE sa.fecha = STR_TO_DATE('2,3,2015','%d,%m,%Y') 
                              AND zp.idzonaproductiva = 66
                              ORDER BY pe.nombres
      ) A2
 ,    (SELECT am.cantidad , pe.nombres||' '||pe.apellidopaterno ||' '||pe.apellidomaterno AS productor, am.IDPRODUCTORMATERIAPRIMA
  FROM sesionacopio sa
                              INNER JOIN acopiomateriaprima am
                              ON am.idsesionacopio = sa.idsesionacopio
                              INNER JOIN persona pe 
                              ON am.IDPRODUCTORMATERIAPRIMA=pe.idpersona 
                              INNER JOIN zonaproductiva zp
                              ON zp.idzonaproductiva = sa.idzonaproductiva
                              WHERE sa.fecha = STR_TO_DATE('3,3,2015','%d,%m,%Y') 
                              AND zp.idzonaproductiva = 66
                              ORDER BY pe.nombres
      ) A3
 ,    (SELECT am.cantidad , pe.nombres||' '||pe.apellidopaterno ||' '||pe.apellidomaterno AS productor, am.IDPRODUCTORMATERIAPRIMA
  FROM sesionacopio sa
                              INNER JOIN acopiomateriaprima am
                              ON am.idsesionacopio = sa.idsesionacopio
                              INNER JOIN persona pe 
                              ON am.IDPRODUCTORMATERIAPRIMA=pe.idpersona 
                              INNER JOIN zonaproductiva zp
                              ON zp.idzonaproductiva = sa.idzonaproductiva
                              WHERE sa.fecha = STR_TO_DATE('4,3,2015','%d,%m,%Y') 
                              AND zp.idzonaproductiva = 66
                              ORDER BY pe.nombres
      ) A4
 ,    (SELECT am.cantidad , pe.nombres||' '||pe.apellidopaterno ||' '||pe.apellidomaterno AS productor, am.IDPRODUCTORMATERIAPRIMA
  FROM sesionacopio sa
                              INNER JOIN acopiomateriaprima am
                              ON am.idsesionacopio = sa.idsesionacopio
                              INNER JOIN persona pe 
                              ON am.IDPRODUCTORMATERIAPRIMA=pe.idpersona 
                              INNER JOIN zonaproductiva zp
                              ON zp.idzonaproductiva = sa.idzonaproductiva
                              WHERE sa.fecha = STR_TO_DATE('5,3,2015','%d,%m,%Y') 
                              AND zp.idzonaproductiva = 66
                              ORDER BY pe.nombres
      ) A5
 ,    (SELECT am.cantidad , pe.nombres||' '||pe.apellidopaterno ||' '||pe.apellidomaterno AS productor, am.IDPRODUCTORMATERIAPRIMA
  FROM sesionacopio sa
                              INNER JOIN acopiomateriaprima am
                              ON am.idsesionacopio = sa.idsesionacopio
                              INNER JOIN persona pe 
                              ON am.IDPRODUCTORMATERIAPRIMA=pe.idpersona 
                              INNER JOIN zonaproductiva zp
                              ON zp.idzonaproductiva = sa.idzonaproductiva
                              WHERE sa.fecha = STR_TO_DATE('6,3,2015','%d,%m,%Y') 
                              AND zp.idzonaproductiva = 66
                              ORDER BY pe.nombres
      ) A6
 ,    (SELECT am.cantidad , pe.nombres||' '||pe.apellidopaterno ||' '||pe.apellidomaterno AS productor, am.IDPRODUCTORMATERIAPRIMA
  FROM sesionacopio sa
                              INNER JOIN acopiomateriaprima am
                              ON am.idsesionacopio = sa.idsesionacopio
                              INNER JOIN persona pe 
                              ON am.IDPRODUCTORMATERIAPRIMA=pe.idpersona 
                              INNER JOIN zonaproductiva zp
                              ON zp.idzonaproductiva = sa.idzonaproductiva
                              WHERE sa.fecha = STR_TO_DATE('7,3,2015','%d,%m,%Y') 
                              AND zp.idzonaproductiva = 66
                              ORDER BY pe.nombres
      ) A7
 ,    (SELECT am.cantidad , pe.nombres||' '||pe.apellidopaterno ||' '||pe.apellidomaterno AS productor, am.IDPRODUCTORMATERIAPRIMA
  FROM sesionacopio sa
                              INNER JOIN acopiomateriaprima am
                              ON am.idsesionacopio = sa.idsesionacopio
                              INNER JOIN persona pe 
                              ON am.IDPRODUCTORMATERIAPRIMA=pe.idpersona 
                              INNER JOIN zonaproductiva zp
                              ON zp.idzonaproductiva = sa.idzonaproductiva
                              WHERE sa.fecha = STR_TO_DATE('8,3,2015','%d,%m,%Y') 
                              AND zp.idzonaproductiva = 66
                              ORDER BY pe.nombres
      ) A8
 ,    (SELECT am.cantidad , pe.nombres||' '||pe.apellidopaterno ||' '||pe.apellidomaterno AS productor, am.IDPRODUCTORMATERIAPRIMA
  FROM sesionacopio sa
                              INNER JOIN acopiomateriaprima am
                              ON am.idsesionacopio = sa.idsesionacopio
                              INNER JOIN persona pe 
                              ON am.IDPRODUCTORMATERIAPRIMA=pe.idpersona 
                              INNER JOIN zonaproductiva zp
                              ON zp.idzonaproductiva = sa.idzonaproductiva
                              WHERE sa.fecha = STR_TO_DATE('9,3,2015','%d,%m,%Y') 
                              AND zp.idzonaproductiva = 66
                              ORDER BY pe.nombres
      ) A9
 ,    (SELECT am.cantidad , pe.nombres||' '||pe.apellidopaterno ||' '||pe.apellidomaterno AS productor, am.IDPRODUCTORMATERIAPRIMA
  FROM sesionacopio sa
                              INNER JOIN acopiomateriaprima am
                              ON am.idsesionacopio = sa.idsesionacopio
                              INNER JOIN persona pe 
                              ON am.IDPRODUCTORMATERIAPRIMA=pe.idpersona 
                              INNER JOIN zonaproductiva zp
                              ON zp.idzonaproductiva = sa.idzonaproductiva
                              WHERE sa.fecha = STR_TO_DATE('10,3,2015','%d,%m,%Y') 
                              AND zp.idzonaproductiva = 66
                              ORDER BY pe.nombres
      ) A10
 ,    (SELECT am.cantidad , pe.nombres||' '||pe.apellidopaterno ||' '||pe.apellidomaterno AS productor, am.IDPRODUCTORMATERIAPRIMA
  FROM sesionacopio sa
                              INNER JOIN acopiomateriaprima am
                              ON am.idsesionacopio = sa.idsesionacopio
                              INNER JOIN persona pe 
                              ON am.IDPRODUCTORMATERIAPRIMA=pe.idpersona 
                              INNER JOIN zonaproductiva zp
                              ON zp.idzonaproductiva = sa.idzonaproductiva
                              WHERE sa.fecha = STR_TO_DATE('11,3,2015','%d,%m,%Y') 
                              AND zp.idzonaproductiva = 66
                              ORDER BY pe.nombres
      ) A11
 ,    (SELECT am.cantidad , pe.nombres||' '||pe.apellidopaterno ||' '||pe.apellidomaterno AS productor, am.IDPRODUCTORMATERIAPRIMA
  FROM sesionacopio sa
                              INNER JOIN acopiomateriaprima am
                              ON am.idsesionacopio = sa.idsesionacopio
                              INNER JOIN persona pe 
                              ON am.IDPRODUCTORMATERIAPRIMA=pe.idpersona 
                              INNER JOIN zonaproductiva zp
                              ON zp.idzonaproductiva = sa.idzonaproductiva
                              WHERE sa.fecha = STR_TO_DATE('12,3,2015','%d,%m,%Y') 
                              AND zp.idzonaproductiva = 66
                              ORDER BY pe.nombres
      ) A12
 ,    (SELECT am.cantidad , pe.nombres||' '||pe.apellidopaterno ||' '||pe.apellidomaterno AS productor, am.IDPRODUCTORMATERIAPRIMA
  FROM sesionacopio sa
                              INNER JOIN acopiomateriaprima am
                              ON am.idsesionacopio = sa.idsesionacopio
                              INNER JOIN persona pe 
                              ON am.IDPRODUCTORMATERIAPRIMA=pe.idpersona 
                              INNER JOIN zonaproductiva zp
                              ON zp.idzonaproductiva = sa.idzonaproductiva
                              WHERE sa.fecha = STR_TO_DATE('13,3,2015','%d,%m,%Y') 
                              AND zp.idzonaproductiva = 66
                              ORDER BY pe.nombres
      ) A13
 ,    (SELECT am.cantidad , pe.nombres||' '||pe.apellidopaterno ||' '||pe.apellidomaterno AS productor, am.IDPRODUCTORMATERIAPRIMA
  FROM sesionacopio sa
                              INNER JOIN acopiomateriaprima am
                              ON am.idsesionacopio = sa.idsesionacopio
                              INNER JOIN persona pe 
                              ON am.IDPRODUCTORMATERIAPRIMA=pe.idpersona 
                              INNER JOIN zonaproductiva zp
                              ON zp.idzonaproductiva = sa.idzonaproductiva
                              WHERE sa.fecha = STR_TO_DATE('14,3,2015','%d,%m,%Y') 
                              AND zp.idzonaproductiva = 66
                              ORDER BY pe.nombres
      ) A14
 ,    (SELECT am.cantidad , pe.nombres||' '||pe.apellidopaterno ||' '||pe.apellidomaterno AS productor, am.IDPRODUCTORMATERIAPRIMA
  FROM sesionacopio sa
                              INNER JOIN acopiomateriaprima am
                              ON am.idsesionacopio = sa.idsesionacopio
                              INNER JOIN persona pe 
                              ON am.IDPRODUCTORMATERIAPRIMA=pe.idpersona 
                              INNER JOIN zonaproductiva zp
                              ON zp.idzonaproductiva = sa.idzonaproductiva
                              WHERE sa.fecha = STR_TO_DATE('15,3,2015','%d,%m,%Y') 
                              AND zp.idzonaproductiva = 66
                              ORDER BY pe.nombres
      ) A15
 WHERE A1.IDPRODUCTORMATERIAPRIMA = A2.IDPRODUCTORMATERIAPRIMA
 AND A1.IDPRODUCTORMATERIAPRIMA = A3.IDPRODUCTORMATERIAPRIMA
 AND A1.IDPRODUCTORMATERIAPRIMA = A4.IDPRODUCTORMATERIAPRIMA
 AND A1.IDPRODUCTORMATERIAPRIMA = A5.IDPRODUCTORMATERIAPRIMA
 AND A1.IDPRODUCTORMATERIAPRIMA = A6.IDPRODUCTORMATERIAPRIMA
 AND A1.IDPRODUCTORMATERIAPRIMA = A7.IDPRODUCTORMATERIAPRIMA
 AND A1.IDPRODUCTORMATERIAPRIMA = A8.IDPRODUCTORMATERIAPRIMA
 AND A1.IDPRODUCTORMATERIAPRIMA = A9.IDPRODUCTORMATERIAPRIMA
 AND A1.IDPRODUCTORMATERIAPRIMA = A10.IDPRODUCTORMATERIAPRIMA
 AND A1.IDPRODUCTORMATERIAPRIMA = A11.IDPRODUCTORMATERIAPRIMA
 AND A1.IDPRODUCTORMATERIAPRIMA = A12.IDPRODUCTORMATERIAPRIMA
 AND A1.IDPRODUCTORMATERIAPRIMA = A13.IDPRODUCTORMATERIAPRIMA
 AND A1.IDPRODUCTORMATERIAPRIMA = A14.IDPRODUCTORMATERIAPRIMA
 AND A1.IDPRODUCTORMATERIAPRIMA = A15.IDPRODUCTORMATERIAPRIMA;
