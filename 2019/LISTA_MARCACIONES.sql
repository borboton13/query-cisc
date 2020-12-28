-- --------------------------------------------------
-- LISTA DE MARCACIONES POR MES
-- --------------------------------------------------
select  E.IDENTIDAD, RH.MARPERID as CI, 
        EM.CODIGOEMPLEADO,
        EM.CODIGOMARCACION,
        P.APELLIDOPATERNO, 
        P.APELLIDOMATERNO, 
        P.NOMBRES, 
        -- TO_CHAR(RH.MARFECHA, 'DD/MM/YYYY') as FECHA0, 
        TO_CHAR(RH.MARHORA, 'DD/MM/YYYY') as FECHA, 
        TO_CHAR(RH.MARHORA, 'HH24:MI:SS') as HORA
        -- RH.MARHORA  
from VMARCADO RH
join ENTIDAD E   on RH.MARPERID = E.NOIDENTIFICACION
join PERSONA P   on E.IDENTIDAD = P.IDPERSONA
join EMPLEADO EM on P.IDPERSONA = EM.IDEMPLEADO
where RH.MARFECHA between to_date('01/03/2015', 'DD/MM/YYYY') and TO_DATE('30/11/2014','DD/MM/YYYY') 
order by RH.MARPERID, RH.MARFECHA, RH.MARHORA


-- -------------------------------------
-- --------------------------------------------------
-- LISTA DE MARCACIONES POR MES
-- --------------------------------------------------
select  E.IDENTIDAD, RH.MARPERID as CI, 
        EM.CODIGOEMPLEADO,
        EM.CODIGOMARCACION,
        P.APELLIDOPATERNO, 
        P.APELLIDOMATERNO, 
        P.NOMBRES, 
        RH.MARFECHA,
        TO_CHAR(RH.MARHORA, 'HH24:MI:SS') as HORA,
        RH.MARHORA,
        RH.DESCRIPCION  
from RHMARCADO RH
join ENTIDAD E   on RH.MARREFTARJETA = E.NOIDENTIFICACION
join PERSONA P   on E.IDENTIDAD = P.IDPERSONA
join EMPLEADO EM on P.IDPERSONA = EM.IDEMPLEADO
where RH.MARFECHA between to_date('01/04/2015', 'DD/MM/YYYY') and TO_DATE('30/04/2015','DD/MM/YYYY') 
order by RH.MARPERID, RH.MARFECHA, RH.MARHORA;

-- ----------------------------
-- QUERY OFICIAL
-- ----------------------------
select  E.IDENTIDAD, 
        E.NOIDENTIFICACION as CI, 
        -- EM.CODIGOEMPLEADO,
        EM.CODIGOMARCACION,
        P.APELLIDOPATERNO, 
        P.APELLIDOMATERNO, 
        P.NOMBRES, 
        RH.MARFECHA,
        RH.MARHORA
        -- RH.DESCRIPCION
from RHMARCADO RH
join EMPLEADO EM on RH.MARREFTARJETA = EM.CODIGOMARCACION
join PERSONA P   on EM.IDEMPLEADO    = P.IDPERSONA
join ENTIDAD E   on P.IDPERSONA      = E.IDENTIDAD
where RH.MARFECHA between '2019-04-01' and '2019-04-30'
;


-- UPDATE SECUENCIA SET VALOR=(SELECT MAX(E.IDRHMARCADO)/10+1 FROM RHMARCADO E) WHERE TABLA='rhmarcado';
select max(E.IDRHMARCADO)+1 from RHMARCADO E;




-- INSERT INTO rh_marcado (control, marfecha, marippc, marperid, marhora)
select 0 as control, r.`marfecha`, r.`marippc`, r.`marperid`, r.`marhora`
from rhmarcado r
where r.`marfecha` between '2018-07-01' and '2018-07-31'
;



select *
from vmarcado v
where v.`marfecha` between '2020-02-01' and '2020-02-29'
and v.`marperid` = 8688934
;

-- DIAS PARA PASAJES
select v.`marperid` as CI, v.`nombre`, count( distinct day(v.`marfecha`) ) as dias
from vmarcado v
where v.`marfecha` between '2020-01-01' and '2020-12-31'
-- and v.`marreftarjeta` in (8714155,5283781,8048438,4532545,5264949,5924127)
group by v.`marperid`, v.`nombre`
;


select *
from rh_marcado r
where r.`marfecha` between '2020-03-01' and '2020-03-31'
;


-- select distinct v.`marperid` as CI, cast(v.`nombre` as char(100))-- , v.`marhora`
select *
from vmarcado v
where v.`marfecha` between '2020-11-01' and '2020-11-31'

;





