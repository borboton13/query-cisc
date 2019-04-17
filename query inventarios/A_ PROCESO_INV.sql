
-- 1.- ACTUALIZAR TABLA AUXINV CON CANTIDAD Y COSTO_PROM A UNA FECHA DADA
-- 1.1 Eliminando tabla
-- DELETE FROM auxinv WHERE alm = 2;

-- 1.2 Insertando
-- INSERT INTO auxinv (cod_art, nombre, cantidad, und, alm, cu, costo_uni, costo_prom)
select 	t.`cod_art`, t.`nombre`, 
	t.`cantidad` + IFNULL(pp.prod_total, 0) - IFNULL(vv.total, 0) + IFNULL(d.cantidad, 0) - IFNULL(ba.cantidad, 0) - IFNULL(br.cantidad, 0) + IFNULL(rec.cantidad, 0) - IFNULL(egr.cantidad, 0) as inv_final, 
	'UN', 2, 0, 0, cu.costo_uni
from inv_inicio t -- -> Inventario inicial, cargar los nuevos productos 
left join (
	select v.`cod_art`, a.`descri`, SUM(v.`TOTAL`) as total
	from ventas v
	join inv_inventario i on v.`cod_art` = i.`cod_art`
	join inv_articulos a  on i.`cod_art` = a.`cod_art`
	where i.`cod_alm` = 2
	and v.`FECHA` between '2019-01-01' and '2019-12-31'
	group by v.`cod_art`, a.`descri`
	) vv on t.`cod_art` = vv.cod_art
left join (
	select p.`COD_ART`, p.`NOMBRE`, SUM((p.`CANTIDAD_SC` + p.`REPROCESO_SC`)) as prod_total
	from producciontotal p
	where p.`FECHA` between '2019-01-01' and '2019-12-31'
	group by p.`COD_ART`, p.`NOMBRE`
	) pp on t.`cod_art` = pp.cod_art
left join (
	-- COSTO UNITARIO PROMEDIO, Ordenes de Produccion
	select 	a.cod_art, i.`descri`, IFNULL( ( (IFNULL(b.costototal, 0) + IFNULL(c.costototal, 0)) / (IFNULL(b.cantidad, 0) + IFNULL(c.cantidad, 0)) ), 0 ) as costo_uni
	from 	( select i.`cod_art`
		  from inv_inventario i
		  where i.`cod_alm` = 2
		) a
	left join (	-- COSTOS TOTALES PRODUCCION NORMAL
				select m.`cod_art`, m.`descripcion`, SUM(op.`cantidadproducida`) as cantidad, SUM(op.`costotoalproduccion`) costototal
				from ordenproduccion op
				join planificacionproduccion p on op.`idplanificacionproduccion` = p.`idplanificacionproduccion`
				join composicionproducto c on op.`idcomposicionproducto` = c.`idcomposicionproducto`
				join productoprocesado pp on c.`idproductoprocesado` = pp.`idproductoprocesado`
				join metaproductoproduccion m on pp.`idproductoprocesado` = m.`idmetaproductoproduccion`
				where p.fecha between '2019-01-01' and '2019-12-31'
				group by m.`cod_art`, m.`descripcion`
		) b 	on a.cod_art = b.cod_art
	left join (	-- COSTOS TOTALES REPROCESOS
				select m.`cod_art`, m.`descripcion`, SUM(ps.`cantidad`) as cantidad, SUM(ps.`costototalproduccion`) as costototal 
				from productosimple ps
				join productobase pb on ps.`idproductobase` = pb.`idproductobase`
				join planificacionproduccion p on pb.`idplanificacionproduccion` = p.`idplanificacionproduccion`
				join productosimpleprocesado pr on ps.`idproductosimple` = pr.`idproductosimple`
				join metaproductoproduccion m on pr.`idmetaproductoproduccion` = m.`idmetaproductoproduccion`
				where p.fecha between '2019-01-01' and '2019-12-31'
				group by m.`cod_art`, m.`descripcion`
		) c 	on a.cod_art = c.cod_art
	left join inv_articulos i on a.cod_art = i.`cod_art`
	) cu on t.`cod_art` = cu.cod_art
left join (
	-- DEVOLUCION DE PRODUCTOS
	select d.`cod_art`, d.`descri`, SUM(d.`cantidad`) as cantidad
	from inv_devolucion d
	where d.`cod_alm` = 2
	and d.`fecha` between '2019-01-01' and '2019-12-31'
	group by d.`cod_art`, d.`descri`
	) d on t.cod_art = d.cod_art
left join (
	-- BAJA DE PRODUCTOS
	select b.`cod_art`, b.`descri`, SUM(b.`cantidad`)  as cantidad
	from inv_bajas b
	where b.`cod_alm` = 2
	and b.`fecha` between '2019-01-01' and '2019-12-31'
	group by b.`cod_art`, b.`descri`
	) ba on t.cod_art = ba.cod_art
left join (
	-- BAJA X REPROCESOS
	select b.`cod_art`, b.`descri`, SUM(b.`cantidad`)  as cantidad
	from inv_reprocesos b
	where b.`cod_alm` = 2
	and b.`fecha` between '2019-01-01' and '2019-12-31'
	group by b.`cod_art`, b.`descri`
	) br on t.cod_art = br.cod_art

