SELECT e.`fecha`, e.`tipo_doc`, e.`no_doc`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, c.`idtipocuenta`, s.`noidentificacion`, s.`nombres`, s.`apellidopaterno`, s.`apellidomaterno`
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e 	ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a 	ON d.`cuenta` = a.`cuenta`
LEFT JOIN cuenta c 	ON d.`idcuenta` = c.`idcuenta`
LEFT JOIN socio s 	ON c.`idsocio` = s.`idsocio`
WHERE e.`fecha` BETWEEN '2019-02-01' AND '2019-02-28'
AND e.`estado` <> 'ANL'
AND d.`cuenta` = '2120110100'
AND d.`idcuenta` IN (2065)
;


SELECT d.`cuenta`, SUM(d.`debe`) AS salida, SUM(d.`haber`) AS entrada, SUM(d.`haber`) - SUM(d.`debe`) AS saldo
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e 	ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a 	ON d.`cuenta` = a.`cuenta`
LEFT JOIN cuenta c 	ON d.`idcuenta` = c.`idcuenta`
LEFT JOIN socio s 	ON c.`idsocio` = s.`idsocio`
WHERE e.`fecha` BETWEEN '2019-01-01' AND '2019-01-31'
AND e.`estado` <> 'ANL'
AND d.`cuenta` = '2120110100'
AND d.`idcuenta` IN (2065)
GROUP BY d.`cuenta`
;

SELECT SUM(d.`haber`) - SUM(d.`debe`) AS saldo
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e 	ON d.`id_tmpenc` = e.`id_tmpenc`
WHERE e.`fecha` BETWEEN '2019-01-01' AND '2017-01-31'
AND e.`estado` <> 'ANL'
AND d.`cuenta` = '2120110100'
AND d.`idcuenta` IN (2065)
-- group by d.`cuenta`
;

-- CUENTAS DPF
SELECT c.`idcuenta`, c.`fechaapertura`, c.`fechavence`, c.`nocuenta`, c.`moneda`, c.`saldo`, t.`nombre`, t.`tipo`
FROM cuenta c
JOIN tipocuenta t ON c.`idtipocuenta` = t.`idtipocuenta`
WHERE t.`tipo` = 'DPF'
;

-- CERTIFICADO APORTACION
SELECT e.`id_tmpenc`, d.`id_tmpdet`, e.`fecha`, e.`tipo_doc` AS tipo, E.`no_doc`, d.`no_trans`,  e.`glosa`,  e.`cod_prov`, d.`cuenta`, a.`descri`, d.`debe`, d.`haber`, 
d.`id_tmpenc`, e.`estado`, d.`idsocio`
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN arcgms a    ON d.`cuenta` = a.`cuenta`
WHERE e.`fecha` BETWEEN '2018-01-01' AND '2020-12-30'
-- and e.`tipo_doc` = 'CI'
AND d.`cuenta` = '3110100000'
-- and d.`idsocio` = 222
;

SELECT e.`fecha`, e.`glosa`, s.`nombres`, s.`apellidopaterno`, s.`apellidomaterno`, d.`cuenta`, d.`debe`, d.`haber`, d.`idsocio`
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN socio s ON d.`idsocio` = s.`idsocio`
WHERE d.`cuenta` = '3110100000'
;

-- REPORTE CERTIFICADOS DE APORTACION
SELECT s.idsocio, s.noidentificacion AS ci, s.nsocio, s.`nombres`, s.`apellidopaterno`, s.`apellidomaterno`, SUM(d.`debe`) AS debe, SUM(d.`haber`) AS haber, SUM(d.`haber`)-SUM(d.`debe`) AS saldo
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN socio s ON d.`idsocio` = s.`idsocio`
WHERE e.fecha <= '2020-12-31'
AND d.`cuenta` = '3110100000'
AND d.idsocio IS NOT NULL
AND e.estado <> 'ANL'
GROUP BY s.idsocio, s.noidentificacion, s.nosocio, s.nsocio, s.`nombres`, s.`apellidopaterno`, s.`apellidomaterno`
;

