
-- REPORTE DE INSUMOS GESTION 2019
select b.cod_art, b.descri, b.cod_med, sum(b.cantidad) as cantidad
from (
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
	union all
	select i.`cod_art`, a.`descri`, a.`cod_med`, sum(i.`cantidad`) as cantidad
	from pr_insumo i 
	left join inv_articulos a on i.`cod_art` = a.`cod_art`
	left join pr_produccion p on i.`idproduccion` = p.`idproduccion`
	left join pr_plan pl on p.`idplan` = pl.`idplan`
	where pl.`fecha` between '2019-05-01' and '2019-12-31'
	and i.tipo = 'INGREDIENT'
	group by i.`cod_art`, a.`descri`, a.`cod_med`
) b
group by b.cod_art, b.descri, b.cod_med
;


-- REPORTE DE MATERIALES GESTION 2019
select b.cod_art, b.descri, b.cod_med, sum(b.cantidad) as cantidad
from (
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
	union all
	select i.`cod_art`, a.`descri`, a.`cod_med`, sum(i.`cantidad`) as cantidad
	from pr_insumo i 
	left join inv_articulos a on i.`cod_art` = a.`cod_art`
	left join pr_produccion p on i.`idproduccion` = p.`idproduccion`
	left join pr_plan pl on p.`idplan` = pl.`idplan`
	where pl.`fecha` between '2019-05-01' and '2019-12-31'
	and i.tipo = 'MATERIAL'
	group by i.`cod_art`, a.`descri`, a.`cod_med`
) b
group by b.cod_art, b.descri, b.cod_med
;
