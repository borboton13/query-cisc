-- ------------------------------------------------
-- ---------------- KARDEX CLIENTES ---------------
-- ------------------------------------------------
SELECT e.`fecha`, e.`tipo_doc`, e.`no_doc`, e.`IDPERSONACLIENTE`, d.`debe`, d.`haber`, d.`idpersonacliente`
FROM sf_tmpdet d
JOIN sf_tmpenc e ON d.`id_tmpenc` = e.`id_tmpenc`
WHERE e.`fecha` BETWEEN '2016-01-01' AND '2016-12-31'
AND d.`cuenta` = '1421010100'
AND d.`idpersonacliente` = 175
;


SELECT p.`NOM`, p.`AP`, p.`AM`, SUM(d.`debe`) AS D, SUM(d.`haber`) AS H
FROM sf_tmpdet d
LEFT JOIN sf_tmpenc e      ON d.`id_tmpenc` = e.`id_tmpenc`
LEFT JOIN personacliente p ON d.`idpersonacliente` = p.`IDPERSONACLIENTE`
WHERE e.`fecha` BETWEEN '2016-01-01' AND '2016-07-01'
AND d.`cuenta` = '1421010100'
AND e.`estado` <> 'ANL'
GROUP BY p.`NOM`, p.`AP`, p.`AM`
-- and d.`idpersonacliente` = 175
;

--
-- -----------------------------------------------
-- UPDATE 1
SELECT *
FROM sf_tmpenc e
-- update sf_tmpenc e set e.`fecha` = '2016-01-01'
WHERE e.`fecha` <= '2015-12-31'
AND e.`tipo_doc` = 'NE'
;

-- UPDATE 2
SELECT e.`fecha`, e.`tipo_doc`, e.`no_doc`, e.`IDPERSONACLIENTE`, d.`debe`, d.`haber`, d.`idpersonacliente`
FROM sf_tmpdet d
-- update sf_tmpdet d
JOIN sf_tmpenc e ON  d.`id_tmpenc` = e.`id_tmpenc`
-- set d.`idpersonacliente` = e.`IDPERSONACLIENTE`
WHERE e.`fecha` = '2016-01-01'
AND e.`tipo_doc` = 'NE'
;

-- UPDATE 3
SELECT *
FROM personacliente
UPDATE personacliente SET nit=0
WHERE nit = ''
;

-- UPDATE 4 
SELECT e.`id_tmpenc`, e.`fecha`, e.`tipo_doc`, e.`no_doc`, e.`estado`, e.`IDPERSONACLIENTE`, e.`glosa`
FROM sf_tmpenc e
WHERE e.`tipo_doc` = 'NE'
-- and e.`no_doc` = 81
-- and e.`id_tmpenc` = 2907
;

SELECT e.`tipo_doc`, e.`no_doc`, COUNT(e.`no_doc`)
FROM sf_tmpenc e
WHERE e.`tipo_doc` = 'NE'
GROUP BY e.`tipo_doc`, e.`no_doc`
;



UPDATE sf_tmpenc SET no_doc = 	1	 WHERE id_tmpenc = 	2864	;
UPDATE sf_tmpenc SET no_doc = 	2	 WHERE id_tmpenc = 	2865	;
UPDATE sf_tmpenc SET no_doc = 	3	 WHERE id_tmpenc = 	2866	;
UPDATE sf_tmpenc SET no_doc = 	4	 WHERE id_tmpenc = 	2867	;
UPDATE sf_tmpenc SET no_doc = 	5	 WHERE id_tmpenc = 	2869	;
UPDATE sf_tmpenc SET no_doc = 	6	 WHERE id_tmpenc = 	2870	;
UPDATE sf_tmpenc SET no_doc = 	7	 WHERE id_tmpenc = 	2871	;
UPDATE sf_tmpenc SET no_doc = 	8	 WHERE id_tmpenc = 	2878	;
UPDATE sf_tmpenc SET no_doc = 	9	 WHERE id_tmpenc = 	2907	;
UPDATE sf_tmpenc SET no_doc = 	10	 WHERE id_tmpenc = 	2908	;
UPDATE sf_tmpenc SET no_doc = 	11	 WHERE id_tmpenc = 	2909	;
UPDATE sf_tmpenc SET no_doc = 	12	 WHERE id_tmpenc = 	2910	;
UPDATE sf_tmpenc SET no_doc = 	13	 WHERE id_tmpenc = 	2911	;
UPDATE sf_tmpenc SET no_doc = 	14	 WHERE id_tmpenc = 	2912	;
UPDATE sf_tmpenc SET no_doc = 	15	 WHERE id_tmpenc = 	2913	;
UPDATE sf_tmpenc SET no_doc = 	16	 WHERE id_tmpenc = 	2914	;
UPDATE sf_tmpenc SET no_doc = 	17	 WHERE id_tmpenc = 	2915	;
UPDATE sf_tmpenc SET no_doc = 	18	 WHERE id_tmpenc = 	2916	;
UPDATE sf_tmpenc SET no_doc = 	19	 WHERE id_tmpenc = 	2917	;
UPDATE sf_tmpenc SET no_doc = 	20	 WHERE id_tmpenc = 	2918	;
UPDATE sf_tmpenc SET no_doc = 	21	 WHERE id_tmpenc = 	2919	;
UPDATE sf_tmpenc SET no_doc = 	22	 WHERE id_tmpenc = 	2920	;
UPDATE sf_tmpenc SET no_doc = 	23	 WHERE id_tmpenc = 	2921	;
UPDATE sf_tmpenc SET no_doc = 	24	 WHERE id_tmpenc = 	2922	;
UPDATE sf_tmpenc SET no_doc = 	25	 WHERE id_tmpenc = 	3027	;
UPDATE sf_tmpenc SET no_doc = 	26	 WHERE id_tmpenc = 	3028	;
UPDATE sf_tmpenc SET no_doc = 	27	 WHERE id_tmpenc = 	3029	;
UPDATE sf_tmpenc SET no_doc = 	28	 WHERE id_tmpenc = 	3119	;
UPDATE sf_tmpenc SET no_doc = 	29	 WHERE id_tmpenc = 	3120	;
UPDATE sf_tmpenc SET no_doc = 	30	 WHERE id_tmpenc = 	3121	;
UPDATE sf_tmpenc SET no_doc = 	31	 WHERE id_tmpenc = 	3122	;
UPDATE sf_tmpenc SET no_doc = 	32	 WHERE id_tmpenc = 	3123	;
UPDATE sf_tmpenc SET no_doc = 	33	 WHERE id_tmpenc = 	3124	;
UPDATE sf_tmpenc SET no_doc = 	34	 WHERE id_tmpenc = 	3125	;
UPDATE sf_tmpenc SET no_doc = 	35	 WHERE id_tmpenc = 	3126	;


UPDATE sf_tmpenc SET ESTADO = 'ANL' WHERE id_tmpenc = 2907;



SELECT * 
FROM pago
WHERE id_tmpenc = 3404
;

UPDATE pago SET pago = 6459 WHERE id_tmpenc = 3404;

SELECT *
FROM sf_tmpdet
WHERE id_tmpenc = 3404
;

UPDATE sf_tmpdet SET debe = 6459 WHERE id_tmpdet = 9911;
UPDATE sf_tmpdet SET haber = 6459 WHERE id_tmpdet = 9912;


