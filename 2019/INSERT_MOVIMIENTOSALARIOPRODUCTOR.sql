-- INSERT MOVIMIENTO SALARIO PRODUCTOR
-- REPOSICION FORMULARIO

select max(idmovimientosalarioproductor)+1 from movimientosalarioproductor;

-- INSERTANDO DESDE LA PLANILLA GENERADA
-- SET @folio = (SELECT MAX(idmovimientosalarioproductor) FROM movimientosalarioproductor);
-- insert into movimientosalarioproductor(idmovimientosalarioproductor,fecha,descripcion,estado,valor,idcompania,idzonaproductiva,idproductormateriaprima,idtipomovimientoproductor)
select (@folio := @folio + 1), '2021-03-16' as fecha, 'COMISION BANCO' as descripcion, 'PENDING' as estado, 5.00 as valor, 1 as idcompania, p.`idzonaproductiva`, d.`idproductormateriaprima`, 7 as idtipomovimientoproductor 
from registropagomateriaprima r
left join planillapagomateriaprima p 	on r.`idplanillapagomateriaprima` = p.`idplanillapagomateriaprima`
left join descuentproductmateriaprima d on r.`iddescuentproductmateriaprima` = d.`iddescuentproductmateriaprima`
where p.fechainicio = '2021-03-16'
and r.`liquidopagable` > 0
;


-- INSERTANDO DESDE LAS SESIONES DE ACOPIO (usado)
-- SET @folio = (SELECT MAX(idmovimientosalarioproductor) FROM movimientosalarioproductor);
-- insert into movimientosalarioproductor(idmovimientosalarioproductor,fecha,descripcion,estado,valor,idcompania,idzonaproductiva,idproductormateriaprima,idtipomovimientoproductor)
-- select am.`idproductormateriaprima` as id, e.`noidentificacion` as ci, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, pr.`numerocuenta`, sum(am.`cantidad`) as CANT, max(sa.`fecha`)
select (@folio := @folio + 1), '2021-01-16' as fecha, 'COMISION BANCO' as descripcion, 'PENDING' as estado, 5.00 as valor, 1 as idcompania, pr.idzonaproductiva, pr.idproductormateriaprima, 7 as idtipomovimientoproductor 
from acopiomateriaprima am
left join sesionacopio sa on am.`idsesionacopio` = sa.`idsesionacopio`
left join persona p on am.`idproductormateriaprima` = p.`idpersona`
left join productormateriaprima pr on p.`idpersona` = pr.`idproductormateriaprima`
left join entidad e on p.`idpersona` = e.`identidad`
where sa.`fecha` between '2021-01-16' and '2021-01-31' and am.`cantidad` > 0
group by am.`idproductormateriaprima`, e.`noidentificacion`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, pr.`numerocuenta`
;

update SECUENCIA set VALOR=(select max(E.IDMOVIMIENTOSALARIOPRODUCTOR)+1 from MOVIMIENTOSALARIOPRODUCTOR E) where TABLA='MOVIMIENTOSALARIOPRODUCTOR';


-- -------------------------------------- --
-- CONTABILIZAR DESCUENTOS VETERINARIOS
-- -------------------------------------- --
-- SET @folio = (SELECT MAX(id_tmpdet) FROM sf_tmpdet);
-- set @folio = 14703;
-- INSERT INTO sf_tmpdet (id_tmpdet, cuenta, no_cia, debe, haber, moneda, no_trans, id_tmpenc, idpersonacliente) 
select (@folio := @folio+1), '1421010200', '01', 0, p.`TOTALIMPORTE`, 'P', 132147, 132100, pe.`IDPERSONACLIENTE` -- 
 , PE.`NRO_DOC`, pe.`NOM`, pe.`AP`, pe.`AM`, p.`ESTADO`, p.`FECHA_ENTREGA`
from pedidos p
join personacliente pe on p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
join entidad e         on pe.`NRO_DOC` = e.`noidentificacion`
join persona per       on e.`identidad` = per.`idpersona`
join productormateriaprima pr on e.`identidad` = pr.`idproductormateriaprima`
where p.`FECHA_ENTREGA` between '2021-01-16' and '2021-01-31'
and p.`ESTADO` <> 'ANULADO'
and p.`IDUSUARIO` = 5
and p.`IDTIPOPEDIDO` = 6
;


select *
from sf_tmpdet d
where d.`id_tmpdet` >= 15190
;

-- CONTABILIZAR DESCUENTOS LACTEOS
-- set @folio = 15402; 
-- INSERT INTO sf_tmpdet (id_tmpdet, cuenta, no_cia, debe, haber, moneda, no_trans, id_tmpenc, idpersonacliente) 
select (@folio := @folio+1), '1421010100', '01', 0, p.`TOTALIMPORTE`, 'P', 163074, 163245, pe.`IDPERSONACLIENTE`        -- , P.`IDPEDIDOS` ,pe.`NOM`, pe.`AP`, pe.`AM`, p.`FECHA_ENTREGA` , per.`idpersona`
from pedidos p
join personacliente pe on p.`IDCLIENTE` = pe.`IDPERSONACLIENTE`
join entidad e         on pe.`NRO_DOC` = e.`noidentificacion`
join persona per       on e.`identidad` = per.`idpersona`
join productormateriaprima pr on e.`identidad` = pr.`idproductormateriaprima`
where p.`FECHA_ENTREGA` between '2021-01-01' and '2021-01-15'
and p.`ESTADO` <> 'ANULADO'
and p.`IDUSUARIO` <> 5
and p.`IDTIPOPEDIDO` = 5
-- and pe.`IDPERSONACLIENTE` not in (587) -- No caopia Lucia Arispe, se paso desdcuento a 1Q-SEP-20
;

-- DESCUENTOS
select m.`idmovimientosalarioproductor`, m.`idproductormateriaprima`, m.`fecha`, m.`descripcion`, m.`valor`, p.`nombres`, p.`apellidopaterno`, p.`apellidomaterno`, p.`idpersona`, m.`idproductormateriaprima`
from movimientosalarioproductor m
left join persona p on m.`idproductormateriaprima` = p.`idpersona`
where m.`fecha` between '2020-01-01' and '2021-02-28'
-- and m.`descripcion` <> 'REPOSICION DE FORMULARIO'
-- and m.`descripcion` not like '%COMISION BANCO%'
and m.`descripcion` not like '%COMISION BANCO%'
and p.`nombres` like '%FIDELIA%'
-- and m.`idtipomovimientoproductor` = 3

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


