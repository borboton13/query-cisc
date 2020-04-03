
select pl.`fecha`, pro.`codigo`, pro.`costototal`, pr.`cod_art`, i.`descri`, pr.`cantidad`, pr.`costo_a`, pr.`costo_b`, pr.`costo_c`, pr.`costo`, pr.`costouni`
from pr_producto pr
left join pr_produccion pro on pr.`idproduccion` = pro.`idproduccion`
left join pr_plan pl on pr.`idplan` = pl.`idplan`
left join inv_articulos i on pr.`cod_art` = i.`cod_art`
where pl.`fecha` between '2019-12-01' and '2019-12-31'
;

select pr.`cod_art`, i.`descri`, sum(pr.`cantidad`) as cantidad, sum(pr.`costo`) as costo
from pr_producto pr
left join pr_plan pl on pr.`idplan` = pl.`idplan`
left join inv_articulos i on pr.`cod_art` = i.`cod_art`
where pl.`fecha` between '2019-08-01' and '2019-10-31'
group by pr.`cod_art`, i.`descri`
;


-- TRANSFERENCIA, BAJAS, ... PT
select *
from inv_vales i
-- update inv_vales i set i.`idtmpenc` = null
where i.`fecha` between '2020-01-01' and '2020-01-31'
and i.`oper` in ('TP', 'BA', 'DE')
;



-- CAMBIAR ESTADO EN PR_PRODUCCION
-- update pr_produccion pr
join pr_plan pl on pr.`idplan` = pl.`idplan`
set pr.`estado` = 'APR'
where pl.`fecha` between '2020-02-01' and '2020-02-29'
;

update pr_plan p set p.`estado` = 'APR' where p.`fecha` between '2020-02-01' and '2020-02-29';
update periodocostoindirecto p set p.`contab` = 0, p.`procesado` = 0 where p.`idperiodocostoindirecto` = 47;


-- PRODUCCION INSUMOS
select pl.`fecha`, pl.`estado`, p.`codigo`, p.`costototal`, p.`totalmp`, i.`cod_art`, a.`descri`, i.`cantidad`, i.`costouni`, i.`tipo`
from pr_insumo i 
left join inv_articulos a on i.`cod_art` = a.`cod_art`
left join pr_produccion p on i.`idproduccion` = p.`idproduccion`
left join pr_plan pl on p.`idplan` = pl.`idplan`
where pl.`fecha` between '2019-10-01' and '2019-10-31'
-- and i.`idproduccion` = 101
-- and i.`cod_art` in (1)
;

select pl.`fecha`, p.`codigo`, p.`totalmp`, i.`cod_art`, a.`descri`, i.`cantidad`, i.`costouni`, i.`tipo`
from pr_insumo i 
left join inv_articulos a on i.`cod_art` = a.`cod_art`
left join pr_produccion p on i.`idproduccion` = p.`idproduccion`
left join pr_plan pl on p.`idplan` = pl.`idplan`
where pl.`fecha` between '2019-05-01' and '2019-05-31'
;

select pl.`fecha`, sum(p.`totalmp`) as cant
from pr_produccion p 
left join pr_plan pl on p.`idplan` = pl.`idplan`
where pl.`fecha` between '2019-10-01' and '2019-10-31'
group by pl.`fecha`
;

-- ARTICULOS EN FORMULA DE PRODUCCION
select pl.`fecha`, pr.`codigo`, p.`cod_art`, i.`descri`, p.`cantidad`, p.`costouni`
from pr_insumo p
left join inv_articulos i on p.`cod_art` = i.`cod_art`
left join pr_produccion pr on p.`idproduccion` = pr.`idproduccion`
left join pr_plan pl on pr.`idplan` = pl.`idplan`
;


-- ARTICULOS GRAL: INSUMOS, MATERIALES
select i.`cod_alm`, i.`cod_art`, i.`descri`, i.`costo_uni`, i.`saldo_mon`, i.`cuenta_art`, a.`descri`, i.`estado`
from inv_articulos i
left join arcgms a on i.`cuenta_art` = a.`cuenta`
where i.`cod_alm` in (1, 3)
;

-- DISTRIBUCION DE LECHE
select month(pl.`fecha`) as mes, c.`nombre`, sum(i.`cantidad`) as cantidad
from pr_insumo i
left join pr_produccion p 	on i.`idproduccion`    = p.`idproduccion`
left join pr_plan pl 		on p.`idplan` 	       = pl.`idplan`	
left join pr_insumoformula ii 	on i.`idinsumoformula` = ii.`idinsumoformula`
left join pr_formula f 		on ii.`idformula`      = f.`idformula`
left join pr_categoria c 	on f.`idcategoria`     = c.`idcategoria`
where pl.`fecha` between '2020-01-01' and '2020-02-29'
and i.`cod_art` in (1)
group by mes, c.`nombre`
;

-- DISTRIBUCION YOG_BASE
select month(pl.`fecha`) as mes, c.`nombre`, sum(i.`cantidad`) as cantidad
from pr_insumo i
left join pr_produccion p 	on i.`idproduccion`    = p.`idproduccion`
left join pr_plan pl 		on p.`idplan` 	       = pl.`idplan`	
left join pr_insumoformula ii 	on i.`idinsumoformula` = ii.`idinsumoformula`
left join pr_formula f 		on ii.`idformula`      = f.`idformula`
left join pr_categoria c 	on f.`idcategoria`     = c.`idcategoria`
where pl.`fecha` between '2020-01-01' and '2020-02-29'
and i.`cod_art` in (182, 183)
group by mes, c.`nombre`
;


-- CANTIDAD DE PRODUCCION X MES X PRODUCTO
select month(p.`FECHA`) as mes, p.`COD_ART`, p.`NOMBRE`, sum(p.`CANT_TOTAL`) as CANT, sum(p.`COSTOTOTALPRODUCCION`) as COSTO
from producciontotal p
where p.`FECHA` between '2019-01-01' and '2019-12-31'
group by mes, p.`COD_ART`, p.`NOMBRE`
;
-- CANTIDAD DE PRODUCCION X PRODUCTO
select p.`COD_ART`, p.`NOMBRE`, sum(p.`CANT_TOTAL`) as CANT, sum(p.`COSTOTOTALPRODUCCION`) as COSTO
from producciontotal p
where p.`FECHA` between '2019-01-01' and '2019-12-31'
group by p.`COD_ART`, p.`NOMBRE`
;


