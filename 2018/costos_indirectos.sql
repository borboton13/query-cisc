SELECT * 
FROM ordenproduccion
WHERE codigo = '1601-0223'
;

UPDATE ordenproduccion SET estadoorden = 'PENDING'
WHERE codigo IN (
''
)
;


SELECT c.nombre, SUM(c.montobs) AS montobs
FROM costosindirectos c
JOIN ordenproduccion op ON c.`idordenproduccion` = op.`idordenproduccion`
JOIN planificacionproduccion p ON op.`idplanificacionproduccion` = p.`idplanificacionproduccion`
WHERE p.`fecha` BETWEEN '2017-07-01' AND '2017-07-31' 
-- AND idcostosindirectos > 7
GROUP BY nombre
UNION ALL
SELECT c.nombre, SUM(c.montobs) AS montobs
FROM costosindirectos c
JOIN productosimple ps ON c.`idproductosimple` = ps.`idproductosimple`
JOIN productobase pb   ON ps.`idproductobase` = pb.`idproductobase`
JOIN planificacionproduccion p ON pb.`idplanificacionproduccion` = p.`idplanificacionproduccion`
WHERE p.`fecha` BETWEEN '2017-07-01' AND '2017-07-31'
GROUP BY c.nombre
;



SELECT *
FROM ordenproduccion
WHERE idplanificacionproduccion = 1000
;

SELECT *
FROM costosindirectos
WHERE idordenproduccion IN (
	SELECT idordenproduccion
	FROM ordenproduccion
	WHERE idplanificacionproduccion = 1000
);

SELECT c.nombre, SUM(c.montobs) AS montobs
FROM costosindirectos c
JOIN ordenproduccion op ON c.`idordenproduccion` = op.`idordenproduccion`
JOIN planificacionproduccion p ON op.`idplanificacionproduccion` = p.`idplanificacionproduccion`
WHERE p.`fecha` BETWEEN '2017-03-31' AND '2017-03-31' 
-- AND idcostosindirectos > 7
GROUP BY nombre




