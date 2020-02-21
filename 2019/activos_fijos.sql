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

-- EQUIPOS
update af_activos set dep_acu_vo = 	25536.58	, dep_vo = 	425.61	  where idactivo =  	6	 ; 
update af_activos set dep_acu_vo = 	136364.93	, dep_vo = 	1420.47	  where idactivo =  	13	 ; 
update af_activos set dep_acu_vo = 	10504.14	, dep_vo = 	109.42	  where idactivo =  	14	 ; 
update af_activos set dep_acu_vo = 	6337.64	, dep_vo = 	66.02	  where idactivo =  	15	 ; 
update af_activos set dep_acu_vo = 	5829.20	, dep_vo = 	60.72	  where idactivo =  	16	 ; 
update af_activos set dep_acu_vo = 	4252.33	, dep_vo = 	44.30	  where idactivo =  	18	 ; 
update af_activos set dep_acu_vo = 	2301.01	, dep_vo = 	23.97	  where idactivo =  	19	 ; 
update af_activos set dep_acu_vo = 	1000.93	, dep_vo = 	10.43	  where idactivo =  	20	 ; 
update af_activos set dep_acu_vo = 	203.03	, dep_vo = 	2.11	  where idactivo =  	21	 ; 
update af_activos set dep_acu_vo = 	127.86	, dep_vo = 	1.33	  where idactivo =  	22	 ; 
update af_activos set dep_acu_vo = 	36049.00	, dep_vo = 	751.02	  where idactivo =  	24	 ; 
update af_activos set dep_acu_vo = 	7286.50	, dep_vo = 	75.90	  where idactivo =  	32	 ; 
update af_activos set dep_acu_vo = 	1183040.44	, dep_vo = 	12323.34	  where idactivo =  	33	 ; 
update af_activos set dep_acu_vo = 	106170.13	, dep_vo = 	1105.94	  where idactivo =  	34	 ; 
update af_activos set dep_acu_vo = 	7086.39	, dep_vo = 	73.82	  where idactivo =  	35	 ; 
update af_activos set dep_acu_vo = 	1690.16	, dep_vo = 	28.17	  where idactivo =  	37	 ; 
update af_activos set dep_acu_vo = 	3835.01	, dep_vo = 	63.92	  where idactivo =  	39	 ; 
update af_activos set dep_acu_vo = 	4018.70	, dep_vo = 	66.98	  where idactivo =  	40	 ; 
update af_activos set dep_acu_vo = 	436.72	, dep_vo = 	18.20	  where idactivo =  	42	 ; 
update af_activos set dep_acu_vo = 	5215.60	, dep_vo = 	86.93	  where idactivo =  	48	 ; 
update af_activos set dep_acu_vo = 	14056.04	, dep_vo = 	234.27	  where idactivo =  	50	 ; 
update af_activos set dep_acu_vo = 	1134.39	, dep_vo = 	18.91	  where idactivo =  	51	 ; 
update af_activos set dep_acu_vo = 	9180.99	, dep_vo = 	153.02	  where idactivo =  	57	 ; 
update af_activos set dep_acu_vo = 	8765.66	, dep_vo = 	146.09	  where idactivo =  	58	 ; 
update af_activos set dep_acu_vo = 	2854.39	, dep_vo = 	47.57	  where idactivo =  	59	 ; 
update af_activos set dep_acu_vo = 	16107.00	, dep_vo = 	268.45	  where idactivo =  	61	 ; 
update af_activos set dep_acu_vo = 	12272.00	, dep_vo = 	204.53	  where idactivo =  	64	 ; 
update af_activos set dep_acu_vo = 	97025.50	, dep_vo = 	1617.09	  where idactivo =  	65	 ; 
update af_activos set dep_acu_vo = 	57524.99	, dep_vo = 	958.75	  where idactivo =  	66	 ; 
update af_activos set dep_acu_vo = 	122720.00	, dep_vo = 	2045.33	  where idactivo =  	67	 ; 
update af_activos set dep_acu_vo = 	57294.90	, dep_vo = 	954.92	  where idactivo =  	68	 ; 
update af_activos set dep_acu_vo = 	1536.38	, dep_vo = 	25.61	  where idactivo =  	72	 ; 
update af_activos set dep_acu_vo = 	1188.16	, dep_vo = 	19.80	  where idactivo =  	75	 ; 
update af_activos set dep_acu_vo = 	382.88	, dep_vo = 	6.38	  where idactivo =  	82	 ; 
update af_activos set dep_acu_vo = 	1128.49	, dep_vo = 	18.81	  where idactivo =  	83	 ; 
update af_activos set dep_acu_vo = 	74222.59	, dep_vo = 	1237.04	  where idactivo =  	84	 ; 
update af_activos set dep_acu_vo = 	62616.95	, dep_vo = 	1043.62	  where idactivo =  	85	 ; 
update af_activos set dep_acu_vo = 	6136.00	, dep_vo = 	102.27	  where idactivo =  	88	 ; 
update af_activos set dep_acu_vo = 	1699.36	, dep_vo = 	28.32	  where idactivo =  	89	 ; 
update af_activos set dep_acu_vo = 	610.99	, dep_vo = 	10.18	  where idactivo =  	91	 ; 
update af_activos set dep_acu_vo = 	430.98	, dep_vo = 	7.18	  where idactivo =  	92	 ; 
update af_activos set dep_acu_vo = 	1380.60	, dep_vo = 	23.01	  where idactivo =  	93	 ; 
update af_activos set dep_acu_vo = 	74399.00	, dep_vo = 	774.99	  where idactivo =  	101	 ; 
update af_activos set dep_acu_vo = 	11505.00	, dep_vo = 	191.75	  where idactivo =  	103	 ; 
update af_activos set dep_acu_vo = 	1725.74	, dep_vo = 	28.76	  where idactivo =  	104	 ; 
update af_activos set dep_acu_vo = 	4026.75	, dep_vo = 	67.11	  where idactivo =  	105	 ; 
update af_activos set dep_acu_vo = 	880.82	, dep_vo = 	14.68	  where idactivo =  	107	 ; 
update af_activos set dep_acu_vo = 	5369.01	, dep_vo = 	89.48	  where idactivo =  	111	 ; 
update af_activos set dep_acu_vo = 	47583.69	, dep_vo = 	495.66	  where idactivo =  	114	 ; 
update af_activos set dep_acu_vo = 	992.42	, dep_vo = 	16.54	  where idactivo =  	115	 ; 
update af_activos set dep_acu_vo = 	2492.75	, dep_vo = 	41.55	  where idactivo =  	116	 ; 
update af_activos set dep_acu_vo = 	173.64	, dep_vo = 	2.89	  where idactivo =  	119	 ; 
update af_activos set dep_acu_vo = 	738.24	, dep_vo = 	12.30	  where idactivo =  	120	 ; 
update af_activos set dep_acu_vo = 	880.82	, dep_vo = 	14.68	  where idactivo =  	121	 ; 
update af_activos set dep_acu_vo = 	18101.20	, dep_vo = 	188.55	  where idactivo =  	122	 ; 
update af_activos set dep_acu_vo = 	95744.61	, dep_vo = 	997.34	  where idactivo =  	124	 ; 
update af_activos set dep_acu_vo = 	99710.01	, dep_vo = 	1038.65	  where idactivo =  	125	 ; 
update af_activos set dep_acu_vo = 	2187.33	, dep_vo = 	36.46	  where idactivo =  	127	 ; 
update af_activos set dep_acu_vo = 	2753.53	, dep_vo = 	45.89	  where idactivo =  	136	 ; 
update af_activos set dep_acu_vo = 	2523.43	, dep_vo = 	26.29	  where idactivo =  	137	 ; 
update af_activos set dep_acu_vo = 	751.66	, dep_vo = 	7.83	  where idactivo =  	138	 ; 
update af_activos set dep_acu_vo = 	64289.94	, dep_vo = 	669.69	  where idactivo =  	139	 ; 
update af_activos set dep_acu_vo = 	52857.65	, dep_vo = 	550.60	  where idactivo =  	140	 ; 
update af_activos set dep_acu_vo = 	31494.40	, dep_vo = 	328.07	  where idactivo =  	141	 ; 
update af_activos set dep_acu_vo = 	997.94	, dep_vo = 	16.63	  where idactivo =  	144	 ; 
update af_activos set dep_acu_vo = 	16874.00	, dep_vo = 	281.23	  where idactivo =  	147	 ; 
update af_activos set dep_acu_vo = 	17257.50	, dep_vo = 	287.63	  where idactivo =  	149	 ; 
update af_activos set dep_acu_vo = 	216884.59	, dep_vo = 	2259.21	  where idactivo =  	150	 ; 
update af_activos set dep_acu_vo = 	3542.32	, dep_vo = 	59.04	  where idactivo =  	152	 ; 
update af_activos set dep_acu_vo = 	39837.21	, dep_vo = 	414.97	  where idactivo =  	155	 ; 
update af_activos set dep_acu_vo = 	23384.22	, dep_vo = 	243.59	  where idactivo =  	164	 ; 
update af_activos set dep_acu_vo = 	15700.80	, dep_vo = 	163.55	  where idactivo =  	165	 ; 
update af_activos set dep_acu_vo = 	1999.34	, dep_vo = 	33.32	  where idactivo =  	177	 ; 
update af_activos set dep_acu_vo = 	87808.61	, dep_vo = 	1463.48	  where idactivo =  	181	 ; 
update af_activos set dep_acu_vo = 	3132.66	, dep_vo = 	52.21	  where idactivo =  	189	 ; 
update af_activos set dep_acu_vo = 	61080.52	, dep_vo = 	636.26	  where idactivo =  	193	 ; 
update af_activos set dep_acu_vo = 	1052.70	, dep_vo = 	43.86	  where idactivo =  	197	 ; 
update af_activos set dep_acu_vo = 	3676.00	, dep_vo = 	61.27	  where idactivo =  	198	 ; 
update af_activos set dep_acu_vo = 	4271.05	, dep_vo = 	177.96	  where idactivo =  	199	 ; 
update af_activos set dep_acu_vo = 	4445.70	, dep_vo = 	74.10	  where idactivo =  	213	 ; 
update af_activos set dep_acu_vo = 	13531.98	, dep_vo = 	225.53	  where idactivo =  	236	 ; 
update af_activos set dep_acu_vo = 	2482.98	, dep_vo = 	41.38	  where idactivo =  	238	 ; 
update af_activos set dep_acu_vo = 	13960.89	, dep_vo = 	232.68	  where idactivo =  	240	 ; 
update af_activos set dep_acu_vo = 	12301.80	, dep_vo = 	205.03	  where idactivo =  	243	 ; 
update af_activos set dep_acu_vo = 	382.80	, dep_vo = 	6.38	  where idactivo =  	244	 ; 
update af_activos set dep_acu_vo = 	344.52	, dep_vo = 	5.74	  where idactivo =  	245	 ; 
update af_activos set dep_acu_vo = 	261.00	, dep_vo = 	4.35	  where idactivo =  	246	 ; 
update af_activos set dep_acu_vo = 	217.50	, dep_vo = 	3.63	  where idactivo =  	247	 ; 
update af_activos set dep_acu_vo = 	194.88	, dep_vo = 	3.25	  where idactivo =  	248	 ; 
update af_activos set dep_acu_vo = 	121.80	, dep_vo = 	2.03	  where idactivo =  	249	 ; 
update af_activos set dep_acu_vo = 	87.00	, dep_vo = 	1.45	  where idactivo =  	250	 ; 
update af_activos set dep_acu_vo = 	60.90	, dep_vo = 	1.02	  where idactivo =  	251	 ; 
update af_activos set dep_acu_vo = 	58.72	, dep_vo = 	0.98	  where idactivo =  	252	 ; 
update af_activos set dep_acu_vo = 	2148.90	, dep_vo = 	35.82	  where idactivo =  	253	 ; 
update af_activos set dep_acu_vo = 	7308.00	, dep_vo = 	121.80	  where idactivo =  	258	 ; 
update af_activos set dep_acu_vo = 	8019.28	, dep_vo = 	133.65	  where idactivo =  	259	 ; 
update af_activos set dep_acu_vo = 	14454.18	, dep_vo = 	240.90	  where idactivo =  	262	 ; 
update af_activos set dep_acu_vo = 	5046.00	, dep_vo = 	84.10	  where idactivo =  	266	 ; 
update af_activos set dep_acu_vo = 	330324.45	, dep_vo = 	668.89	  where idactivo =  	161	 ; 
update af_activos set dep_acu_vo = 	616594.95	, dep_vo = 	1248.57	  where idactivo =  	162	 ; 
update af_activos set dep_acu_vo = 	704701.52	, dep_vo = 	1426.98	  where idactivo =  	163	 ; 
update af_activos set dep_acu_vo = 	185029.72	, dep_vo = 	466.63	  where idactivo =  	186	 ; 
update af_activos set dep_acu_vo = 	41982.77	, dep_vo = 	21.10	  where idactivo =  	191	 ; 
update af_activos set dep_acu_vo = 	34329.88	, dep_vo = 	322.08	  where idactivo =  	349	 ; 
update af_activos set dep_acu_vo = 	13444.35	, dep_vo = 	106.53	  where idactivo =  	355	 ; 
update af_activos set dep_acu_vo = 	979.61	, dep_vo = 	8.15	  where idactivo =  	187	 ; 
update af_activos set dep_acu_vo = 	6610.11	, dep_vo = 	54.86	  where idactivo =  	188	 ; 
update af_activos set dep_acu_vo = 	3958.62	, dep_vo = 	41.23	  where idactivo =  	203	 ; 
update af_activos set dep_acu_vo = 	6822.54	, dep_vo = 	71.05	  where idactivo =  	204	 ; 
update af_activos set dep_acu_vo = 	9216.44	, dep_vo = 	95.74	  where idactivo =  	212	 ; 
update af_activos set dep_acu_vo = 	55666.80	, dep_vo = 	576.65	  where idactivo =  	214	 ; 
update af_activos set dep_acu_vo = 	17970.55	, dep_vo = 	185.81	  where idactivo =  	241	 ; 
update af_activos set dep_acu_vo = 	221406.48	, dep_vo = 	2274.55	  where idactivo =  	263	 ; 
update af_activos set dep_acu_vo = 	106390.85	, dep_vo = 	1089.22	  where idactivo =  	267	 ; 
update af_activos set dep_acu_vo = 	10948.87	, dep_vo = 	182.50	  where idactivo =  	270	 ; 
update af_activos set dep_acu_vo = 	4425.76	, dep_vo = 	73.78	  where idactivo =  	271	 ; 
update af_activos set dep_acu_vo = 	8223.44	, dep_vo = 	137.03	  where idactivo =  	272	 ; 
update af_activos set dep_acu_vo = 	4524.11	, dep_vo = 	75.40	  where idactivo =  	275	 ; 
update af_activos set dep_acu_vo = 	48071.71	, dep_vo = 	799.94	  where idactivo =  	284	 ; 
update af_activos set dep_acu_vo = 	84141.04	, dep_vo = 	855.09	  where idactivo =  	285	 ; 
update af_activos set dep_acu_vo = 	99676.10	, dep_vo = 	1012.96	  where idactivo =  	286	 ; 
update af_activos set dep_acu_vo = 	196632.07	, dep_vo = 	1998.25	  where idactivo =  	287	 ; 
update af_activos set dep_acu_vo = 	17013.24	, dep_vo = 	282.58	  where idactivo =  	290	 ; 
update af_activos set dep_acu_vo = 	13007.33	, dep_vo = 	216.05	  where idactivo =  	291	 ; 
update af_activos set dep_acu_vo = 	60233.70	, dep_vo = 	1000.34	  where idactivo =  	292	 ; 
update af_activos set dep_acu_vo = 	9189.95	, dep_vo = 	152.25	  where idactivo =  	297	 ; 
update af_activos set dep_acu_vo = 	1925.10	, dep_vo = 	31.90	  where idactivo =  	300	 ; 
update af_activos set dep_acu_vo = 	6568.15	, dep_vo = 	108.75	  where idactivo =  	301	 ; 
update af_activos set dep_acu_vo = 	85306.02	, dep_vo = 	1410.04	  where idactivo =  	307	 ; 
update af_activos set dep_acu_vo = 	9136.61	, dep_vo = 	150.74	  where idactivo =  	310	 ; 
update af_activos set dep_acu_vo = 	8639.53	, dep_vo = 	142.30	  where idactivo =  	312	 ; 
update af_activos set dep_acu_vo = 	73139.36	, dep_vo = 	1201.55	  where idactivo =  	314	 ; 
update af_activos set dep_acu_vo = 	4681.59	, dep_vo = 	76.85	  where idactivo =  	317	 ; 
update af_activos set dep_acu_vo = 	10607.17	, dep_vo = 	173.86	  where idactivo =  	318	 ; 
update af_activos set dep_acu_vo = 	2491.20	, dep_vo = 	40.37	  where idactivo =  	334	 ; 
update af_activos set dep_acu_vo = 	38069.62	, dep_vo = 	614.60	  where idactivo =  	336	 ; 
update af_activos set dep_acu_vo = 	17552.88	, dep_vo = 	282.58	  where idactivo =  	339	 ; 
update af_activos set dep_acu_vo = 	5689.40	, dep_vo = 	91.35	  where idactivo =  	343	 ; 

