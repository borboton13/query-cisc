354 Oscar Gandarrillas ok ok
346

Guely Norka Lara 165 ok ok
Guely Norka . 231 X

Wilma Pinto 192 ok ok
WILMA . 298 X
;

SELECT *
FROM personacliente p
WHERE p.`NOM` LIKE '%wilma%'
-- where IDPERSONACLIENTE in (165,231)
;

SELECT * FROM ventacliente
-- update ventacliente set IDCLIENTE = 192
WHERE IDCLIENTE = 298
;

SELECT * FROM pedidos
-- update pedidos set IDCLIENTE = 192
WHERE IDCLIENTE = 298
;

SELECT  * FROM ventadirecta
-- update ventadirecta set IDCLIENTE = 192
WHERE IDCLIENTE = 298
;

SELECT * FROM sf_tmpenc
-- update sf_tmpenc set IDPERSONACLIENTE = 192
WHERE IDPERSONACLIENTE = 298
;

SELECT * FROM pago
-- update pago set IDPERSONACLIENTE = 
WHERE IDPERSONACLIENTE = 298
;

SELECT *
FROM personacliente
WHERE IDPERSONACLIENTE = 298
;



SELECT *
FROM ventadirecta
WHERE IDCLIENTE IN
(346,354);

SELECT * FROM sf_tmpenc
WHERE id_tmpenc IN (
	SELECT id_tmpenc
	FROM ventadirecta
	WHERE IDCLIENTE IN
	(346,354)
);

