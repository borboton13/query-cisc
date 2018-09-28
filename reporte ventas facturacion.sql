-- REPORTES DE VENTAS, PEDIDOS Y FACURACION

-- VENTAS AL CONTADO
SELECT 	v.`FECHA_PEDIDO` AS FECHA, 
	CONCAT(pe.`NOM`, " ", pe.`AP`, " ", pe.`AM`) AS CLIENTE,
	v.`ESTADO`, v.`CODIGO`, v.`TOTALIMPORTE`, v.`IDMOVIMIENTO`, m.`NROFACTURA`, m.`ESTADO`, m.`IMPORTE_TOTAL`, m.`DESCUENTOS`, m.`IMPORTE_PARA_DEBITO_FISCAL`, m.`DEBITO_FISCAL`,
	e.`tipo_doc`,
	e.`no_doc`, 
	e.`estado`
FROM ventadirecta v
LEFT JOIN personacliente pe ON v.`IDCLIENTE` 	= pe.`IDPERSONACLIENTE`
LEFT JOIN movimiento m 	    ON v.`IDMOVIMIENTO` = m.`IDMOVIMIENTO`
LEFT JOIN sf_tmpenc e  	    ON v.`id_tmpenc`	= e.`id_tmpenc`
WHERE v.`FECHA_PEDIDO` BETWEEN '2017-01-01' AND '2017-01-31'
;


-- PEDIDOS
SELECT 	p.`FECHA_ENTREGA` AS FECHA, 
	CONCAT(pe.`NOM`, " ", pe.`AP`, " ", pe.`AM`) AS CLIENTE,
	p.`ESTADO`, 
	t.`NOMBRE` AS TIPO,
	p.`CODIGO`, p.`TOTALIMPORTE`, p.`IDMOVIMIENTO`, m.`NROFACTURA`, m.`ESTADO`, m.`IMPORTE_TOTAL`, m.`DESCUENTOS`, m.`IMPORTE_PARA_DEBITO_FISCAL`, m.`DEBITO_FISCAL`,
	e.`tipo_doc`,
	e.`no_doc`, 
	e.`estado`
FROM pedidos p
LEFT JOIN personacliente pe ON p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
LEFT JOIN tipopedido t ON p.`IDTIPOPEDIDO`   = t.`IDTIPOPEDIDO`
LEFT JOIN movimiento m ON p.`IDMOVIMIENTO`   = m.`IDMOVIMIENTO`
LEFT JOIN sf_tmpenc e  	    ON p.`id_tmpenc` = e.`id_tmpenc`
WHERE p.`FECHA_ENTREGA` BETWEEN '2017-01-01' AND '2017-01-31'
;