-- 
-- socios - personas - por ci
SELECT s.`idsocio`, s.`nombres`, s.`apellidopaterno`, s.`apellidomaterno`, s.`noidentificacion`, e.`identidad`, e.`noidentificacion`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`
FROM socio s
JOIN entidad e ON s.`noidentificacion` = e.`noidentificacion`
JOIN persona p ON e.`identidad` = p.`idpersona`
;

--
-- socios - personas - por nombres
SELECT s.`idsocio`, s.`nombres`, s.`apellidopaterno`, s.`apellidomaterno`, s.`noidentificacion`, p.`idpersona`, e.`noidentificacion`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`
FROM socio s, persona p, entidad e
WHERE s.`nombres` = p.`nombres`
AND s.`apellidopaterno` = p.`apellidopaterno`
AND s.`apellidomaterno` = p.`apellidomaterno`
AND p.`idpersona` = e.`identidad`
;

--
-- CUENTAS DE AHORRO - MOVIMIENTOS
SELECT e.`id_tmpenc`, e.`fecha`, e.`estado`, e.`tipo_doc`, e.`no_doc`, d.`id_tmpdet`, d.`idcuenta`, c.`nocuenta`, 
s.`nombres`, s.`apellidopaterno`, d.`debe`, d.`haber`, d.`debeme`, d.`haberme`
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN cuenta c ON d.`idcuenta` = c.`idcuenta`
LEFT JOIN socio s ON c.`idsocio` = s.`idsocio`
WHERE d.`idcuenta` IS NOT NULL
AND c.`nocuenta` IN ( 200519, 100338)
ORDER BY e.`fecha`, d.`id_tmpdet`
;

-- CUENTAS DE AHORRO - SALDO
SELECT s.`idsocio`, c.idcuenta, t.nombre, s.`nombres`, s.`apellidopaterno`, s.`apellidomaterno`, c.fechaapertura, c.fechavence,  c.`nocuenta`, c.`codigo`, c.`moneda`, c.estado,
	SUM(d.`haber`) - SUM(d.`debe`) saldo_Bs,
	SUM(d.haberme) - SUM(d.`debeme`) saldo_ME
FROM sf_tmpdet d
JOIN sf_tmpenc e 	ON d.id_tmpenc = e.id_tmpenc
JOIN cuenta c 		ON d.`idcuenta` = c.`idcuenta`
JOIN tipocuenta t	ON c.idtipocuenta = t.idtipocuenta
JOIN socio s ON c.`idsocio` = s.`idsocio`
WHERE e.estado <> 'ANL'
AND t.tipo = 'DPF'
-- and c.fechaapertura between '2021-03-01' and '2021-03-31'
-- and c.fechavence >= '2021-02-01' and c.fechaapertura <= '2021-02-01'
AND fechaapertura >= '2021-04-01'
-- and c.`nocuenta` in ( 200519, 100338)
GROUP BY s.`idsocio`, c.idcuenta, s.`nombres`, s.`apellidopaterno`, s.`apellidopaterno`, c.fechaapertura, c.fechavence, c.`nocuenta`, c.`codigo`, c.`moneda`, c.estado
;


SELECT *
FROM cuenta c
WHERE c.`codigo` IN (
'ME0072',
'ME0071',
'ME0073'
);

-- 

SELECT *
FROM sf_tmpdet d WHERE d.`id_tmpdet` = 578040;

-- Para corregir capitalizacion intereses
/*
update sf_tmpdet d set d.`haber` = 3.27 , d.`haberme` =  0.47 where d.`id_tmpdet` = 578077 ; 
update sf_tmpdet d set d.`debe`  = 0.42 , d.`debeme`  = 0.06  where d.`id_tmpdet` = 578078 ; 

update sf_tmpdet d set d.`haber` = 0.07 , d.`haberme` =  0.01
where d.`id_tmpdet` in (580957, 583817, 586695, 589561,592416,595245, 598067, 601794  );

update sf_tmpdet d set d.`haber` =  where d.`id_tmpdet` =  ; 
update sf_tmpdet d set d.`debe`  =  where d.`id_tmpdet` =  ; 


-- update cuenta c set c.`estado` = 'INACTIVE' where c.`nocuenta` = '100149';
-- update cuenta c set c.`estado` = 'INACTIVE' where c.`nocuenta` = '100079';

-- Anular solo para capitalizar intereses, luego revertir
update sf_tmpenc e set e.`estado` = 'ANL' where e.`id_tmpenc` = 104401;
*/
