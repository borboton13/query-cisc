SELECT p.`IDPEDIDOS`, p.`FECHA_ENTREGA`, p.`CODIGO`, p.`IDCLIENTE`, pe.`NOM`, p.`ESTADO`, a.`cod_art`, i.`descri`, a.`CANTIDAD`, a.`PROMOCION`, a.`REPOSICION`, a.`PRECIO`, a.`TOTAL`, a.`IMPORTE`
FROM pedidos p
JOIN articulos_pedido a ON p.`IDPEDIDOS` = a.`IDPEDIDOS`
JOIN inv_articulos i    ON a.`cod_art`   = i.`cod_art`
JOIN personacliente pe  ON p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
WHERE p.`IDCLIENTE` = 726
AND p.`FECHA_ENTREGA` BETWEEN '2016-01-01' AND '2017-09-30'
AND P.`ESTADO` <> 'ANULADO'
;

