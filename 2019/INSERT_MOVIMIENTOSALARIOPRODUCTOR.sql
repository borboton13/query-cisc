-- INSERT MOVIMIENTO SALARIO PRODUCTOR
-- REPOSICION FORMULARIO

select max(idmovimientosalarioproductor)+1 from movimientosalarioproductor;

-- SET @folio = (SELECT MAX(idmovimientosalarioproductor) FROM movimientosalarioproductor);
-- insert into movimientosalarioproductor(idmovimientosalarioproductor,fecha,descripcion,estado,valor,idcompania,idzonaproductiva,idproductormateriaprima,idtipomovimientoproductor)
select (@folio := @folio + 1), '2020-01-16' as fecha, 'COMISION BANCO' as descripcion, 'PENDING' as estado, 5.00 as valor, 1 as idcompania, p.`idzonaproductiva`, d.`idproductormateriaprima`, 7 as idtipomovimientoproductor 
from registropagomateriaprima r
left join planillapagomateriaprima p 	on r.`idplanillapagomateriaprima` = p.`idplanillapagomateriaprima`
left join descuentproductmateriaprima d on r.`iddescuentproductmateriaprima` = d.`iddescuentproductmateriaprima`
where p.fechainicio = '2020-01-16'
and r.`liquidopagable` > 0
;

update SECUENCIA set VALOR=(select max(E.IDMOVIMIENTOSALARIOPRODUCTOR)+1 from MOVIMIENTOSALARIOPRODUCTOR E) where TABLA='MOVIMIENTOSALARIOPRODUCTOR';

select *
where `descripcion` = 'COMISION BANCO'
and `fecha` between '2019-12-01' and '2019-12-31'
;


-- ----------------------------------------------------------------
-- ----------------------------------------------------------------

-- PEDIDOS VETERINARIOS + CLIENTES
select p.`IDPEDIDOS`, p.`FECHA_ENTREGA`, p.`ESTADO`, p.`CODIGO`, pe.`NOM`, pe.`AP`, pe.`AM`, pe.`NRO_DOC`, pe.`IDPERSONACLIENTE`, e.`identidad`, e.`noidentificacion`, per.`nombres`, pr.`idproductormateriaprima`, p.`TOTALIMPORTE`, p.`id_tmpenc`
from pedidos p
left join personacliente pe on p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
left join entidad e         on pe.`NRO_DOC` = e.`noidentificacion`
left join persona per       on e.`identidad` = per.`idpersona`
left join productormateriaprima pr on e.`identidad` = pr.`idproductormateriaprima`
where p.`FECHA_ENTREGA` between '2019-12-16' and '2019-12-31'
and p.`ESTADO` <> 'ANULADO'
and p.`IDUSUARIO` = 5
and p.`IDTIPOPEDIDO` = 6
;