-- INSTALACIONES
update af_activos set dep_acu_vo = 	170504.40	, dep_vo = 	1776.09	  where idactivo =  	12	 ; 
update af_activos set dep_acu_vo = 	17243.16	, dep_vo = 	287.39	  where idactivo =  	87	 ; 
update af_activos set dep_acu_vo = 	45551.60	, dep_vo = 	759.19	  where idactivo =  	143	 ; 
update af_activos set dep_acu_vo = 	103545.00	, dep_vo = 	1725.75	  where idactivo =  	146	 ; 
update af_activos set dep_acu_vo = 	176409.99	, dep_vo = 	1837.60	  where idactivo =  	151	 ; 
update af_activos set dep_acu_vo = 	56719.65	, dep_vo = 	590.83	  where idactivo =  	157	 ; 
update af_activos set dep_acu_vo = 	12678.51	, dep_vo = 	132.07	  where idactivo =  	158	 ; 
update af_activos set dep_acu_vo = 	4227.94	, dep_vo = 	44.04	  where idactivo =  	159	 ; 
update af_activos set dep_acu_vo = 	1691.95	, dep_vo = 	14.03	  where idactivo =  	196	 ; 
update af_activos set dep_acu_vo = 	5424.01	, dep_vo = 	90.40	  where idactivo =  	265	 ; 
update af_activos set dep_acu_vo = 	11300.40	, dep_vo = 	188.36	  where idactivo =  	268	 ; 
update af_activos set dep_acu_vo = 	1603.04	, dep_vo = 	26.61	  where idactivo =  	294	 ; 
update af_activos set dep_acu_vo = 	3668.41	, dep_vo = 	60.76	  where idactivo =  	302	 ; 
update af_activos set dep_acu_vo = 	19425.14	, dep_vo = 	315.40	  where idactivo =  	331	 ; 

