SELECT C.*, CI.IDPERIODOCOSTOINDIRECTO AS IDPER, A.DESCRI, CI.IDCOSTOSINDIRECTOS, CI.NOMBRE, CI.MONTOBS
FROM EOS.COSTOSINDIRECTOSCONF C, WISE.ARCGMS A, EOS.COSTOSINDIRECTOS CI
WHERE CI.IDCOSTOSINDIRECTOSCONF = C.IDCOSTOSINDIRECTOSCONF 
AND C.CUENTA = A.CUENTA
AND CI.IDPERIODOCOSTOINDIRECTO = 2


SELECT * FROM WISE.ARCGMS

SELECT * FROM EOS.COSTOSINDIRECTOSCONF

SELECT * FROM EOS.COSTOSINDIRECTOS CI
WHERE CI.IDPERIODOCOSTOINDIRECTO = 2


SELECT PL.FECHA,M.NOMBRE,O.CODIGO, O.CANTIDADESPERADA, O.CANTIDADPRODUCIDA,O.COSTOTOALPRODUCCION, O.COSTOUNITARIO
FROM EOS.ORDENPRODUCCION O
LEFT JOIN EOS.PLANIFICACIONPRODUCCION PL    ON O.IDPLANIFICACIONPRODUCCION  = PL.IDPLANIFICACIONPRODUCCION
LEFT JOIN EOS.COMPOSICIONPRODUCTO C         ON O.IDCOMPOSICIONPRODUCTO      = C.IDCOMPOSICIONPRODUCTO
LEFT JOIN EOS.PRODUCTOPROCESADO P           ON C.IDPRODUCTOPROCESADO        = P.IDPRODUCTOPROCESADO
LEFT JOIN EOS.METAPRODUCTOPRODUCCION M      ON P.IDPRODUCTOPROCESADO        = M.IDMETAPRODUCTOPRODUCCION  
WHERE PL.FECHA BETWEEN TO_DATE('01/01/2015','DD/MM/YYYY') AND TO_DATE('31/01/2015','DD/MM/YYYY');


SELECT DISTINCT M.NOMBRE
FROM EOS.ORDENPRODUCCION O
LEFT JOIN EOS.PLANIFICACIONPRODUCCION PL    ON O.IDPLANIFICACIONPRODUCCION  = PL.IDPLANIFICACIONPRODUCCION
LEFT JOIN EOS.COMPOSICIONPRODUCTO C         ON O.IDCOMPOSICIONPRODUCTO      = C.IDCOMPOSICIONPRODUCTO
LEFT JOIN EOS.PRODUCTOPROCESADO P           ON C.IDPRODUCTOPROCESADO        = P.IDPRODUCTOPROCESADO
LEFT JOIN EOS.METAPRODUCTOPRODUCCION M      ON P.IDPRODUCTOPROCESADO        = M.IDMETAPRODUCTOPRODUCCION  
WHERE PL.FECHA BETWEEN TO_DATE('01/01/2014','DD/MM/YYYY') AND TO_DATE('31/05/2014','DD/MM/YYYY');

/* COSTO TOTAL DE PRODUCCION X DIA */

SELECT A.FECHA, SUM(A.COSTOTOALPRODUCCION) AS COSTO_TOTAL
FROM 
(

    SELECT PL.FECHA,M.NOMBRE,O.CODIGO,O.CANTIDADPRODUCIDA,O.COSTOTOALPRODUCCION,O.COSTOUNITARIO
    FROM EOS.ORDENPRODUCCION O
    LEFT JOIN EOS.PLANIFICACIONPRODUCCION PL    ON O.IDPLANIFICACIONPRODUCCION  = PL.IDPLANIFICACIONPRODUCCION
    LEFT JOIN EOS.COMPOSICIONPRODUCTO C         ON O.IDCOMPOSICIONPRODUCTO      = C.IDCOMPOSICIONPRODUCTO
    LEFT JOIN EOS.PRODUCTOPROCESADO P           ON C.IDPRODUCTOPROCESADO        = P.IDPRODUCTOPROCESADO
    LEFT JOIN EOS.METAPRODUCTOPRODUCCION M      ON P.IDPRODUCTOPROCESADO        = M.IDMETAPRODUCTOPRODUCCION  
    WHERE PL.FECHA BETWEEN TO_DATE('01/01/2014','DD/MM/YYYY') AND TO_DATE('11/02/2014','DD/MM/YYYY')

) A
GROUP BY A.FECHA

