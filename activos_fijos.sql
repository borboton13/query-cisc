SELECT
/*
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
*/
a.`idactivo`, d.`idhdepre`
FROM af_activos a
LEFT JOIN af_hdepre d 	 ON a.`idactivo` = d.`idactivo`
-- left join af_subgrupos s on a.`subgrupo` = s.`subgrupo`
-- left join `af_grupos` g  on a.`grupo`	 = g.`grupo`
WHERE d.`fecha_en_proceso` = '2016-05-31'
;

--

SELECT
 	a.`idactivo`, 
	s.`descri`,
	s.`cta_vo`,
	a.`descri`, 
	a.`fch_alta`, a.`fch_baja`, a.`fch_ajuste`, 
	a.`duracion`,
	a.`vobs`, a.`vosus`, a.`voufv`,
	a.`tasa_dep`, a.`tasabssus`, a.`tasabsufv`, 
	a.`estado`, 
	a.`dep_acu_vo`, a.`dep_vo`, 
	a.`ulttasabssus`, a.`ulttasabsufv`
FROM af_activos a
-- LEFT JOIN af_hdepre d 	 ON a.`idactivo` = d.`idactivo`
LEFT JOIN af_subgrupos s ON a.`subgrupo` = s.`subgrupo`
LEFT JOIN `af_grupos` g  ON a.`grupo`	 = g.`grupo`
;

--
-- REPORTE ORIG
--
SELECT
 	a.`idactivo`, 
	s.`descri`,
	s.`cta_vo`,
	a.`descri`, 
	a.`fch_alta`, -- a.`fch_baja`, a.`fch_ajuste`, 
	a.`estado`, 
	a.`duracion` / 12 AS vida_util,
	a.`vobs`, a.`vosus`, a.`voufv`,
	-- a.`tasa_dep`, a.`tasabssus`, a.`tasabsufv`, 
	a.`dep_acu_vo`, a.`dep_vo`,
	(a.`vobs` - a.`dep_acu_vo`) AS saldo_neto
	-- a.`ulttasabssus`, a.`ulttasabsufv`
FROM af_activos a
-- LEFT JOIN af_hdepre d 	 ON a.`idactivo` = d.`idactivo`
LEFT JOIN af_subgrupos s ON a.`subgrupo` = s.`subgrupo`
LEFT JOIN `af_grupos` g  ON a.`grupo`	 = g.`grupo`
;

-- ---------------------------------------------
-- REPORTE FINAL OFICIAL ACTIVOS FIJOS
-- -------------------------------------------
SELECT
 	a.`idactivo`, 
	s.`descri`,
	s.`cta_vo`,
	a.`descri`, 
	a.`fch_alta`, -- a.`fch_baja`, a.`fch_ajuste`, 
	-- a.`estado`, 
	a.`duracion` / 12 AS vida_util,
	a.`vobs`, -- a.`vosus`, a.`voufv`,
	-- a.`tasa_dep`, a.`tasabssus`, a.`tasabsufv`, 
	-- a.`dep_acu_vo`, 
	IF(a.estado = 'TDP' OR a.estado = 'BAJ' , a.`vobs`, a.`dep_acu_vo`) AS DEP_ACUM_VO,
	-- a.`dep_vo`,
	-- (a.`vobs` - a.`dep_acu_vo`) AS saldo_net,
	IF(a.estado = 'TDP' OR a.estado = 'BAJ' , 0, (a.`vobs` - a.`dep_acu_vo`)) AS saldo_neto,
	-- a.`ulttasabssus`, a.`ulttasabsufv`
	-- 2016, year(a.`fch_alta`) as anio,
	-- 2016 - YEAR(a.`fch_alta`) AS dif_year,
	-- (a.`duracion` / 12) - (2016 - YEAR(a.`fch_alta`)) as vida_res,
	IF( ((a.`duracion` / 12) - (2016 - YEAR(a.`fch_alta`))) < 0 , 0 , ((a.`duracion` / 12) - (2016 - YEAR(a.`fch_alta`))) ) AS vida_rest
FROM af_activos a
-- LEFT JOIN af_hdepre d 	 ON a.`idactivo` = d.`idactivo`
LEFT JOIN af_subgrupos s ON a.`subgrupo` = s.`subgrupo`
LEFT JOIN `af_grupos` g  ON a.`grupo`	 = g.`grupo`
;

