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


select e.`idempleado`, bc.`idbandahorariacontrato`, bc.`idbandahoraria`, en.`noidentificacion`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, bc.`fechainicio`, bc.`fechafin`, bh.`diainicio`, bh.`horainicio`, bh.`horafin`
from bandahoraria bh
left join bandahorariacontrato bc on bh.`idbandahoraria` = bc.`idbandahoraria`
left join contratopuesto cp on bc.`idcontratopuesto` = cp.`idcontratopuesto`
left join contrato c on cp.`idcontrato` = c.`idcontrato`
left join empleado e on c.`idempleado` = e.`idempleado`
left join persona p  on e.`idempleado` = p.`idpersona`
left join entidad en on p.`idpersona` = en.`identidad`
where en.`noidentificacion` = 8048438
and bc.`fechafin` >= '2020-01-01'
-- and bh.`horainicio` = '08:00:00'
;

delete from bandahorariacontrato where idbandahorariacontrato in () ;
delete from bandahoraria where idbandahoraria in () ;

/** Cambiando Horario **/
-- UPDATE bandahoraria bh 
left join bandahorariacontrato bc on bh.`idbandahoraria` = bc.`idbandahoraria`
left join contratopuesto cp on bc.`idcontratopuesto` = cp.`idcontratopuesto`
left join contrato c on cp.`idcontrato` = c.`idcontrato`
left join empleado e on c.`idempleado` = e.`idempleado`
left join persona p  on e.`idempleado` = p.`idpersona`
left join entidad en on p.`idpersona` = en.`identidad`
set bh.`horainicio` = '05:00', bh.horafin = '13:00'
-- set bh.horafin = '18:00:00'
where en.`noidentificacion` = 6517642
and bc.`fechafin` >= '2020-01-01'
-- and bh.`horainicio` = '07:00:00'
-- and bh.idbandahoraria in (1028)
;

update SECUENCIA set VALOR=(select max(E.IDRHMARCADO)/10+1 from RHMARCADO E) where TABLA='BonoConseguido';

update bandahorariacontrato b set b.`fechafin` = '2020-12-31'
where b.`idbandahorariacontrato` in (
	
);

-- delete from bandahorariacontrato
delete from bandahoraria
where idbandahoraria in (

);


