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


-- CAMBIAR ESTADO EN PR_PRODUCCION
-- update pr_produccion pr
join pr_plan pl on pr.`idplan` = pl.`idplan`
set pr.`estado` = 'APR'
where pl.`fecha` between '2019-11-01' and '2019-11-30'
;

-- update pr_plan p set p.`estado` = 'APR' where p.`fecha` between '2019-11-01' and '2019-11-30';
update periodocostoindirecto p set p.`contab` = 0, p.`procesado` = 0 where p.`idperiodocostoindirecto` = 37;


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

-- update sf_tmpenc e set e.`estado` = 'ANL'
where e.`tipo_doc` = 'PD'
and e.`fecha` between '2019-05-01' and '2019-05-31'
;


-- delete from sf_tmpdet
where id_tmpenc in (
	select e.`id_tmpenc`
	from sf_tmpenc e
	where e.`tipo_doc` = 'PD'
	and e.`fecha` between '2019-11-01' and '2019-11-30'
);



select 
sum(pr.`totalmp`)
from pr_produccion pr
left join pr_plan pl on pr.`idplan` = pl.`idplan`
where pl.`fecha` between '2019-05-01' and '2019-05-31'
;




