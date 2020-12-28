select d.`cod_art`, i.`descri`, sum(d.`cant_sol`) as cant_sol, sum(d.`total`) as total, sum(d.`costo_uni`) as costo_uni_sum , count(d.`cod_art`) as counter, (sum(d.`costo_uni`) / count(d.`cod_art`)) as CU
from com_detoc d
left join com_encoc e 	  on d.`id_com_encoc` = e.`id_com_encoc`
left join inv_articulos i on d.`cod_art`      = i.`cod_art`
where i.`cuenta_art` = '4460110300'
and e.`fecha` between '2016-05-01' and '2016-11-30'
-- and e.`fecha_recepcion` between '2016-05-01' and '2016-07-31'
group by d.`cod_art`, i.`descri`
;


--
-- Insumos de Produccion
-- 
select 	distinct
	pl.`fecha`,
	oi.`cod_art`,
	op.`codigo`,
	oi.`cantidad`,
	oi.`costounitario`,
	oi.`costototal`
from ordenproduccion op
left join ordeninsumo oi		on op.`idordenproduccion` = oi.`idordenproduccion`
left join planificacionproduccion pl 	on op.`idplanificacionproduccion` = pl.`idplanificacionproduccion`
where pl.`fecha` between '2016-11-01' and '2016-11-30'
and oi.`cod_art` in (12,13,14,15,18,20,8)
union all
select 	distinct
	pl.`fecha`, 
	oi.`cod_art`,
	pb.`codigo`, 
	oi.`cantidad`,
	oi.`costounitario`,
	oi.`costototal`
from productobase pb
left join productosimple ps 		on pb.`idproductobase` = ps.`idproductobase`
left join ordeninsumo oi		on pb.`idproductobase` = oi.`idproductobase`
left join planificacionproduccion pl 	on pb.`idplanificacionproduccion` = pl.`idplanificacionproduccion`
where pl.`fecha` between '2016-11-01' and '2016-11-30'
and oi.`cod_art` in (12,13,14,15,18,20,8)
;

-- REPORTE DE INSUMOS UTILIZADOS X FECHA
select z.`cod_art`, z.`descri`, z.`cod_med`, sum(z.cantidad) as cantidad
from (
	select oi.`cod_art`, a.`descri`, a.`cod_med`, sum(oi.`cantidad`) as cantidad
	from ordeninsumo oi 	
	left join inv_articulos a  		on oi.`cod_art` = a.`cod_art`
	left join ordenproduccion op 		on oi.`idordenproduccion` = op.`idordenproduccion`
	left join planificacionproduccion pl 	on op.`idplanificacionproduccion` = pl.`idplanificacionproduccion`
	where pl.`fecha` between '2019-01-01' and '2019-04-31'
	group by oi.`cod_art`, a.`descri`, a.`cod_med`
	union all
	select oi.`cod_art`, a.`descri`, a.`cod_med`, sum(oi.`cantidad`) as cantidad
	from productobase pb
	left join productosimple ps 		on pb.`idproductobase` = ps.`idproductobase`
	left join ordeninsumo oi		on pb.`idproductobase` = oi.`idproductobase`
	left join inv_articulos a 		on oi.`cod_art` = a.`cod_art`
	left join planificacionproduccion pl 	on pb.`idplanificacionproduccion` = pl.`idplanificacionproduccion`
	where pl.`fecha` between '2019-01-01' and '2019-04-31'
	group by oi.`cod_art`, a.`descri`, a.`cod_med`
) z 
group by z.`cod_art`, z.`descri`, z.`cod_med`
;


-- REPORTE DE MATERIALES UTILIZADOS X FECHA
select z.`cod_art`, z.`descri`, z.`cod_med`, sum(z.cantidad) as cantidad
from (

	select om.`cod_art`, a.`descri`, a.`cod_med`, sum(om.`cantidadpesousada`) as cantidad
	from ordenmaterial om 	
	left join inv_articulos a  		on om.`cod_art` = a.`cod_art`
	left join ordenproduccion op 		on om.`idordenproduccion` = op.`idordenproduccion`
	left join planificacionproduccion pl 	on op.`idplanificacionproduccion` = pl.`idplanificacionproduccion`
	where pl.`fecha` between '2019-01-01' and '2019-04-31'
	group by om.`cod_art`, a.`descri`, a.`cod_med`
	union all
	select om.`cod_art`, a.`descri`, a.`cod_med`, sum(om.`cantidadpesousada`) as cantidad
	from productosimple ps
	left join productobase pb 		on ps.`idproductobase` = pb.`idproductobase`
	left join ordenmaterial om		on ps.idproductosimple = om.`idproductosimple`
	left join inv_articulos a 		on om.`cod_art` = a.`cod_art`
	left join planificacionproduccion pl 	on pb.`idplanificacionproduccion` = pl.`idplanificacionproduccion`
	where pl.`fecha` between '2019-01-01' and '2019-04-31'
	group by om.`cod_art`, a.`descri`, a.`cod_med`
) z 
group by z.`cod_art`, z.`descri`, z.`cod_med`
;






