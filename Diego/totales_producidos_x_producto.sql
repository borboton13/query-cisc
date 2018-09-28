set termout off
set feedback off
set serveroutput on size 100000
declare
noFact VARCHAR2(10 BYTE);
numVale VARCHAR2(20 BYTE);
total integer;
begin

for ordenes in (
        SELECT distinct mp.nombre as nombre FROM ordenproduccion op
inner join planificacionproduccion pp
on op.idplanificacionproduccion = pp.idplanificacionproduccion
inner join composicionproducto cp
on op.idcomposicionproducto = cp.idcomposicionproducto
inner join metaproductoproduccion mp
on mp.idmetaproductoproduccion = cp.idproductoprocesado
where pp.fecha between to_date('01/04/2014','DD/MM/YYYY') and to_date('30/04/2014','DD/MM/YYYY')
  ) loop                                                
     
          SELECT sum(op.cantidadproducida) as total into total  FROM ordenproduccion op
          inner join planificacionproduccion pp
          on op.idplanificacionproduccion = pp.idplanificacionproduccion
          inner join composicionproducto cp
          on op.idcomposicionproducto = cp.idcomposicionproducto
          inner join metaproductoproduccion mp
          on mp.idmetaproductoproduccion = cp.idproductoprocesado
          where pp.fecha between to_date('01/04/2014','DD/MM/YYYY') and to_date('30/04/2014','DD/MM/YYYY')
          and mp.nombre = ordenes.nombre ;  
          
          SYS.dbms_output.put_line(ordenes.nombre||' Cantidad: '||to_char(total));
         -- SYS.dbms_output.put_line('Producto: '||ordenes.nombre);

end loop;

end;