-- CANTIDADES PRODUCIDAS (1)
SELECT A.COD, A.NOMBRE, SUM(A.CANTIDADPRODUCIDA) AS CANTIDAD, SUM(A.COSTOUNITARIO) AS COSTO_UNI, SUM(A.COSTOTOALPRODUCCION) AS COSTO_TOT
FROM 
(
    SELECT PL.FECHA,M.CODIGO AS COD, M.NOMBRE, O.CODIGO, O.CANTIDADPRODUCIDA, O.COSTOTOALPRODUCCION, O.COSTOUNITARIO
    FROM ORDENPRODUCCION O
    LEFT JOIN PLANIFICACIONPRODUCCION PL    ON O.IDPLANIFICACIONPRODUCCION  = PL.IDPLANIFICACIONPRODUCCION
    LEFT JOIN COMPOSICIONPRODUCTO C         ON O.IDCOMPOSICIONPRODUCTO      = C.IDCOMPOSICIONPRODUCTO
    LEFT JOIN PRODUCTOPROCESADO P           ON C.IDPRODUCTOPROCESADO        = P.IDPRODUCTOPROCESADO
    LEFT JOIN METAPRODUCTOPRODUCCION M      ON P.IDPRODUCTOPROCESADO        = M.IDMETAPRODUCTOPRODUCCION  
    WHERE PL.FECHA BETWEEN '2015-11-25' AND '2015-11-25'
) A
GROUP BY A.COD, A.NOMBRE;

-- CANTIDADES PRODUCIDAS (2)
SELECT A.COD, A.NOMBRE, SUM(A.CANTIDADPRODUCIDARESPONSABLE) AS CANTIDAD, SUM(A.COSTOUNITARIO) AS COSTO_UNI, SUM(A.COSTOTOALPRODUCCION) AS COSTO_TOT
FROM 
(
    SELECT PL.FECHA,M.CODIGO AS COD, M.NOMBRE, O.CODIGO, O.CANTIDADPRODUCIDARESPONSABLE, O.COSTOTOALPRODUCCION, O.COSTOUNITARIO
    FROM ORDENPRODUCCION O
    LEFT JOIN PLANIFICACIONPRODUCCION PL    ON O.IDPLANIFICACIONPRODUCCION  = PL.IDPLANIFICACIONPRODUCCION
    LEFT JOIN COMPOSICIONPRODUCTO C         ON O.IDCOMPOSICIONPRODUCTO      = C.IDCOMPOSICIONPRODUCTO
    LEFT JOIN PRODUCTOPROCESADO P           ON C.IDPRODUCTOPROCESADO        = P.IDPRODUCTOPROCESADO
    LEFT JOIN METAPRODUCTOPRODUCCION M      ON P.IDPRODUCTOPROCESADO        = M.IDMETAPRODUCTOPRODUCCION  
    WHERE PL.FECHA BETWEEN '2015-11-25' AND '2015-11-25'
) A
GROUP BY A.COD, A.NOMBRE;

