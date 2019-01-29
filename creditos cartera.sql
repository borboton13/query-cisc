
SELECT CONCAT(t.`nombre`, ' ', c.`estado`), c.`estado`, ' ',t.`nombre`,  z.`numero`, z.`nombre`, c.`idcredito`, s.`nombres`, s.`apellidopaterno`, c.`fechaconcesion`, c.`anual`, c.`importe`, c.`saldo`, c.`ultimopago`
FROM credito c
JOIN socio s 		ON c.`idsocio` = s.`idsocio`
JOIN zonaproductiva z 	ON s.`idzonaproductiva` = z.`idzonaproductiva`
JOIN tipocredito t 	ON c.`idtipocredito` = t.`idtipocredito`
WHERE c.`estado` = 'EJE'
AND z.`grupo` = 'CISC'
ORDER BY t.`nombre`, c.`estado`
;


SELECT c.`estado`, z.`numero`, z.`nombre`, c.`idcredito`, c.`codigoant`, s.`nombres`, s.`apellidopaterno`, s.`apellidomaterno`, c.`fechaconcesion`, c.`anual`, c.`importe`, c.`saldo`, c.`ultimopago`
FROM credito c
JOIN socio s 		ON c.`idsocio` = s.`idsocio`
JOIN zonaproductiva z 	ON s.`idzonaproductiva` = z.`idzonaproductiva`
WHERE z.`grupo` = 'CISC'
AND c.`idtipocredito` IS NULL
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

-- ESTADO CARTERA JOIN SOCIO CI...?
SELECT e.id, e.`nombres`, e.`ap`, e.`am`, e.`nombrecomp`, s.`nombres`, s.`apellidopaterno`, s.`noidentificacion`
FROM estadocartera e, socio s
WHERE e.`ap` 	= s.`apellidopaterno`
AND e.`am` 	= s.`apellidomaterno`
AND e.`nombres` = s.`nombres`
;


SELECT *
FROM estadocartera e 

;


SELECT e.`id`, s.`noidentificacion` AS ci, s.`nombres`, s.`apellidopaterno`, s.`apellidomaterno`,  e.`fapertura`, e.`saldoactual`, e.`ultimopago`, c.`idcredito`, c.`codigoant`, c.`fechaconcesion`, c.`saldo`, c.`ultimopago`
FROM estadocartera e
LEFT JOIN credito c 	ON e.`idcredito` = c.`idcredito`
LEFT JOIN socio s 	ON c.`idsocio` = s.`idsocio`
;


SELECT e.`id`, e.`ci`, e.`nombres`, e.`fapertura`, s.`noidentificacion`, s.`nombres`, s.`apellidopaterno`, s.`apellidomaterno`, c.`idcredito`, c.`fechaconcesion`
FROM estadocartera e
LEFT JOIN socio s 	ON e.`ci` = s.`noidentificacion`
LEFT JOIN credito c 	ON s.`idsocio` = c.`idsocio`
WHERE e.`fapertura` = c.`fechaconcesion`
;

-- UPDATE SECUENCIA SET VALOR=(SELECT MAX(e.`id_tmpdet`)+1 FROM sf_tmpdet e) WHERE TABLA='sf_tmpdet';
-- UPDATE SECUENCIA SET VALOR=(SELECT MAX(e.`id_tmpenc`)+1 FROM sf_tmpdet e) WHERE TABLA='sf_tmpenc';
-- UPDATE SECUENCIA SET VALOR=(SELECT MAX(e.`idcredito`)+1 FROM sf_tmpdet e) WHERE TABLA='credito';
-- UPDATE SECUENCIA SET VALOR=(SELECT MAX(e.`idtransaccioncredito`)+1 FROM transaccioncredito e) WHERE TABLA='transaccioncredito';



SELECT *
FROM transaccioncredito t
WHERE t.`fechacreacion` >= '2019-01-28'
;
-- AND t.`idcredito` IN ();


SELECT a.`cuenta`, a.`descri`, SUM(d.`debe`) AS debe, SUM(d.`haber`) AS haber
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e 	ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a 	ON d.`cuenta` = a.`cuenta`
WHERE e.`tipo_doc` = 'CD' AND e.`no_doc` = 1
GROUP BY a.`cuenta`, a.`descri`
;



SELECT e.id, c.`idcredito`, c.`codigoant`, c.`importe`, c.`fechaconcesion`, s.`noidentificacion`, s.`nombres`, s.`apellidopaterno`, s.`apellidomaterno`, e.`saldoactual`, e.`ultimopago`
FROM credito c
LEFT JOIN socio s 		ON c.`idsocio` = s.`idsocio`
LEFT JOIN estadocartera e 	ON s.`noidentificacion` = e.`ci`
WHERE c.`fechaconcesion` = e.`fapertura`
;


/** PARA INSERTAR ASIENTOS **/
SELECT s.`idsocio`, s.`nombres`, s.`apellidopaterno`, s.`apellidomaterno`, c.`idcredito`, C.`estado`, c.`codigoant`, c.`fechaconcesion`, c.`importe`, c.`saldo`, 
t.`idtransaccioncredito`, t.`capital`, t.`interes`, t.`importe`, t.`fechatransaccion`, t.`fechacreacion`, t.`saldo`, t.`tipo`, t.`id_tmpenc`,
tc.`nombre`, tc.`ctavig`, tc.`ctaven`, tc.`ctaeje`, tc.`ictavig`, tc.`ictaven`
FROM transaccioncredito t
JOIN credito c ON t.`idcredito` = c.`idcredito`
JOIN tipocredito tc ON c.`idtipocredito` = tc.`idtipocredito`
JOIN socio s   ON c.`idsocio` = s.`idsocio`
AND t.`fechacreacion` >= '2019-01-28'
;


/** Ahorros socios **/
SELECT e.`id`, e.`nombrecomp`, e.`nombres`, e.`ap`, e.`am`, e.`ci`, s.`idsocio`, s.`nombres`, s.`apellidopaterno`, s.`apellidomaterno`, s.`noidentificacion`
FROM estadoahorro e, socio s
WHERE e.`nombres` = s.`nombres`
AND e.`ap` = s.`apellidopaterno`
AND e.`am` = s.`apellidomaterno`
AND e.`ci` IS NULL
;



