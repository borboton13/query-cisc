-- -----------------------------------------------------------------------------------------------------------------------------------------------------
-- CONSULTA OPTIMIZADA - SESIONES DE ACOPIO QUINCENA
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 	p.idzonaproductiva, zp.nombre, p.apellidopaterno, p.apellidomaterno, p.nombres, 
	
	/*d1.cantidad D01, d2.cantidad D02, d3.cantidad D03, d4.cantidad D04, d5.cantidad D05, 
	d6.cantidad D06, d7.cantidad D07, d8.cantidad D08, d9.cantidad D09, d10.cantidad D10, 
	d11.cantidad D11, d12.cantidad D12, d13.cantidad D13, d14.cantidad D14, d15.cantidad D15,*/
	
	IFNULL(d1.cantidad, 0) D01, IFNULL(d2.cantidad, 0) D02, IFNULL(d3.cantidad, 0) D03, IFNULL(d4.cantidad, 0) D04, IFNULL(d5.cantidad, 0) D05, 
	IFNULL(d6.cantidad, 0) D06, IFNULL(d7.cantidad, 0) D07, IFNULL(d8.cantidad, 0) D08, IFNULL(d9.cantidad, 0) D09, IFNULL(d10.cantidad, 0) D10, 
	IFNULL(d11.cantidad, 0) D11, IFNULL(d12.cantidad, 0) D12, IFNULL(d13.cantidad, 0) D13, IFNULL(d14.cantidad, 0) D14, IFNULL(d15.cantidad, 0) D15, IFNULL(d16.cantidad, 0) D16,
	
	IFNULL(d1.cantidad, 0)+IFNULL(d2.cantidad, 0) +IFNULL(d3.cantidad, 0) +IFNULL(d4.cantidad, 0) +IFNULL(d5.cantidad, 0) +IFNULL(d6.cantidad, 0) +IFNULL(d7.cantidad, 0)+IFNULL(d8.cantidad, 0)+
	IFNULL(d9.cantidad, 0)+IFNULL(d10.cantidad, 0)+IFNULL(d11.cantidad, 0)+IFNULL(d12.cantidad, 0)+IFNULL(d13.cantidad, 0)+IFNULL(d14.cantidad, 0)+IFNULL(d15.cantidad, 0)+IFNULL(d16.cantidad, 0) TOTAL
FROM
(	SELECT pm.`idzonaproductiva`, pm.`idproductormateriaprima`, pe.`apellidopaterno`, pe.`apellidomaterno`, pe.`nombres`, 0 AS cantidad
	FROM productormateriaprima pm                             
	LEFT JOIN persona pe ON pm.`idproductormateriaprima` = pe.idpersona
)p
LEFT JOIN 
	(	SELECT sa.`fecha`, sa.`idzonaproductiva`, am.`idproductormateriaprima`, am.`cantidad`
		FROM acopiomateriaprima am
			LEFT JOIN sesionacopio sa ON am.`idsesionacopio` 	  = sa.`idsesionacopio`
			LEFT JOIN persona pe      ON am.`idproductormateriaprima` = pe.`idpersona`
		WHERE sa.`fecha` = '2018-07-16'
	) d1 	ON p.idproductormateriaprima = d1.idproductormateriaprima
LEFT JOIN
	(	SELECT sa.`fecha`, sa.`idzonaproductiva`, am.`idproductormateriaprima`, am.`cantidad`
		FROM acopiomateriaprima am
			LEFT JOIN sesionacopio sa ON am.`idsesionacopio` 	  = sa.`idsesionacopio`
			LEFT JOIN persona pe      ON am.`idproductormateriaprima` = pe.`idpersona`
		WHERE sa.`fecha` = '2018-07-17'
	) d2 	ON p.idproductormateriaprima = d2.idproductormateriaprima
LEFT JOIN
	(	SELECT sa.`fecha`, sa.`idzonaproductiva`, am.`idproductormateriaprima`, am.`cantidad`
		FROM acopiomateriaprima am
			LEFT JOIN sesionacopio sa ON am.`idsesionacopio` 	  = sa.`idsesionacopio`
			LEFT JOIN persona pe      ON am.`idproductormateriaprima` = pe.`idpersona`
		WHERE sa.`fecha` = '2018-07-18'
	) d3 	ON p.idproductormateriaprima = d3.idproductormateriaprima
