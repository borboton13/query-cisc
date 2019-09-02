select 	t.`cod_art`, t.`nombre`, 
	t.`cantidad` + IFNULL(pp.prod_total, 0) - IFNULL(vv.total, 0) + IFNULL(d.cantidad, 0) - IFNULL(ba.cantidad, 0) - IFNULL(br.cantidad, 0) + IFNULL(rec.cantidad, 0) - IFNULL(egr.cantidad, 0) as inv_final,
	a.estado
from inv_inicio t -- -> Inventario inicial, cargar los nuevos productos 
left join (
	select v.`cod_art`, a.`descri`, SUM(v.`TOTAL`) as total
	from ventas v
	join inv_inventario i on v.`cod_art` = i.`cod_art`
	join inv_articulos a  on i.`cod_art` = a.`cod_art`
	where i.`cod_alm` = 2
	and v.`FECHA` between '2019-01-01' and '2019-08-31'
	group by v.`cod_art`, a.`descri`
	) vv on t.`cod_art` = vv.cod_art
left join (
	select p.`COD_ART`, p.`NOMBRE`, SUM((p.`CANTIDAD_SC` + p.`REPROCESO_SC`)) as prod_total
	from producciontotal p
	where p.`FECHA` between '2019-01-01' and '2019-08-31'
	group by p.`COD_ART`, p.`NOMBRE`
	) pp on t.`cod_art` = pp.cod_art
left join (
	-- DEVOLUCION DE PRODUCTOS
	select d.`cod_art`, d.`descri`, SUM(d.`cantidad`) as cantidad
	from inv_devolucion d
	where d.`cod_alm` = 2
	and d.`fecha` between '2019-01-01' and '2019-08-31'
	group by d.`cod_art`, d.`descri`
	) d on t.cod_art = d.cod_art
left join (
	-- BAJA DE PRODUCTOS
	select b.`cod_art`, b.`descri`, SUM(b.`cantidad`)  as cantidad
	from inv_bajas b
	where b.`cod_alm` = 2
	and b.`fecha` between '2019-01-01' and '2019-08-31'
	group by b.`cod_art`, b.`descri`
	) ba on t.cod_art = ba.cod_art
left join (
	-- BAJA X REPROCESOS
	select b.`cod_art`, b.`descri`, SUM(b.`cantidad`)  as cantidad
	from inv_reprocesos b
	where b.`cod_alm` = 2
	and b.`fecha` between '2019-01-01' and '2019-08-31'
	group by b.`cod_art`, b.`descri`
	) br on t.cod_art = br.cod_art
left join (
	select d.`cod_art`, SUM(d.`cantidad`) as cantidad
	from inv_movdet d
	left join inv_vales v on d.`no_trans` = v.`no_trans`
	where v.`fecha` between '2019-01-01' and '2019-08-31'
	and v.`cod_doc` in ('REC', 'EGR')
	and v.`cod_alm` = 2
	and v.`idordenproduccion` is null
	and v.`idproductobase` is null
	and d.`tipo_mov` = 'E'
	and v.estado <> 'ANL'
	group by d.`cod_art`
	) rec on t.cod_art = rec.cod_art
left join (
	select d.`cod_art`, SUM(d.`cantidad`) as cantidad
	from inv_movdet d
	left join inv_vales v on d.`no_trans` = v.`no_trans`
	where v.`fecha` between '2019-01-01' and '2019-08-31'
	and v.`cod_doc` in ('REC', 'EGR')
	and v.`cod_alm` = 2
	and v.`idordenproduccion` is null
	and v.`idproductobase` is null
	and d.`tipo_mov` = 'S'
	and v.estado <> 'ANL'
	group by d.`cod_art`
	) egr on t.cod_art = egr.cod_art
left join inv_articulos a on t.cod_art = a.cod_art
where t.alm = 2 and t.gestion = 2019
and a.estado = 'VIG'
;
