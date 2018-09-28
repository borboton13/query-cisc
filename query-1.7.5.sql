UPDATE arcgms SET activa = 'S';

UPDATE arcgms SET ind_mov = 'S';

UPDATE arcgms SET tipo = 'A'
WHERE cuenta < '2000000000';

UPDATE arcgms SET tipo = 'P'
WHERE cuenta >= '2000000000' AND cuenta < '3000000000';

UPDATE arcgms SET tipo = 'C'
WHERE cuenta >= '3000000000' AND cuenta < '4000000000'
;

UPDATE arcgms SET tipo = 'E'
WHERE cuenta >= '4000000000' AND cuenta < '5000000000'
;

UPDATE arcgms SET tipo = 'I'
WHERE cuenta >= '5000000000' AND cuenta < '6000000000'
;

SELECT MAX(idmovimientosalarioproductor)+1 FROM movimientosalarioproductor;

SET @folio = 753;
INSERT INTO movimientosalarioproductor(idmovimientosalarioproductor,fecha,descripcion,estado,valor,idcompania,idzonaproductiva,idproductormateriaprima,idtipomovimientoproductor)
SELECT (@folio := @folio + 1), '2015-05-31' AS fecha, 'REPOSICION DE FORMULARIO' AS descripcion, 'PENDING' AS estado, 0.50 AS valor, 1 AS idcompania, p.`idzonaproductiva`, d.`idproductormateriaprima`, 5 AS idtipomovimientoproductor 
FROM registropagomateriaprima r
LEFT JOIN planillapagomateriaprima p 	ON r.`idplanillapagomateriaprima` = p.`idplanillapagomateriaprima`
LEFT JOIN descuentproductmateriaprima d ON r.`iddescuentproductmateriaprima` = d.`iddescuentproductmateriaprima`
WHERE p.fechainicio = '2015-05-16'
-- AND p.`idzonaproductiva` = 140
AND r.`liquidopagable` > 0
;

-- 

SELECT *
FROM arcgms
WHERE cuenta >= '6000000000' 
-- and cuenta < '6000000000'
;
