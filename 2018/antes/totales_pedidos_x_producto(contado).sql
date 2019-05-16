set termout off
set feedback off
set serveroutput on size 100000
declare
noFact VARCHAR2(10 BYTE);
numVale VARCHAR2(20 BYTE);
total integer;
begin

for ordenes in (
        select distinct ia.descri as nombre  
        from WISE.inv_ventart iv
        inner join USER01_DAF.b_movimientos mo on mo.nrofactura = iv.no_fact
        inner join WISE.inv_articulos ia       on ia.cod_art = iv.cod_art
        where mo.fecha between to_date('01/01/2014','dd/mm/yyyy') and to_date('31/01/2014','dd/mm/yyyy')
        and mo.desc_pedido <> 'Saldo Inicial al 31 de Diciembre'
        and mo.desc_pedido <> 'Saldo al 31 Diciembre del 2013'
        and mo.desc_pedido not like '%Nro.Pedido:%'
        
  ) loop                                                
     
          select sum(iv.cantidad) into total from WISE.inv_ventart iv
          inner join USER01_DAF.b_movimientos mo
          on mo.nrofactura = iv.no_fact
          inner join WISE.inv_articulos ia
          on ia.cod_art = iv.cod_art
          where mo.fecha between to_date('01/01/2014','dd/mm/yyyy') and to_date('31/01/2014','dd/mm/yyyy')
          and mo.desc_pedido <> 'Saldo Inicial al 31 de Diciembre'
          and mo.desc_pedido <> 'Saldo al 31 Diciembre del 2013'
          and mo.desc_pedido not like '%Nro.Pedido:%'
          and ia.descri = ordenes.nombre ;  
          
          SYS.dbms_output.put_line(ordenes.nombre||' Cantidad: '||to_char(total));
         -- SYS.dbms_output.put_line('Producto: '||ordenes.nombre);

end loop;

end;