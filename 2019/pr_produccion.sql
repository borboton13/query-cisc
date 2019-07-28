select pl.`fecha`, pro.`codigo`, pro.`costototal`, pr.`cod_art`, i.`descri`, pr.`cantidad`, pr.`costo_a`, pr.`costo_b`, pr.`costo_c`, pr.`costo`, pr.`costouni`
from pr_producto pr
left join pr_produccion pro on pr.`idproduccion` = pro.`idproduccion`
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


update pr_produccion p set p.`estado` = 'APR';
update pr_plan p set p.`estado` = 'APR' where p.`fecha` between '2019-05-01' and '2019-06-31';
update periodocostoindirecto p set p.`contab` = 0, p.`procesado` = 0 where p.`idperiodocostoindirecto` = 37;
update periodocostoindirecto p set p.`contab` = 0, p.`procesado` = 0 where p.`idperiodocostoindirecto` = 38;

-- PRODUCCION INSUMOS
select pl.`fecha`, pl.`estado`, p.`codigo`, p.`costototal`, p.`totalmp`, i.`cod_art`, a.`descri`, i.`cantidad`, i.`costouni`, i.`tipo`
from pr_insumo i 
left join inv_articulos a on i.`cod_art` = a.`cod_art`
left join pr_produccion p on i.`idproduccion` = p.`idproduccion`
left join pr_plan pl on p.`idplan` = pl.`idplan`
where pl.`fecha` between '2019-05-01' and '2019-05-31'
-- and i.`idproduccion` = 101
-- and i.`cod_art` = 1
;

select pl.`fecha`, p.`codigo`, p.`totalmp`, i.`cod_art`, a.`descri`, i.`cantidad`, i.`costouni`, i.`tipo`
from pr_insumo i 
left join inv_articulos a on i.`cod_art` = a.`cod_art`
left join pr_produccion p on i.`idproduccion` = p.`idproduccion`
left join pr_plan pl on p.`idplan` = pl.`idplan`
where pl.`fecha` between '2019-05-01' and '2019-05-31'
;



update sf_tmpenc e set e.`estado` = 'ANL'
where e.`tipo_doc` = 'PD'
and e.`fecha` between '2019-05-01' and '2019-05-31'
;





select 
sum(pr.`totalmp`)
from pr_produccion pr
left join pr_plan pl on pr.`idplan` = pl.`idplan`
where pl.`fecha` between '2019-05-01' and '2019-05-31'
;




