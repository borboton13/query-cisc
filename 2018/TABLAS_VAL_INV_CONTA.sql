-- -------------------------------
-- TABLAS RELACIONADAS CON: VALES, INVENTARIOS Y CONTABILIDAD (pendiente en contabilidad)

SELECT * 
FROM WISE.INV_VALES V   -- 263
-- WHERE V.NO_TRANS IN (263,44830,44806,44804,44836,44838,44840,44842,44844,44846,44848,44850,44852,44854,67350,67352,67354,67356,67358,67360)
-- WHERE V.NO_VALE = '5-1' 

-- NO_TRANS: 44840

SELECT *
FROM WISE.INV_MOVDET MD
WHERE MD.NO_TRANS IN (263,44830,44806,44804,44836,44838,44840,44842,44844,44846,44848,44850,44852,44854,67350,67352,67354,67356,67358,67360)

SELECT *
FROM WISE.INV_MOV M
WHERE M.NO_TRANS IN (263,44830,44806,44804,44836,44838,44840,44842,44844,44846,44848,44850,44852,44854,67350,67352,67354,67356,67358,67360)
-- WHERE M.DESCRI LIKE '%ACOPI%'


SELECT *
FROM WISE.INV_INVENTARIO I
WHERE I.COD_ART = 26

SELECT *
FROM WISE.INV_INVENTARIO_DETALLE ID
WHERE COD_ART = 26

SELECT * -- COD_ART,DESCRI,COSTO_UNI,SALDO_MON 
FROM WISE.INV_ARTICULOS     
WHERE COD_ART = 26

SELECT * 
FROM WISE.INV_INVMES            
WHERE COD_ART = 26 


SELECT * 
FROM WISE.SF_TMPENC
-- WHERE NO_TRANS IN (44805,44809,44831,44837,44839,44841,44843,44845,44847,44849,44851,44853,44855,67351,67353,67355,67357,67359,67361)
WHERE DESCRI LIKE '%ACOPIO DE LECHE MES%'


SELECT * 
FROM WISE.SF_TMPDET
WHERE NO_TRANS IN (44805,44809,44831,44837,44839,44841,44843,44845,44847,44849,44851,44853,44855,67351,67353,67355,67357,67359,67361)