-- EQUIPOS UHT
update af_activos set dep_acu_vo = 	298115.23	, dep_vo = 	4968.59	  where idactivo =  	215	 ; 
update af_activos set dep_acu_vo = 	128803.60	, dep_vo = 	2146.73	  where idactivo =  	216	 ; 
update af_activos set dep_acu_vo = 	90886.40	, dep_vo = 	1514.77	  where idactivo =  	264	 ; 
update af_activos set dep_acu_vo = 	1495300.68	, dep_vo = 	5876.40	  where idactivo =  	230	 ; 
update af_activos set dep_acu_vo = 	2067177.22	, dep_vo = 	8123.83	  where idactivo =  	231	 ; 
update af_activos set dep_acu_vo = 	3719.64	, dep_vo = 	139.88	  where idactivo =  	365	 ; 
update af_activos set dep_acu_vo = 	7517.66	, dep_vo = 	307.94	  where idactivo =  	366	 ; 
update af_activos set dep_acu_vo = 	6183.18	, dep_vo = 	64.07	  where idactivo =  	217	 ; 
update af_activos set dep_acu_vo = 	9894.50	, dep_vo = 	102.52	  where idactivo =  	218	 ; 
update af_activos set dep_acu_vo = 	11496.23	, dep_vo = 	119.11	  where idactivo =  	219	 ; 
update af_activos set dep_acu_vo = 	12579.62	, dep_vo = 	130.33	  where idactivo =  	220	 ; 
update af_activos set dep_acu_vo = 	27462.17	, dep_vo = 	284.49	  where idactivo =  	221	 ; 
update af_activos set dep_acu_vo = 	31962.74	, dep_vo = 	331.11	  where idactivo =  	222	 ; 
update af_activos set dep_acu_vo = 	37419.29	, dep_vo = 	387.63	  where idactivo =  	223	 ; 
update af_activos set dep_acu_vo = 	43246.38	, dep_vo = 	447.99	  where idactivo =  	224	 ; 
update af_activos set dep_acu_vo = 	86956.05	, dep_vo = 	900.76	  where idactivo =  	225	 ; 
update af_activos set dep_acu_vo = 	103523.47	, dep_vo = 	1072.37	  where idactivo =  	226	 ; 
update af_activos set dep_acu_vo = 	156252.86	, dep_vo = 	1618.57	  where idactivo =  	227	 ; 
update af_activos set dep_acu_vo = 	255904.44	, dep_vo = 	2650.81	  where idactivo =  	228	 ; 
update af_activos set dep_acu_vo = 	648.17	, dep_vo = 	10.83	  where idactivo =  	273	 ; 
update af_activos set dep_acu_vo = 	5406.73	, dep_vo = 	90.10	  where idactivo =  	277	 ; 
update af_activos set dep_acu_vo = 	35209.42	, dep_vo = 	586.29	  where idactivo =  	281	 ; 
update af_activos set dep_acu_vo = 	4344.64	, dep_vo = 	72.35	  where idactivo =  	282	 ; 
update af_activos set dep_acu_vo = 	604.11	, dep_vo = 	12.62	  where idactivo =  	304	 ; 
update af_activos set dep_acu_vo = 	785.99	, dep_vo = 	16.40	  where idactivo =  	305	 ; 
update af_activos set dep_acu_vo = 	907.24	, dep_vo = 	18.92	  where idactivo =  	306	 ; 
update af_activos set dep_acu_vo = 	46309.31	, dep_vo = 	750.82	  where idactivo =  	333	 ; 
update af_activos set dep_acu_vo = 	40066.41	, dep_vo = 	793.31	  where idactivo =  	350	 ; 

