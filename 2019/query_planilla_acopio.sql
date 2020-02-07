-- ----------------------------------------------------------------------
-- TOTALES PLANILLAS DE PAGO x GAB
-- ----------------------------------------------------------------------
select 
        Z.NUMERO as GAB,
        Z.NOMBRE as ZONA_PRODUCTIVA,
        P.IDZONAPRODUCTIVA, 
        P.TOTALPESADOXGAB as CANT_PESAJE_LT, 
        P.TOTALMONTOACOPIOADOXGAB as TOTAL_BS, 
        P.TOTALRETENCIONESXGAB as RET, 
        P.TOTALALCOHOLXGAB as ALCOHOL, 
        P.TOTALCONCENTRADOSXGAB as CONCENT,
        P.TOTALCREDITOXGAB as CREDITO,
        P.TOTALVETERINARIOXGAB as VETER,
        P.TOTALYOGURDXGAB as YOG,
        P.TOTALTACHOSXGAB as TACHOS,
        P.TOTALOTROSDECUENTOSXGAB as OTROSD,
        P.TOTALAJUSTEXGAB as AJUSTE,
        P.TOTALOTROSINGRESOSXGAB as OTROSI,
        P.TOTALIQUIDOXGAB as LIQUIDO_PAG
from PLANILLAPAGOMATERIAPRIMA P
left join ZONAPRODUCTIVA Z on P.IDZONAPRODUCTIVA = Z.IDZONAPRODUCTIVA
where P.FECHAINICIO = '2019-02-01'
and   P.FECHAFIN    = '2019-02-15'
;
-- ----------------------------------------------------------------------

select *
from REGISTROACOPIO R
left join PLANILLAACOPIO P on R.IDPLANILLAACOPIO = P.IDPLANILLAACOPIO
where P.FECHA between '2018-01-01' and '2018-01-15'
;

select month(P.FECHA) as MES, sum(R.CANTIDADRECIBIDA) as RECIBIDA, sum(R.CANTIDADPESADA) as PESADA, ((sum(R.CANTIDADPESADA)) * 3.2) as PESADA_BS
from REGISTROACOPIO R
left join PLANILLAACOPIO P on R.IDPLANILLAACOPIO = P.IDPLANILLAACOPIO
-- WHERE P.FECHA BETWEEN TO_DATE('01/02/2015','DD/MM/YYYY') AND TO_DATE('28/02/2015','DD/MM/YYYY')
where P.FECHA between '2019-01-01' and '2019-12-31'
group by month(P.FECHA)
;

select day(P.FECHA) as dia, z.`idzonaproductiva`, z.`numero`, z.`nombre`, sum(R.CANTIDADRECIBIDA) as RECIBIDA, sum(R.CANTIDADPESADA) as PESADA
from REGISTROACOPIO R
left join PLANILLAACOPIO P on R.IDPLANILLAACOPIO = P.IDPLANILLAACOPIO
left join zonaproductiva z on r.`idzonaproductiva` = z.`idzonaproductiva`
where P.FECHA between '2019-02-01' and '2019-02-15'
and z.`numero` = 074
group by day(P.FECHA), z.`idzonaproductiva`, z.`numero`, z.`nombre`
;

select p.`fecha`, sum(R.CANTIDADRECIBIDA) as RECIBIDA, sum(R.CANTIDADPESADA) as PESADA
from REGISTROACOPIO R
left join PLANILLAACOPIO P on R.IDPLANILLAACOPIO = P.IDPLANILLAACOPIO
where P.FECHA between '2019-10-01' and '2019-10-31'
group by p.`fecha`
;


select * from planillapagomateriaprima;
select * from `descuentproductmateriaprima`;

