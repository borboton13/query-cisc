
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

select se.idsesionacopio, se.fecha, se.idzonaproductiva, zo.nombre, zo.numero, SUM(ac.cantidad) as cantidad
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

select zo.`idzonaproductiva`, zo.nombre, zo.numero, SUM(ra.cantidadrecibida)as recibida, SUM(ra.cantidadpesada) as pesada
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
select MONTH(sa.`fecha`) as MES, zp.`numero`, zp.`nombre`, am.`idproductormateriaprima`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, SUM(am.`cantidad`) as CANT
from acopiomateriaprima am
left join sesionacopio sa on am.`idsesionacopio` = sa.`idsesionacopio`
left join zonaproductiva zp on sa.`idzonaproductiva` = zp.`idzonaproductiva`
left join persona p on am.`idproductormateriaprima` = p.`idpersona`
where sa.`fecha` between '2019-04-01' and '2019-04-30'
group by MONTH(sa.`fecha`), zp.`numero`, zp.`nombre`, am.`idproductormateriaprima`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`
;


-- REPORTE DE ACOPIO POR PRODUCTOR X MES + ci
select MONTH(sa.`fecha`) as MES, zp.`numero`, zp.`nombre`, am.`idproductormateriaprima` as idprod, e.`noidentificacion` as ci, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, SUM(am.`cantidad`) as CANT
from acopiomateriaprima am
left join sesionacopio sa on am.`idsesionacopio` = sa.`idsesionacopio`
left join zonaproductiva zp on sa.`idzonaproductiva` = zp.`idzonaproductiva`
left join persona p on am.`idproductormateriaprima` = p.`idpersona`
left join entidad e on p.`idpersona` = e.`identidad`
where sa.`fecha` between '2019-04-01' and '2019-05-30'
and am.`cantidad` > 0
group by MONTH(sa.`fecha`), zp.`numero`, zp.`nombre`, am.`idproductormateriaprima`, e.`noidentificacion`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`
;

-- REPORTE DE ACOPIO POR PRODUCTOR X MES + ci
-- SELECT day(sa.`fecha`) AS dia, zp.`numero`, zp.`nombre`, am.`idproductormateriaprima` AS idprod, e.`noidentificacion` AS ci, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, SUM(am.`cantidad`) AS CANT
select DAY(sa.`fecha`) as dia, zp.`numero`, zp.`nombre`, SUM(am.`cantidad`) as CANT
from acopiomateriaprima am
left join sesionacopio sa on am.`idsesionacopio` = sa.`idsesionacopio`
left join zonaproductiva zp on sa.`idzonaproductiva` = zp.`idzonaproductiva`
left join persona p on am.`idproductormateriaprima` = p.`idpersona`
left join entidad e on p.`idpersona` = e.`identidad`
where sa.`fecha` between '2019-02-01' and '2019-02-15'
and am.`cantidad` > 0
and zp.`numero` = 074
group by DAY(sa.`fecha`), zp.`numero`, zp.`nombre`
;




