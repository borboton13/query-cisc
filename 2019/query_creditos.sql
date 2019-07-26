SELECT s.`idsocio`, s.`nombres`, s.`apellidopaterno`, s.`apellidomaterno`, c.`codigoant`, c.`estado`, c.`fechaconcesion`, c.`fechapago`, c.`importe`, c.`saldo`, c.`ultimopago`, c.`idtipocredito`,
t.`nombre`
FROM credito c
JOIN socio s ON c.`idsocio` = s.`idsocio`
JOIN tipocredito t ON c.`idtipocredito` = t.`idtipocredito`
WHERE c.`idtipocredito` = 2
;

SELECT s.`idsocio`, c.`idcredito`, s.`nombres`, s.`apellidopaterno`, s.`apellidomaterno`, c.`codigoant`, c.`estado`, c.`fechaconcesion`, c.`importe`, c.`saldo`, c.`ultimopago`, c.`idtipocredito`,
t.`nombre`, tr.`tipo`, tr.`id_tmpenc`
FROM credito c
JOIN socio s 			ON c.`idsocio` = s.`idsocio`
JOIN tipocredito t 		ON c.`idtipocredito` = t.`idtipocredito`
JOIN transaccioncredito tr 	ON c.`idcredito` = tr.`idcredito`
WHERE c.`idtipocredito` = 2
;

--

SELECT e.`fecha`, e.`tipo_doc`, e.`no_doc`, e.`glosa`, c.`idcredito`, c.`codigo`, c.`codigoant`, s.`nombres`, s.`apellidopaterno`, s.`apellidomaterno`, 
CONCAT(s.`nombres`,' ', s.`apellidopaterno`, ' ', s.`apellidomaterno`, ' ', c.`codigoant`, ', ', e.`glosa`)
FROM sf_tmpenc e
JOIN sf_tmpdet d ON e.`id_tmpenc` = d.`id_tmpenc`
JOIN credito c ON d.`idcredito` = c.`idcredito`
JOIN socio s ON c.`idsocio` = s.`idsocio`
WHERE e.`tipo_doc` = 'CE'
;


SELECT t.`idtransaccioncredito`, t.`idcredito`, t.`fechacreacion`, t.`fechatransaccion`, e.`fecha`
FROM transaccioncredito t 
JOIN sf_tmpenc e ON t.`id_tmpenc` = e.`id_tmpenc`
;

SELECT t.`idtransaccioncredito`, t.`idcredito`, t.`fechacreacion`, t.`fechatransaccion`, e.`fecha`
FROM sf_tmpenc e 
JOIN transaccioncredito t ON e.`id_tmpenc` = t.`id_tmpenc`
;