-- ---------------------------------------------------------------
-- --------------- PLANILLA DE PAGO X QUINCENA -------------------
-- ---------------------------------------------------------------
select  r.`idregistropagomateriaprima`, p.`idplanillapagomateriaprima`, z.`idzonaproductiva`, d.`iddescuentproductmateriaprima`,
	p.`fechainicio`,
	z.`nombre`, z.`numero`,
	pe.`idpersona`, e.`noidentificacion` as ci, pe.`nombres`, pe.`apellidopaterno`, pe.`apellidomaterno`,
	r.`cantidadtotal` 		as Cant, 
	r.`totalpagoacopio` 		as Total, 
	r.`ga`,
	d.`retencion`			as Ret,
	d.`alcohol`,
	d.`concentrados`,
	d.`credito`,
	d.`veterinario`,
	d.`yogurt`,
	d.`tachos`,
	d.`otrosdescuentos` 		as Otros,
	r.`descuentoreserva`		as Reser,
	r.`ajustezonaproductiva` 	as Ajuste,
	d.`otrosingresos`		as Ingresos,
	r.`liquidopagable`		as LiquidoP,
	 r.`totalganado` -- 
from registropagomateriaprima r
join descuentproductmateriaprima d 	on r.`iddescuentproductmateriaprima` = d.`iddescuentproductmateriaprima`
join persona pe        			on d.`idproductormateriaprima` = pe.`idpersona`
join entidad e 				on pe.`idpersona` = e.`identidad`
join planillapagomateriaprima p 	on r.`idplanillapagomateriaprima` = p.`idplanillapagomateriaprima`
join zonaproductiva z 			on p.`idzonaproductiva` = z.`idzonaproductiva`
where p.fechainicio = '2019-09-01'
-- AND z.`numero` = 001
-- AND pe.`idpersona` IN (352)
and r.`liquidopagable` <> 0
;


-- ---------------------------------------------------------------
-- --------------- PLANILLA DE PAGO X QUINCENA + CUENTAS -------------------
-- ---------------------------------------------------------------
select  /* r.`idregistropagomateriaprima`, p.`idplanillapagomateriaprima`, z.`idzonaproductiva`, d.`iddescuentproductmateriaprima`,*/
	/*p.`fechainicio`,*/
	z.`nombre` as gab, 
	-- z.`numero`,
	-- pe.`idpersona`, 
	e.`noidentificacion` as ci, pe.`nombres`, pe.`apellidopaterno`, pe.`apellidomaterno`,
	r.`cantidadtotal` 		as Cant, 
	r.`totalpagoacopio` 		as Total, 
	/*r.`ga`,
	d.`retencion`			as Ret,
	d.`alcohol`,
	d.`concentrados`,
	d.`credito`,
	d.`veterinario`,
	d.`yogurt`,
	d.`tachos`,
	d.`otrosdescuentos` 		as Otros,
	r.`descuentoreserva`		as Reser,
	r.`ajustezonaproductiva` 	as Ajuste,
	d.`otrosingresos`		as Ingresos,*/
	r.`liquidopagable`		as LiquidoP,
	pr.`numerocuenta`
	-- r.`totalganado` -- 
from registropagomateriaprima r
join descuentproductmateriaprima d 	on r.`iddescuentproductmateriaprima` = d.`iddescuentproductmateriaprima`
join persona pe        			on d.`idproductormateriaprima` = pe.`idpersona`
join productormateriaprima pr 		on pe.`idpersona` = pr.`idproductormateriaprima`
join entidad e 				on pe.`idpersona` = e.`identidad`
join planillapagomateriaprima p 	on r.`idplanillapagomateriaprima` = p.`idplanillapagomateriaprima`
join zonaproductiva z 			on p.`idzonaproductiva` = z.`idzonaproductiva`
where p.fechainicio = '2020-01-16'
and r.`liquidopagable` <> 0
;


select  z.`idzonaproductiva`, z.`nombre`, z.`numero`, sum(r.`cantidadtotal`) as cantidad
from registropagomateriaprima r
join descuentproductmateriaprima d 	on r.`iddescuentproductmateriaprima` = d.`iddescuentproductmateriaprima`
join persona pe        			on d.`idproductormateriaprima` = pe.`idpersona`
join entidad e 				on pe.`idpersona` = e.`identidad`
join planillapagomateriaprima p 	on r.`idplanillapagomateriaprima` = p.`idplanillapagomateriaprima`
join zonaproductiva z 			on p.`idzonaproductiva` = z.`idzonaproductiva`
where p.fechainicio = '2019-02-01'
-- AND r.`liquidopagable` <> 0
group by z.`idzonaproductiva`, z.`nombre`, z.`numero`
;



