select

 	a.`idactivo`, 
	s.`descri`,
	a.`descri`, 
	a.`fch_alta`, a.`fch_baja`, a.`fch_ajuste`, 
	a.`duracion`,
	a.`vobs`, a.`vosus`, a.`voufv`,
	a.`tasa_dep`, a.`tasabssus`, a.`tasabsufv`, 
	a.`estado`, 
	a.`dep_acu_vo`, a.`dep_vo`, 
	a.`ulttasabssus`, a.`ulttasabsufv`, 
	d.`idhdepre`,
	d.`fecha_en_proceso`,
	d.`fecha`,
	d.`tasabsufv`,
	d.`dep_acu_vo`, d.`dep_acu_vo_bs`, d.`dep_vo`, d.`dep_vo_bs`, d.`val_tot`

-- a.`idactivo`, d.`idhdepre`
from af_activos a
left join af_hdepre d 	 on a.`idactivo` = d.`idactivo`
left join af_subgrupos s on a.`subgrupo` = s.`subgrupo`
left join `af_grupos` g  on a.`grupo`	 = g.`grupo`
where d.`fecha_en_proceso` = '2020-01-31'
;

--

-- ---------------------------------------------
-- REPORTE FINAL OFICIAL ACTIVOS FIJOS
-- -------------------------------------------
select
 	a.`idactivo`, 
	s.`descri`,
	s.`cta_vo`,
	a.`descri`, 
	a.`fch_alta`, -- a.`fch_baja`, a.`fch_ajuste`, 
	-- a.`estado`, 
	a.`duracion` / 12 as vida_util,
	a.`vobs`, -- a.`vosus`, a.`voufv`,
	-- a.`tasa_dep`, a.`tasabssus`, a.`tasabsufv`, 
	-- a.`dep_acu_vo`, 
	if(a.estado = 'TDP' or a.estado = 'BAJ' , a.`vobs`, a.`dep_acu_vo`) as DEP_ACUM_VO,
	-- a.`dep_vo`,
	-- (a.`vobs` - a.`dep_acu_vo`) AS saldo_net,
	if(a.estado = 'TDP' or a.estado = 'BAJ' , 0, (a.`vobs` - a.`dep_acu_vo`)) as saldo_neto,
	-- a.`ulttasabssus`, a.`ulttasabsufv`
	-- 2016, year(a.`fch_alta`) as anio,
	-- 2019 - YEAR(a.`fch_alta`) AS dif_year,
	-- (a.`duracion` / 12) - (2016 - YEAR(a.`fch_alta`)) as vida_res,
	if( ((a.`duracion` / 12) - (2019 - year(a.`fch_alta`))) < 0 , 0 , ((a.`duracion` / 12) - (2019 - year(a.`fch_alta`))) ) as vida_rest
from af_activos a
-- LEFT JOIN af_hdepre d 	 ON a.`idactivo` = d.`idactivo`
left join af_subgrupos s on a.`subgrupo` = s.`subgrupo`
left join `af_grupos` g  on a.`grupo`	 = g.`grupo`
;

-- 
select
 	a.`idactivo`, 
	s.`descri`,
	s.`cta_vo`,
	a.`descri`, 
	a.`fch_alta`, -- a.`fch_baja`, a.`fch_ajuste`, 
	a.`estado`, 
	a.`duracion` / 12 as vida_util,
	
	a.`vobs`, a.`vosus`, a.`voufv`,
	a.`tasa_dep`, a.`tasabssus`, a.`tasabsufv`, 
	
	if(a.estado = 'TDP' or a.estado = 'BAJ' , a.`vobs`, a.`dep_acu_vo`) as DEP_ACUM_VO,
	a.`dep_vo`,
	if(a.estado = 'TDP' or a.estado = 'BAJ' , 0, (a.`vobs` - a.`dep_acu_vo`)) as saldo_neto,
	(a.`vobs` - a.`dep_acu_vo`) as saldo_net,
	a.`ulttasabssus`, a.`ulttasabsufv`,
	if( ((a.`duracion` / 12) - (2020 - year(a.`fch_alta`))) < 0 , 0 , ((a.`duracion` / 12) - (2019 - year(a.`fch_alta`))) ) as vida_rest
from af_activos a
-- LEFT JOIN af_hdepre d 	 ON a.`idactivo` = d.`idactivo`
left join af_subgrupos s on a.`subgrupo` = s.`subgrupo`
left join `af_grupos` g  on a.`grupo`	 = g.`grupo`
;


update af_activos a set a.`estado` = 'TDP' where a.`idactivo` = 1;
update af_activos a set a.`desecho` = 0;

