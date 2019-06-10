-- INSERT MOVIMIENTO SALARIO PRODUCTOR
-- REPOSICION FORMULARIO

SELECT MAX(idmovimientosalarioproductor)+1 FROM movimientosalarioproductor;

-- SET @folio = (SELECT MAX(idmovimientosalarioproductor)+1 FROM movimientosalarioproductor);
INSERT INTO movimientosalarioproductor(idmovimientosalarioproductor,fecha,descripcion,estado,valor,idcompania,idzonaproductiva,idproductormateriaprima,idtipomovimientoproductor)
SELECT (@folio := @folio + 1), '2019-05-16' AS fecha, 'REPOSICION DE FORMULARIO' AS descripcion, 'PENDING' AS estado, 0.80 AS valor, 1 AS idcompania, p.`idzonaproductiva`, d.`idproductormateriaprima`, 5 AS idtipomovimientoproductor 
FROM registropagomateriaprima r
LEFT JOIN planillapagomateriaprima p 	ON r.`idplanillapagomateriaprima` = p.`idplanillapagomateriaprima`
LEFT JOIN descuentproductmateriaprima d ON r.`iddescuentproductmateriaprima` = d.`iddescuentproductmateriaprima`
WHERE p.fechainicio = '2019-05-16'
AND r.`liquidopagable` > 0
;

UPDATE SECUENCIA SET VALOR=(SELECT MAX(E.IDMOVIMIENTOSALARIOPRODUCTOR)+1 FROM MOVIMIENTOSALARIOPRODUCTOR E) WHERE TABLA='MOVIMIENTOSALARIOPRODUCTOR';
UPDATE SECUENCIA SET VALOR=(SELECT MAX(E.IDCOSTOSINDIRECTOS)/10+1 FROM COSTOSINDIRECTOS E) WHERE TABLA='COSTOSINDIRECTOS';
UPDATE SECUENCIA SET VALOR=(SELECT MAX(E.IDCOSTOSINDIRECTOS)/10+1 FROM COSTOSINDIRECTOS E) WHERE TABLA='rhmarcado';
UPDATE SECUENCIA SET VALOR=(SELECT MAX(E.idinvinicio)+1 FROM inv_inicio E) WHERE TABLA='inv_inicio';

UPDATE SECUENCIA SET VALOR=(SELECT MAX(p.idplanillaacopio)+1 FROM planillaacopio p) WHERE TABLA='PLANILLAACOPIO';

SELECT *
FROM movimientosalarioproductor
WHERE fecha = '2018-12-16'
AND descripcion = 'REPOSICION DE FORMULARIO'
;


SELECT *
FROM planillapagomateriaprima
-- update planillapagomateriaprima set estado = 'PENDING'
WHERE fechainicio = '2018-05-16'
;

-- ----------------------

-- ----------------------------------------------------------------
-- ----------------------------------------------------------------

-- PEDIDOS VETERINARIOS + CLIENTES
SELECT p.`IDPEDIDOS`, p.`FECHA_ENTREGA`, p.`ESTADO`, p.`CODIGO`, pe.`NOM`, pe.`AP`, pe.`AM`, pe.`NRO_DOC`, pe.`IDPERSONACLIENTE`, e.`identidad`, e.`noidentificacion`, per.`nombres`, pr.`idproductormateriaprima`, p.`TOTALIMPORTE`, p.`id_tmpenc`
FROM pedidos p
LEFT JOIN personacliente pe ON p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
LEFT JOIN entidad e         ON pe.`NRO_DOC` = e.`noidentificacion`
LEFT JOIN persona per       ON e.`identidad` = per.`idpersona`
LEFT JOIN productormateriaprima pr ON e.`identidad` = pr.`idproductormateriaprima`
WHERE p.`FECHA_ENTREGA` BETWEEN '2018-09-16' AND '2018-09-30'
AND p.`ESTADO` <> 'ANULADO'
AND p.`IDUSUARIO` = 5
AND p.`IDTIPOPEDIDO` = 6
;

