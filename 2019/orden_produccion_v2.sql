-- 
select pl.`fecha`, pl.`estado`, pd.`codigo`, pd.`costototal`, pr.`cod_art`, pr.`cantidad`, pr.`costo_a`, pr.`costo_b`, pr.`costo_c`, i.`idinsumo`, i.`idproduccion`, i.`cod_art`, i.`cantidad`, i.`costouni`, i.`tipo`, i.`idproducto`
from pr_insumo i
left join pr_producto pr   on i.`idproducto` = pr.`idproducto`
left join pr_produccion pd on pr.`idproduccion` = pd.`idproduccion`
left join pr_plan pl 	   on pd.`idplan` = pl.`idplan`
where pl.`fecha` = '2019-05-14'
;

select pl.`fecha`, pl.`estado`, pd.`codigo`, pd.`costototal`, i.`idinsumo`, i.`idproduccion`, i.`cod_art`, a.`descri`, i.`cantidad`, i.`costouni`, i.`tipo`, i.`idproducto`, pr.`cod_art`, b.`descri`, pr.`cantidad`
from pr_insumo i
left join pr_produccion pd on i.`idproduccion` = pd.`idproduccion`
left join pr_plan pl 	   on pd.`idplan` = pl.`idplan`
left join inv_articulos a  on i.`cod_art` = a.`cod_art`
left join pr_producto pr   on i.`idproducto` = pr.`idproducto`
left join inv_articulos b  on pr.`cod_art` = b.`cod_art`
where pl.`fecha` = '2019-05-14'
;


select pr.`idproduccion`, i.`cod_art`, sum(i.`cantidad`) as cant, i.`costouni`, sum(i.`costouni` * i.`cantidad`) as TOTAL
from pr_produccion pr
join pr_insumo i on pr.`idproduccion` = i.`idproduccion`
group by pr.`idproduccion`, i.`cod_art`
;



select a.`descri`, sum(p.`cantidad`) as cantidad, sum(p.`costo_a`) as costo_a, sum(p.`costo_b`) as costo_b, sum(p.`costo_c`) as costo_c
from pr_producto p
left join pr_produccion pr on p.`idproduccion` = pr.`idproduccion`
left join pr_plan pl on pr.`idplan` = pl.`idplan`
left join inv_articulos a on p.`cod_art` = a.`cod_art`
where pl.`fecha` between '2019-01-01' and '2019-12-31'
group by a.`descri`
;