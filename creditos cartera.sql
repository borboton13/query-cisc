
SELECT CONCAT(t.`nombre`, ' ', c.`estado`), c.`estado`, ' ',t.`nombre`,  z.`numero`, z.`nombre`, c.`idcredito`, s.`nombres`, s.`apellidopaterno`, c.`fechaconcesion`, c.`anual`, c.`importe`, c.`saldo`, c.`ultimopago`
FROM credito c
JOIN socio s 		ON c.`idsocio` = s.`idsocio`
JOIN zonaproductiva z 	ON s.`idzonaproductiva` = z.`idzonaproductiva`
JOIN tipocredito t 	ON c.`idtipocredito` = t.`idtipocredito`
WHERE c.`estado` = 'EJE'
AND z.`grupo` = 'CISC'
ORDER BY t.`nombre`, c.`estado`
;

SELECT e.`fecha`, e.`tipo_doc`, e.`no_doc`, e.`glosa`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, d.`idcredito`
FROM sf_tmpdet d
JOIN sf_tmpenc e 	ON d.`id_tmpenc` = e.`id_tmpenc`
JOIN arcgms a 		ON d.`cuenta` = a.`cuenta`
JOIN credito c 	ON d.`idcredito` = c.`idcredito`
WHERE c.`idcredito` = 268
AND d.`cuenta` NOT IN (5130510100, 5140510100)
;

-- delete from sf_tmpdet where id_tmpenc in (97936, 97937, 97938) ;
-- delete from sf_tmpenc WHERE id_tmpenc IN (97936, 97937, 97938) ;


SELECT t.`idcredito`, t.`fechatransaccion`, t.`importe`, t.`tipo`
FROM transaccioncredito t
ORDER BY t.`idcredito`, t.`fechatransaccion` DESC
;

SELECT *
FROM (
	SELECT t.`idcredito`, t.`fechatransaccion`, t.`importe`, t.`tipo`
	FROM transaccioncredito t
	WHERE t.`tipo` = 'ING'
	ORDER BY t.`idcredito`, t.`fechatransaccion` DESC
	) z
GROUP BY z.idcredito
;