LEFT JOIN
	(	SELECT sa.`fecha`, sa.`idzonaproductiva`, am.`idproductormateriaprima`, am.`cantidad`
		FROM acopiomateriaprima am
			LEFT JOIN sesionacopio sa ON am.`idsesionacopio` 	  = sa.`idsesionacopio`
			LEFT JOIN persona pe      ON am.`idproductormateriaprima` = pe.`idpersona`
		WHERE sa.`fecha` = '2018-07-19'
	) d4 	ON p.idproductormateriaprima = d4.idproductormateriaprima
LEFT JOIN
	(	SELECT sa.`fecha`, sa.`idzonaproductiva`, am.`idproductormateriaprima`, am.`cantidad`
		FROM acopiomateriaprima am
			LEFT JOIN sesionacopio sa ON am.`idsesionacopio` 	  = sa.`idsesionacopio`
			LEFT JOIN persona pe      ON am.`idproductormateriaprima` = pe.`idpersona`
		WHERE sa.`fecha` = '2018-07-20'
	) d5 	ON p.idproductormateriaprima = d5.idproductormateriaprima
LEFT JOIN
	(	SELECT sa.`fecha`, sa.`idzonaproductiva`, am.`idproductormateriaprima`, am.`cantidad`
		FROM acopiomateriaprima am
			LEFT JOIN sesionacopio sa ON am.`idsesionacopio` 	  = sa.`idsesionacopio`
			LEFT JOIN persona pe      ON am.`idproductormateriaprima` = pe.`idpersona`
		WHERE sa.`fecha` = '2018-07-21'
	) d6 	ON p.idproductormateriaprima = d6.idproductormateriaprima
LEFT JOIN
	(	SELECT sa.`fecha`, sa.`idzonaproductiva`, am.`idproductormateriaprima`, am.`cantidad`
		FROM acopiomateriaprima am
			LEFT JOIN sesionacopio sa ON am.`idsesionacopio` 	  = sa.`idsesionacopio`
			LEFT JOIN persona pe      ON am.`idproductormateriaprima` = pe.`idpersona`
		WHERE sa.`fecha` = '2018-07-22'
	) d7 	ON p.idproductormateriaprima = d7.idproductormateriaprima	
LEFT JOIN
	(	SELECT sa.`fecha`, sa.`idzonaproductiva`, am.`idproductormateriaprima`, am.`cantidad`
		FROM acopiomateriaprima am
			LEFT JOIN sesionacopio sa ON am.`idsesionacopio` 	  = sa.`idsesionacopio`
			LEFT JOIN persona pe      ON am.`idproductormateriaprima` = pe.`idpersona`
		WHERE sa.`fecha` = '2018-07-23'
	) d8 	ON p.idproductormateriaprima = d8.idproductormateriaprima
LEFT JOIN
	(	SELECT sa.`fecha`, sa.`idzonaproductiva`, am.`idproductormateriaprima`, am.`cantidad`
		FROM acopiomateriaprima am
			LEFT JOIN sesionacopio sa ON am.`idsesionacopio` 	  = sa.`idsesionacopio`
			LEFT JOIN persona pe      ON am.`idproductormateriaprima` = pe.`idpersona`
		WHERE sa.`fecha` = '2018-07-24'
	) d9 	ON p.idproductormateriaprima = d9.idproductormateriaprima
LEFT JOIN
	(	SELECT sa.`fecha`, sa.`idzonaproductiva`, am.`idproductormateriaprima`, am.`cantidad`
		FROM acopiomateriaprima am
			LEFT JOIN sesionacopio sa ON am.`idsesionacopio` 	  = sa.`idsesionacopio`
			LEFT JOIN persona pe      ON am.`idproductormateriaprima` = pe.`idpersona`
		WHERE sa.`fecha` = '2018-07-25'
	) d10 	ON p.idproductormateriaprima = d10.idproductormateriaprima
