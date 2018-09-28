/** 03.07.2018 **/
ALTER TABLE configuracion ADD COLUMN ct_cajaahorro VARCHAR(20) NULL;
ALTER TABLE configuracion ADD COLUMN ct_cajaveter VARCHAR(20) NULL;

UPDATE configuracion c SET c.`ct_cajaahorro` = '1220110605' WHERE c.`no_cia` = '01';
UPDATE configuracion c SET c.`ct_cajaveter` = '1110110300' WHERE c.`no_cia` = '01';

ALTER TABLE ventadirecta ADD COLUMN flagct INT(11) NULL DEFAULT 0;

INSERT INTO funcionalidad(idfuncionalidad,codigo,descripcion,idmodulo,permiso,nombrerecurso,idcompania) 
VALUES (240,'TRANSFER_VETERINARY_CASHSALE',NULL,1,1,'CashSale.transferVeterinarySales',1);

SELECT *
FROM ventadirecta v
-- update ventadirecta v set v.`flagct` = 1
WHERE v.`FECHA_PEDIDO` BETWEEN '2015-01-01' AND '2018-05-31'
;