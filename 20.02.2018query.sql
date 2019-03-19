



UPDATE inv_movdet i SET i.`estado` = 'APR' WHERE i.`no_trans` = 11642;
UPDATE inv_mov i SET i.`estado` = 'APR' WHERE i.`no_trans` = 11642;
UPDATE inv_vales i SET i.`estado` = 'APR' WHERE i.`no_trans` = 11642;

UPDATE inv_movdet i SET i.`estado` = 'PEN' WHERE i.`no_trans` = 11643;
UPDATE inv_mov i SET i.`estado` = 'PEN' WHERE i.`no_trans` = 11643;
UPDATE inv_vales i SET i.`estado` = 'PEN' WHERE i.`no_trans` = 11643;

UPDATE inv_movdet i SET i.`preciocompra` = 64, i.`preciounitcompra` = 64 WHERE i.`id_inv_movdet` = 11960; -- cambiar id

UPDATE inv_inicio i SET i.`cantidad` = 16240.00 
WHERE i.`cod_art` = 449 
AND i.`gestion` = 2017;

--

UPDATE inv_movdet i SET i.`fecha` = '2017-01-05' WHERE i.`no_trans` = 6291;
UPDATE inv_mov i SET i.`fecha_cre` = '2017-01-05', i.`fecha_mov` = '2017-01-05'  WHERE i.`no_trans` = 6291;
UPDATE inv_vales i SET i.`fecha` = '2017-01-05' WHERE i.`no_trans` = 6291;


UPDATE inv_movdet i SET i.`fecha` = '2017-12-31' WHERE i.`no_trans` = 11642;
UPDATE inv_mov i SET i.`fecha_cre` = '2017-12-31', i.`fecha_mov` = '2017-12-31' WHERE i.`no_trans` = 11642;
UPDATE inv_vales i SET i.`fecha` = '2017-12-31' WHERE i.`no_trans` = 11642;

UPDATE inv_movdet i SET i.`fecha` = '2017-12-31' WHERE i.`no_trans` = 11643;
UPDATE inv_mov i SET i.`fecha_cre` = '2017-12-31', i.`fecha_mov` = '2017-12-31' WHERE i.`no_trans` = 11643;
UPDATE inv_vales i SET i.`fecha` = '2017-12-31' WHERE i.`no_trans` = 11643;