LEFT JOIN
	(	SELECT sa.`fecha`, sa.`idzonaproductiva`, am.`idproductormateriaprima`, am.`cantidad`
		FROM acopiomateriaprima am
			LEFT JOIN sesionacopio sa ON am.`idsesionacopio` 	  = sa.`idsesionacopio`
			LEFT JOIN persona pe      ON am.`idproductormateriaprima` = pe.`idpersona`
		WHERE sa.`fecha` = '2018-07-26'
	) d11 	ON p.idproductormateriaprima = d11.idproductormateriaprima
LEFT JOIN
	(	SELECT sa.`fecha`, sa.`idzonaproductiva`, am.`idproductormateriaprima`, am.`cantidad`
		FROM acopiomateriaprima am
			LEFT JOIN sesionacopio sa ON am.`idsesionacopio` 	  = sa.`idsesionacopio`
			LEFT JOIN persona pe      ON am.`idproductormateriaprima` = pe.`idpersona`
		WHERE sa.`fecha` = '2018-07-27'
	) d12 	ON p.idproductormateriaprima = d12.idproductormateriaprima
LEFT JOIN
	(	SELECT sa.`fecha`, sa.`idzonaproductiva`, am.`idproductormateriaprima`, am.`cantidad`
		FROM acopiomateriaprima am
			LEFT JOIN sesionacopio sa ON am.`idsesionacopio` 	  = sa.`idsesionacopio`
			LEFT JOIN persona pe      ON am.`idproductormateriaprima` = pe.`idpersona`
		WHERE sa.`fecha` = '2018-07-28'
	) d13 	ON p.idproductormateriaprima = d13.idproductormateriaprima
LEFT JOIN
	(	SELECT sa.`fecha`, sa.`idzonaproductiva`, am.`idproductormateriaprima`, am.`cantidad`
		FROM acopiomateriaprima am
			LEFT JOIN sesionacopio sa ON am.`idsesionacopio` 	  = sa.`idsesionacopio`
			LEFT JOIN persona pe      ON am.`idproductormateriaprima` = pe.`idpersona`
		WHERE sa.`fecha` = '2018-07-29'
	) d14 	ON p.idproductormateriaprima = d14.idproductormateriaprima
LEFT JOIN
	(	SELECT sa.`fecha`, sa.`idzonaproductiva`, am.`idproductormateriaprima`, am.`cantidad`
		FROM acopiomateriaprima am
			LEFT JOIN sesionacopio sa ON am.`idsesionacopio` 	  = sa.`idsesionacopio`
			LEFT JOIN persona pe      ON am.`idproductormateriaprima` = pe.`idpersona`
		WHERE sa.`fecha` = '2018-07-30'
	) d15 	ON p.idproductormateriaprima = d15.idproductormateriaprima
LEFT JOIN
	(	SELECT sa.`fecha`, sa.`idzonaproductiva`, am.`idproductormateriaprima`, am.`cantidad`
		FROM acopiomateriaprima am
			LEFT JOIN sesionacopio sa ON am.`idsesionacopio` 	  = sa.`idsesionacopio`
			LEFT JOIN persona pe      ON am.`idproductormateriaprima` = pe.`idpersona`
		WHERE sa.`fecha` = '2018-07-31'
	) d16 	ON p.idproductormateriaprima = d16.idproductormateriaprima
-- WHERE p.idzonaproductiva = 66
JOIN zonaproductiva zp ON p.idzonaproductiva = zp.idzonaproductiva
WHERE (
	IFNULL(d1.cantidad, 0)+IFNULL(d2.cantidad, 0) +IFNULL(d3.cantidad, 0) +IFNULL(d4.cantidad, 0) +IFNULL(d5.cantidad, 0) +IFNULL(d6.cantidad, 0) +IFNULL(d7.cantidad, 0)+IFNULL(d8.cantidad, 0)+
	IFNULL(d9.cantidad, 0)+IFNULL(d10.cantidad, 0)+IFNULL(d11.cantidad, 0)+IFNULL(d12.cantidad, 0)+IFNULL(d13.cantidad, 0)+IFNULL(d14.cantidad, 0)+IFNULL(d15.cantidad, 0)+IFNULL(d16.cantidad, 0)
) > 0
;