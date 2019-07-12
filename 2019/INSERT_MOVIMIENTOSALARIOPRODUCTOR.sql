-- INSERT MOVIMIENTO SALARIO PRODUCTOR
-- REPOSICION FORMULARIO

select MAX(idmovimientosalarioproductor)+1 from movimientosalarioproductor;

-- SET @folio = (SELECT MAX(idmovimientosalarioproductor)+1 FROM movimientosalarioproductor);
insert into movimientosalarioproductor(idmovimientosalarioproductor,fecha,descripcion,estado,valor,idcompania,idzonaproductiva,idproductormateriaprima,idtipomovimientoproductor)
select (@folio := @folio + 1), '2019-05-16' as fecha, 'REPOSICION DE FORMULARIO' as descripcion, 'PENDING' as estado, 0.80 as valor, 1 as idcompania, p.`idzonaproductiva`, d.`idproductormateriaprima`, 5 as idtipomovimientoproductor 
from registropagomateriaprima r
left join planillapagomateriaprima p 	on r.`idplanillapagomateriaprima` = p.`idplanillapagomateriaprima`
left join descuentproductmateriaprima d on r.`iddescuentproductmateriaprima` = d.`iddescuentproductmateriaprima`
where p.fechainicio = '2019-05-16'
and r.`liquidopagable` > 0
;

update SECUENCIA set VALOR=(select MAX(E.IDMOVIMIENTOSALARIOPRODUCTOR)+1 from MOVIMIENTOSALARIOPRODUCTOR E) where TABLA='MOVIMIENTOSALARIOPRODUCTOR';
update SECUENCIA set VALOR=(select MAX(E.IDCOSTOSINDIRECTOS)/10+1 from COSTOSINDIRECTOS E) where TABLA='COSTOSINDIRECTOS';
update SECUENCIA set VALOR=(select MAX(E.IDCOSTOSINDIRECTOS)/10+1 from COSTOSINDIRECTOS E) where TABLA='rhmarcado';
update SECUENCIA set VALOR=(select MAX(E.idinvinicio)+1 from inv_inicio E) where TABLA='inv_inicio';

update SECUENCIA set VALOR=(select MAX(p.idplanillaacopio)+1 from planillaacopio p) where TABLA='PLANILLAACOPIO';

select *
from movimientosalarioproductor
where fecha = '2018-12-16'
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
and p.`ESTADO` <> 'ANULADO'
and p.`IDUSUARIO` <> 5
and p.`IDTIPOPEDIDO` = 5
;


-- ACOPIO, INSERTAR DESCUENTOS VETERINARIOS
set @folio = (select MAX(idmovimientosalarioproductor) from movimientosalarioproductor);
-- INSERT INTO movimientosalarioproductor 
select (@folio := @folio + 1), p.`FECHA_ENTREGA` as fecha, CONCAT('DESC_VETERINARIO venta a credito Nro. ', p.codigo) as descripcion, 'PENDING', P.`TOTALIMPORTE` as valor, 1 as idcompania, pr.idzonaproductiva, pr.`idproductormateriaprima`, 4 as tipomovimientoproductor
from pedidos p
join personacliente pe on p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
join entidad e         on pe.`NRO_DOC` = e.`noidentificacion`
join persona per       on e.`identidad` = per.`idpersona`
join productormateriaprima pr on e.`identidad` = pr.`idproductormateriaprima`
where p.`FECHA_ENTREGA` between '2018-09-01' and '2018-09-14'
and p.`ESTADO` <> 'ANULADO'
and p.`IDUSUARIO` = 5
and p.`IDTIPOPEDIDO` = 6
;

select *
from movimientosalarioproductor m
where m.`fecha` between '2018-01-01' and '2018-12-31'
and m.`descripcion` <> 'REPOSICION DE FORMULARIO'
and m.`idproductormateriaprima` = 352
;

select * from personacliente p where p.`NRO_DOC` = 5237757;
select * from entidad e where e.`noidentificacion` = 5237757;

-- update movimientosalarioproductor m set m.`fecha` = '2018-09-19' where m.`idmovimientosalarioproductor` = 223680, m.`valor` = 0; -- 300Bs
-- DELETE FROM movimientosalarioproductor WHERE idmovimientosalarioproductor = 223680;

select *
from pedidos p
where p.`CODIGO` = 5969;


