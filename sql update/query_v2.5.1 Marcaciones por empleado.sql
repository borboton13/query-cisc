/** v2.5.1 **/

-- 22/08/2018 Marcaciones x empleado

INSERT INTO funcionalidad (idfuncionalidad, codigo, descripcion, idmodulo, permiso, nombrerecurso, idcompania) VALUES (243, 'RHMARK', NULL, 4, 1, 'Functionality.reports.rrhh.rhmark', 1);
INSERT INTO funcionalidad (idfuncionalidad, codigo, descripcion, idmodulo, permiso, nombrerecurso, idcompania) VALUES (244, 'REPORTMARKSTATE', NULL, 4, 1, 'Functionality.reports.finances.markStateReport', 1);
INSERT INTO funcionalidad (idfuncionalidad, codigo, descripcion, idmodulo, permiso, nombrerecurso, idcompania) VALUES (245, 'MOVEMENTTYPEWIN', NULL, 4, 1, 'menu.employees.configuration.salaryMovement.movementType.win', 1);

INSERT INTO modulo (idmodulo, nombrerecurso, idcompania) VALUES (9, 'receivables', 1);
INSERT INTO modulocompania (idcompania, idmodulo, activo) VALUES (1, 9, 1);

-- INSERT INTO funcionalidad (idfuncionalidad, codigo, descripcion, idmodulo, permiso, nombrerecurso, idcompania) VALUES (246, 'ROTATORYFUND', NULL, 9, 15, 'RotatoryFund.rotatoryFund', 1);
INSERT INTO funcionalidad (idfuncionalidad, codigo, descripcion, idmodulo, permiso, nombrerecurso, idcompania) VALUES (247, 'ROTATORYFUNDCOLLECTION', NULL, 9, 15, 'menu.finances.rotatoryFundCollection', 1);
INSERT INTO funcionalidad (idfuncionalidad, codigo, descripcion, idmodulo, permiso, nombrerecurso, idcompania) VALUES (248, 'ROTATORYFUNDDOCUMENTTYPE', NULL, 9, 15, 'menu.finances.receivables.configuration.documentType', 1);

INSERT INTO funcionalidad (idfuncionalidad, codigo, descripcion, idmodulo, permiso, nombrerecurso, idcompania) VALUES (249, 'FINANCEUSER', NULL, 9, 1, 'RotatoryFundDocumentType.financeUser', 1);




-- CREATE OR REPLACE VIEW vmarcado AS 
SELECT r.idrhmarcado , r.`marfecha`, r.`marperid`, CONCAT(r.`marperid`, "") AS marreftarjeta, r.`marhora`, r.`control`, r.marippc, r.descripcion ,'1' AS sede, 
CONCAT(p.nombres, ' ', p.apellidopaterno, ' ', p.apellidomaterno) AS nombre
FROM rh_marcado r
LEFT JOIN empleado em ON r.`marperid` = em.`codigomarcacion`
LEFT JOIN persona p   ON em.`idempleado` = p.`idpersona` 
WHERE r.`marfecha` >= '2018-08-01'
;



-- insert into rh_marcado (control, marfecha, marperid, marhora)
SELECT 0, r.`marfecha`, r.`marperid`, r.`marhora`
FROM rhmarcado r
WHERE r.`marfecha` BETWEEN '2018-07-01' AND '2018-07-31'
;
