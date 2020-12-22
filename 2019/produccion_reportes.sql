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
select month(p.`fecha`) as mes, m.`cod_art`, i.`descri`, sum(m.`cantidad`) as cantidad, sum(d.`debe`) as costo
from ordenproduccion o
left join planificacionproduccion p on o.`idplanificacionproduccion` = p.`idplanificacionproduccion`
left join inv_vales v  		on o.`no_vale`  = v.`no_vale`
left join inv_movdet m 		on v.`no_trans` = m.`no_trans`
left join inv_articulos i 	on m.`cod_art`  = i.`cod_art` 
left join sf_tmpenc e 		on v.`idtmpenc` = e.`id_tmpenc`
left join sf_tmpdet d 		on e.`id_tmpenc` = d.`id_tmpenc`
where p.`fecha` between '2018-01-01' and '2018-12-31'
and d.`cuenta` = '1510110201'
group by month(p.`fecha`) , m.`cod_art`, i.`descri`
;

-- Reporte de Produccion: Producto x Cantidad x Costo x AÑO
select year(p.`fecha`) as mes, m.`cod_art`, i.`descri`, sum(m.`cantidad`) as cantidad, sum(d.`debe`) as costo
from ordenproduccion o
left join planificacionproduccion p on o.`idplanificacionproduccion` = p.`idplanificacionproduccion`
left join inv_vales v  		on o.`no_vale`  = v.`no_vale`
left join inv_movdet m 		on v.`no_trans` = m.`no_trans`
left join inv_articulos i 	on m.`cod_art`  = i.`cod_art` 
left join sf_tmpenc e 		on v.`idtmpenc` = e.`id_tmpenc`
left join sf_tmpdet d 		on e.`id_tmpenc` = d.`id_tmpenc`
where p.`fecha` between '2018-01-01' and '2018-12-31'
and d.`cuenta` = '1510110201'
group by year(p.`fecha`) , m.`cod_art`, i.`descri`
;


-- REPROCESO
--
-- SELECT p.`fecha`, pb.`codigo`, pb.`estado`, pb.`no_vale`, i.`cod_art`, i.`descri`, ps.`cantidad` AS cantidad, ps.`costototalproduccion`, ps.`costounitario`, pb.`id_tmpenc`, e.`no_trans`, e.`tipo_doc`, e.`no_doc`, e.`estado`, d.`id_tmpdet`, d.`debe`, d.`cod_art`
select  month(p.`fecha`)as mes, i.`cod_art`, i.`descri`, sum(ps.`cantidad`) as cantidad, sum(d.`debe`) as costo
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
group by month(p.`fecha`), i.`cod_art`, i.`descri`
;

-- REPORTE PRODUCCION TOTAL COSTO X DIA
-- Union Normal - Reproceso
select z.dia, z.cod_art, z.nombrecorto, sum(z.cantidad) as cantidad, sum(z.costo) as costo, sum(z.costo) / sum(z.cantidad) as unit
from (
	select day(p.`fecha`) as dia, m.`cod_art`, i.nombrecorto , sum(m.`cantidad`) as cantidad, sum(d.`debe`) as costo
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
	group by day(p.`fecha`) , m.`cod_art`, i.`descri`
	union all
	select  day(p.`fecha`)as dia, i.`cod_art`, i.`nombrecorto`, sum(ps.`cantidad`) as cantidad, sum(d.`debe`) as costo
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
	group by day(p.`fecha`), i.`cod_art`, i.`descri`
) z
group by z.dia, z.cod_art, z.nombrecorto
;


-- REPORTE PRODUCCION TOTAL COSTO X DIA v2
-- Para: Planilla de Costo de Produccion v2
select day(pl.`fecha`) as dia, pr.`cod_art`, i.`nombrecorto`, sum(pr.`cantidad`) as cantidad, sum(pr.`costo`) as costo, sum(pr.`costo`)/sum(pr.`cantidad`) as unit
from pr_producto pr
left join pr_plan pl on pr.`idplan` = pl.`idplan`
left join inv_articulos i on pr.`cod_art` = i.`cod_art`
where pl.`fecha` between '2020-11-01' and '2020-11-31'
-- and i.cod_gru in (4, 6)
-- and i.cod_gru in (5)
group by day(pl.`fecha`), pr.`cod_art`, i.`descri`
;

-- REPORTE PRODUCCION TOTAL COSTO X DIA v2 - Desde Contabilidad
-- Para: Planilla de Costo de Produccion v2
select day(e.`fecha`)as dia, d.cod_art, a.`nombrecorto`,
sum(d.cant_art)  as cantidad,
sum(d.debe)     as costo,
-- sum(if(d.debe>0, d.cant_art, 0))  as cant_e
sum(d.debe) / sum(d.cant_art) as unit
from sf_tmpdet d
left join sf_tmpenc e on d.id_tmpenc = e.id_tmpenc
left join inv_articulos a on d.cod_art = a.cod_art
where e.fecha between '2020-01-01' and '2020-01-31'
and d.cuenta = '1510110201'
and e.`tipo_doc` = 'PD'
and e.estado <> 'ANL'
group by day(e.`fecha`), d.cod_art, a.`nombrecorto`
;


-- ASIENTOS - ARTICULOS ENTRADA - SALIDA
-- select e.`tipo_doc`, e.`no_doc`, d.cod_art, a.descri, a.cod_med,
select d.cod_art, a.descri, a.cod_med,
sum(d.debe)     as debe,
sum(d.haber)    as haber,
sum(if(d.debe>0, d.cant_art, 0))  as cant_e,
sum(if(d.haber>0, d.cant_art, 0)) as cant_s
from sf_tmpdet d
left join sf_tmpenc e on d.id_tmpenc = e.id_tmpenc
left join inv_articulos a on d.cod_art = a.cod_art
where e.fecha between '2019-10-01' and '2019-10-31'
and d.cuenta = '1510110201'
and e.`tipo_doc` = 'PD'
and e.estado <> 'ANL'
-- group by e.`tipo_doc`, e.`no_doc`, d.cod_art, a.descri, a.cod_med
group by d.cod_art, a.descri, a.cod_med
;






