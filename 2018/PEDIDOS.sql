SELECT P.PEDIDO, P.ESTADO_PEDIDO, PE.AP, PE.AM, PE.NOM, P.FECHA_ENTREGA, I.DESCRI, A.PRECIO, A.CANTIDAD, A.TOTAL 
FROM USER01_DAF.PEDIDOS P
JOIN USER01_DAF.PERSONAS PE ON P.ID = PE.PI_ID
JOIN USER01_DAF.ARTICULOS_PEDIDO A ON P.PEDIDO = A.PEDIDO
JOIN WISE.INV_ARTICULOS I ON A.COD_ART = I.COD_ART
WHERE P.PEDIDO = 1


SELECT * 
FROM USER01_DAF.PEDIDOS P
JOIN USER01_DAF.PERSONAS PE ON P.ID = PE.PI_ID
JOIN USER01_DAF.ARTICULOS_PEDIDO A ON P.PEDIDO = A.PEDIDO
JOIN WISE.INV_ARTICULOS I ON A.COD_ART = I.COD_ART
WHERE P.PEDIDO = 1


SELECT P.FECHA_ENTREGA, COUNT(DISTINCT P.PEDIDO )
FROM USER01_DAF.PEDIDOS P
WHERE P.ESTADO_PEDIDO <> 'ANL'
GROUP BY P.FECHA_ENTREGA
ORDER BY P.FECHA_ENTREGA DESC

SELECT *
FROM USER01_DAF.PEDIDOS

-- -----------------------------------------------------------------------------

SELECT 
-- *
CI.NOMBRE, CI.MONTOBS, CI.IDPERIODOCOSTOINDIRECTO, CIC.CUENTA, CIC.COD_GRU, CIC.ESTADO, GR.DESCRI
FROM EOS.COSTOSINDIRECTOS CI
LEFT JOIN EOS.COSTOSINDIRECTOSCONF CIC  ON CI.IDCOSTOSINDIRECTOSCONF = CIC.IDCOSTOSINDIRECTOSCONF 
LEFT JOIN WISE.INV_GRUPOS GR            ON CIC.COD_GRU = GR.COD_GRU 
WHERE CI.IDPERIODOCOSTOINDIRECTO = 2

SELECT * FROM WISE.INV_GRUPOS

SELECT * FROM EOS.COSTOSINDIRECTOS C
WHERE C.IDPERIODOCOSTOINDIRECTO = 1


SELECT *
FROM WISE.INV_VENTART V
where v.PEDIDO = '7410'


SELECT DISTINCT P.*, V.PEDIDO
FROM USER01_DAF.PEDIDOS P
LEFT JOIN WISE.INV_VENTART V ON P.PEDIDO = V.PEDIDO
WHERE P.FECHA_ENTREGA BETWEEN TO_DATE('06/12/2014','DD/MM/YYYY') AND TO_DATE('06/12/2014','DD/MM/YYYY')
AND P.ESTADO_PEDIDO <> 'ANL'


SELECT *
FROM USER01_DAF.PEDIDOS P
WHERE P.FECHA_ENTREGA BETWEEN TO_DATE('06/10/2014','DD/MM/YYYY') AND TO_DATE('06/12/2014','DD/MM/YYYY')
-- and p.pedido = '3739'
AND P.ESTADO_PEDIDO = 'ANL'

SELECT *
FROM USER01_DAF.ARTICULOS_PEDIDO

-- CANT PEDIDOS X ART 
SELECT AP.COD_ART, SUM(AP.CANTIDAD) CANT, SUM(AP.REPOSICION) REP, SUM(AP.PROMOCION) PRO
FROM USER01_DAF.ARTICULOS_PEDIDO AP, USER01_DAF.PEDIDOS P
WHERE AP.PEDIDO = P.PEDIDO
AND AP.COD_ART = 134
AND P.FECHA_ENTREGA BETWEEN TO_DATE('01/01/2014','DD/MM/YYYY') AND TO_DATE('31/01/2014','DD/MM/YYYY')
AND P.ESTADO_PEDIDO <> 'ANL'
AND P.ESTADO_PEDIDO
GROUP BY AP.COD_ART

-- CANT PEDIDOS X ART (INV_VENTART)
SELECT *
-- COD_ART, PEDIDO, CANTIDAD
FROM WISE.INV_VENTART
WHERE COD_ART = 101
AND PEDIDO IS NOT NULL

