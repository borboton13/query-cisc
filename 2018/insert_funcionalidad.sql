SELECT MAX(idfuncionalidad)
FROM funcionalidad;
	
INSERT INTO funcionalidad (IDFUNCIONALIDAD,CODIGO,PERMISO,NOMBRERECURSO,IDMODULO, IDCOMPANIA) 
SELECT MAX(idfuncionalidad)+1,'ROTATORYFUND','15','menu.finances.rotatoryFund','5', 1
FROM funcionalidad
;

INSERT INTO funcionalidad (IDFUNCIONALIDAD,CODIGO,PERMISO,NOMBRERECURSO,IDMODULO, IDCOMPANIA) 
SELECT MAX(idfuncionalidad)+1,'OTHERRECEIVABLES','15','Functionality.finances.otherReceivables','5', 1
FROM funcionalidad
;