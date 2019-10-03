-- INSERT MOVIMIENTO SALARIO PRODUCTOR
-- REPOSICION FORMULARIO

select MAX(idmovimientosalarioproductor)+1 from movimientosalarioproductor;

-- SET @folio = (SELECT MAX(idmovimientosalarioproductor)+1 FROM movimientosalarioproductor);
insert into movimientosalarioproductor(idmovimientosalarioproductor,fecha,descripcion,estado,valor,idcompania,idzonaproductiva,idproductormateriaprima,idtipomovimientoproductor)
select (@folio := @folio + 1), '2019-09-16' as fecha, 'REPOSICION DE FORMULARIO' as descripcion, 'PENDING' as estado, 0.80 as valor, 1 as idcompania, p.`idzonaproductiva`, d.`idproductormateriaprima`, 5 as idtipomovimientoproductor 
from registropagomateriaprima r
left join planillapagomateriaprima p 	on r.`idplanillapagomateriaprima` = p.`idplanillapagomateriaprima`
left join descuentproductmateriaprima d on r.`iddescuentproductmateriaprima` = d.`iddescuentproductmateriaprima`
where p.fechainicio = '2019-09-16'
and r.`liquidopagable` > 0
;

update SECUENCIA set VALOR=(select MAX(E.IDMOVIMIENTOSALARIOPRODUCTOR)+1 from MOVIMIENTOSALARIOPRODUCTOR E) where TABLA='MOVIMIENTOSALARIOPRODUCTOR';
update SECUENCIA set VALOR=(select MAX(E.IDCOSTOSINDIRECTOS)/10+1 from COSTOSINDIRECTOS E) where TABLA='COSTOSINDIRECTOS';
update SECUENCIA set VALOR=(select MAX(E.IDCOSTOSINDIRECTOS)/10+1 from COSTOSINDIRECTOS E) where TABLA='rhmarcado';
update SECUENCIA set VALOR=(select MAX(E.idinvinicio)+1 from inv_inicio E) where TABLA='inv_inicio';

update SECUENCIA set VALOR=(select MAX(p.idplanillaacopio)+1 from planillaacopio p) where TABLA='PLANILLAACOPIO';

select *
from movimientosalarioproductor
where fecha = '2019-07-01'
and descripcion = 'REPOSICION DE FORMULARIO'
;


select *
from planillapagomateriaprima
-- update planillapagomateriaprima set estado = 'PENDING'
where fechainicio = '2018-05-16'
;

-- ----------------------

-- ----------------------------------------------------------------
-- ----------------------------------------------------------------

-- PEDIDOS VETERINARIOS + CLIENTES
select p.`IDPEDIDOS`, p.`FECHA_ENTREGA`, p.`ESTADO`, p.`CODIGO`, pe.`NOM`, pe.`AP`, pe.`AM`, pe.`NRO_DOC`, pe.`IDPERSONACLIENTE`, e.`identidad`, e.`noidentificacion`, per.`nombres`, pr.`idproductormateriaprima`, p.`TOTALIMPORTE`, p.`id_tmpenc`
from pedidos p
left join personacliente pe on p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
left join entidad e         on pe.`NRO_DOC` = e.`noidentificacion`
left join persona per       on e.`identidad` = per.`idpersona`
left join productormateriaprima pr on e.`identidad` = pr.`idproductormateriaprima`
where p.`FECHA_ENTREGA` between '2018-09-16' and '2018-09-30'
and p.`ESTADO` <> 'ANULADO'
and p.`IDUSUARIO` = 5
and p.`IDTIPOPEDIDO` = 6
;

