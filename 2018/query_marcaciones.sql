DROP SEQUENCE inc_idrhmarcado;

SELECT (MAX(RH.IDRHMARCADO)+1)  FROM RHMARCADO RH;

CREATE SEQUENCE inc_idrhmarcado 
INCREMENT BY 1 
START WITH 5361;

-- INSERT INTO EOS.rhmarcado 
(idrhmarcado,marfecha,marippc,marperid,marreftarjeta,marestado,marhora,sede,idcompania,control) 
(
select INC_IDRHMARCADO.NEXTVAL AS IDRHMARCADO, V.MARFECHA, V.MARIPPC, V.MARPERID, V.MARREFTARJETA, V.MARESTADO, V.MARHORA, V.SEDE, 1.IDCOMPANIA, 
CASE  WHEN V.MAR_IN_OUT = 'Entrada' THEN 1
      WHEN V.MAR_IN_OUT = 'Salida'  THEN 2
      ELSE 0 END AS CONTROL
from VMARCADO V
-- WHERE V.MARFECHA >= to_date('2010-10-07','yyyy-mm-dd')
WHERE V.MARFECHA >= to_date('2014-01-01','yyyy-mm-dd')
AND   V.MARFECHA <= to_date('2014-03-31','yyyy-mm-dd')
-- AND V.MARHORA IS NOT NULL
-- AND V.MARREFTARJETA IN ()
);


-- UPDATE SECUENCIA SET VALOR=(SELECT MAX(M.IDRHMARCADO)/10+1 FROM RHMARCADO M) WHERE TABLA='rhmarcado';

SELECT * FROM VMARCADO V
WHERE V.MARFECHA >= to_date('2014-01-01','yyyy-mm-dd')
AND   V.MARFECHA <= to_date('2014-03-31','yyyy-mm-dd')



select * from EOS.RHMARCADO
-- delete from RHMARCADO
where RHMARCADO.MARFECHA >= to_date('2014-03-01','yyyy-mm-dd')
AND   RHMARCADO.MARFECHA <= to_date('2014-03-31','yyyy-mm-dd')
AND RHMARCADO.MARREFTARJETA IN ('6496706')
;