-- EQUIP ELECTRICOS Y COMPUTACION
update af_activos set dep_acu_vo = 	16348.61	, dep_vo = 	340.60	  where idactivo =  	1	 ; 
update af_activos set dep_acu_vo = 	4446.38	, dep_vo = 	92.63	  where idactivo =  	2	 ; 
update af_activos set dep_acu_vo = 	1221.45	, dep_vo = 	25.45	  where idactivo =  	25	 ; 
update af_activos set dep_acu_vo = 	4921.84	, dep_vo = 	102.54	  where idactivo =  	43	 ; 
update af_activos set dep_acu_vo = 	41456.35	, dep_vo = 	863.67	  where idactivo =  	45	 ; 
update af_activos set dep_acu_vo = 	144.73	, dep_vo = 	6.03	  where idactivo =  	60	 ; 
update af_activos set dep_acu_vo = 	1414.58	, dep_vo = 	58.94	  where idactivo =  	70	 ; 
update af_activos set dep_acu_vo = 	7670.00	, dep_vo = 	127.83	  where idactivo =  	73	 ; 
update af_activos set dep_acu_vo = 	2070.89	, dep_vo = 	34.51	  where idactivo =  	74	 ; 
update af_activos set dep_acu_vo = 	2560.56	, dep_vo = 	42.68	  where idactivo =  	77	 ; 
update af_activos set dep_acu_vo = 	382.34	, dep_vo = 	6.37	  where idactivo =  	78	 ; 
update af_activos set dep_acu_vo = 	421.16	, dep_vo = 	7.02	  where idactivo =  	79	 ; 
update af_activos set dep_acu_vo = 	344.61	, dep_vo = 	5.74	  where idactivo =  	80	 ; 
update af_activos set dep_acu_vo = 	191.53	, dep_vo = 	3.19	  where idactivo =  	81	 ; 
update af_activos set dep_acu_vo = 	23316.80	, dep_vo = 	388.61	  where idactivo =  	86	 ; 
update af_activos set dep_acu_vo = 	344.69	, dep_vo = 	5.74	  where idactivo =  	90	 ; 
update af_activos set dep_acu_vo = 	3681.60	, dep_vo = 	61.36	  where idactivo =  	94	 ; 
update af_activos set dep_acu_vo = 	255.34	, dep_vo = 	4.26	  where idactivo =  	98	 ; 
update af_activos set dep_acu_vo = 	6059.30	, dep_vo = 	126.24	  where idactivo =  	99	 ; 
update af_activos set dep_acu_vo = 	504.53	, dep_vo = 	8.41	  where idactivo =  	100	 ; 
update af_activos set dep_acu_vo = 	843.70	, dep_vo = 	14.06	  where idactivo =  	106	 ; 
update af_activos set dep_acu_vo = 	1493.66	, dep_vo = 	24.89	  where idactivo =  	109	 ; 
update af_activos set dep_acu_vo = 	2684.50	, dep_vo = 	44.74	  where idactivo =  	113	 ; 
update af_activos set dep_acu_vo = 	1059.08	, dep_vo = 	17.65	  where idactivo =  	117	 ; 
update af_activos set dep_acu_vo = 	1917.50	, dep_vo = 	31.96	  where idactivo =  	130	 ; 
update af_activos set dep_acu_vo = 	4563.64	, dep_vo = 	76.06	  where idactivo =  	142	 ; 
update af_activos set dep_acu_vo = 	3382.47	, dep_vo = 	56.37	  where idactivo =  	148	 ; 
update af_activos set dep_acu_vo = 	4242.58	, dep_vo = 	70.71	  where idactivo =  	154	 ; 
update af_activos set dep_acu_vo = 	367.09	, dep_vo = 	6.12	  where idactivo =  	160	 ; 
update af_activos set dep_acu_vo = 	3889.53	, dep_vo = 	81.03	  where idactivo =  	166	 ; 
update af_activos set dep_acu_vo = 	2816.58	, dep_vo = 	58.68	  where idactivo =  	167	 ; 
update af_activos set dep_acu_vo = 	2615.39	, dep_vo = 	54.49	  where idactivo =  	168	 ; 
update af_activos set dep_acu_vo = 	1289.48	, dep_vo = 	26.86	  where idactivo =  	169	 ; 
update af_activos set dep_acu_vo = 	5631.93	, dep_vo = 	93.87	  where idactivo =  	178	 ; 
update af_activos set dep_acu_vo = 	375.75	, dep_vo = 	6.26	  where idactivo =  	185	 ; 
update af_activos set dep_acu_vo = 	481.95	, dep_vo = 	10.04	  where idactivo =  	190	 ; 
update af_activos set dep_acu_vo = 	8584.29	, dep_vo = 	143.07	  where idactivo =  	192	 ; 
update af_activos set dep_acu_vo = 	2971.48	, dep_vo = 	49.52	  where idactivo =  	194	 ; 
update af_activos set dep_acu_vo = 	1525.20	, dep_vo = 	25.42	  where idactivo =  	195	 ; 
update af_activos set dep_acu_vo = 	2761.75	, dep_vo = 	46.03	  where idactivo =  	206	 ; 
update af_activos set dep_acu_vo = 	1383.95	, dep_vo = 	23.07	  where idactivo =  	207	 ; 
update af_activos set dep_acu_vo = 	5043.74	, dep_vo = 	84.06	  where idactivo =  	209	 ; 
update af_activos set dep_acu_vo = 	5043.74	, dep_vo = 	84.06	  where idactivo =  	210	 ; 
update af_activos set dep_acu_vo = 	4920.72	, dep_vo = 	82.01	  where idactivo =  	232	 ; 
update af_activos set dep_acu_vo = 	4305.63	, dep_vo = 	71.76	  where idactivo =  	233	 ; 
update af_activos set dep_acu_vo = 	4305.63	, dep_vo = 	71.76	  where idactivo =  	234	 ; 
update af_activos set dep_acu_vo = 	4305.63	, dep_vo = 	71.76	  where idactivo =  	235	 ; 
update af_activos set dep_acu_vo = 	737.76	, dep_vo = 	12.30	  where idactivo =  	242	 ; 
update af_activos set dep_acu_vo = 	957.00	, dep_vo = 	15.95	  where idactivo =  	261	 ; 
update af_activos set dep_acu_vo = 	143.90	, dep_vo = 	0.07	  where idactivo =  	344	 ; 
update af_activos set dep_acu_vo = 	561.42	, dep_vo = 	0.58	  where idactivo =  	346	 ; 
update af_activos set dep_acu_vo = 	1512.30	, dep_vo = 	3.05	  where idactivo =  	348	 ; 
update af_activos set dep_acu_vo = 	474.03	, dep_vo = 	1.67	  where idactivo =  	351	 ; 
update af_activos set dep_acu_vo = 	658.73	, dep_vo = 	2.33	  where idactivo =  	352	 ; 
update af_activos set dep_acu_vo = 	866.31	, dep_vo = 	6.28	  where idactivo =  	354	 ; 
update af_activos set dep_acu_vo = 	1901.05	, dep_vo = 	17.65	  where idactivo =  	356	 ; 
update af_activos set dep_acu_vo = 	2329.75	, dep_vo = 	64.99	  where idactivo =  	362	 ; 
update af_activos set dep_acu_vo = 	359.08	, dep_vo = 	10.02	  where idactivo =  	363	 ; 
update af_activos set dep_acu_vo = 	668.08	, dep_vo = 	11.17	  where idactivo =  	274	 ; 
update af_activos set dep_acu_vo = 	384.52	, dep_vo = 	6.44	  where idactivo =  	280	 ; 
update af_activos set dep_acu_vo = 	1841.33	, dep_vo = 	30.45	  where idactivo =  	308	 ; 
update af_activos set dep_acu_vo = 	6107.35	, dep_vo = 	100.78	  where idactivo =  	309	 ; 
update af_activos set dep_acu_vo = 	7227.11	, dep_vo = 	118.90	  where idactivo =  	313	 ; 
update af_activos set dep_acu_vo = 	4482.52	, dep_vo = 	73.67	  where idactivo =  	315	 ; 
update af_activos set dep_acu_vo = 	6059.70	, dep_vo = 	98.95	  where idactivo =  	325	 ; 
update af_activos set dep_acu_vo = 	1289.17	, dep_vo = 	21.03	  where idactivo =  	327	 ; 
update af_activos set dep_acu_vo = 	1169.49	, dep_vo = 	19.02	  where idactivo =  	328	 ; 
update af_activos set dep_acu_vo = 	2080.86	, dep_vo = 	33.82	  where idactivo =  	329	 ; 
update af_activos set dep_acu_vo = 	7545.51	, dep_vo = 	122.54	  where idactivo =  	330	 ; 
update af_activos set dep_acu_vo = 	1246.12	, dep_vo = 	20.18	  where idactivo =  	335	 ; 
update af_activos set dep_acu_vo = 	563.87	, dep_vo = 	11.78	  where idactivo =  	337	 ; 
update af_activos set dep_acu_vo = 	1147.28	, dep_vo = 	47.85	  where idactivo =  	338	 ; 
update af_activos set dep_acu_vo = 	5042.31	, dep_vo = 	81.20	  where idactivo =  	341	 ; 
update af_activos set dep_acu_vo = 	895.35	, dep_vo = 	14.43	  where idactivo =  	342	 ; 

