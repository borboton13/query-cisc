set termout off
set feedback off
set serveroutput on size 100000
declare
noFact VARCHAR2(10 BYTE);
numVale VARCHAR2(20 BYTE);
total integer;
begin

for ordenes in (
      select distinct ia.descri as nombre from WISE.inv_ventart iv
      inner join USER01_DAF.pedidos pe
      on iv.pedido = pe.pedido
      inner join WISE.inv_articulos ia
      on ia.cod_art = iv.cod_art
      where pe.fecha_entrega between to_date('01/01/2014','dd/mm/yyyy') and to_date('31/01/2014','dd/mm/yyyy')      
        
  ) loop                                                
     
          select sum(iv.cantidad) into total from WISE.inv_ventart iv
          inner join USER01_DAF.pedidos pe
          on iv.pedido = pe.pedido
          inner join WISE.inv_articulos ia
          on ia.cod_art = iv.cod_art
          where pe.fecha_entrega between to_date('01/01/2014','dd/mm/yyyy') and to_date('31/01/2014','dd/mm/yyyy')
          and ia.descri = ordenes.nombre;
          
          SYS.dbms_output.put_line(ordenes.nombre||' Cantidad: '||to_char(total));
         -- SYS.dbms_output.put_line('Producto: '||ordenes.nombre);

end loop;

end;