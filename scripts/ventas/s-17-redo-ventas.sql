
--@Author:          Rodrigo Tapia Navarro
--@Fecha creaciòn   09/12/24
--@Descripciòn      script para simular la generacion de datos de REDO para el modulo ventas.

connect tana_ventas/ventas@tana_ventas 


declare
  v_orden_compra_id number;
  v_fecha date;
  v_folio varchar2(10);
  v_direccion varchar2(50);
begin

  select max(orden_compra_id) into v_orden_compra_id
  from orden_compra;
  
  for i in 1..100 loop
    v_orden_compra_id := v_orden_compra_id + 1;
    v_fecha := sysdate - dbms_random.value(0,5);
    v_folio := dbms_random.string('X', 10);
    v_direccion := dbms_random.string('X', round(dbms_random.value(10, 40),0));

    insert into orden_compra (orden_compra_id, fecha, folio, direccion_entrega)
    values (v_orden_compra_id, v_fecha, v_folio, v_direccion);
  end loop;

end;
/

prompt carga de ordenes exitosa!

declare 
  v_factura_id number;
  v_folio varchar2(6);
  v_monto_total number;
  v_comision  number;
  v_empresa_id number;
  v_orden_compra_id number;
begin
  select max(factura_id) into v_factura_id 
  from factura;

  for i in 1..100 loop
    v_factura_id := v_factura_id + 1;
    v_folio := dbms_random.string('X', 6);
    v_monto_total := round(dbms_random.value(1000,50000),2);
    v_comision := v_monto_total*0.1;
    v_empresa_id := round(dbms_random.value(1,30),0);
    
    select orden_compra_id into v_orden_compra_id
    from orden_compra sample(10) where rownum = 1;

    insert into factura
      (factura_id, folio, monto_total, comision, empresa_paqueteria_id, orden_compra_id)
    values
      (v_factura_id, v_folio, v_monto_total, v_comision, v_empresa_id, v_orden_compra_id);
  end loop;
end;
/

prompt carga de facturas exitosa

commit;