-- VEHICULOS
update af_activos set dep_acu_vo = 	190177.65	, dep_vo = 	3169.63	  where idactivo =  	3	 ; 
update af_activos set dep_acu_vo = 	0.00	, dep_vo = 	0.00	  where idactivo =  	71	 ; 
update af_activos set dep_acu_vo = 	0.00	, dep_vo = 	0.00	  where idactivo =  	102	 ; 
update af_activos set dep_acu_vo = 	75738.26	, dep_vo = 	631.15	  where idactivo =  	110	 ; 
update af_activos set dep_acu_vo = 	0.00	, dep_vo = 	0.00	  where idactivo =  	126	 ; 
update af_activos set dep_acu_vo = 	122770.25	, dep_vo = 	1023.09	  where idactivo =  	128	 ; 
update af_activos set dep_acu_vo = 	523.41	, dep_vo = 	8.72	  where idactivo =  	153	 ; 
update af_activos set dep_acu_vo = 	0.00	, dep_vo = 	0.00	  where idactivo =  	170	 ; 
update af_activos set dep_acu_vo = 	24467.30	, dep_vo = 	407.79	  where idactivo =  	183	 ; 
update af_activos set dep_acu_vo = 	92040.00	, dep_vo = 	1534.00	  where idactivo =  	184	 ; 
update af_activos set dep_acu_vo = 	0.00	, dep_vo = 	0.00	  where idactivo =  	202	 ; 
update af_activos set dep_acu_vo = 	82805.96	, dep_vo = 	1380.10	  where idactivo =  	211	 ; 
update af_activos set dep_acu_vo = 	15784.64	, dep_vo = 	257.35	  where idactivo =  	326	 ; 
update af_activos set dep_acu_vo = 	39700.66	, dep_vo = 	643.68	  where idactivo =  	332	 ; 
update af_activos set dep_acu_vo = 	93683.28	, dep_vo = 	1508.00	  where idactivo =  	340	 ; 
update af_activos set dep_acu_vo = 	17704.89	, dep_vo = 	324.80	  where idactivo =  	347	 ; 
update af_activos set dep_acu_vo = 	66604.65	, dep_vo = 	3505.51	  where idactivo =  	364	 ; 


