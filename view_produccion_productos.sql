
-- QUERY: CANTIDAD DE PRODUCTOS PRODUCIDOS (NORMAL Y REPROCESOS)	
	SELECT P.FECHA, ART.COD, ART.NOMBRE, P.CANTIDAD_SC, RP.REPROCESO_SC, P.CANTIDAD_SP, RP.REPROCESO_SP
	FROM (
		SELECT mp.`codigo` AS COD, mp.`nombre`
		FROM productoprocesado pp
		JOIN metaproductoproduccion mp ON pp.`idproductoprocesado` = mp.`idmetaproductoproduccion`
	     ) ART
			LEFT JOIN
			    (
				SELECT A.FECHA, A.COD, A.NOMBRE, SUM(A.CANTIDADPRODUCIDARESPONSABLE) AS CANTIDAD_SC, SUM(A.`cantidadproducida`) AS CANTIDAD_SP
				FROM 
				(
				    SELECT PL.FECHA, M.CODIGO AS COD, M.NOMBRE, O.CODIGO, O.CANTIDADPRODUCIDARESPONSABLE, o.`cantidadproducida`
				    FROM ORDENPRODUCCION O
				    LEFT JOIN PLANIFICACIONPRODUCCION PL    ON O.IDPLANIFICACIONPRODUCCION  = PL.IDPLANIFICACIONPRODUCCION
				    LEFT JOIN COMPOSICIONPRODUCTO C         ON O.IDCOMPOSICIONPRODUCTO      = C.IDCOMPOSICIONPRODUCTO
				    LEFT JOIN PRODUCTOPROCESADO P           ON C.IDPRODUCTOPROCESADO        = P.IDPRODUCTOPROCESADO
				    LEFT JOIN METAPRODUCTOPRODUCCION M      ON P.IDPRODUCTOPROCESADO        = M.IDMETAPRODUCTOPRODUCCION  
				    WHERE PL.FECHA BETWEEN '2015-11-19' AND '2015-11-19'
				) A
				GROUP BY A.FECHA, A.COD, A.NOMBRE
			    ) P ON ART.COD = P.COD
			LEFT JOIN (
				    SELECT pp.`fecha`, mp.codigo AS COD, mp.`nombre`, SUM(ps.`cantidadproducidaresponsable`) AS REPROCESO_SC, SUM(ps.`cantidad`) AS REPROCESO_SP
				    FROM productobase pb
				    LEFT JOIN planificacionproduccion pp 	ON pb.`idplanificacionproduccion` = pp.`idplanificacionproduccion` 
				    LEFT JOIN productosimple ps		ON pb.`idproductobase` = ps.`idproductobase`
				    LEFT JOIN productosimpleprocesado psp	ON ps.`idproductosimple` = psp.`idproductosimple`
				    LEFT JOIN metaproductoproduccion mp 	ON psp.`idmetaproductoproduccion` = mp.`idmetaproductoproduccion`
				    WHERE pp.`fecha` BETWEEN '2015-11-19' AND '2015-11-19'
				    GROUP BY pp.`fecha`, mp.codigo, mp.`nombre` 
			          ) RP ON ART.COD = RP.COD
			;


		    
-- VISTAS PARA REPORTE DE PRODUCCIO DE PRODUCTOS			
-- 1.-
CREATE VIEW produccionreproceso AS 
		SELECT PL.FECHA, M.CODIGO AS COD_ART, M.NOMBRE, O.CODIGO AS COD_ORD, o.`cantidadproducida` AS CANTIDAD_SC, O.CANTIDADPRODUCIDARESPONSABLE AS CANTIDAD_SP, 0 AS REPROCESO_SC, 0 AS REPROCESO_SP
		FROM ORDENPRODUCCION O
		LEFT JOIN PLANIFICACIONPRODUCCION PL    ON O.IDPLANIFICACIONPRODUCCION  = PL.IDPLANIFICACIONPRODUCCION
		LEFT JOIN COMPOSICIONPRODUCTO C         ON O.IDCOMPOSICIONPRODUCTO      = C.IDCOMPOSICIONPRODUCTO
		LEFT JOIN PRODUCTOPROCESADO P           ON C.IDPRODUCTOPROCESADO        = P.IDPRODUCTOPROCESADO
		LEFT JOIN METAPRODUCTOPRODUCCION M      ON P.IDPRODUCTOPROCESADO        = M.IDMETAPRODUCTOPRODUCCION  
		UNION
		SELECT pp.`FECHA`, mp.codigo AS COD_ART, mp.`NOMBRE`, pb.`CODIGO` AS COD_ORD, 0 AS CANTIDAD_SC, 0 AS CANTIDAD_SP, ps.`cantidad` AS REPROCESO_SC, ps.`cantidadproducidaresponsable` AS REPROCESO_SP
		FROM productobase pb
		LEFT JOIN planificacionproduccion pp 	ON pb.`idplanificacionproduccion` = pp.`idplanificacionproduccion` 
		LEFT JOIN productosimple ps		ON pb.`idproductobase` = ps.`idproductobase`
		LEFT JOIN productosimpleprocesado psp	ON ps.`idproductosimple` = psp.`idproductosimple`
		LEFT JOIN metaproductoproduccion mp 	ON psp.`idmetaproductoproduccion` = mp.`idmetaproductoproduccion`
;

-- 2.-
CREATE VIEW producciontotal AS
SELECT 1 AS ID, FECHA, COD_ART, NOMBRE, SUM(CANTIDAD_SC) AS CANTIDAD_SC, SUM(CANTIDAD_SP) AS CANTIDAD_SP, SUM(REPROCESO_SC) AS REPROCESO_SC, SUM(REPROCESO_SP) AS REPROCESO_SP
FROM produccionreproceso
GROUP BY ID, FECHA, COD_ART, NOMBRE
;


SELECT COD_ART, NOMBRE, SUM(CANTIDAD_SC), SUM(CANTIDAD_SP), SUM(REPROCESO_SC), SUM(REPROCESO_SP)
FROM producciontotal
WHERE fecha BETWEEN '2015-11-01' AND '2015-11-30'
GROUP BY COD_ART, NOMBRE
;

