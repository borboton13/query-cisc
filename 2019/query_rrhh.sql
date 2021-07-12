SELECT cp.`idcontratopuesto`, c.`idcontrato`, en.`identidad`, en.`noidentificacion`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, c.`fechainicio`, c.`fechafin`
FROM contratopuesto cp
JOIN contrato c ON cp.`idcontrato` = c.`idcontrato`
JOIN empleado e ON c.`idempleado` = e.`idempleado`
JOIN persona p  ON e.`idempleado` = p.`idpersona`
JOIN entidad en ON p.`idpersona`  = en.`identidad`
AND c.`fechafin` = '2019-12-31'
;


UPDATE contrato c SET c.`fechafin` = '2020-12-31'
WHERE c.`idcontrato` IN (

);




-- select e.`idempleado`, bc.`idbandahorariacontrato`, bc.`idbandahoraria`, en.`noidentificacion`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, bc.`fechainicio`, bc.`fechafin`, bh.`diainicio`, bh.`horainicio`, bh.`horafin`
SELECT e.`idempleado`, en.`noidentificacion`, COUNT(bc.`idbandahorariacontrato`)
FROM bandahoraria bh
LEFT JOIN bandahorariacontrato bc ON bh.`idbandahoraria` = bc.`idbandahoraria`
LEFT JOIN contratopuesto cp ON bc.`idcontratopuesto` = cp.`idcontratopuesto`
LEFT JOIN contrato c ON cp.`idcontrato` = c.`idcontrato`
LEFT JOIN empleado e ON c.`idempleado` = e.`idempleado`
LEFT JOIN persona p  ON e.`idempleado` = p.`idpersona`
LEFT JOIN entidad en ON p.`idpersona` = en.`identidad`
WHERE bc.`fechafin` >= '2020-01-01'
GROUP BY e.`idempleado`, en.`noidentificacion`
;



DELETE FROM bandahorariacontrato WHERE idbandahorariacontrato IN (4120, 4121, 4122, 4123, 4124, 4125, 4126, 4127, 4128, 4129, 4130, 4131);
DELETE FROM bandahoraria WHERE idbandahoraria IN (4120, 4121, 4122, 4123, 4124, 4125, 4126, 4127, 4128, 4129, 4130, 4131);


-- Horario del Personal
SELECT c.`fechafin`, e.`idempleado`, bc.`idbandahorariacontrato`, bc.`idbandahoraria`, en.`noidentificacion`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, bc.`fechainicio`, bc.`fechafin`, bh.`diainicio`, bh.`horainicio`, bh.`horafin`
FROM bandahoraria bh
LEFT JOIN bandahorariacontrato bc ON bh.`idbandahoraria` = bc.`idbandahoraria`
LEFT JOIN contratopuesto cp ON bc.`idcontratopuesto` = cp.`idcontratopuesto`
LEFT JOIN contrato c ON cp.`idcontrato` = c.`idcontrato`
LEFT JOIN empleado e ON c.`idempleado` = e.`idempleado`
LEFT JOIN persona p  ON e.`idempleado` = p.`idpersona`
LEFT JOIN entidad en ON p.`idpersona` = en.`identidad`
WHERE en.`noidentificacion` = 8008156 
-- and bc.`fechafin` = '2021-12-31'
AND c.`fechafin` >= '2021-01-01'
-- and bh.`horainicio` = '08:00:00'
;


/** Cambiando Horario **/
-- UPDATE bandahoraria bh 
LEFT JOIN bandahorariacontrato bc ON bh.`idbandahoraria` = bc.`idbandahoraria`
LEFT JOIN contratopuesto cp ON bc.`idcontratopuesto` = cp.`idcontratopuesto`
LEFT JOIN contrato c ON cp.`idcontrato` = c.`idcontrato`
LEFT JOIN empleado e ON c.`idempleado` = e.`idempleado`
LEFT JOIN persona p  ON e.`idempleado` = p.`idpersona`
LEFT JOIN entidad en ON p.`idpersona` = en.`identidad`
SET bh.`horainicio` = '06:00:00', bh.horafin = '13:00:00'
-- set bh.`horainicio` = '14:00:00'
-- set bh.horafin = '17:00:00'
-- set bc.fechafin = '2020-12-31'
WHERE en.`noidentificacion` = 8008156
AND bc.`fechafin` >= '2021-01-01'
-- and bh.`horainicio` = '13:30:00'
AND bh.idbandahoraria IN (
3868,
3869,
3870,
3871,
3872,
3873
);

UPDATE SECUENCIA SET VALOR=(SELECT MAX(E.IDRHMARCADO)/10+1 FROM RHMARCADO E) WHERE TABLA='BonoConseguido';