--

select 	a.`idactivo`, a.`descri`, a.`fch_alta`, a.`vobs`, a.`voufv`, a.`vosus`, a.`tasa_dep`, a.`dep_vo`, a.`dep_acu_vo`, a.`estado`,
	d.`idhdepre`, d.`fecha_en_proceso` as fecha , d.`tasabsufv`, d.`tasabssus`,
	d.`dep_acu_vo`, d.`dep_acu_vo_bs`, d.`val_tot`,
	d.`dep_vo`, d.`dep_vo_bs`
from `af_activos` a
left join af_hdepre d on a.`idactivo` = d.`idactivo`
where a.`idactivo` in (3,
71,
102,
110,
126,
128,
153,
170,
183,
184,
202,
211,
326,
332,
340,
347,
364
)
;

select 	a.`idactivo`, a.`descri`, a.`fch_alta`, a.`duracion`, a.`vobs`, a.`dep_acu_vo`, a.`estado`, a.`dep_vo`,
	sum(d.`dep_vo_bs`) s_dep_vo_bs
from `af_activos` a
left join af_hdepre d on a.`idactivo` = d.`idactivo`
-- where a.`idactivo` in (229)
where a.`subgrupo` = 8
group by a.`idactivo`, a.`descri`, a.`fch_alta`, a.`duracion`, a.`vobs`, a.`dep_acu_vo`, a.`estado`, a.`dep_vo`
;


