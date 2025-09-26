--@Author:          Rodrigo Tapia Navarro
--@Fecha creaciòn   09/12/24
--@Descripciòn      script para simular la generacion de datos de REDO diaria de la base.

connect tana_subastas/subastas@tana_subastas

set serveroutput on
show errors

--Carga de usuarios
declare 
  v_usuario_id number;
  v_nombre varchar2(100);
  v_apellido_pat varchar2(100);
  v_apellido_mat varchar2(100);
  v_username  varchar2(50);
  v_password  varchar2(30);
  v_email varchar2(100);
  v_rfc varchar2(13);
  v_es_vendedor number;
  v_es_comprador number;
  v_telefono_id number;
begin
  select max(usuario_id) into v_usuario_id 
  from usuario;

  select max(telefono_comprador_id)  into v_telefono_id
  from telefono_comprador;

  for i in 1..2000 loop
    v_usuario_id := v_usuario_id + 1;
    v_nombre := dbms_random.string('A', round(dbms_random.value(5,40),0));
    v_apellido_mat := dbms_random.string('A', round(dbms_random.value(5,40),0));
    v_apellido_pat := dbms_random.string('A', round(dbms_random.value(5,40),0));
    v_username := dbms_random.string('A', round(dbms_random.value(6,30),0));
    v_password := dbms_random.string('A', round(dbms_random.value(6,16),0));
    v_email := dbms_random.string('A', round(dbms_random.value(20,45),0));
    v_rfc := dbms_random.string('A', 13);
    v_es_vendedor := round(dbms_random.value(0,1),0);
    case v_es_vendedor
      when 0 then
        v_es_comprador := 1;
      when 1 then
        v_es_comprador := round(dbms_random.value(0,1),0);
    end case;

    insert into usuario
      (usuario_id, nombre, apellido_pat, apellido_mat, username, password, email, 
      fecha_registro, foto, rfc, es_vendedor, es_comprador)
    values 
        (v_usuario_id, v_nombre, v_apellido_pat, v_apellido_mat, v_username, v_password,
        v_email, sysdate, empty_blob(), v_rfc,v_es_vendedor, v_es_comprador);
    if v_es_comprador = 1 then
        insert into comprador (usuario_id, descripcion, ocupacion_id)
        values (v_usuario_id, dbms_random.string('X', 40), round(dbms_random.value(1,20),0));
        
        v_telefono_id := v_telefono_id + 1;

        insert into telefono_comprador (telefono_comprador_id, num_telefono, usuario_id)
        values (v_telefono_id, round(dbms_random.value(1000000, 999999999),0), v_usuario_id); 
    end if;
    if v_es_vendedor = 1 then
      insert into vendedor (usuario_id, tipo, direccion, calificacion)
      values (v_usuario_id, 'persona', dbms_random.string('X', 40), round(dbms_random.value(0,10),0));
    end if;
  end loop;
end;
/
prompt carga de usuarios exitosa!

--Carga de productos 
declare
  v_producto_id number;
  v_nombre varchar2(100);
  v_descripcion varchar2(300);
  v_defectos  varchar2(200);
  v_fecha_vida_util date;
  v_precio_inicial number;
  v_fecha_status date;
  v_status_producto_id number;
  v_usuario_id number;
  v_categoria_id number;
begin
  select max(producto_id) into v_producto_id
  from producto;

  for i in 1..1200 loop

    v_producto_id := v_producto_id + 1;

    select usuario_id into v_usuario_id
    from vendedor sample(5) where rownum = 1;

    v_nombre := dbms_random.string('A', 20);
    v_descripcion := dbms_random.string('X', 50);
    v_defectos := dbms_random.string('X', 50);
    v_fecha_vida_util := sysdate + dbms_random.value(100, 200);
    v_precio_inicial := dbms_random.value(1000,50000);
    v_fecha_status := sysdate + dbms_random.value(0, 1);
    v_status_producto_id := round(dbms_random.value(1,7),0);
    v_categoria_id := round(dbms_random.value(1,7),0);

    insert into producto 
      (producto_id, nombre, descripcion, defectos, fecha_vida_util, precio_inicial, fecha_status, status_producto_id,
      usuario_id, categoria_producto_id)
    values
      (v_producto_id, v_nombre, v_descripcion, v_defectos, v_fecha_vida_util, v_precio_inicial, v_fecha_status,
      v_status_producto_id, v_usuario_id, v_categoria_id);
  end loop;

end;
/
prompt carga de productos exitosa!


declare
  v_oferta_id number;
  v_fecha_oferta date;
  v_importe number;
  v_comprador_id number;
  v_producto_id number;
  v_producto_id_max number;
begin
  select max(oferta_id) into v_oferta_id
  from oferta;

  select max(producto_id) into v_producto_id_max
  from producto;

  for i in 1..1200 loop
    v_oferta_id := v_oferta_id + 1;
    v_fecha_oferta := sysdate;
    v_importe := round(dbms_random.value(1000, 50000),2);

    select usuario_id into v_comprador_id
    from comprador sample(10) where rownum = 1;

    v_producto_id := round(dbms_random.value(1, v_producto_id_max),0);

    insert into oferta
      (oferta_id, fecha_oferta, importe, es_ganadora, comprador_id, producto_id, subasta_id,
      orden_compra_id)
    values
      (v_oferta_id, v_fecha_oferta, v_importe, 0, v_comprador_id, v_producto_id, null, null);
    
  end loop;
end;
/
prompt carga de ofertas exitosa!

commit;