-- ACOPIO, INSERTAR DESCUENTOS LACTEOS
set @folio = (select MAX(idmovimientosalarioproductor) from movimientosalarioproductor);
-- INSERT INTO movimientosalarioproductor 
select (@folio := @folio + 1), p.`FECHA_ENTREGA` as fecha, CONCAT('Descuento Productos Lacteos Pedido Nro. ', p.codigo) as descripcion, 'PENDING', P.`TOTALIMPORTE` as valor, 1 as idcompania, pr.idzonaproductiva, pr.`idproductormateriaprima`, 3 as tipomovimientoproductor
from pedidos p
join personacliente pe on p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
join entidad e         on pe.`NRO_DOC` = e.`noidentificacion`
join persona per       on e.`identidad` = per.`idpersona`
join productormateriaprima pr on e.`identidad` = pr.`idproductormateriaprima`
where p.`FECHA_ENTREGA` between '2018-09-01' and '2018-09-30'
and p.`ESTADO` <> 'ANULADO'
and p.`IDUSUARIO` <> 5
and p.`IDTIPOPEDIDO` = 5
-- and e.`noidentificacion` = 3587562
;

select p.`IDPEDIDOS`, p.`FECHA_ENTREGA`, p.`CODIGO`, pe.`IDPERSONACLIENTE`, pe.`NRO_DOC`
from pedidos p
join personacliente pe 		on p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
join entidad e 	    		on pe.`NRO_DOC` = e.`noidentificacion`
join productormateriaprima pr 	on e.`identidad` = pr.`idproductormateriaprima`
where p.`FECHA_ENTREGA` between '2018-08-01' and '2018-08-31'
and p.`ESTADO` <> 'ANULADO'
and p.`IDUSUARIO` <> 5
and p.`IDTIPOPEDIDO` = 5
;


-- 11312
-- CONTABILIZAR DESCUENTOS VETERINARIOS
-- SET @folio = (SELECT MAX(id_tmpdet) FROM sf_tmpdet);
set @folio = 14018;
-- INSERT INTO sf_tmpdet (id_tmpdet, cuenta, no_cia, debe, haber, moneda, no_trans, id_tmpenc, idpersonacliente) 
select (@folio := @folio+1), '1421010200', '01', 0, p.`TOTALIMPORTE`, 'P', 114589, 114551, pe.`IDPERSONACLIENTE`
-- ,pe.`NOM`, pe.`AP`, pe.`AM`
from pedidos p
join personacliente pe on p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
join entidad e         on pe.`NRO_DOC` = e.`noidentificacion`
join persona per       on e.`identidad` = per.`idpersona`
join productormateriaprima pr on e.`identidad` = pr.`idproductormateriaprima`
where p.`FECHA_ENTREGA` between '2019-06-01' and '2019-06-15'
and p.`ESTADO` <> 'ANULADO'
and p.`IDUSUARIO` = 5
and p.`IDTIPOPEDIDO` = 6
and P.`IDCLIENTE` not in (1487)
;

select *
from sf_tmpdet d where d.`id_tmpdet` >= 13730;

select * from sf_tmpenc e where e.`tipo_doc` = 'CB' and E.`fecha` >= '2019-05-01';

-- CONTABILIZAR DESCUENTOS LACTEOS
-- SET @folio = (SELECT MAX(id_tmpdet) FROM sf_tmpdet);
set @folio = 13898;
-- INSERT INTO sf_tmpdet (id_tmpdet, cuenta, no_cia, debe, haber, moneda, no_trans, id_tmpenc, idpersonacliente) 
select (@folio := @folio+1), '1421010100', '01', 0, p.`TOTALIMPORTE`, 'P', 114589, 114551, pe.`IDPERSONACLIENTE`
-- ,pe.`NOM`, pe.`AP`, pe.`AM`
from pedidos p
join personacliente pe on p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
join entidad e         on pe.`NRO_DOC` = e.`noidentificacion`
join persona per       on e.`identidad` = per.`idpersona`
join productormateriaprima pr on e.`identidad` = pr.`idproductormateriaprima`
where p.`FECHA_ENTREGA` between '2019-06-01' and '2019-06-15'
and p.`ESTADO` <> 'ANULADO'
and p.`IDUSUARIO` <> 5
and p.`IDTIPOPEDIDO` = 5
;
-- 112115 112153

select m.`idproductormateriaprima`, m.`fecha`, m.`descripcion`, m.`valor`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`
from movimientosalarioproductor m
left join persona p on m.`idproductormateriaprima` = p.`idpersona`
where m.`fecha` between '2019-05-16' and '2019-05-31'
and m.`descripcion` like '%DESC_LAC%'
;
8122


select a.`idproductormateriaprima`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, SUM(a.`cantidad`) as cant
from acopiomateriaprima a
left join sesionacopio s on a.`idsesionacopio` = s.`idsesionacopio`
left join persona p on a.`idproductormateriaprima` = p.`idpersona`
where s.`fecha` between '2019-05-16' and '2019-05-31'
group by a.`idproductormateriaprima`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`
;