left join (
	select d.`cod_art`, SUM(d.`cantidad`) as cantidad
	from inv_movdet d
	left join inv_vales v on d.`no_trans` = v.`no_trans`
	where v.`fecha` between '2019-01-01' and '2019-12-31'
	and v.`cod_doc` in ('REC', 'EGR')
	and v.`cod_alm` = 2
	and v.`idordenproduccion` is null
	and v.`idproductobase` is null
	and d.`tipo_mov` = 'E'
	group by d.`cod_art`
	) rec on t.cod_art = rec.cod_art
left join (
	select d.`cod_art`, SUM(d.`cantidad`) as cantidad
	from inv_movdet d
	left join inv_vales v on d.`no_trans` = v.`no_trans`
	where v.`fecha` between '2019-01-01' and '2019-12-31'
	and v.`cod_doc` in ('REC', 'EGR')
	and v.`cod_alm` = 2
	and v.`idordenproduccion` is null
	and v.`idproductobase` is null
	and d.`tipo_mov` = 'S'
	group by d.`cod_art`
	) egr on t.cod_art = egr.cod_art
where t.alm = 2 and t.gestion = 2019
;


select d.`cod_art`, SUM(d.`cantidad`) as cantidad
from inv_movdet d
left join inv_vales v on d.`no_trans` = v.`no_trans`
where v.`fecha` between '2018-01-01' and '2018-09-30'
and v.`cod_doc` in ('REC', 'EGR')
and v.`cod_alm` = 2
and v.`idordenproduccion` is null
and v.`idproductobase` is null
and d.`tipo_mov` = 'S'
group by d.`cod_art`
;
select *
from inv_articulos i
where i.`descri` like '%YOG%120%';

-- 2. Actualizando CostoS 
-- 	Queso Prensado en EDAM, 
--	127 LECHE SABORIZADA FRUTILLA 120
-- 	478 ILFRUT DURAZNO 150 ML 
--	138 YOGURT SACHET DURAZNO 80 CC

update auxinv i set i.`costo_prom` = 0.637661 where i.`cod_art` = 127;
update auxinv i set i.`costo_prom` = 0.266430 where i.`cod_art` = 478;
update auxinv i set i.`costo_prom` = 0.387188 where i.`cod_art` = 138;

update auxinv i set i.`costo_prom` = 0.720466 where i.`cod_art` = 125; -- FRUTIKID
update auxinv i set i.`costo_prom` = 0.769829 where i.`cod_art` = 585; -- BANANA 160
update auxinv i set i.`costo_prom` = 18.372657 where i.`cod_art` = 148; -- EDAM
-- UPDATE auxinv i SET i.`costo_prom` = 18.372657 WHERE i.`cod_art` = 151; -- PRENSADO

update auxinv i set i.`costo_prom` = 0.621655 where i.`cod_art` = 120; -- LECHE SABORIZADA CHOCOLATE 160ML ***


-- 4.- ACTUALIZAR INV_ARTICULOS, COSTO_UNI, CU, SALDO_MON
-- 4.1 Fijando en CERO
update inv_articulos i
join auxinv a on i.`cod_art` = a.`cod_art`
set i.`costo_uni` = 0, i.`cu` = 0, i.`saldo_mon` = 0, i.ct = 0
where a.`alm` = 2;

-- 
update inv_articulos i
join auxinv a on i.`cod_art` = a.`cod_art`
set 	i.`costo_uni` = a.`costo_prom`, 
	i.`cu` 	      = (a.`costo_prom`*100)/87, 
	i.`saldo_mon` = a.`cantidad` * a.`costo_prom`, 
	i.ct 	      = a.`cantidad` * ((a.`costo_prom`*100)/87)
where a.`alm` = 2;


-- 3. ACTUALIZAR TABLAS INV_INVENTARIO, INV_INVENTARIO_DETALLE
update inv_inventario_detalle i set i.`cantidad` = 0, i.`version` = 0 where i.`cod_alm` = 2;
update inv_inventario i set i.`saldo_uni` = 0, i.`version` = 0 where i.`cod_alm` = 2;


update inv_inventario i
join auxinv a on i.`cod_art` = a.`cod_art`
set i.`saldo_uni` = a.`cantidad`
where i.`cod_alm` = 2
;

update inv_inventario_detalle i
join auxinv a on i.`cod_art` = a.`cod_art`
set i.`cantidad` = a.`cantidad`
where i.`cod_alm` = 2
;

-- Fijando en cero QUESO RECORTE
update inv_inventario i         set i.`saldo_uni` = 0 where i.`cod_art` = 195;
update inv_inventario_detalle i set i.`cantidad`  = 0 where i.`cod_art` = 195;

update inv_inventario i         set i.`saldo_uni` = 0 where i.`cod_art` = 196;
update inv_inventario_detalle i set i.`cantidad`  = 0 where i.`cod_art` = 196;

-- ---------------------------------------------------------------------------------------
-- CRUCE INV_INICIO - INV_ARTICULOS
select a.`cod_art`, a.`descri`, a.`saldo_mon`, a.`ct`, a.`costo_uni`, a.`cu`, i.`cod_art`, i.`nombre`, i.`costo_uni`
from inv_articulos a
left join inv_inicio i on a.`cod_art` = i.`cod_art`
where a.`cod_alm` = 1
and i.`gestion` = 2019
;


-- UPDATE inv_inventario i SET i.`saldo_uni` = 0, i.`version` = 0 WHERE i.`cod_alm` = 1;
-- UPDATE inv_inventario_detalle i SET i.`cantidad` = 0, i.`version` = 0 WHERE i.`cod_alm` = 1;

