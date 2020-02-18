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
	a.`fch_alta`,
	a.duracion,
	a.`estado`, 
	a.dep_vo,
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
left join af_subgrupos s on a.`subgrupo` = s.`subgrupo`
left join `af_grupos` g  on a.`grupo`	 = g.`grupo`
;

-- 
--

-- ACTUALIZAR ACTIVOS FIJOS ILVA INICIO 2020
/** 17.02.2020 actualizar activos fijos ILVA **/
update af_activos a set a.`estado` = 'DEP' where a.`idactivo` = 364;
update af_activos a set a.`dep_acu_vo` = 66604.65 where a.`idactivo` = 364;
update af_activos a set a.`dep_acu_vo` = a.`vobs` where a.`estado` in ('BAJ', 'TDP');
update af_activos a set a.`dep_vo` = round(a.`vobs`/a.`duracion`, 2) where a.`dep_vo` > 0 ;
update af_activos a set a.`moneda` = 'P';
--
/** TEST Corregige acumulado al 31/12/2019 Edificios **/
update af_activos set dep_acu_vo = 	148656.71	, dep_vo = 	1238.81	  where idactivo =  	23	 ; 
update af_activos set dep_acu_vo = 	70840.89	, dep_vo = 	295.17	  where idactivo =  	27	 ; 
update af_activos set dep_acu_vo = 	257177.60	, dep_vo = 	996.81	  where idactivo =  	36	 ; 
update af_activos set dep_acu_vo = 	17411.10	, dep_vo = 	97.82	  where idactivo =  	145	 ; 
update af_activos set dep_acu_vo = 	5294.89	, dep_vo = 	35.30	  where idactivo =  	182	 ; 
update af_activos set dep_acu_vo = 	9625.00	, dep_vo = 	72.92	  where idactivo =  	208	 ; 
update af_activos set dep_acu_vo = 	2461.96	, dep_vo = 	32.83	  where idactivo =  	319	 ; 



--

select 	a.`idactivo`, a.`descri`, a.`fch_alta`, a.`vobs`, a.`voufv`, a.`vosus`, a.`tasa_dep`, a.`dep_vo`, a.`dep_acu_vo`, a.`estado`,
	d.`idhdepre`, d.`fecha_en_proceso` as fecha , d.`tasabsufv`, d.`tasabssus`,
	d.`dep_acu_vo`, d.`dep_acu_vo_bs`, d.`val_tot`,
	d.`dep_vo`, d.`dep_vo_bs`
from `af_activos` a
left join af_hdepre d on a.`idactivo` = d.`idactivo`
where a.`idactivo` in (23,27,36,145,182,208,319)
;

select 	a.`idactivo`, a.`descri`, a.`fch_alta`, a.`duracion`, a.`vobs`, a.`dep_acu_vo`, a.`estado`, a.`dep_vo`,
	sum(d.`dep_vo`) s_dep_vo, sum(d.`dep_vo_bs`) s_dep_vo_bs
from `af_activos` a
left join af_hdepre d on a.`idactivo` = d.`idactivo`
where a.`idactivo` in (23,27,36,145,182,208,319)
group by a.`idactivo`, a.`descri`, a.`fch_alta`, a.`duracion`, a.`vobs`, a.`dep_acu_vo`, a.`estado`, a.`dep_vo`
;


















