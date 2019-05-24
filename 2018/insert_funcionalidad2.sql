INSERT INTO funcionalidad (IDFUNCIONALIDAD,CODIGO,PERMISO,NOMBRERECURSO,IDMODULO, IDCOMPANIA) 
SELECT MAX(idfuncionalidad)+1,'FIXEDASSETSREPORT','1','Functionality.reports.finances.fixedAssetReport','5', 1
FROM funcionalidad
;

INSERT INTO funcionalidad (IDFUNCIONALIDAD,CODIGO,PERMISO,NOMBRERECURSO,IDMODULO, IDCOMPANIA) 
SELECT MAX(idfuncionalidad)+1,'FIXEDASSETFILEREPORT','1','Functionality.reports.finances.fixedAssetFileReport','5', 1
FROM funcionalidad
;

INSERT INTO funcionalidad (IDFUNCIONALIDAD,CODIGO,PERMISO,NOMBRERECURSO,IDMODULO, IDCOMPANIA) 
SELECT MAX(idfuncionalidad)+1,'DEPRECIATEDFIXEDASSETSREPORT','1','Functionality.reports.finances.depreciatedFixedAssetReport','5', 1
FROM funcionalidad
;
