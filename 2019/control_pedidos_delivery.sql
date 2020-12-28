select p.`IDPEDIDOS`, p.`CODIGO`, pe.`NOM`, pe.`AP`, pe.`AM`, p.`FECHA_ENTREGA`, p.`OBSERVACION`, p.`iddistribuidor`, p.`IDCLIENTE`, p.`TOTALIMPORTE`, p.`MONTODIST`
from pedidos p
left join personacliente pe on p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
where p.`FECHA_ENTREGA` >= '2020-04-01'
and p.`ESTADO` <> 'ANULADO'
and p.`IDCLIENTE` in (
1864	,
1722	,
1870	,
1724	,
1737	,
1730	,
1733	,
1908	,
1741	,
1872	,
1885	,
1723	,
1873	,
1727	,
1842	,
1890	,
1736	,
1729	,
1860	,
1735	,
1914	,
1739	,
1910	,
1734	,
1742	,
1859	
)
;