-- PEDIDOS LACTEOS + CLIENTES
select p.`IDPEDIDOS`, p.`FECHA_ENTREGA`, p.`ESTADO`, p.`CODIGO`, pe.`NOM`, pe.`AP`, pe.am, pe.`NRO_DOC`, e.`identidad`, e.`noidentificacion`, per.`nombres`, pr.`idproductormateriaprima`, p.`TOTALIMPORTE`
from pedidos p
left join personacliente pe on p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
left join entidad e         on pe.`NRO_DOC` = e.`noidentificacion`
left join persona per       on e.`identidad` = per.`idpersona`
left join productormateriaprima pr on e.`identidad` = pr.`idproductormateriaprima`
where p.`FECHA_ENTREGA` between '2018-09-01' and '2018-09-15'
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
SET @folio = 14176;
-- INSERT INTO sf_tmpdet (id_tmpdet, cuenta, no_cia, debe, haber, moneda, no_trans, id_tmpenc, idpersonacliente) 
SELECT (@folio := @folio+1), '1421010200', '01', 0, p.`TOTALIMPORTE`, 'P', 120573, 120535, pe.`IDPERSONACLIENTE` -- 
-- ,pe.`NOM`, pe.`AP`, pe.`AM`
FROM pedidos p
JOIN personacliente pe ON p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
JOIN entidad e         ON pe.`NRO_DOC` = e.`noidentificacion`
JOIN persona per       ON e.`identidad` = per.`idpersona`
JOIN productormateriaprima pr ON e.`identidad` = pr.`idproductormateriaprima`
WHERE p.`FECHA_ENTREGA` BETWEEN '2019-08-16' AND '2019-08-31'
-- and p.`ESTADO` <> 'ANULADO'
AND p.`IDUSUARIO` = 5
AND p.`IDTIPOPEDIDO` = 6
-- and P.`IDCLIENTE` not in (1558)
;

-- CONTABILIZAR DESCUENTOS LACTEOS
-- set @folio = 14166; -- id_tmpdet anterior
-- INSERT INTO sf_tmpdet (id_tmpdet, cuenta, no_cia, debe, haber, moneda, no_trans, id_tmpenc, idpersonacliente) 
SELECT (@folio := @folio+1), '1421010100', '01', 0, p.`TOTALIMPORTE`, 'P', 120573, 120535, pe.`IDPERSONACLIENTE`
-- ,pe.`NOM`, pe.`AP`, pe.`AM`
FROM pedidos p
JOIN personacliente pe ON p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
JOIN entidad e         ON pe.`NRO_DOC` = e.`noidentificacion`
JOIN persona per       ON e.`identidad` = per.`idpersona`
JOIN productormateriaprima pr ON e.`identidad` = pr.`idproductormateriaprima`
WHERE p.`FECHA_ENTREGA` BETWEEN '2019-08-16' AND '2019-08-31'
AND p.`ESTADO` <> 'ANULADO'
AND p.`IDUSUARIO` <> 5
AND p.`IDTIPOPEDIDO` = 5
;
SELECT * FROM pedidos p WHERE p.`CODIGO` IN (5383, 5443, 5380) AND p.`FECHA_ENTREGA` BETWEEN '2019-08-01' AND '2019-08-31';

SELECT m.`idproductormateriaprima`, m.`fecha`, m.`descripcion`, m.`valor`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, p.`idpersona`, m.`idproductormateriaprima`
FROM movimientosalarioproductor m
LEFT JOIN persona p ON m.`idproductormateriaprima` = p.`idpersona`
WHERE m.`fecha` BETWEEN '2019-06-01' AND '2019-07-31'
-- AND m.`descripcion` LIKE '%DESC_VET%'
;



SELECT a.`idproductormateriaprima`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, SUM(a.`cantidad`) AS cant
FROM acopiomateriaprima a
LEFT JOIN sesionacopio s ON a.`idsesionacopio` = s.`idsesionacopio`
LEFT JOIN persona p ON a.`idproductormateriaprima` = p.`idpersona`
WHERE s.`fecha` BETWEEN '2019-05-16' AND '2019-05-31'
GROUP BY a.`idproductormateriaprima`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`
;

