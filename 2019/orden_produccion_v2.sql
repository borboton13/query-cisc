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


select pr.`idproduccion`, i.`cod_art`, sum(i.`cantidad`) as cant, I.`costouni`, sum(i.`costouni` * i.`cantidad`) as TOTAL
from pr_produccion pr
join pr_insumo i on pr.`idproduccion` = i.`idproduccion`
group by pr.`idproduccion`, i.`cod_art`
;

