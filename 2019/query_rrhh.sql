select cp.`idcontratopuesto`, c.`idcontrato`, en.`identidad`, en.`noidentificacion`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, c.`fechainicio`, c.`fechafin`
from contratopuesto cp
join contrato c on cp.`idcontrato` = c.`idcontrato`
join empleado e on c.`idempleado` = e.`idempleado`
join persona p  on e.`idempleado` = p.`idpersona`
join entidad en on p.`idpersona`  = en.`identidad`
and c.`fechafin` = '2019-12-31'
;


update contrato c set c.`fechafin` = '2020-12-31'
where c.`idcontrato` in (

);




-- select e.`idempleado`, bc.`idbandahorariacontrato`, bc.`idbandahoraria`, en.`noidentificacion`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, bc.`fechainicio`, bc.`fechafin`, bh.`diainicio`, bh.`horainicio`, bh.`horafin`
select e.`idempleado`, en.`noidentificacion`, count(bc.`idbandahorariacontrato`)
from bandahoraria bh
left join bandahorariacontrato bc on bh.`idbandahoraria` = bc.`idbandahoraria`
left join contratopuesto cp on bc.`idcontratopuesto` = cp.`idcontratopuesto`
left join contrato c on cp.`idcontrato` = c.`idcontrato`
left join empleado e on c.`idempleado` = e.`idempleado`
left join persona p  on e.`idempleado` = p.`idpersona`
left join entidad en on p.`idpersona` = en.`identidad`
where bc.`fechafin` >= '2020-01-01'
group by e.`idempleado`, en.`noidentificacion`
;



delete from bandahorariacontrato where idbandahorariacontrato in () ;
delete from bandahoraria where idbandahoraria in () ;


-- Horario del Personal
select c.`fechafin`, e.`idempleado`, bc.`idbandahorariacontrato`, bc.`idbandahoraria`, en.`noidentificacion`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, bc.`fechainicio`, bc.`fechafin`, bh.`diainicio`, bh.`horainicio`, bh.`horafin`
from bandahoraria bh
left join bandahorariacontrato bc on bh.`idbandahoraria` = bc.`idbandahoraria`
left join contratopuesto cp on bc.`idcontratopuesto` = cp.`idcontratopuesto`
left join contrato c on cp.`idcontrato` = c.`idcontrato`
left join empleado e on c.`idempleado` = e.`idempleado`
left join persona p  on e.`idempleado` = p.`idpersona`
left join entidad en on p.`idpersona` = en.`identidad`
where bc.`fechafin` = '2020-12-31'
and c.`fechafin` >= '2021-01-01'
-- and en.`noidentificacion` = 8008156
-- and bh.`horainicio` = '08:00:00'
;

-- 418
-- 412

/** Cambiando Horario **/
-- UPDATE bandahoraria bh 
left join bandahorariacontrato bc on bh.`idbandahoraria` = bc.`idbandahoraria`
left join contratopuesto cp on bc.`idcontratopuesto` = cp.`idcontratopuesto`
left join contrato c on cp.`idcontrato` = c.`idcontrato`
left join empleado e on c.`idempleado` = e.`idempleado`
left join persona p  on e.`idempleado` = p.`idpersona`
left join entidad en on p.`idpersona` = en.`identidad`
-- set bh.`horainicio` = '07:00:00', bh.horafin = '12:00:00'
-- set bh.`horainicio` = '14:00:00'
set bh.horafin = '12:00:00'
-- set bc.fechafin = '2020-12-31'
where en.`noidentificacion` = 8008156
and bc.`fechafin` >= '2020-12-01'
-- and bh.`horainicio` = '13:30:00'
and bh.idbandahoraria in (3873)
;

update SECUENCIA set VALOR=(select max(E.IDRHMARCADO)/10+1 from RHMARCADO E) where TABLA='BonoConseguido';

update bandahorariacontrato b set b.`fechainicio` = '2020-09-01'
where b.`idbandahorariacontrato` in (

);

update bandahoraria b set b.`horainicio` = '08:00:00'
where b.`idbandahoraria` in (
);


-- delete from bandahorariacontrato
-- delete from bandahoraria
where idbandahoraria in (

);

-- eliminando planillas generadas
delete from reportecontrol 		 	where idplanillagenerada in (441);
delete from `planillafiscalporcategoria` 	where idplanillagenerada in (441);
delete from `planillatributariaporcategoria` 	where idplanillagenerada in (441);
delete from `planillaadministrativos` 		where idplanillagenerada in (441);
delete from `planillagenerada` 			where idplanillagenerada in (441);

-- Actualizar Luis Ferrufino
update planillafiscalporcategoria p
set 	p.`liquidopagable` 	= 4237.28,
	p.`afplab_individual` 	= p.`afplab_individual`,
	p.`afplab_riesgocomun`  = 0,
	p.`afplab_solidario`	= p.`afplab_solidario`,
	p.`totaldescuentos` 	= 523.72
where p.`idplanillafiscalporcategoria` = 18846;

-- Actualizar Juana Pozo
update planillafiscalporcategoria p
set 	p.`liquidopagable` 	= 12470.63,
	p.`afplab_individual` 	= 0,
	p.`afplab_riesgocomun`  = p.`afplab_riesgocomun`,
	p.`afplab_solidario`	= p.`afplab_solidario`,
	p.`totaldescuentos` 	= 347.37
where p.`idplanillafiscalporcategoria` = 18863;

-- Actualizar para Eliseo
update planillafiscalporcategoria p
set 	p.`liquidopagable` 	= 15729.64,
	p.`afplab_individual` 	= 0,
	p.`afplab_riesgocomun`  = 0,
	p.`totaldescuentos` 	= 188.36
where p.`idplanillafiscalporcategoria` = 18864;

-- Actualizar Simon Calucho
update planillafiscalporcategoria p
set 	p.`liquidopagable` 	= 2597.02,
	p.`afplab_individual` 	= p.`afplab_individual`,
	p.`afplab_riesgocomun`  = 0,
	p.`afplab_solidario`	= p.`afplab_solidario`,
	p.`totaldescuentos` 	= 320.98
where p.`idplanillafiscalporcategoria` = 18868;



select *
from `planillafiscalporcategoria` p
where p.`idplanillagenerada` = 461
and p.`ci` in (
815059, 2862262, 2868139, 921886
) ;



