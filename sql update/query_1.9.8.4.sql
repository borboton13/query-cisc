
/*
insert into funcionalidad(idfuncionalidad,codigo,descripcion,idmodulo,permiso,nombrerecurso,idcompania) values (226, 'AFPRATE', NULL, 4, 15, 'Functionality.rrhh.afpRate', 1);
INSERT INTO funcionalidad(idfuncionalidad,codigo,descripcion,idmodulo,permiso,nombrerecurso,idcompania) VALUES (227, 'CNSRATE', NULL, 4, 15, 'Functionality.rrhh.cnsRate', 1);
INSERT INTO funcionalidad(idfuncionalidad,codigo,descripcion,idmodulo,permiso,nombrerecurso,idcompania) VALUES (228, 'IVARATE', NULL, 4, 15, 'Functionality.rrhh.ivaRate', 1);
INSERT INTO funcionalidad(idfuncionalidad,codigo,descripcion,idmodulo,permiso,nombrerecurso,idcompania) VALUES (229, 'SMNRATE', NULL, 4, 15, 'Functionality.rrhh.smnRate', 1);
INSERT INTO funcionalidad(idfuncionalidad,codigo,descripcion,idmodulo,permiso,nombrerecurso,idcompania) VALUES (230, 'BONUS', NULL, 4, 15, 'Functionality.rrhh.bonus', 1);
INSERT INTO funcionalidad(idfuncionalidad,codigo,descripcion,idmodulo,permiso,nombrerecurso,idcompania) VALUES (231, 'DISCHARGEDOCUMENT', NULL, 4, 15, 'menu.rrhh.payrollGeneration.dischargeDocument', 1);
INSERT INTO funcionalidad(idfuncionalidad,codigo,descripcion,idmodulo,permiso,nombrerecurso,idcompania) VALUES (232, 'VACATIONRULE', NULL, 4, 15, 'menu.employees.configuration.vacationRules', 1);
INSERT INTO funcionalidad(idfuncionalidad,codigo,descripcion,idmodulo,permiso,nombrerecurso,idcompania) VALUES (233, 'DISCOUNTRULE', NULL, 4, 15, 'menu.employees.configuration.discountRule', 1);
*/
INSERT INTO funcionalidad(idfuncionalidad,codigo,descripcion,idmodulo,permiso,nombrerecurso,idcompania) VALUES (234, 'SALARYMOVEMENTTYPE', NULL, 4, 15, 'Functionality.employees.salaryMovementType', 1);
INSERT INTO funcionalidad(idfuncionalidad,codigo,descripcion,idmodulo,permiso,nombrerecurso,idcompania) VALUES (235, 'MOVEMENTTYPEOTHERDISCOUNT', NULL, 4, 1, 'menu.employees.configuration.salaryMovement.movementType.otherDiscount', 1);
INSERT INTO funcionalidad(idfuncionalidad,codigo,descripcion,idmodulo,permiso,nombrerecurso,idcompania) VALUES (236, 'MOVEMENTTYPEOTHERINCOME', NULL, 4, 1, 'menu.employees.configuration.salaryMovement.movementType.otherIncome', 1);
INSERT INTO funcionalidad(idfuncionalidad,codigo,descripcion,idmodulo,permiso,nombrerecurso,idcompania) VALUES (237, 'MOVEMENTTYPEDISCOUNTOUTOFRETENTION', NULL, 4, 1, 'menu.employees.configuration.salaryMovement.movementType.discountOutOfRetention', 1);


UPDATE categoriapuesto 
SET 	codctaprovaguime = '1000000000',
	codctaprevindemme = '1000000000',
	codctactbhaberme = '1000000000',
	codctactbdebeme = '1000000000',
	codctagastoaguimn = '1000000000',
	codctaprovaguimn = '1000000000',
	codctagastoindemmn = '1000000000',
	codctaprevindemmn = '1000000000',
	codctactbhaber = '1000000000',
	codctactbdebe = '1000000000',
	fonpenctapatronal = '1000000000',
	segsocctapatronal = '1000000000';
	
	
INSERT INTO funcionalidad(idfuncionalidad,codigo,descripcion,idmodulo,permiso,nombrerecurso,idcompania) 
VALUES (239, 'GRANTEDBONUS', NULL, 4, 15, 'Functionality.employees.configurationTaxPayRoll.grantedBonus', 1);
