-- INVENTARIO DE PRODUCTO TERMINADO
SELECT I.COD_ART, A.DESCRI, A.COSTO_UNI, I.SALDO_UNI
FROM WISE.INV_INVENTARIO I, WISE.INV_ARTICULOS A
WHERE  I.COD_ART = A.COD_ART
AND I.COD_ALM = 2
ORDER BY A.DESCRI

SELECT *
FROM WISE.INV_ARTICULOS

-- PEDIDOS POR FECHA DE ENTREGA
SELECT P.PEDIDO, P.ESTADO_PEDIDO, P.FECHA_PEDIDO, P.FECHA_ENTREGA 
FROM USER01_DAF.PEDIDOS P
-- WHERE P.FECHA_ENTREGA BETWEEN TO_DATE(:FECHA_ENTREGA, 'DD/MM/YYYY') AND TO_DATE(:FECHA_ENTREGA, 'DD/MM/YYYY')
WHERE P.FECHA_ENTREGA BETWEEN TO_DATE('04/08/2014', 'DD/MM/YYYY') AND 
                              TO_DATE('04/08/2014', 'DD/MM/YYYY')
AND P.ESTADO_PEDIDO = 'PEN'


-- B_MOVIMIENTOS
-- VENTAS AL CONTADO POR FECHA
SELECT 
-- M.FECHA, M.ESTADO, M.OBSERVACION, M.CUEN_ID, M.NROFACTURA, M.CANT, M.DESC_PEDIDO, CU.CODIGO, CU.COD_ART, CU.NOMBRE, CU.CON_COD, CO.COD, CO.DESCR
DISTINCT M.FECHA, M.ESTADO, M.NROFACTURA, CU.CON_COD, CO.COD, CO.DESCR
FROM USER01_DAF.B_MOVIMIENTOS M, USER01_DAF.CUENTAS CU, USER01_DAF.CONCEPTOS CO
WHERE   M.CUEN_ID   = CU.ID
AND     CU.CON_COD  = CO.COD
AND     CO.COD IN (02, 03)
AND     M.FECHA = TO_DATE(:FECHA, 'DD/MM/YYYY')

AND     M.FECHA BETWEEN TO_DATE('01/05/2014', 'DD/MM/YYYY') AND TO_DATE('01/07/2014', 'DD/MM/YYYY')
                

SELECT 
-- M.FECHA, M.ESTADO, M.OBSERVACION, M.CUEN_ID, M.NROFACTURA, M.CANT, M.DESC_PEDIDO, CU.CODIGO, CU.COD_ART, CU.NOMBRE, CU.CON_COD, CO.COD, CO.DESCR
DISTINCT M.FECHA, M.ESTADO, M.NROFACTURA, CU.CON_COD, CO.COD, CO.DESCR
FROM USER01_DAF.B_MOVIMIENTOS M, USER01_DAF.CUENTAS CU, USER01_DAF.CONCEPTOS CO
WHERE   M.CUEN_ID   = CU.ID
AND     CU.CON_COD  = CO.COD
AND     CO.COD IN (02, 03)

AND     M.NROFACTURA = 4424


-- B_MOVIMIENTOS, INV_VENTART
-- VENTAS AL CONTADO POR FECHA
SELECT 
DISTINCT M.FECHA, M.ESTADO, M.NROFACTURA, CU.CON_COD, CO.COD, CO.DESCR, VE.ESTADO
FROM USER01_DAF.B_MOVIMIENTOS M, USER01_DAF.CUENTAS CU, USER01_DAF.CONCEPTOS CO, WISE.INV_VENTART VE
WHERE   M.CUEN_ID       = CU.ID
AND     CU.CON_COD      = CO.COD
AND     M.NROFACTURA    = VE.NO_FACT
-- AND     VE.NO_FACT IS NULL
AND     CO.COD IN (02, 03)
AND     M.FECHA = TO_DATE(:FECHA, 'DD/MM/YYYY')

AND     VE.ESTADO = 'PENDING'



SELECT *
FROM WISE.INV_VENTART
-- WHERE NO_FACT = 26004469
WHERE PEDIDO = 4424

SELECT *
FROM USER01_DAF.PEDIDOS
-- WHERE ESTADO_PEDIDO = 'PEN'
WHERE PEDIDO = 4545

SELECT *
FROM USER01_DAF.B_MOVIMIENTOS M 

SELECT *
FROM USER01_DAF.CUENTAS 

SELECT *
FROM USER01_DAF.CONCEPTOS



select distinct iv.no_fact, mo.fecha
from WISE.inv_ventart iv
inner join USER01_DAF.b_movimientos mo
on mo.nrofactura = iv.no_fact
where mo.fecha between to_date('02/08/2014','dd/mm/yyyy') and 
                       to_date('02/08/2014','dd/mm/yyyy')
and mo.desc_pedido <> 'Saldo Inicial al 31 de Diciembre'
and mo.desc_pedido <> 'Saldo al 31 Diciembre del 2013'
and mo.desc_pedido not like '%Nro.Pedido:%'
and mo.estado <> 'A'
and iv.cod_art <> 147
-- and iv.cod_art <> 165
and iv.cod_art <> 155
and iv.estado = 'PENDING';

select distinct nrofactura from USER01_DAF.movimientos
where fecha = to_date('11/07/2014','dd/mm/yyyy');


select sum( ra.cantidadpesada) from registroacopio ra
inner join planillaacopio pa
on pa.idplanillaacopio = ra.idplanillaacopio
where pa.fecha between to_date('16/01/2014','dd/mm/yyyy') and to_date('31/01/2014','dd/mm/yyyy');