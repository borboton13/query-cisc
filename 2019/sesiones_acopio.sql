
select se.idsesionacopio, se.fecha, se.idzonaproductiva, zo.nombre, zo.numero, ac.idacopiomateriaprima, ac.idproductormateriaprima, ac.cantidad
from acopiomateriaprima ac
left join sesionacopio se   on ac.idsesionacopio   = se.idsesionacopio
left join zonaproductiva zo on se.idzonaproductiva = zo.idzonaproductiva
where se.fecha = to_date('16/02/2015','dd/mm/yyyy')
-- and zo.numero = 543
;

select se.idsesionacopio, se.fecha, se.idzonaproductiva, zo.nombre, zo.numero, ac.idacopiomateriaprima, ac.idproductormateriaprima, ac.cantidad
from sesionacopio se
left join acopiomateriaprima ac   on se.idsesionacopio = ac.idsesionacopio
left join zonaproductiva zo       on se.idzonaproductiva = zo.idzonaproductiva
where se.fecha = to_date('16/02/2015','dd/mm/yyyy')
-- and zo.numero = 543
;

select se.idsesionacopio, se.fecha, se.idzonaproductiva, zo.nombre, zo.numero, sum(ac.cantidad) as cantidad
from acopiomateriaprima ac
left join sesionacopio se   on ac.idsesionacopio   = se.idsesionacopio
left join zonaproductiva zo on se.idzonaproductiva = zo.idzonaproductiva
where se.fecha between '2015-05-29' and '2015-05-29'
-- and zo.numero = 093
group by se.idsesionacopio, se.fecha, se.idzonaproductiva, zo.nombre, zo.numero
-- ORDER BY zo.numero
order by se.fecha
;

-- UPDATE SECUENCIA SET VALOR=(SELECT MAX(E.IDACOPIOMATERIAPRIMA)/10+1 FROM ACOPIOMATERIAPRIMA E) WHERE TABLA='ACOPIOMATERIAPRIMA';

select *
from PLANILLAACOPIO;

select *
from REGISTROACOPIO RA;

select pl.idplanillaacopio, pl.fecha, pl.totalpesado, ra.idregistroacopio, zo.nombre, zo.numero, ra.cantidadrecibida, ra.cantidadpesada, ra.cantidadrechazada, ra.idzonaproductiva
from REGISTROACOPIO RA
left join PLANILLAACOPIO PL on ra.idplanillaacopio = pl.idplanillaacopio
left join zonaproductiva zo on ra.idzonaproductiva = zo.idzonaproductiva
where pl.fecha between '2019-02-01' and '2019-02-15'
-- AND zo.numero = 543
order by pl.fecha
;

select zo.`idzonaproductiva`, zo.nombre, zo.numero, sum(ra.cantidadrecibida)as recibida, sum(ra.cantidadpesada) as pesada
from REGISTROACOPIO RA
left join PLANILLAACOPIO PL on ra.idplanillaacopio = pl.idplanillaacopio
left join zonaproductiva zo on ra.idzonaproductiva = zo.idzonaproductiva
where pl.fecha between '2019-02-01' and '2019-02-15'
group by zo.`idzonaproductiva`, zo.nombre, zo.numero
;


select *
from sesionacopio
;

select *
from acopiomateriaprima am
;
-- REPORTE DE ACOPIO POR PRODUCTOR X MES
select month(sa.`fecha`) as MES, zp.`numero`, zp.`nombre`, am.`idproductormateriaprima` as id, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, sum(am.`cantidad`) as CANT
from acopiomateriaprima am
left join sesionacopio sa on am.`idsesionacopio` = sa.`idsesionacopio`
left join zonaproductiva zp on sa.`idzonaproductiva` = zp.`idzonaproductiva`
left join persona p on am.`idproductormateriaprima` = p.`idpersona`
where sa.`fecha` between '2020-06-16' and '2020-06-30'
and am.`cantidad` > 0
group by month(sa.`fecha`), zp.`numero`, zp.`nombre`, am.`idproductormateriaprima`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`
;

-- *** REPORTE DE ACOPIO POR PRODUCTOR X MES
select month(sa.`fecha`) as MES, count(distinct am.`idproductormateriaprima`)as PRODUCTORES, sum(am.`cantidad`) as LITROS
from acopiomateriaprima am
left join sesionacopio sa on am.`idsesionacopio` = sa.`idsesionacopio`
left join zonaproductiva zp on sa.`idzonaproductiva` = zp.`idzonaproductiva`
left join persona p on am.`idproductormateriaprima` = p.`idpersona`
where sa.`fecha` between '2019-01-01' and '2019-12-31'
and am.`cantidad` > 0
group by month(sa.`fecha`)
;

-- REPORTE DE ACOPIO POR PRODUCTOR X MES/QUINC + ci
select month(sa.`fecha`) as MES, zp.`numero`, zp.`nombre`, /*am.`idproductormateriaprima` as idprod,*/ e.`noidentificacion` as ci, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, sum(am.`cantidad`) as CANT
from acopiomateriaprima am
left join sesionacopio sa on am.`idsesionacopio` = sa.`idsesionacopio`
left join zonaproductiva zp on sa.`idzonaproductiva` = zp.`idzonaproductiva`
left join persona p on am.`idproductormateriaprima` = p.`idpersona`
left join entidad e on p.`idpersona` = e.`identidad`
where sa.`fecha` between '2019-08-01' and '2019-08-31'
and am.`cantidad` > 0
group by month(sa.`fecha`), zp.`numero`, zp.`nombre`, am.`idproductormateriaprima`, e.`noidentificacion`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`
;