select m.`fecha`, m.`idproductormateriaprima`, m.`descripcion`, m.`valor`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`
from movimientosalarioproductor m
left join persona p on m.`idproductormateriaprima` = p.`idpersona`
where m.`fecha` between '2019-12-01' and '2019-12-31'
and m.`descripcion` <> 'COMISION BANCO'
;


-- PEDIDOS LACTEOS + CLIENTES
select p.`IDPEDIDOS`, p.`FECHA_ENTREGA`, p.`ESTADO`, p.`CODIGO`, pe.`NOM`, pe.`AP`, pe.am, pe.`NRO_DOC`, e.`identidad`, e.`noidentificacion`, per.`nombres`, pr.`idproductormateriaprima`, p.`TOTALIMPORTE`
from pedidos p
left join personacliente pe on p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
left join entidad e         on pe.`NRO_DOC` = e.`noidentificacion`
left join persona per       on e.`identidad` = per.`idpersona`
left join productormateriaprima pr on e.`identidad` = pr.`idproductormateriaprima`
where p.`FECHA_ENTREGA` between '2018-09-16' and '2018-09-30'
and p.`ESTADO` <> 'ANULADO'
and p.`IDUSUARIO` <> 5
and p.`IDTIPOPEDIDO` = 5
;


/* -- ACOPIO, INSERTAR DESCUENTOS VETERINARIOS
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
;*/

/* -- ACOPIO, INSERTAR DESCUENTOS LACTEOS
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
; */


-- -------------------------------------- --
-- CONTABILIZAR DESCUENTOS VETERINARIOS
-- -------------------------------------- --
-- SET @folio = (SELECT MAX(id_tmpdet) FROM sf_tmpdet);
set @folio = 699288;
-- INSERT INTO sf_tmpdet (id_tmpdet, cuenta, no_cia, debe, haber, moneda, no_trans, id_tmpenc, idpersonacliente) 
select (@folio := @folio+1), '1421010200', '01', 0, p.`TOTALIMPORTE`, 'P', 124923, 124885, pe.`IDPERSONACLIENTE` -- 
, PE.`NRO_DOC`, pe.`NOM`, pe.`AP`, pe.`AM`, p.`ESTADO`
from pedidos p
join personacliente pe on p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
join entidad e         on pe.`NRO_DOC` = e.`noidentificacion`
join persona per       on e.`identidad` = per.`idpersona`
join productormateriaprima pr on e.`identidad` = pr.`idproductormateriaprima`
where p.`FECHA_ENTREGA` between '2019-11-16' and '2019-11-30'
and p.`ESTADO` <> 'ANULADO'
and p.`IDUSUARIO` = 5
and p.`IDTIPOPEDIDO` = 6
;

-- 716540

select *
from sf_tmpdet d
where d.`id_tmpdet` >= 716540
;

-- CONTABILIZAR DESCUENTOS LACTEOS
set @folio = 716540; 
-- INSERT INTO sf_tmpdet (id_tmpdet, cuenta, no_cia, debe, haber, moneda, no_trans, id_tmpenc, idpersonacliente) 
select (@folio := @folio+1), '1421010100', '01', 0, p.`TOTALIMPORTE`, 'P', 127326, 127287, pe.`IDPERSONACLIENTE`
-- ,pe.`NOM`, pe.`AP`, pe.`AM`
from pedidos p
join personacliente pe on p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
join entidad e         on pe.`NRO_DOC` = e.`noidentificacion`
join persona per       on e.`identidad` = per.`idpersona`
join productormateriaprima pr on e.`identidad` = pr.`idproductormateriaprima`
where p.`FECHA_ENTREGA` between '2019-11-16' and '2019-11-30'
and p.`ESTADO` <> 'ANULADO'
and p.`IDUSUARIO` <> 5
and p.`IDTIPOPEDIDO` = 5
;

-- DESCUENTOS
select m.`idmovimientosalarioproductor`, m.`idproductormateriaprima`, m.`fecha`, m.`descripcion`, m.`valor`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, p.`idpersona`, m.`idproductormateriaprima`
from movimientosalarioproductor m
left join persona p on m.`idproductormateriaprima` = p.`idpersona`
where m.`fecha` between '2020-01-01' and '2020-01-31'
-- and m.`descripcion` <> 'REPOSICION DE FORMULARIO'
and m.`descripcion` like '%COMISION BANCO%'
and m.`fecha` between '2020-01-01' and '2020-01-31'
;


select *
delete from movimientosalarioproductor 
where `descripcion` like '%COMISION BANCO%'
;


select a.`idproductormateriaprima`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, sum(a.`cantidad`) as cant
from acopiomateriaprima a
left join sesionacopio s on a.`idsesionacopio` = s.`idsesionacopio`
left join persona p on a.`idproductormateriaprima` = p.`idpersona`
where s.`fecha` between '2019-05-16' and '2019-05-31'
group by a.`idproductormateriaprima`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`
;




select (@folio := @folio+1), '1421010200', '01', 0, p.`TOTALIMPORTE`, 'P', 124923, 124885, pe.`IDPERSONACLIENTE` -- 
, PE.`NRO_DOC`, pe.`NOM`, pe.`AP`, pe.`AM`, p.`ESTADO`
from pedidos p
join personacliente pe on p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
join entidad e         on pe.`NRO_DOC` = e.`noidentificacion`
join persona per       on e.`identidad` = per.`idpersona`
join productormateriaprima pr on e.`identidad` = pr.`idproductormateriaprima`
where p.`FECHA_ENTREGA` between '2019-11-16' and '2019-11-30'
and p.`ESTADO` <> 'ANULADO'
and p.`IDUSUARIO` = 5
and p.`IDTIPOPEDIDO` = 6
;

select p.`IDPERSONACLIENTE`, p.`NOM`, p.`AP`, p.`AM`, p.`NRO_DOC`, e.`identidad`, pr.`idproductormateriaprima`, pr.`idzonaproductiva`
from personacliente p
join entidad e on p.`NRO_DOC` = e.`noidentificacion`
join productormateriaprima pr on e.`identidad` = pr.`idproductormateriaprima`
;