SELECT V.COD_ART, SUM(V.CANTIDAD)
FROM WISE.INV_VENTART V, USER01_DAF.PEDIDOS P
WHERE V.PEDIDO = P.PEDIDO
-- AND V.COD_ART = 101
-- AND V.PEDIDO IS NOT NULL
AND P.FECHA_ENTREGA BETWEEN TO_DATE('01/01/2014','DD/MM/YYYY') AND TO_DATE('31/01/2014','DD/MM/YYYY')
GROUP BY V.COD_ART


SELECT * 
FROM USER01_DAF.PEDIDOS P


-- CANTIDAD DE PRODUCTOS PRODUCIDOS
SELECT 
-- PP.FECHA, OP.CODIGO, MP.COD_ART, MP.NOMBRE, OP.CANTIDADPRODUCIDA, OP.ESTADOORDEN
MP.COD_ART, MP.NOMBRE, SUM(OP.CANTIDADPRODUCIDA) AS CANTIDAD
FROM EOS.ORDENPRODUCCION OP
LEFT JOIN EOS.PLANIFICACIONPRODUCCION PP ON OP.IDPLANIFICACIONPRODUCCION    = PP.IDPLANIFICACIONPRODUCCION
LEFT JOIN EOS.COMPOSICIONPRODUCTO     CP ON OP.IDCOMPOSICIONPRODUCTO        = CP.IDCOMPOSICIONPRODUCTO
LEFT JOIN EOS.PRODUCTOPROCESADO       PR ON CP.IDPRODUCTOPROCESADO          = PR.IDPRODUCTOPROCESADO
LEFT JOIN EOS.METAPRODUCTOPRODUCCION  MP ON PR.IDPRODUCTOPROCESADO          = MP.IDMETAPRODUCTOPRODUCCION  
WHERE PP.FECHA BETWEEN TO_DATE('01/01/2014','DD/MM/YYYY') AND TO_DATE('31/01/2014','DD/MM/YYYY')
GROUP BY MP.COD_ART, MP.NOMBRE


SELECT *
FROM EOS.PLANIFICACIONPRODUCCION


SELECT *
FROM EOS.COMPOSICIONPRODUCTO

SELECT *
FROM EOS.PRODUCTOPROCESADO

SELECT *
FROM EOS.METAPRODUCTOPRODUCCION


SELECT DISTINCT B.TIPO_PAGO
FROM USER01_DAF.B_MOVIMIENTOS B

WHERE B.NROFACTURA = 14

SELECT *
FROM USER01_DAF.CUENTAS

select *
from WISE.inv_ventart iv
inner join USER01_DAF.b_movimientos mo on mo.nrofactura = iv.no_fact
inner join WISE.inv_articulos ia       on ia.cod_art = iv.cod_art
where mo.fecha between to_date('01/01/2014','dd/mm/yyyy') and to_date('31/01/2014','dd/mm/yyyy')


SELECT B.FECHA, C.COD_ART, C.NOMBRE, B.CANT
FROM USER01_DAF.B_MOVIMIENTOS B
LEFT JOIN USER01_DAF.CUENTAS C ON B.CUEN_ID = C.ID
WHERE B.FECHA BETWEEN TO_DATE('01/01/2014','DD/MM/YYYY') AND TO_DATE('31/01/2014','DD/MM/YYYY')
AND C.COD_ART = 107



SELECT *
FROM WISE.INV_VENTART V 
WHERE V.PEDIDO IS NULL AND V.NO_FACT IS NOT NULL
AND V.COD_ART = 107


SELECT *
FROM USER01_DAF.PEDIDOS

SELECT *
FROM USER01_DAF.B_MOVIMIENTOS
WHERE OBSERVACION LIKE '%VENTA%CONTADO%'
AND ESTADO <> 'A'
AND NROFACTURA = '26000092'

Saldo al 31 Diciembre del 2013

SELECT *
-- C.COD_ART, C.NOMBRE, SUM(B.CANT) AS CANT
-- B.FECHA, C.COD_ART, C.NOMBRE, B.CANT
FROM USER01_DAF.B_MOVIMIENTOS B
LEFT JOIN USER01_DAF.CUENTAS C ON B.CUEN_ID = C.ID
WHERE B.OBSERVACION LIKE '%CONTADO%'
AND B.FECHA BETWEEN TO_DATE('01/01/2014','DD/MM/YYYY') AND TO_DATE('31/01/2014','DD/MM/YYYY')
AND B.ESTADO <> 'A'
-- AND C.COD_ART = 107
-- GROUP BY C.COD_ART, C.NOMBRE

SELECT *
FROM WISE.INV_MOV
WHERE DESCRI LIKE '%ENTRADA%'


SELECT *
FROM WISE.INV_VENTART V
WHERE V.COD_ART = 165
AND V.PEDIDO IS NOT NULL