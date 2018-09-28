--costos indirectos
select nombre,sum( montobs), cuenta
from(
select ci.nombre as nombre ,sum (ci.montobs) as montobs,conf.cuenta as cuenta from planificacionproduccion pl 
INNER JOIN ordenproduccion OP
ON op.idplanificacionproduccion = pl.idplanificacionproduccion
inner join costosindirectos ci
on ci.idordenproduccion = op.idordenproduccion
inner join costosindirectosconf conf
on conf.idcostosindirectosconf = ci.idcostosindirectosconf
where pl.estado = 'TABULATED'
and fecha between to_date('01/01/2015') and to_date('31/01/2015')
group by ci.nombre,conf.cuenta
union all
select ci.nombre as nombre ,sum (ci.montobs) as montobs,conf.cuenta as cuenta from planificacionproduccion pl 
INNER JOIN productobase pb
ON pb.idplanificacionproduccion = pl.idplanificacionproduccion
inner join productosimple ps
on ps.idproductobase = pb.idproductobase
inner join costosindirectos ci
on ci.idproductosimple = ps.idproductosimple
inner join costosindirectosconf conf
on conf.idcostosindirectosconf = ci.idcostosindirectosconf
where pl.estado = 'TABULATED'
and fecha between to_date('01/01/2015') and to_date('31/01/2015')
group by ci.nombre,conf.cuenta)
group by nombre,cuenta;

--insumos
select sum(costototal),invart.cuenta_art,invart.descri from(
select sum(oi.costototal) as costototal, oi.cod_art as codart from planificacionproduccion pl 
INNER JOIN ordenproduccion OP
ON op.idplanificacionproduccion = pl.idplanificacionproduccion
inner join ordeninsumo oi
on oi.idordenproduccion = op.idordenproduccion
where pl.estado = 'TABULATED'
and fecha between to_date('01/06/2014') and to_date('30/06/2014')
group by oi.cod_art
union all
select sum(oi.costototal) as costototal, oi.cod_art as codart from planificacionproduccion pl 
INNER JOIN productobase pb
ON pb.idplanificacionproduccion = pl.idplanificacionproduccion
inner join ordeninsumo oi
on oi.idproductobase = pb.idproductobase
where pl.estado = 'TABULATED'
and fecha between to_date('01/06/2014') and to_date('30/06/2014')
group by oi.cod_art
)
inner join WISE.inv_articulos invart
on invart.cod_art = codart
group by codart,invart.cuenta_art,invart.descri;


--materiales
select sum(costototal),invart.cuenta_art,invart.descri from(
select sum(om.costototal) as costototal,om.cod_art as codart from planificacionproduccion pl 
INNER JOIN ordenproduccion OP
ON op.idplanificacionproduccion = pl.idplanificacionproduccion
inner join ordenmaterial om
on om.idordenproduccion = op.idordenproduccion
where pl.estado = 'TABULATED'
and fecha between to_date('01/06/2014') and to_date('30/06/2014')
group by om.cod_art
UNION ALL
select sum(om.costototal) as costototal,om.cod_art as codart from planificacionproduccion pl 
INNER JOIN productobase pb
ON pb.idplanificacionproduccion = pl.idplanificacionproduccion
inner join productosimple ps
on ps.idproductobase = pb.idproductobase
inner join ordenmaterial om
on om.idproductosimple = ps.idproductosimple
where pl.estado = 'TABULATED'
and fecha between to_date('01/06/2014') and to_date('30/06/2014')
group by om.cod_art
) 
inner join WISE.inv_articulos invart
on invart.cod_art = codart
group by codart,invart.cuenta_art,invart.descri;