-- PEDIDOS LACTEOS + CLIENTES
SELECT p.`IDPEDIDOS`, p.`FECHA_ENTREGA`, p.`ESTADO`, p.`CODIGO`, pe.`NOM`, pe.`AP`, pe.am, pe.`NRO_DOC`, e.`identidad`, e.`noidentificacion`, per.`nombres`, pr.`idproductormateriaprima`, p.`TOTALIMPORTE`
FROM pedidos p
LEFT JOIN personacliente pe ON p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
LEFT JOIN entidad e         ON pe.`NRO_DOC` = e.`noidentificacion`
LEFT JOIN persona per       ON e.`identidad` = per.`idpersona`
LEFT JOIN productormateriaprima pr ON e.`identidad` = pr.`idproductormateriaprima`
WHERE p.`FECHA_ENTREGA` BETWEEN '2018-09-01' AND '2018-09-15'
AND p.`ESTADO` <> 'ANULADO'
AND p.`IDUSUARIO` <> 5
AND p.`IDTIPOPEDIDO` = 5
;


-- ACOPIO, INSERTAR DESCUENTOS VETERINARIOS
SET @folio = (SELECT MAX(idmovimientosalarioproductor) FROM movimientosalarioproductor);
-- INSERT INTO movimientosalarioproductor 
SELECT (@folio := @folio + 1), p.`FECHA_ENTREGA` AS fecha, CONCAT('DESC_VETERINARIO venta a credito Nro. ', p.codigo) AS descripcion, 'PENDING', P.`TOTALIMPORTE` AS valor, 1 AS idcompania, pr.idzonaproductiva, pr.`idproductormateriaprima`, 4 AS tipomovimientoproductor
FROM pedidos p
JOIN personacliente pe ON p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
JOIN entidad e         ON pe.`NRO_DOC` = e.`noidentificacion`
JOIN persona per       ON e.`identidad` = per.`idpersona`
JOIN productormateriaprima pr ON e.`identidad` = pr.`idproductormateriaprima`
WHERE p.`FECHA_ENTREGA` BETWEEN '2018-09-01' AND '2018-09-14'
AND p.`ESTADO` <> 'ANULADO'
AND p.`IDUSUARIO` = 5
AND p.`IDTIPOPEDIDO` = 6
;

SELECT *
FROM movimientosalarioproductor m
WHERE m.`fecha` BETWEEN '2018-01-01' AND '2018-12-31'
AND m.`descripcion` <> 'REPOSICION DE FORMULARIO'
AND m.`idproductormateriaprima` = 352
;

SELECT * FROM personacliente p WHERE p.`NRO_DOC` = 5237757;
SELECT * FROM entidad e WHERE e.`noidentificacion` = 5237757;

-- update movimientosalarioproductor m set m.`fecha` = '2018-09-19' where m.`idmovimientosalarioproductor` = 223680, m.`valor` = 0; -- 300Bs
-- DELETE FROM movimientosalarioproductor WHERE idmovimientosalarioproductor = 223680;

SELECT *
FROM pedidos p
WHERE p.`CODIGO` = 5969;


-- ACOPIO, INSERTAR DESCUENTOS LACTEOS
SET @folio = (SELECT MAX(idmovimientosalarioproductor) FROM movimientosalarioproductor);
-- INSERT INTO movimientosalarioproductor 
SELECT (@folio := @folio + 1), p.`FECHA_ENTREGA` AS fecha, CONCAT('Descuento Productos Lacteos Pedido Nro. ', p.codigo) AS descripcion, 'PENDING', P.`TOTALIMPORTE` AS valor, 1 AS idcompania, pr.idzonaproductiva, pr.`idproductormateriaprima`, 3 AS tipomovimientoproductor
FROM pedidos p
JOIN personacliente pe ON p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
JOIN entidad e         ON pe.`NRO_DOC` = e.`noidentificacion`
JOIN persona per       ON e.`identidad` = per.`idpersona`
JOIN productormateriaprima pr ON e.`identidad` = pr.`idproductormateriaprima`
WHERE p.`FECHA_ENTREGA` BETWEEN '2018-09-01' AND '2018-09-30'
AND p.`ESTADO` <> 'ANULADO'
AND p.`IDUSUARIO` <> 5
AND p.`IDTIPOPEDIDO` = 5
-- and e.`noidentificacion` = 3587562
;