-- ---------------------------------------------------------------
-- ---------------------------------------------------------------
-- --------------- REPORTE TOTAL X PRODUCTOR A PARTIR PLANILLA ---
-- ---------------------------------------------------------------
select  
	z.`nombre`, z.`numero`,
	pe.`nombres`, pe.`apellidopaterno`, pe.`apellidomaterno`,
	sum(r.`cantidadtotal`) 		as Cant_LT
	-- r.`totalpagoacopio` 		AS Total
from registropagomateriaprima r
join descuentproductmateriaprima d 	on r.`iddescuentproductmateriaprima` = d.`iddescuentproductmateriaprima`
join persona pe        			on d.`idproductormateriaprima` = pe.`idpersona`
join planillapagomateriaprima p 	on r.`idplanillapagomateriaprima` = p.`idplanillapagomateriaprima`
join zonaproductiva z 			on p.`idzonaproductiva` = z.`idzonaproductiva`
where p.fechainicio between '2017-08-01' and '2017-08-31'
-- AND z.`numero` = 074
and r.`liquidopagable` <> 0
group by z.`nombre`, z.`numero`, pe.`nombres`, pe.`apellidopaterno`, pe.`apellidomaterno`
;
-- ---------------------------------------------------------------
-- ---------------------------------------------------------------
-- ---------------------------------------------------------------
-- --------------- PLANILLA DE PAGO X QUINCENA (PARA DEVOLUCION) -------------------
-- ---------------------------------------------------------------
select  
	/* z.`nombre`, z.`numero`, */
	pe.`nombres`, pe.`apellidopaterno`, pe.`apellidomaterno`,
	sum(r.`cantidadtotal`) 		as Cant, 
	sum(r.`totalpagoacopio`)	as TotalBs
from registropagomateriaprima r
join descuentproductmateriaprima d 	on r.`iddescuentproductmateriaprima` = d.`iddescuentproductmateriaprima`
join persona pe        			on d.`idproductormateriaprima` = pe.`idpersona`
join planillapagomateriaprima p 	on r.`idplanillapagomateriaprima` = p.`idplanillapagomateriaprima`
join zonaproductiva z 			on p.`idzonaproductiva` = z.`idzonaproductiva`
where p.fechainicio between '2016-09-01' and '2016-11-15'
-- AND z.`numero` = 091
and r.`liquidopagable` <> 0
group by pe.`nombres`, pe.`apellidopaterno`, pe.`apellidomaterno`
;


-- ---------------------------------------------------
-- ---------- PESAJE X FECHA -------------------------
-- ---------------------------------------------------
-- SELECT pl.idplanillaacopio, pl.fecha, pl.totalpesado, ra.idregistroacopio, zo.nombre, zo.numero, ra.cantidadrecibida, ra.cantidadpesada, ra.cantidadrechazada, ra.idzonaproductiva
select zo.nombre, zo.numero, sum(ra.cantidadrecibida) as cantidadrecibida, sum(ra.cantidadpesada) as cantidadpesada
from REGISTROACOPIO RA
left join PLANILLAACOPIO PL on ra.idplanillaacopio = pl.idplanillaacopio
left join zonaproductiva ZO on ra.idzonaproductiva = zo.idzonaproductiva
where pl.fecha between '2019-02-01' and '2019-02-15'
group by zo.nombre, zo.numero
;

select se.idzonaproductiva, zo.nombre, zo.numero, sum(ac.cantidad) as cantidad
from acopiomateriaprima ac
left join sesionacopio se   on ac.idsesionacopio   = se.idsesionacopio
left join zonaproductiva zo on se.idzonaproductiva = zo.idzonaproductiva
where se.fecha between '2018-12-16' and '2018-12-31'
group by se.idzonaproductiva, zo.nombre, zo.numero
;



select sum(totalga)
from planillapagomateriaprima p
where p.`fechainicio` = '2016-05-01'
;

