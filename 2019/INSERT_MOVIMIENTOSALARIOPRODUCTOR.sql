-- INSERT MOVIMIENTO SALARIO PRODUCTOR
-- REPOSICION FORMULARIO

select MAX(idmovimientosalarioproductor)+1 from movimientosalarioproductor;

-- SET @folio = (SELECT MAX(idmovimientosalarioproductor) FROM movimientosalarioproductor);
insert into movimientosalarioproductor(idmovimientosalarioproductor,fecha,descripcion,estado,valor,idcompania,idzonaproductiva,idproductormateriaprima,idtipomovimientoproductor)
select (@folio := @folio + 1), '2019-10-16' as fecha, 'COSTO POR TRANSFERENCIA' as descripcion, 'PENDING' as estado, 5.00 as valor, 1 as idcompania, p.`idzonaproductiva`, d.`idproductormateriaprima`, 5 as idtipomovimientoproductor 
from registropagomateriaprima r
left join planillapagomateriaprima p 	on r.`idplanillapagomateriaprima` = p.`idplanillapagomateriaprima`
left join descuentproductmateriaprima d on r.`iddescuentproductmateriaprima` = d.`iddescuentproductmateriaprima`
where p.fechainicio = '2019-10-16'
and r.`liquidopagable` > 0
;

update SECUENCIA set VALOR=(select MAX(E.IDMOVIMIENTOSALARIOPRODUCTOR)+1 from MOVIMIENTOSALARIOPRODUCTOR E) where TABLA='MOVIMIENTOSALARIOPRODUCTOR';

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
set @folio = 14194;
-- INSERT INTO sf_tmpdet (id_tmpdet, cuenta, no_cia, debe, haber, moneda, no_trans, id_tmpenc, idpersonacliente) 
select (@folio := @folio+1), '1421010200', '01', 0, p.`TOTALIMPORTE`, 'P', 122845, 122807, pe.`IDPERSONACLIENTE` -- 
,pe.`NOM`, pe.`AP`, pe.`AM`, p.`ESTADO`
from pedidos p
join personacliente pe on p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
join entidad e         on pe.`NRO_DOC` = e.`noidentificacion`
join persona per       on e.`identidad` = per.`idpersona`
join productormateriaprima pr on e.`identidad` = pr.`idproductormateriaprima`
where p.`FECHA_ENTREGA` between '2019-10-01' and '2019-10-31'
-- and p.`ESTADO` <> 'ANULADO'
and p.`IDUSUARIO` = 5
and p.`IDTIPOPEDIDO` = 6
;


-- CONTABILIZAR DESCUENTOS LACTEOS
set @folio = 14199; 
-- INSERT INTO sf_tmpdet (id_tmpdet, cuenta, no_cia, debe, haber, moneda, no_trans, id_tmpenc, idpersonacliente) 
select (@folio := @folio+1), '1421010100', '01', 0, p.`TOTALIMPORTE`, 'P', 122845, 122807, pe.`IDPERSONACLIENTE`
-- ,pe.`NOM`, pe.`AP`, pe.`AM`
from pedidos p
join personacliente pe on p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
join entidad e         on pe.`NRO_DOC` = e.`noidentificacion`
join persona per       on e.`identidad` = per.`idpersona`
join productormateriaprima pr on e.`identidad` = pr.`idproductormateriaprima`
where p.`FECHA_ENTREGA` between '2019-10-01' and '2019-10-15'
and p.`ESTADO` <> 'ANULADO'
and p.`IDUSUARIO` <> 5
and p.`IDTIPOPEDIDO` = 5
;

-- DESCUENTOS
select m.`idproductormateriaprima`, m.`fecha`, m.`descripcion`, m.`valor`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, p.`idpersona`, m.`idproductormateriaprima`
from movimientosalarioproductor m
left join persona p on m.`idproductormateriaprima` = p.`idpersona`
where m.`fecha` between '2019-10-01' and '2019-10-15'
-- and m.`descripcion` <> 'REPOSICION DE FORMULARIO'
and m.`descripcion` like '%DESC_VET%'
;



select a.`idproductormateriaprima`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, SUM(a.`cantidad`) as cant
from acopiomateriaprima a
left join sesionacopio s on a.`idsesionacopio` = s.`idsesionacopio`
left join persona p on a.`idproductormateriaprima` = p.`idpersona`
where s.`fecha` between '2019-05-16' and '2019-05-31'
group by a.`idproductormateriaprima`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`
;

