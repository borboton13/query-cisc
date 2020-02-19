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
update af_activos set dep_acu_vo = 	17754.38	, dep_vo = 	96.68	  where idactivo =  	145	 ; 
update af_activos set dep_acu_vo = 	2576.64	, dep_vo = 	32.54	  where idactivo =  	319	 ; 
update af_activos set dep_acu_vo = 	148656.71	, dep_vo = 	1238.81	  where idactivo =  	23	 ; 
update af_activos set dep_acu_vo = 	260675.40	, dep_vo = 	981.06	  where idactivo =  	36	 ; 
update af_activos set dep_acu_vo = 	5418.64	, dep_vo = 	34.92	  where idactivo =  	182	 ; 
update af_activos set dep_acu_vo = 	9881.19	, dep_vo = 	72.18	  where idactivo =  	208	 ; 
update af_activos set dep_acu_vo = 	54313.82	, dep_vo = 	16527.07	  where idactivo =  	27	 ; 

-- Edificios UHT
update af_activos set dep_acu_vo = 	137549.86	, dep_vo = 	1102.83	  where idactivo =  	229	 ; 

-- Mobiliario
update af_activos set dep_acu_vo = 	1887.97	, dep_vo = 	15.73	  where idactivo =  	4	 ; 
update af_activos set dep_acu_vo = 	472.01	, dep_vo = 	3.93	  where idactivo =  	5	 ; 
update af_activos set dep_acu_vo = 	5103.54	, dep_vo = 	42.53	  where idactivo =  	7	 ; 
update af_activos set dep_acu_vo = 	4593.17	, dep_vo = 	38.28	  where idactivo =  	8	 ; 
update af_activos set dep_acu_vo = 	2296.63	, dep_vo = 	19.14	  where idactivo =  	9	 ; 
update af_activos set dep_acu_vo = 	784.80	, dep_vo = 	6.54	  where idactivo =  	10	 ; 
update af_activos set dep_acu_vo = 	800.44	, dep_vo = 	6.67	  where idactivo =  	11	 ; 
update af_activos set dep_acu_vo = 	5461.12	, dep_vo = 	45.51	  where idactivo =  	17	 ; 
update af_activos set dep_acu_vo = 	157.38	, dep_vo = 	1.31	  where idactivo =  	26	 ; 
update af_activos set dep_acu_vo = 	2734.97	, dep_vo = 	22.79	  where idactivo =  	28	 ; 
update af_activos set dep_acu_vo = 	1328.29	, dep_vo = 	11.07	  where idactivo =  	29	 ; 
update af_activos set dep_acu_vo = 	100.01	, dep_vo = 	0.83	  where idactivo =  	30	 ; 
update af_activos set dep_acu_vo = 	88.20	, dep_vo = 	0.74	  where idactivo =  	31	 ; 
update af_activos set dep_acu_vo = 	100.32	, dep_vo = 	0.84	  where idactivo =  	38	 ; 
update af_activos set dep_acu_vo = 	1542.21	, dep_vo = 	12.85	  where idactivo =  	41	 ; 
update af_activos set dep_acu_vo = 	3758.30	, dep_vo = 	31.32	  where idactivo =  	44	 ; 
update af_activos set dep_acu_vo = 	18408.00	, dep_vo = 	153.40	  where idactivo =  	46	 ; 
update af_activos set dep_acu_vo = 	5807.57	, dep_vo = 	48.40	  where idactivo =  	47	 ; 
update af_activos set dep_acu_vo = 	1150.50	, dep_vo = 	9.59	  where idactivo =  	49	 ; 
update af_activos set dep_acu_vo = 	9204.00	, dep_vo = 	76.70	  where idactivo =  	52	 ; 
update af_activos set dep_acu_vo = 	6903.01	, dep_vo = 	57.53	  where idactivo =  	53	 ; 
update af_activos set dep_acu_vo = 	5522.40	, dep_vo = 	46.02	  where idactivo =  	54	 ; 
update af_activos set dep_acu_vo = 	575.25	, dep_vo = 	4.79	  where idactivo =  	55	 ; 
update af_activos set dep_acu_vo = 	115.05	, dep_vo = 	0.96	  where idactivo =  	56	 ; 
update af_activos set dep_acu_vo = 	12885.60	, dep_vo = 	107.38	  where idactivo =  	62	 ; 
update af_activos set dep_acu_vo = 	3451.50	, dep_vo = 	28.76	  where idactivo =  	63	 ; 
update af_activos set dep_acu_vo = 	652.41	, dep_vo = 	5.44	  where idactivo =  	69	 ; 
update af_activos set dep_acu_vo = 	294.07	, dep_vo = 	2.45	  where idactivo =  	76	 ; 
update af_activos set dep_acu_vo = 	699.65	, dep_vo = 	5.83	  where idactivo =  	95	 ; 
update af_activos set dep_acu_vo = 	435.27	, dep_vo = 	3.63	  where idactivo =  	96	 ; 
update af_activos set dep_acu_vo = 	393.85	, dep_vo = 	3.28	  where idactivo =  	97	 ; 
update af_activos set dep_acu_vo = 	2838.05	, dep_vo = 	23.65	  where idactivo =  	108	 ; 
update af_activos set dep_acu_vo = 	2837.90	, dep_vo = 	23.65	  where idactivo =  	112	 ; 
update af_activos set dep_acu_vo = 	779.89	, dep_vo = 	6.50	  where idactivo =  	118	 ; 
update af_activos set dep_acu_vo = 	8513.70	, dep_vo = 	70.95	  where idactivo =  	123	 ; 
update af_activos set dep_acu_vo = 	5752.51	, dep_vo = 	47.94	  where idactivo =  	129	 ; 
update af_activos set dep_acu_vo = 	4308.94	, dep_vo = 	35.91	  where idactivo =  	131	 ; 
update af_activos set dep_acu_vo = 	1984.61	, dep_vo = 	16.54	  where idactivo =  	132	 ; 
update af_activos set dep_acu_vo = 	392.10	, dep_vo = 	3.27	  where idactivo =  	133	 ; 
update af_activos set dep_acu_vo = 	248.66	, dep_vo = 	2.07	  where idactivo =  	134	 ; 
update af_activos set dep_acu_vo = 	15849.43	, dep_vo = 	132.08	  where idactivo =  	135	 ; 
update af_activos set dep_acu_vo = 	2349.00	, dep_vo = 	39.15	  where idactivo =  	200	 ; 
update af_activos set dep_acu_vo = 	1740.00	, dep_vo = 	29.00	  where idactivo =  	201	 ; 
update af_activos set dep_acu_vo = 	78868.44	, dep_vo = 	654.46	  where idactivo =  	237	 ; 
update af_activos set dep_acu_vo = 	1441.99	, dep_vo = 	11.96	  where idactivo =  	239	 ; 
update af_activos set dep_acu_vo = 	1134.36	, dep_vo = 	2.81	  where idactivo =  	254	 ; 
update af_activos set dep_acu_vo = 	30312.33	, dep_vo = 	76.25	  where idactivo =  	255	 ; 
update af_activos set dep_acu_vo = 	15408.62	, dep_vo = 	38.79	  where idactivo =  	256	 ; 
update af_activos set dep_acu_vo = 	80580.14	, dep_vo = 	202.74	  where idactivo =  	257	 ; 
update af_activos set dep_acu_vo = 	1020.35	, dep_vo = 	4.96	  where idactivo =  	260	 ; 
update af_activos set dep_acu_vo = 	206.15	, dep_vo = 	1.66	  where idactivo =  	276	 ; 
update af_activos set dep_acu_vo = 	862.13	, dep_vo = 	7.00	  where idactivo =  	278	 ; 
update af_activos set dep_acu_vo = 	1619.26	, dep_vo = 	13.40	  where idactivo =  	279	 ; 
update af_activos set dep_acu_vo = 	975.13	, dep_vo = 	8.65	  where idactivo =  	288	 ; 
update af_activos set dep_acu_vo = 	1965.60	, dep_vo = 	18.58	  where idactivo =  	293	 ; 
update af_activos set dep_acu_vo = 	703.84	, dep_vo = 	6.76	  where idactivo =  	295	 ; 
update af_activos set dep_acu_vo = 	1173.87	, dep_vo = 	11.25	  where idactivo =  	296	 ; 
update af_activos set dep_acu_vo = 	3451.15	, dep_vo = 	23.22	  where idactivo =  	298	 ; 
update af_activos set dep_acu_vo = 	4429.46	, dep_vo = 	29.84	  where idactivo =  	299	 ; 
update af_activos set dep_acu_vo = 	3905.78	, dep_vo = 	41.45	  where idactivo =  	311	 ; 
update af_activos set dep_acu_vo = 	402.13	, dep_vo = 	4.51	  where idactivo =  	316	 ; 
update af_activos set dep_acu_vo = 	1236.46	, dep_vo = 	14.73	  where idactivo =  	320	 ; 
update af_activos set dep_acu_vo = 	409.52	, dep_vo = 	6.87	  where idactivo =  	345	 ; 
update af_activos set dep_acu_vo = 	105507.13	, dep_vo = 	2175.00	  where idactivo =  	353	 ; 
update af_activos set dep_acu_vo = 	11980.77	, dep_vo = 	291.45	  where idactivo =  	357	 ; 
update af_activos set dep_acu_vo = 	486.25	, dep_vo = 	16.67	  where idactivo =  	359	 ; 
update af_activos set dep_acu_vo = 	1115.69	, dep_vo = 	0.02	  where idactivo =  	156	 ; 
update af_activos set dep_acu_vo = 	35.23	, dep_vo = 	0.02	  where idactivo =  	171	 ; 
update af_activos set dep_acu_vo = 	131.63	, dep_vo = 	0.02	  where idactivo =  	172	 ; 
update af_activos set dep_acu_vo = 	322.23	, dep_vo = 	0.02	  where idactivo =  	173	 ; 
update af_activos set dep_acu_vo = 	546.67	, dep_vo = 	0.01	  where idactivo =  	174	 ; 
update af_activos set dep_acu_vo = 	812.86	, dep_vo = 	0.01	  where idactivo =  	175	 ; 
update af_activos set dep_acu_vo = 	995.86	, dep_vo = 	0.01	  where idactivo =  	176	 ; 
update af_activos set dep_acu_vo = 	400.52	, dep_vo = 	0.01	  where idactivo =  	179	 ; 
update af_activos set dep_acu_vo = 	7632.34	, dep_vo = 	63.49	  where idactivo =  	180	 ; 
update af_activos set dep_acu_vo = 	14144.51	, dep_vo = 	116.67	  where idactivo =  	205	 ; 
update af_activos set dep_acu_vo = 	43502.60	, dep_vo = 	725.00	  where idactivo =  	269	 ; 
update af_activos set dep_acu_vo = 	48995.38	, dep_vo = 	498.44	  where idactivo =  	283	 ; 
update af_activos set dep_acu_vo = 	3357.37	, dep_vo = 	55.83	  where idactivo =  	289	 ; 
update af_activos set dep_acu_vo = 	882.32	, dep_vo = 	14.63	  where idactivo =  	303	 ; 
update af_activos set dep_acu_vo = 	1152.51	, dep_vo = 	18.85	  where idactivo =  	321	 ; 
update af_activos set dep_acu_vo = 	3018.00	, dep_vo = 	49.30	  where idactivo =  	322	 ; 
update af_activos set dep_acu_vo = 	4261.61	, dep_vo = 	69.60	  where idactivo =  	323	 ; 
update af_activos set dep_acu_vo = 	2396.19	, dep_vo = 	39.15	  where idactivo =  	324	 ; 


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
	sum(d.`dep_vo_bs`) s_dep_vo_bs
from `af_activos` a
left join af_hdepre d on a.`idactivo` = d.`idactivo`
-- where a.`idactivo` in (229)
where a.`subgrupo` = 3
group by a.`idactivo`, a.`descri`, a.`fch_alta`, a.`duracion`, a.`vobs`, a.`dep_acu_vo`, a.`estado`, a.`dep_vo`
;


















