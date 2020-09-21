-- REPORTE DE INVENTARIO FISICO-VALORADO
select i.`cod_art`as Codigo, a.`descri` as Articulo, a.`cod_med` as Unidad, i.`costouni`as 'Costo Unit', i.`saldofis` as 'Saldo Fis', i.`saldoval` as 'Saldo Val'
from inv_periodo i
left join inv_articulos a on i.`cod_art` = a.`cod_art`
where i.`gestion` = 2020 and i.`mes` = 2
and i.`cod_alm` = 5
;