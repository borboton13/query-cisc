-- Pedidos Clientes Canal Redes Sociales
select p.`IDPEDIDOS`, p.`CODIGO`, pe.`NOM`, pe.`AP`, pe.`AM`, p.`FECHA_ENTREGA`, p.`OBSERVACION`, p.`iddistribuidor`, p.`IDCLIENTE`, p.`TOTALIMPORTE`, p.`MONTODIST`
from pedidos p
left join personacliente pe on p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
where p.`FECHA_ENTREGA` >= '2020-04-01'
and p.`ESTADO` <> 'ANULADO'
and p.`IDCLIENTE` in (
1864	,1722	,1870	,1724	,1737	,1730	,1733	,1908	,1741	,1872	,1885	,1723	,1873	,
1727	,1842	,1890	,1736	,1729	,1860	,1735	,1914	,1739	,1910	,1734	,1742	,1859,
1909, 1912, 2016, 2066
)
;

-- Resumen Pedidos
select pe.`NOM`, pe.`AP`, pe.`AM`, sum(p.`TOTALIMPORTE`) as Importe, count(p.`IDPEDIDOS`) as Recurrencia
from pedidos p
left join personacliente pe on p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
-- where p.`FECHA_ENTREGA` >= '2020-04-01'
where p.`FECHA_ENTREGA` between '2020-12-01' and '2021-01-31'
and p.`ESTADO` <> 'ANULADO'
and p.`IDCLIENTE` in (
1864	,1722	,1870	,1724	,1737	,1730	,1733	,1908	,1741	,1872	,1885	,1723	,1873	,
1727	,1842	,1890	,1736	,1729	,1860	,1735	,1914	,1739	,1910	,1734	,1742	,1859,
1909, 1912, 2016, 2066
)
group by pe.`NOM`, pe.`AP`, pe.`AM`
;


-- ----------------------------------------------------------------
-- ---------------------- RESUMEN PEDIDOS X ZONA PREVENTA -------------------------
select month(p.`FECHA_ENTREGA`) as Mes, day(p.`FECHA_ENTREGA`) as Dia, sum(p.`TOTALIMPORTE`) as Importe, count(p.`IDPEDIDOS`) as Recurrencia
from pedidos p
left join personacliente pc on p.`IDCLIENTE` = pc.`IDPERSONACLIENTE`
where p.`FECHA_ENTREGA` between '2020-12-01' and '2021-01-31'
and p.`ESTADO` <> 'ANULADO'
and pc.`IDTERRITORIOTRABAJO` = 24
group by month(p.`FECHA_ENTREGA`), day(p.`FECHA_ENTREGA`)
;




