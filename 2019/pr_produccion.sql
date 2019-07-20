select pl.`fecha`, pr.`cod_art`, i.`descri`, pr.`cantidad`, pr.`costo_a`, pr.`costo_b`, pr.`costo_c`, pr.`costo`, pr.`costouni`
from pr_producto pr
left join pr_plan pl on pr.`idplan` = pl.`idplan`
left join inv_articulos i on pr.`cod_art` = i.`cod_art`
where pl.`fecha` between '2019-05-01' and '2019-05-31'
;


select pr.`cod_art`, i.`descri`, sum(pr.`cantidad`) as cantidad, sum(pr.`costo`) as costo
from pr_producto pr
left join pr_plan pl on pr.`idplan` = pl.`idplan`
left join inv_articulos i on pr.`cod_art` = i.`cod_art`
where pl.`fecha` between '2019-05-01' and '2019-05-31'
group by pr.`cod_art`, i.`descri`
;