SELECT *
FROM inv_inventario i
WHERE i.`cod_alm` = 2;

UPDATE inv_inventario i SET i.`saldo_uni` = 9999999 WHERE i.`cod_alm` = 2;
UPDATE `inv_inventario_detalle` i SET i.`cantidad` = 9999999 WHERE i.`cod_alm` = 2;

SELECT i.`cod_art`, i.`descri`,  i.`costo_uni`, i.`saldo_mon`, i.`cu`, i.`ct`, i.`estado`
FROM inv_articulos i
WHERE i.`cuenta_art` = 4420110201
;

UPDATE inv_articulos i SET i.`saldo_mon` = i.`costo_uni` * 1000, i.`ct` = i.`cu` * 1000 WHERE i.`cuenta_art` = 4420110201;

/** 1. Bloquear articulos sin uso **/
UPDATE inv_articulos i SET i.`estado` = 'BLO'
WHERE i.`cod_art` IN (491	,492	,120	,121	,161	,433	,541	,144	,478	,189	, 146	,190	,606	,608	,594	,595	,147	,145	,123	,124	,486	,127	,
126	,149	,150	,196	,195	,551	,133	,157	,158	,159	,160	,136	,154	,156	,155	,137	,138	,139	,140	,141	,142	,191	);

/** 2. Actualizar cuenta bajas **/
UPDATE configuracion c SET c.`ctaMermaBaj` = 4460111100;
UPDATE inv_tipodocs i SET i.`tipo_vale` = 'B' WHERE i.`cod_doc` = 'BAJ';

/** 3. Insertar nueco tipo Reproceso **/
INSERT INTO inv_tipodocs (no_cia, cod_doc, descri, estado, VERSION, tipo_vale) VALUES ('01', 'REP', 'REPROCESO', 'VIG', 0, 'W');

ALTER TABLE configuracion ADD COLUMN ctaReproc VARCHAR(20) NULL;
UPDATE configuracion c SET c.`ctaReproc` = 4460111101;