-- -------------------------------------
-- COSTO TOTAL DE PRODUCCION X PRODUCTO
-- -------------------------------------
SELECT A.COD, A.NOMBRE, SUM(A.CANTIDADPRODUCIDA) AS CANTIDAD, SUM(A.COSTOTOALPRODUCCION) AS COSTO_TOTAL
FROM 
(
    SELECT PL.FECHA,M.CODIGO AS COD, M.NOMBRE,O.CODIGO,O.CANTIDADPRODUCIDA,O.COSTOTOALPRODUCCION,O.COSTOUNITARIO
    FROM EOS.ORDENPRODUCCION O
    LEFT JOIN EOS.PLANIFICACIONPRODUCCION PL    ON O.IDPLANIFICACIONPRODUCCION  = PL.IDPLANIFICACIONPRODUCCION
    LEFT JOIN EOS.COMPOSICIONPRODUCTO C         ON O.IDCOMPOSICIONPRODUCTO      = C.IDCOMPOSICIONPRODUCTO
    LEFT JOIN EOS.PRODUCTOPROCESADO P           ON C.IDPRODUCTOPROCESADO        = P.IDPRODUCTOPROCESADO
    LEFT JOIN EOS.METAPRODUCTOPRODUCCION M      ON P.IDPRODUCTOPROCESADO        = M.IDMETAPRODUCTOPRODUCCION  
    WHERE PL.FECHA BETWEEN TO_DATE('01/05/2014','DD/MM/YYYY') AND TO_DATE('31/05/2014','DD/MM/YYYY')
) A
GROUP BY A.COD, A.NOMBRE;
-- -------------------------------------

SELECT *
FROM productosimpleprocesado ps;

SELECT *
FROM PLANIFICACIONPRODUCCION;

SELECT *
FROM productosimple;

SELECT *
FROM productobase pb;

-- CANTIDADES PRODUCIDAS (2)
SELECT A.COD, A.NOMBRE, SUM(A.CANTIDADPRODUCIDARESPONSABLE) AS CANTIDAD
FROM 
(
    SELECT PL.FECHA,M.CODIGO AS COD, M.NOMBRE, O.CODIGO, O.CANTIDADPRODUCIDARESPONSABLE, O.COSTOTOALPRODUCCION, O.COSTOUNITARIO
    FROM ORDENPRODUCCION O
    LEFT JOIN PLANIFICACIONPRODUCCION PL    ON O.IDPLANIFICACIONPRODUCCION  = PL.IDPLANIFICACIONPRODUCCION
    LEFT JOIN COMPOSICIONPRODUCTO C         ON O.IDCOMPOSICIONPRODUCTO      = C.IDCOMPOSICIONPRODUCTO
    LEFT JOIN PRODUCTOPROCESADO P           ON C.IDPRODUCTOPROCESADO        = P.IDPRODUCTOPROCESADO
    LEFT JOIN METAPRODUCTOPRODUCCION M      ON P.IDPRODUCTOPROCESADO        = M.IDMETAPRODUCTOPRODUCCION  
    WHERE PL.FECHA BETWEEN '2015-11-01' AND '2015-11-30'
) A
GROUP BY A.COD, A.NOMBRE;

-- select pp.`fecha`, pb.`codigo`, mp.codigo, mp.`nombre`, ps.`cantidadproducidaresponsable`
-- select *
SELECT mp.codigo, mp.`nombre`, SUM(ps.`cantidadproducidaresponsable`) AS cantidad
FROM productobase pb
LEFT JOIN planificacionproduccion pp 	ON pb.`idplanificacionproduccion` = pp.`idplanificacionproduccion` 
LEFT JOIN productosimple ps		ON pb.`idproductobase` = ps.`idproductobase`
LEFT JOIN productosimpleprocesado psp	ON ps.`idproductosimple` = psp.`idproductosimple`
LEFT JOIN metaproductoproduccion mp 	ON psp.`idmetaproductoproduccion` = mp.`idmetaproductoproduccion`
WHERE pp.`fecha` BETWEEN '2015-11-12' AND '2015-11-12'
GROUP BY mp.codigo, mp.`nombre` 
;