SELECT p.`IDPEDIDOS`, p.`FECHA_ENTREGA`, p.`CODIGO`, pe.`IDPERSONACLIENTE`, pe.`NRO_DOC`
FROM pedidos p
JOIN personacliente pe 		ON p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
JOIN entidad e 	    		ON pe.`NRO_DOC` = e.`noidentificacion`
JOIN productormateriaprima pr 	ON e.`identidad` = pr.`idproductormateriaprima`
WHERE p.`FECHA_ENTREGA` BETWEEN '2018-08-01' AND '2018-08-31'
AND p.`ESTADO` <> 'ANULADO'
AND p.`IDUSUARIO` <> 5
AND p.`IDTIPOPEDIDO` = 5
;


-- 11312
-- CONTABILIZAR DESCUENTOS VETERINARIOS
-- SET @folio = (SELECT MAX(id_tmpdet) FROM sf_tmpdet);
SET @folio = 13677;
-- INSERT INTO sf_tmpdet (id_tmpdet, cuenta, no_cia, debe, haber, moneda, no_trans, id_tmpenc, idpersonacliente) 
SELECT (@folio := @folio+1), '1421010200', '01', 0, p.`TOTALIMPORTE`, 'P', 109803, 109765, pe.`IDPERSONACLIENTE`
-- ,pe.`NOM`, pe.`AP`, pe.`AM`
FROM pedidos p
JOIN personacliente pe ON p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
JOIN entidad e         ON pe.`NRO_DOC` = e.`noidentificacion`
JOIN persona per       ON e.`identidad` = per.`idpersona`
JOIN productormateriaprima pr ON e.`identidad` = pr.`idproductormateriaprima`
WHERE p.`FECHA_ENTREGA` BETWEEN '2019-04-16' AND '2019-04-30'
AND p.`ESTADO` <> 'ANULADO'
AND p.`IDUSUARIO` = 5
AND p.`IDTIPOPEDIDO` = 6
;

-- CONTABILIZAR DESCUENTOS LACTEOS
-- SET @folio = (SELECT MAX(id_tmpdet) FROM sf_tmpdet);
SET @folio = 13730;
-- INSERT INTO sf_tmpdet (id_tmpdet, cuenta, no_cia, debe, haber, moneda, no_trans, id_tmpenc, idpersonacliente) 
SELECT (@folio := @folio+1), '1421010100', '01', 0, p.`TOTALIMPORTE`, 'P', 112153, 112115, pe.`IDPERSONACLIENTE`
-- ,pe.`NOM`, pe.`AP`, pe.`AM`
FROM pedidos p
JOIN personacliente pe ON p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
JOIN entidad e         ON pe.`NRO_DOC` = e.`noidentificacion`
JOIN persona per       ON e.`identidad` = per.`idpersona`
JOIN productormateriaprima pr ON e.`identidad` = pr.`idproductormateriaprima`
WHERE p.`FECHA_ENTREGA` BETWEEN '2019-05-16' AND '2019-05-31'
AND p.`ESTADO` <> 'ANULADO'
AND p.`IDUSUARIO` <> 5
AND p.`IDTIPOPEDIDO` = 5
;
-- 112115 112153

SELECT m.`idproductormateriaprima`, m.`fecha`, m.`descripcion`, m.`valor`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`
FROM movimientosalarioproductor m
LEFT JOIN persona p ON m.`idproductormateriaprima` = p.`idpersona`
WHERE m.`fecha` BETWEEN '2019-05-16' AND '2019-05-31'
AND m.`descripcion` LIKE '%DESC_LAC%'
;



SELECT a.`idproductormateriaprima`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, SUM(a.`cantidad`) AS cant
FROM acopiomateriaprima a
LEFT JOIN sesionacopio s ON a.`idsesionacopio` = s.`idsesionacopio`
LEFT JOIN persona p ON a.`idproductormateriaprima` = p.`idpersona`
WHERE s.`fecha` BETWEEN '2019-05-16' AND '2019-05-31'
GROUP BY a.`idproductormateriaprima`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`
;




301 - X317 - ANGELA 