-- REPORTE DE ACOPIO POR PRODUCTOR + PROMEDIO
select month(sa.`fecha`) as MES, zp.`numero`, zp.`nombre`, e.`noidentificacion` as ci, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, sum(am.`cantidad`) as cant, count(sa.`fecha`) as dias, sum(am.`cantidad`)/count(sa.`fecha`) as prom
from acopiomateriaprima am
left join sesionacopio sa on am.`idsesionacopio` = sa.`idsesionacopio`
left join zonaproductiva zp on sa.`idzonaproductiva` = zp.`idzonaproductiva`
left join persona p on am.`idproductormateriaprima` = p.`idpersona`
left join entidad e on p.`idpersona` = e.`identidad`
where sa.`fecha` between '2021-03-01' and '2021-03-31'
and am.`cantidad` > 0
group by month(sa.`fecha`), zp.`numero`, zp.`nombre`, am.`idproductormateriaprima`, e.`noidentificacion`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`
;

-- REPORTE DE ACOPIO POR PRODUCTOR x Dia
select sa.`fecha`, zp.`numero`, zp.`nombre`, e.`noidentificacion` as ci, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, sum(am.`cantidad`) as cant
from acopiomateriaprima am
left join sesionacopio sa on am.`idsesionacopio` = sa.`idsesionacopio`
left join zonaproductiva zp on sa.`idzonaproductiva` = zp.`idzonaproductiva`
left join persona p on am.`idproductormateriaprima` = p.`idpersona`
left join entidad e on p.`idpersona` = e.`identidad`
where sa.`fecha` between '2021-03-01' and '2021-03-31'
and am.`cantidad` > 0
group by sa.`fecha`, zp.`numero`, zp.`nombre`, am.`idproductormateriaprima`, e.`noidentificacion`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`
;

-- REPORTE DE ACOPIO POR PRODUCTOR X DIA + ci
-- select sa.`fecha`, zp.`numero`, zp.`nombre`, am.`idproductormateriaprima` as idprod, e.`noidentificacion` as ci, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, SUM(am.`cantidad`) as CANT
select sa.`fecha`, zp.`numero`, zp.`nombre`, am.`idproductormateriaprima` as idprod, e.`noidentificacion` as ci, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, am.`cantidad`
from acopiomateriaprima am
left join sesionacopio sa on am.`idsesionacopio` = sa.`idsesionacopio`
left join zonaproductiva zp on sa.`idzonaproductiva` = zp.`idzonaproductiva`
left join persona p on am.`idproductormateriaprima` = p.`idpersona`
left join entidad e on p.`idpersona` = e.`identidad`
where sa.`fecha` between '2019-07-01' and '2019-07-31'
and am.`cantidad` > 0
-- group by sa.`fecha`, zp.`numero`, zp.`nombre`, am.`idproductormateriaprima`, e.`noidentificacion`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`
;

-- REPORTE DE ACOPIO POR PRODUCTOR GRAL + ci
select zp.`idzonaproductiva`, zp.`numero`, zp.`nombre`, am.`idproductormateriaprima` as id, e.`noidentificacion` as ci, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, sum(am.`cantidad`) as CANT
from acopiomateriaprima am
left join sesionacopio sa on am.`idsesionacopio` = sa.`idsesionacopio`
left join zonaproductiva zp on sa.`idzonaproductiva` = zp.`idzonaproductiva`
left join persona p on am.`idproductormateriaprima` = p.`idpersona`
left join entidad e on p.`idpersona` = e.`identidad`
where sa.`fecha` between '2020-12-01' and '2021-02-28'
and am.`cantidad` > 0
-- and p.`nombres` like '%FELICIDA%'
-- AND am.`idproductormateriaprima` IN (/*94, 524, 539, 102, 570, 526*/    107, 109, 105, 113, 112, 111, 91, 108)
group by zp.`idzonaproductiva`, zp.`numero`, zp.`nombre`, am.`idproductormateriaprima`, e.`noidentificacion`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`
;