SELECT *
FROM metaproductoproduccion;


	SELECT ART.COD, ART.NOMBRE, P.CANTIDAD AS CANTIDAD_SC, RP.CANTIDADR AS REPROCESO_SC, P.CANT_SP, RP.CANT_RSP
	      FROM (
		SELECT a.`cod_art` AS cod, a.`descri` AS nombre
		FROM inv_articulos a
		WHERE cuenta_art = '4420110201'
	     ) ART
	LEFT JOIN
	    (
		SELECT A.COD, A.NOMBRE, SUM(A.CANTIDADPRODUCIDARESPONSABLE) AS CANTIDAD, SUM(A.`cantidadproducida`) AS CANT_SP
		FROM 
		(
		    SELECT PL.FECHA,M.CODIGO AS COD, M.NOMBRE, O.CODIGO, O.CANTIDADPRODUCIDARESPONSABLE, o.`cantidadproducida`, O.COSTOTOALPRODUCCION, O.COSTOUNITARIO
		    FROM ORDENPRODUCCION O
		    LEFT JOIN PLANIFICACIONPRODUCCION PL    ON O.IDPLANIFICACIONPRODUCCION  = PL.IDPLANIFICACIONPRODUCCION
		    LEFT JOIN COMPOSICIONPRODUCTO C         ON O.IDCOMPOSICIONPRODUCTO      = C.IDCOMPOSICIONPRODUCTO
		    LEFT JOIN PRODUCTOPROCESADO P           ON C.IDPRODUCTOPROCESADO        = P.IDPRODUCTOPROCESADO
		    LEFT JOIN METAPRODUCTOPRODUCCION M      ON P.IDPRODUCTOPROCESADO        = M.IDMETAPRODUCTOPRODUCCION  
		    WHERE PL.FECHA BETWEEN '2015-11-01' AND '2015-11-30'
		) A
		GROUP BY A.COD, A.NOMBRE
	    ) P ON ART.COD = P.COD
	LEFT JOIN (
		SELECT mp.codigo AS COD, mp.`nombre`, SUM(ps.`cantidadproducidaresponsable`) AS cantidadr, SUM(ps.`cantidad`) AS CANT_RSP
		FROM productobase pb
		LEFT JOIN planificacionproduccion pp 	ON pb.`idplanificacionproduccion` = pp.`idplanificacionproduccion` 
		LEFT JOIN productosimple ps		ON pb.`idproductobase` = ps.`idproductobase`
		LEFT JOIN productosimpleprocesado psp	ON ps.`idproductosimple` = psp.`idproductosimple`
		LEFT JOIN metaproductoproduccion mp 	ON psp.`idmetaproductoproduccion` = mp.`idmetaproductoproduccion`
		WHERE pp.`fecha` BETWEEN '2015-11-01' AND '2015-11-30'
		GROUP BY mp.codigo, mp.`nombre` 
	) RP ON ART.COD = RP.cod;



-- AUX

SELECT PL.FECHA,M.CODIGO AS COD, M.NOMBRE, O.CODIGO, O.CANTIDADPRODUCIDARESPONSABLE, o.`cantidadproducida`
		    FROM ORDENPRODUCCION O
		    LEFT JOIN PLANIFICACIONPRODUCCION PL    ON O.IDPLANIFICACIONPRODUCCION  = PL.IDPLANIFICACIONPRODUCCION
		    LEFT JOIN COMPOSICIONPRODUCTO C         ON O.IDCOMPOSICIONPRODUCTO      = C.IDCOMPOSICIONPRODUCTO
		    LEFT JOIN PRODUCTOPROCESADO P           ON C.IDPRODUCTOPROCESADO        = P.IDPRODUCTOPROCESADO
		    LEFT JOIN METAPRODUCTOPRODUCCION M      ON P.IDPRODUCTOPROCESADO        = M.IDMETAPRODUCTOPRODUCCION  
		    WHERE PL.FECHA BETWEEN '2015-11-01' AND '2015-11-30';

