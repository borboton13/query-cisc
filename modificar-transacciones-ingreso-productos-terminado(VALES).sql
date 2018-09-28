
set termout off
set feedback off
set serveroutput on size 100000
declare
noFact VARCHAR2(10 BYTE);
numVale VARCHAR2(20 BYTE);
cont integer;
begin
cont := 1;
for pedidos in (
        select fecha,glosa from WISE.sf_tmpenc where formulario = 'PED'
  ) loop                                                
     
     SELECT REGEXP_SUBSTR(pedidos.glosa,
        '[1-9]-[1-9][0-9][0-9]') into numVale
      FROM dual;
     SYS.dbms_output.put_line('numVale: '||numVale);          
     /*SYS.dbms_output.put_line('update WISE.inv_vales set fecha = to_date('''||to_char(pedidos.fecha,'DD/MM/YYYY')||''',''DD/MM/YYYY'')
                              where NO_VALE = '''||numVale||''';');         */
                              
     cont := cont +1;     

end loop;
SYS.dbms_output.put_line('total:'||cont);
EXCEPTION
     WHEN NO_DATA_FOUND THEN
     SYS.dbms_output.put_line('error:'||noFact);
end;
/*
SELECT REGEXP_SUBSTR('CONSUMO, EGRESO, ALMACEN (ALMACEN DE PRODUCTOS TERMINADOS), ARTICULOS(100, 101, 103, 107, 108, 109, 132, 94), FECHA(02/01/2014 00:00), APROBACIÓN DEL VALE NRO. 2-198(VALE GENERADO AUTOMÁTICAMENTE POR LA ENTREGA DE LA FACTURA NRO: 226)',
        '[1-9]-[1-9][1-9][1-9]') 
      FROM dual;
      */