-- REPORTE DE ACOPIO POR PRODUCTORES (PARA SOL CASCARILLA) X MESES
select am.`idproductormateriaprima` as id, e.`noidentificacion` as ci, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, month(sa.`fecha`) as mes, sum(am.`cantidad`) as cant
from acopiomateriaprima am
left join sesionacopio sa on am.`idsesionacopio` = sa.`idsesionacopio`
left join zonaproductiva zp on sa.`idzonaproductiva` = zp.`idzonaproductiva`
left join persona p on am.`idproductormateriaprima` = p.`idpersona`
left join entidad e on p.`idpersona` = e.`identidad`
where sa.`fecha` between '2019-06-01' and '2019-11-30'
-- and am.`cantidad` > 0
and E.`noidentificacion` in (8804935,	2890182,	5295951,	4442330,	3565335,	3588392,	859557,	5225910,	4389392,	3787676,	3562707,	3584420,	3130328,	4499629,	8008046,	2902741,	6498257,	3587562,	4418347,	5210751,	6479621,	3560702,	3013295,	818053,	3560711,	4424142,	4438154,	6408655,	5909313,	2868329,	4513674,	3812055,	5920932,	4400847,	6443376,	3580789,	4529955,	8725507,	3567711,	2903504)
group by am.`idproductormateriaprima`, e.`noidentificacion`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, month(sa.`fecha`)
;

-- LISTA DE PRODUCTORES ACTIVOS
select am.`idproductormateriaprima` as id, zp.numero, zp.nombre, e.`noidentificacion` as ci, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, pr.`numerocuenta`, sum(am.`cantidad`) as CANT, max(sa.`fecha`)
from acopiomateriaprima am
left join sesionacopio sa on am.`idsesionacopio` = sa.`idsesionacopio`
left join zonaproductiva zp on sa.`idzonaproductiva` = zp.`idzonaproductiva`
left join persona p on am.`idproductormateriaprima` = p.`idpersona`
left join productormateriaprima pr on p.`idpersona` = pr.`idproductormateriaprima`
left join entidad e on p.`idpersona` = e.`identidad`
where sa.`fecha` between '2021-03-01' and '2021-03-31'
and am.`cantidad` > 0
-- and p.`nombres` like '%FELICIDA%'
-- AND am.`idproductormateriaprima` IN (/*94, 524, 539, 102, 570, 526*/    107, 109, 105, 113, 112, 111, 91, 108)
-- group by am.`idproductormateriaprima`, e.`noidentificacion`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, pr.`numerocuenta`
group by am.`idproductormateriaprima`, zp.numero, zp.nombre, e.`noidentificacion`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, pr.`numerocuenta`
;

-- REPORTE DE ACOPIO POR PRODUCTOR X MES + ci
-- SELECT day(sa.`fecha`) AS dia, zp.`numero`, zp.`nombre`, am.`idproductormateriaprima` AS idprod, e.`noidentificacion` AS ci, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, SUM(am.`cantidad`) AS CANT
select day(sa.`fecha`) as dia, zp.`numero`, zp.`nombre`, sum(am.`cantidad`) as CANT
from acopiomateriaprima am
left join sesionacopio sa on am.`idsesionacopio` = sa.`idsesionacopio`
left join zonaproductiva zp on sa.`idzonaproductiva` = zp.`idzonaproductiva`
left join persona p on am.`idproductormateriaprima` = p.`idpersona`
left join entidad e on p.`idpersona` = e.`identidad`
where sa.`fecha` between '2020-08-01' and '2020-08-31'
and am.`cantidad` > 0
-- and zp.`numero` = 074
group by day(sa.`fecha`), zp.`numero`, zp.`nombre`
;

