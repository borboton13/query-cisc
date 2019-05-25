-- Reporte de Produccion: Producto x Cantidad x Costo x DIA
select o.`idordenproduccion`, p.`fecha`, m.`cod_art`, i.`descri`, v.`no_vale`, m.`cantidad`, v.`idtmpenc`, e.`tipo_doc`, e.`no_doc`, d.`id_tmpdet`, d.`debe` as costo
from ordenproduccion o
left join planificacionproduccion p on o.`idplanificacionproduccion` = p.`idplanificacionproduccion`
left join inv_vales v  		on o.`no_vale`  = v.`no_vale`
left join inv_movdet m 		on v.`no_trans` = m.`no_trans`
left join inv_articulos i 	on m.`cod_art`  = i.`cod_art` 
left join sf_tmpenc e 		on v.`idtmpenc` = e.`id_tmpenc`
left join sf_tmpdet d 		on e.`id_tmpenc` = d.`id_tmpenc`
where p.`fecha` between '2018-01-01' and '2018-12-31'
and d.`cuenta` = '1510110201'
-- mand v.`no_vale` is not null
;

-- Reporte de Produccion: Producto x Cantidad x Costo x MES
select MONTH(p.`fecha`) as mes, m.`cod_art`, i.`descri`, SUM(m.`cantidad`) as cantidad, SUM(d.`debe`) as costo
from ordenproduccion o
left join planificacionproduccion p on o.`idplanificacionproduccion` = p.`idplanificacionproduccion`
left join inv_vales v  		on o.`no_vale`  = v.`no_vale`
left join inv_movdet m 		on v.`no_trans` = m.`no_trans`
left join inv_articulos i 	on m.`cod_art`  = i.`cod_art` 
left join sf_tmpenc e 		on v.`idtmpenc` = e.`id_tmpenc`
left join sf_tmpdet d 		on e.`id_tmpenc` = d.`id_tmpenc`
where p.`fecha` between '2018-01-01' and '2018-12-31'
and d.`cuenta` = '1510110201'
group by MONTH(p.`fecha`) , m.`cod_art`, i.`descri`
;

-- Reporte de Produccion: Producto x Cantidad x Costo x AÑO
select YEAR(p.`fecha`) as mes, m.`cod_art`, i.`descri`, SUM(m.`cantidad`) as cantidad, SUM(d.`debe`) as costo
from ordenproduccion o
left join planificacionproduccion p on o.`idplanificacionproduccion` = p.`idplanificacionproduccion`
left join inv_vales v  		on o.`no_vale`  = v.`no_vale`
left join inv_movdet m 		on v.`no_trans` = m.`no_trans`
left join inv_articulos i 	on m.`cod_art`  = i.`cod_art` 
left join sf_tmpenc e 		on v.`idtmpenc` = e.`id_tmpenc`
left join sf_tmpdet d 		on e.`id_tmpenc` = d.`id_tmpenc`
where p.`fecha` between '2018-01-01' and '2018-12-31'
and d.`cuenta` = '1510110201'
group by YEAR(p.`fecha`) , m.`cod_art`, i.`descri`
;


-- REPROCESO
--
-- SELECT p.`fecha`, pb.`codigo`, pb.`estado`, pb.`no_vale`, i.`cod_art`, i.`descri`, ps.`cantidad` AS cantidad, ps.`costototalproduccion`, ps.`costounitario`, pb.`id_tmpenc`, e.`no_trans`, e.`tipo_doc`, e.`no_doc`, e.`estado`, d.`id_tmpdet`, d.`debe`, d.`cod_art`
select  MONTH(p.`fecha`)as mes, i.`cod_art`, i.`descri`, SUM(ps.`cantidad`) as cantidad, SUM(d.`debe`) as costo
from productosimple ps
left join productosimpleprocesado pp on ps.`idproductosimple` = pp.`idproductosimple`
left join metaproductoproduccion m   on pp.`idmetaproductoproduccion` = m.`idmetaproductoproduccion`
left join productobase pb            on ps.`idproductobase` = pb.`idproductobase`
left join planificacionproduccion p  on pb.`idplanificacionproduccion` = p.`idplanificacionproduccion`
left join inv_articulos i 	     on m.`cod_art`  = i.`cod_art`
left join sf_tmpenc e 		on pb.`id_tmpenc` = e.`id_tmpenc`
left join sf_tmpdet d 		on e.`id_tmpenc` = d.`id_tmpenc`
where p.`fecha` between '2018-01-01' and '2018-12-31'
and d.`cuenta` = '1510110201'
group by MONTH(p.`fecha`), i.`cod_art`, i.`descri`
;