UPDATE bandahorariacontrato b SET b.`fechainicio` = '2020-09-01'
WHERE b.`idbandahorariacontrato` IN (

);

UPDATE bandahoraria b SET b.`horainicio` = '08:00:00'
WHERE b.`idbandahoraria` IN (
);


-- delete from bandahorariacontrato
-- delete from bandahoraria
WHERE idbandahoraria IN (

);

-- eliminando planillas generadas
DELETE FROM reportecontrol 		 	WHERE idplanillagenerada IN (494, 495, 490, 491, 482, 483, 484);
DELETE FROM `planillafiscalporcategoria` 	WHERE idplanillagenerada IN (494, 495, 490, 491, 482, 483, 484);
DELETE FROM `planillatributariaporcategoria` 	WHERE idplanillagenerada IN (494, 495, 490, 491, 482, 483, 484);
DELETE FROM `planillaadministrativos` 		WHERE idplanillagenerada IN (494, 495, 490, 491, 482, 483, 484);
DELETE FROM `planillagenerada` 			WHERE idplanillagenerada IN (494, 495, 490, 491, 482, 483, 484);

-- Actualizar Luis Ferrufino
UPDATE planillafiscalporcategoria p
SET 	p.`liquidopagable` 	= 5906.92,
	p.`afplab_individual` 	= p.`afplab_individual`,
	p.`afplab_riesgocomun`  = 0,
	p.`afplab_solidario`	= p.`afplab_solidario`,
	p.`totaldescuentos` 	= 730.08
WHERE p.`idplanillafiscalporcategoria` = 20026;

-- Actualizar Juana Pozo
UPDATE planillafiscalporcategoria p
SET 	p.`liquidopagable` 	= 12470.63,
	p.`afplab_individual` 	= 0,
	p.`afplab_riesgocomun`  = p.`afplab_riesgocomun`,
	p.`afplab_solidario`	= p.`afplab_solidario`,
	p.`totaldescuentos` 	= 347.37
WHERE p.`idplanillafiscalporcategoria` = 20043;

-- Actualizar para Eliseo
UPDATE planillafiscalporcategoria p
SET 	p.`liquidopagable` 	= 15729.64,
	p.`afplab_individual` 	= 0,
	p.`afplab_riesgocomun`  = 0,
	p.`totaldescuentos` 	= 188.36
WHERE p.`idplanillafiscalporcategoria` = 20044;

-- Actualizar Simon Calucho
UPDATE planillafiscalporcategoria p
SET 	p.`liquidopagable` 	= 2597.02,
	p.`afplab_individual` 	= p.`afplab_individual`,
	p.`afplab_riesgocomun`  = 0,
	p.`afplab_solidario`	= p.`afplab_solidario`,
	p.`totaldescuentos` 	= 320.98
WHERE p.`idplanillafiscalporcategoria` = 20048;


SELECT p.`idplanillafiscalporcategoria`, p.`idempleado`, p.`ci`, p.`nombre`, 
p.`retencionafp`, p.afplab_individual, p.afplab_riesgocomun, p.afplab_solidario, p.`totalganado`, p.totaldescuentos, p.`liquidopagable`
FROM `planillafiscalporcategoria` p
WHERE p.`idplanillagenerada` = 486
AND p.`ci` IN (
815059, 2862262, 2868139, 921886
) ;

SELECT *
FROM planillaadministrativos p
WHERE p.`idplanillagenerada` = 486
AND p.`idempleado` IN (401, 445, 576, 582)
;
-- ACTUALIZANDO PLANILLAADMINISTRATIVOS (PARA UNINET)
-- LUIS FERRUFINO GUTIERREZ
UPDATE planillaadministrativos p 
SET 	p.`liquidopagable` = 5906.92,
	p.`totaldescuento` = 730.08
WHERE p.`idplanillaadministrativos` = 20100
;

-- JUANA DE DIOS POZO SEJAS
UPDATE planillaadministrativos p 
SET 	p.`liquidopagable` = 12470.63,
	p.`totaldescuento` = 347.37
WHERE p.`idplanillaadministrativos` = 20117
;

-- ELISEO CAMACHO ORELLANA
UPDATE planillaadministrativos p 
SET 	p.`liquidopagable` = 15729.64,
	p.`totaldescuento` = 188.36
WHERE p.`idplanillaadministrativos` = 20118
;

-- SIMON CALUCHO JIMENEZ
UPDATE planillaadministrativos p 
SET 	p.`liquidopagable` = 2597.02,
	p.`totaldescuento` = 320.98
WHERE p.`idplanillaadministrativos` = 20122
;