-- SQL PLANILLA
select zp.`nombre`, p.`idpersona`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, ppm.`preciounitario`, 
	sum(rpm.cantidadtotal) as cantidadtotal, 
	sum(rpm.`totalpagoacopio`) as totalpagoacopio, 
	sum(rpm.`liquidopagable`) as liquidopagable,
	sum(dpm.RETENCION) as RETENCION,
	sum(dpm.ALCOHOL) as ALCOHOL,
	sum(dpm.CONCENTRADOS) as CONCENTRADOS,
	sum(dpm.CREDITO) as CREDITO,
	sum(dpm.VETERINARIO) as VETERINARIO,
	sum(dpm.YOGURT) as YOGURT,
	sum(dpm.TACHOS) as TACHOS,
	sum(dpm.OTROSDESCUENTOS) as OTROSDESCUENTOS,
	sum(rpm.AJUSTEZONAPRODUCTIVA) as AJUSTEZONAPRODUCTIVA,
	sum(dpm.OTROSINGRESOS) as OTROSINGRESOS,
	sum(rpm.DESCUENTORESERVA) as DESCUENTORESERVA,
	sum(rpm.GA) as GA
from PLANILLAPAGOMATERIAPRIMA ppm
join REGISTROPAGOMATERIAPRIMA rpm 	on ppm.`idplanillapagomateriaprima`    = rpm.`idplanillapagomateriaprima`
join DESCUENTPRODUCTMATERIAPRIMA dpm 	on rpm.`iddescuentproductmateriaprima` = dpm.`iddescuentproductmateriaprima` 
join PRODUCTORMATERIAPRIMA pm 		on dpm.`idproductormateriaprima`       = pm.`idproductormateriaprima` 
join ZONAPRODUCTIVA zp 			on ppm.`idzonaproductiva` 	       = zp.`idzonaproductiva`
join persona p 				on pm.`idproductormateriaprima`        = p.`idpersona`
where ppm.`fechainicio` >= '2019-02-01' 
and   ppm.`fechafin`    <= '2019-02-15'
and rpm.`totalpagoacopio` > 0
-- and zp.`numero` = 074
group by zp.`nombre`, p.`idpersona`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, ppm.`preciounitario`
;


--

select -- zp.`nombre`, p.`idpersona`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, ppm.`preciounitario`, 
	sum(rpm.cantidadtotal) as cantidadtotal, 
	sum(rpm.`totalpagoacopio`) as totalpagoacopio, 
	sum(rpm.`liquidopagable`) as liquidopagable,
	sum(dpm.RETENCION) as RETENCION,
	sum(dpm.ALCOHOL) as ALCOHOL,
	sum(dpm.CONCENTRADOS) as CONCENTRADOS,
	sum(dpm.CREDITO) as CREDITO,
	sum(dpm.VETERINARIO) as VETERINARIO,
	sum(dpm.YOGURT) as YOGURT,
	sum(dpm.TACHOS) as TACHOS,
	sum(dpm.OTROSDESCUENTOS) as OTROSDESCUENTOS,
	sum(rpm.AJUSTEZONAPRODUCTIVA) as AJUSTEZONAPRODUCTIVA,
	sum(dpm.OTROSINGRESOS) as OTROSINGRESOS,
	sum(rpm.DESCUENTORESERVA) as DESCUENTORESERVA,
	sum(rpm.GA) as GA
from PLANILLAPAGOMATERIAPRIMA ppm
join REGISTROPAGOMATERIAPRIMA rpm 	on ppm.`idplanillapagomateriaprima`    = rpm.`idplanillapagomateriaprima`
join DESCUENTPRODUCTMATERIAPRIMA dpm 	on rpm.`iddescuentproductmateriaprima` = dpm.`iddescuentproductmateriaprima` 
join PRODUCTORMATERIAPRIMA pm 		on dpm.`idproductormateriaprima`       = pm.`idproductormateriaprima` 
join ZONAPRODUCTIVA zp 			on ppm.`idzonaproductiva` 	       = zp.`idzonaproductiva`
join persona p 				on pm.`idproductormateriaprima`        = p.`idpersona`
where ppm.`fechainicio` >= '2018-02-01' 
and   ppm.`fechafin`    <= '2018-02-15'
and rpm.`totalpagoacopio` > 0
-- GROUP BY -- zp.`nombre`, p.`idpersona`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, ppm.`preciounitario`
;