-- REPORTE TOTAL MESxDia
-- Union Normal - Reproceso
select z.dia, z.cod_art, z.nombrecorto, SUM(z.cantidad) as cantidad, SUM(z.costo) as costo, SUM(z.costo) / SUM(z.cantidad) as unit
from (
	select DAY(p.`fecha`) as dia, m.`cod_art`, i.nombrecorto , SUM(m.`cantidad`) as cantidad, SUM(d.`debe`) as costo
	from ordenproduccion o
	left join planificacionproduccion p on o.`idplanificacionproduccion` = p.`idplanificacionproduccion`
	-- left join inv_vales v  		on o.`no_vale`  = v.`no_vale`
	left join inv_vales v 		on o.`idordenproduccion` = v.`idordenproduccion`
	left join inv_movdet m 		on v.`no_trans` = m.`no_trans`
	left join inv_articulos i 	on m.`cod_art`  = i.`cod_art` 
	left join sf_tmpenc e 		on v.`idtmpenc` = e.`id_tmpenc`
	left join sf_tmpdet d 		on e.`id_tmpenc` = d.`id_tmpenc`
	where p.`fecha` between '2019-04-01' and '2019-04-30'
	and d.`cuenta` = '1510110201'
	group by DAY(p.`fecha`) , m.`cod_art`, i.`descri`
	union all
	select  DAY(p.`fecha`)as dia, i.`cod_art`, i.`nombrecorto`, SUM(ps.`cantidad`) as cantidad, SUM(d.`debe`) as costo
	from productosimple ps
	left join productosimpleprocesado pp on ps.`idproductosimple` = pp.`idproductosimple`
	left join metaproductoproduccion m   on pp.`idmetaproductoproduccion` = m.`idmetaproductoproduccion`
	left join productobase pb            on ps.`idproductobase` = pb.`idproductobase`
	left join planificacionproduccion p  on pb.`idplanificacionproduccion` = p.`idplanificacionproduccion`
	left join inv_articulos i 	     on m.`cod_art`  = i.`cod_art`
	left join sf_tmpenc e 		on pb.`id_tmpenc` = e.`id_tmpenc`
	left join sf_tmpdet d 		on e.`id_tmpenc` = d.`id_tmpenc`
	where p.`fecha` between '2019-04-01' and '2019-04-30'
	and d.`cuenta` = '1510110201'
	and i.`cod_art` = d.`cod_art`
	group by DAY(p.`fecha`), i.`cod_art`, i.`descri`
) z
group by z.dia, z.cod_art, z.nombrecorto
;




select DAY(p.`fecha`) as dia, m.`cod_art`, i.nombrecorto , SUM(m.`cantidad`) as cantidad, SUM(d.`debe`) as costo
from ordenproduccion o
left join planificacionproduccion p on o.`idplanificacionproduccion` = p.`idplanificacionproduccion`
left join inv_vales v 		on o.`idordenproduccion` = v.`idordenproduccion`
left join inv_movdet m 		on v.`no_trans` = m.`no_trans`
left join inv_articulos i 	on m.`cod_art`  = i.`cod_art` 
left join sf_tmpenc e 		on v.`idtmpenc` = e.`id_tmpenc`
left join sf_tmpdet d 		on e.`id_tmpenc` = d.`id_tmpenc`
where p.`fecha` between '2019-02-01' and '2019-02-28'
and d.`cuenta` = '1510110201'
group by DAY(p.`fecha`) , m.`cod_art`, i.`descri`;



select  DAY(p.`fecha`)as dia, i.`cod_art`, i.`nombrecorto`, SUM(ps.`cantidad`) as cantidad, SUM(d.`debe`) as costo
from productosimple ps
left join productosimpleprocesado pp on ps.`idproductosimple` = pp.`idproductosimple`
left join metaproductoproduccion m   on pp.`idmetaproductoproduccion` = m.`idmetaproductoproduccion`
left join productobase pb            on ps.`idproductobase` = pb.`idproductobase`
left join planificacionproduccion p  on pb.`idplanificacionproduccion` = p.`idplanificacionproduccion`
left join inv_articulos i 	     on m.`cod_art`  = i.`cod_art`
left join sf_tmpenc e 		on pb.`id_tmpenc` = e.`id_tmpenc`
left join sf_tmpdet d 		on e.`id_tmpenc` = d.`id_tmpenc`
where p.`fecha` between '2019-02-21' and '2019-02-25'
and d.`cuenta` = '1510110201'
and i.`cod_art` = d.`cod_art`
group by DAY(p.`fecha`), i.`cod_art`, i.`descri`
;










