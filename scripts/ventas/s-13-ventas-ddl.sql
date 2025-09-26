--
-- ER/Studio 8.0 SQL Code Generation
-- Company :      FIUNAM
-- Project :      E-market-ventas.DM1
-- Author :       RodrigoTN
--
-- Date Created : Monday, December 09, 2024 00:17:31
-- Target DBMS : Oracle 11g
--

-- 
-- TABLE: BANCO 
--

connect tana_ventas/ventas@tana_ventas 

CREATE TABLE BANCO(
    BANCO_ID       NUMBER(4, 0)     NOT NULL,
    CLAVE          VARCHAR2(6)      NOT NULL,
    NOMBRE         VARCHAR2(50)     NOT NULL,
    DESCRIPCION    VARCHAR2(300)    NOT NULL,
    CONSTRAINT banco_pk PRIMARY KEY (BANCO_ID)
        using index  tablespace indices_tbs
) tablespace catalogos_tbs
pctfree 0
;



-- 
-- TABLE: EMPRESA_PAQUETERIA 
--

CREATE TABLE EMPRESA_PAQUETERIA(
    EMPRESA_PAQUETERIA_ID    NUMBER(4, 0)     NOT NULL,
    CLAVE                    VARCHAR2(20)     NOT NULL,
    NOMBRE                   VARCHAR2(150)    NOT NULL,
    RFC                      VARCHAR2(13)     NOT NULL,
    EMPRESA_AUXILIAR         NUMBER(4, 0),
    CONSTRAINT empresa_paqueteria_pk PRIMARY KEY (EMPRESA_PAQUETERIA_ID)
        using index tablespace indices_tbs,
    constraint empresa_paqueteria_empresa_auxiliar_fk 
        foreign key (empresa_auxiliar) references empresa_paqueteria(empresa_paqueteria_id)
)tablespace catalogos_tbs
pctfree 0
;

-- 
-- TABLE: TARJETA 
--

CREATE TABLE TARJETA(
    TARJETA_ID          NUMBER(10, 0)    NOT NULL,
    NUM_TARJETA         VARCHAR2(30)     NOT NULL,
    FECHA_EXPIRACION    DATE             NOT NULL,
    NUM_SEGURIDAD       NUMBER(3, 0),
    USUARIO_ID          NUMBER(10, 0)    NOT NULL,
    BANCO_ID            NUMBER(4, 0)     NOT NULL,
    CONSTRAINT tarjeta_pk PRIMARY KEY (TARJETA_ID)
        using index tablespace indices_tbs,
    constraint tarjeta_banco_id_fk foreign key (banco_id) references banco(banco_id)
) tablespace tarjeta_cliente_tbs
;

create unique index tarjeta_num_tarjeta_iuk on tarjeta(num_tarjeta)
    tablespace indices_tbs;

create index tarjeta_banco_id_ix on tarjeta(banco_id)
    tablespace indices_tbs;
 
-- 
-- TABLE: ORDEN_COMPRA 
--

CREATE TABLE ORDEN_COMPRA(
    ORDEN_COMPRA_ID      NUMBER(10, 0)    NOT NULL,
    FECHA                DATE             NOT NULL,
    FOLIO                VARCHAR2(10),
    DIRECCION_ENTREGA    VARCHAR2(150)    NOT NULL,
    CONSTRAINT orden_compra_pk PRIMARY KEY (ORDEN_COMPRA_ID)
        using index tablespace indices_tbs
) tablespace ordenes_compra_tbs
;

create index orden_compra_fecha_ifx on orden_compra(to_char(fecha, 'dd/mm/yyyy'))
    tablespace indices_tbs;

-- 
-- TABLE: FACTURA 
--

CREATE TABLE FACTURA(
    FACTURA_ID               NUMBER(10, 0)    NOT NULL,
    FOLIO                    CHAR(6)          NOT NULL,
    MONTO_TOTAL              NUMBER(9, 2)     NOT NULL,
    COMISION                 NUMBER(8, 2)     NOT NULL,
    EMPRESA_PAQUETERIA_ID    NUMBER(4, 0)     NOT NULL,
    ORDEN_COMPRA_ID          NUMBER(10, 0)    NOT NULL,
    CONSTRAINT factura_pk PRIMARY KEY (FACTURA_ID)
        using index tablespace indices_tbs,
    constraint factura_empresa_paqueteria_id_fk
        foreign key (empresa_paqueteria_id) references empresa_paqueteria(empresa_paqueteria_id),
    constraint factura_orden_compra_id_fk
        foreign key (orden_compra_id) references orden_compra(orden_compra_id),
    constraint factura_folio_chk check (
        regexp_like(folio, '^([0-9]|[A-Za-z]){6}$')
    )
)
;

create unique index factura_folio_iuk on factura(folio)
    tablespace indices_tbs;

create index factura_empresa_paqueteria_id_ix on factura(empresa_paqueteria_id)
    tablespace indices_tbs;

create index factura_orden_compra_id_ix on factura(orden_compra_id)
    tablespace indices_tbs;



-- 
-- TABLE: PAGO 
--

CREATE TABLE PAGO(
    FACTURA_ID    NUMBER(10, 0)    NOT NULL,
    NUM_PAGO      NUMBER(2, 0)     NOT NULL,
    IMPORTE       NUMBER(8, 2)     NOT NULL,
    FECHA         DATE             NOT NULL,
    TARJETA_ID    NUMBER(10, 0)    NOT NULL,
    CONSTRAINT pago_pk PRIMARY KEY (FACTURA_ID, NUM_PAGO)
        using index tablespace indices_tbs,
    constraint pago_factura_id_fk 
        foreign key (factura_id) references factura(factura_id)
)
;

create index pago_tarjeta_id_ix on pago(tarjeta_id)
    tablespace indices_tbs;
-- 
-- TABLE: UBICACION_PAQUETE 
--

CREATE TABLE UBICACION_PAQUETE(
    ORDEN_COMPRA_ID    NUMBER(10, 0)    NOT NULL,
    NUM_MEDICION       NUMBER(2, 0)     NOT NULL,
    LATITUD            NUMBER(5, 2)     NOT NULL,
    LONGITUD           NUMBER(5, 2)     NOT NULL,
    CONSTRAINT ubicacion_paquete_pk PRIMARY KEY (ORDEN_COMPRA_ID, NUM_MEDICION)
        using index tablespace indices_tbs,
    constraint ubicacion_paquete_orden_compra_id_fk 
        foreign key (orden_compra_id) references orden_compra(orden_compra_id),
    constraint ubicacion_paquete_latitud_chk check(
        latitud >= -180.0 and latitud <= 180.0
    ),
    constraint ubicacion_paquete_longitud_chk check(
        longitud >= -180.0 and longitud <= 180.0
    )
) tablespace ubicaciones_tbs
;