-- --------------------------------------------------------------------------------
-- --------------- PLANILLA DE PAGO X QUINCENA + RETENCION 0.20 -------------------
-- --------------------------------------------------------------------------------
select  d.`idproductormateriaprima`,
 	z.`nombre` as GAB, z.`numero` as Nro, e.`noidentificacion` as CI, pe.`Nombres`, pe.`ApellidoPaterno`, pe.`ApellidoMaterno`,
	r.`cantidadtotal` 		as Cantidad,
	@ret:=r.`cantidadtotal` * 0.2 	as Retenc, 
	-- r.`totalpagoacopio` 		AS Total, 
	-- r.`ga`,
	-- d.`retencion`			AS Ret,
	-- d.`alcohol`,
	-- d.`concentrados`,
	-- d.`credito`,
	-- d.`veterinario`,
	-- d.`yogurt`,
	-- d.`tachos`,
	-- d.`otrosdescuentos` 		AS Otros,
	-- r.`descuentoreserva`		AS Reser,
	-- r.`ajustezonaproductiva` 	AS Ajuste,
	-- d.`otrosingresos`		AS Ingresos,
	r.`liquidopagable`		as TotalBP,
	r.`liquidopagable` - @ret 	as Total_Pagar
	-- r.`totalganado` 
from registropagomateriaprima r
join descuentproductmateriaprima d 	on r.`iddescuentproductmateriaprima` = d.`iddescuentproductmateriaprima`
join persona pe        			on d.`idproductormateriaprima` = pe.`idpersona`
join entidad e 				on pe.`idpersona` = e.`identidad`
join planillapagomateriaprima p 	on r.`idplanillapagomateriaprima` = p.`idplanillapagomateriaprima`
join zonaproductiva z 			on p.`idzonaproductiva` = z.`idzonaproductiva`
where p.fechainicio = '2019-02-01'
-- AND z.`numero` = 001
and r.`liquidopagable` <> 0
order by z.`nombre`, pe.`nombres`
;
-- ---------------------------------------------------------------


select *
from zonaproductiva z
where z.`nombre` like '%ENE%'
;

select p.`idproductormateriaprima`, pe.`nombres`, pe.`apellidopaterno`, pe.`apellidomaterno`, p.`idzonaproductiva`
from productormateriaprima p
join persona pe on p.`idproductormateriaprima` = pe.`idpersona`
-- where pe.`nombres` like '%TANI%' and pe.`apellidopaterno` like '%CA%'
where p.`idzonaproductiva` = 83
;

-- CAMBIANDO GAB
update productormateriaprima p set p.`idzonaproductiva` = 74 where p.`idproductormateriaprima` = 169;
update productormateriaprima p set p.`idzonaproductiva` = 74 where p.`idproductormateriaprima` = 170;

update productormateriaprima p set p.`idzonaproductiva` = 153 where p.`idproductormateriaprima` = 110;
update productormateriaprima p set p.`idzonaproductiva` = 153 where p.`idproductormateriaprima` = 106;
update productormateriaprima p set p.`idzonaproductiva` = 153 where p.`idproductormateriaprima` = 100;

update productormateriaprima p set p.`idzonaproductiva` = 60 where p.`idproductormateriaprima` = 391;
update productormateriaprima p set p.`idzonaproductiva` = 60 where p.`idproductormateriaprima` = 392;
update productormateriaprima p set p.`idzonaproductiva` = 60 where p.`idproductormateriaprima` = 393;
update productormateriaprima p set p.`idzonaproductiva` = 60 where p.`idproductormateriaprima` = 395;
update productormateriaprima p set p.`idzonaproductiva` = 60 where p.`idproductormateriaprima` = 396;
update productormateriaprima p set p.`idzonaproductiva` = 60 where p.`idproductormateriaprima` = 397;
update productormateriaprima p set p.`idzonaproductiva` = 60 where p.`idproductormateriaprima` = 398;
update productormateriaprima p set p.`idzonaproductiva` = 60 where p.`idproductormateriaprima` = 525;

update productormateriaprima p set p.`idzonaproductiva` = 69 where p.`idproductormateriaprima` = 373; -- UCUREÑA I
update productormateriaprima p set p.`idzonaproductiva` = 69 where p.`idproductormateriaprima` = 363; -- UCUREÑA I
update productormateriaprima p set p.`idzonaproductiva` = 69 where p.`idproductormateriaprima` = 365; -- UCUREÑA I



