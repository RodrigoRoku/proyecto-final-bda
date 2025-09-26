--
-- ER/Studio 8.0 SQL Code Generation
-- Company :      FIUNAM
-- Project :      E-market-subastas.DM1
-- Author :       RodrigoTN
--
-- Date Created : Monday, December 09, 2024 05:44:55
-- Target DBMS : Oracle 11g
--

-- 
-- TABLE: OCUPACION 
--

connect tana_subastas/subastas@tana_subastas 

CREATE TABLE OCUPACION(
    OCUPACION_ID    NUMBER(5, 0)     NOT NULL,
    CLAVE           VARCHAR2(50)     NOT NULL,
    DESCRIPCION     VARCHAR2(200),
    CONSTRAINT ocupacion_pk PRIMARY KEY (OCUPACION_ID)
        using index tablespace indices_tbs
) tablespace catalogos_tbs
  pctfree 0
;


-- 
-- TABLE: STATUS_PRODUCTO 
--

CREATE TABLE STATUS_PRODUCTO(
    STATUS_PRODUCTO_ID    NUMBER(2, 0)     NOT NULL,
    CLAVE                 VARCHAR2(20)     NOT NULL,
    DESCRIPCION           VARCHAR2(200)    NOT NULL,
    ACTIVO                NUMBER(1, 0)     NOT NULL,
    CONSTRAINT status_producto_pk PRIMARY KEY (STATUS_PRODUCTO_ID)
        using index tablespace indices_tbs
) tablespace catalogos_tbs
  pctfree 0
;


-- 
-- TABLE: CATEGORIA_PRODUCTO 
--

CREATE TABLE CATEGORIA_PRODUCTO(
    CATEGORIA_PRODUCTO_ID    NUMBER(4, 0)     NOT NULL,
    CLAVE                    VARCHAR2(20)     NOT NULL,
    DESCRIPCION              VARCHAR2(200)    NOT NULL,
    CONSTRAINT categoria_producto_pk PRIMARY KEY (CATEGORIA_PRODUCTO_ID)
        using index tablespace indices_tbs
) tablespace catalogos_tbs
  pctfree 0
;


-- 
-- TABLE: USUARIO 
--

CREATE TABLE USUARIO(
    USUARIO_ID        NUMBER(10, 0)    NOT NULL,
    NOMBRE            VARCHAR2(100)    NOT NULL,
    APELLIDO_PAT      VARCHAR2(100)    NOT NULL,
    APELLIDO_MAT      VARCHAR2(100),
    USERNAME          VARCHAR2(50)     NOT NULL,
    PASSWORD          VARCHAR2(30)     NOT NULL,
    EMAIL             VARCHAR2(100)    NOT NULL,
    FECHA_REGISTRO    DATE             NOT NULL,
    FOTO              BLOB             NOT NULL,
    RFC               VARCHAR2(13)     NOT NULL,
    ES_VENDEDOR       NUMBER(1, 0)     NOT NULL,
    ES_COMPRADOR      NUMBER(1, 0)     NOT NULL,
    CONSTRAINT usuario_pk PRIMARY KEY (USUARIO_ID)
        using index tablespace indices_tbs,
    constraint usuario_es_vendedor_es_comprador_chk check (
        (es_vendedor = 0 and es_comprador = 1) or
        (es_vendedor = 1 and es_comprador = 0) or
        (es_vendedor = 1 and es_comprador = 1)
    )
) LOB(foto) store as securefile usuario_foto(
    tablespace fotos_usuario_tbs
)
;

create unique index usuario_username_iuk on usuario(username)
    tablespace indices_tbs;

create unique index usuario_email_iuk on usuario(email)
    tablespace indices_tbs;

create unique index usuario_rfc_iuk on usuario(rfc)
    tablespace indices_tbs;


-- 
-- TABLE: COMPRADOR 
--

CREATE TABLE COMPRADOR(
    USUARIO_ID      NUMBER(10, 0)    NOT NULL,
    DESCRIPCION     VARCHAR2(500)    NOT NULL,
    OCUPACION_ID    NUMBER(5, 0)     NOT NULL,
    CONSTRAINT comprador_pk PRIMARY KEY (USUARIO_ID)
        using index tablespace indices_tbs,
    constraint comprador_usuario_id_fk 
        foreign key (usuario_id) references usuario(usuario_id)
)
;

create index comprador_ocupacion_id_ix on comprador(ocupacion_id)
    tablespace indices_tbs;


-- 
-- TABLE: TELEFONO_COMPRADOR 
--

CREATE TABLE TELEFONO_COMPRADOR(
    TELEFONO_COMPRADOR_ID    NUMBER(10, 0)    NOT NULL,
    NUM_TELEFONO             VARCHAR2(15)     NOT NULL,
    USUARIO_ID               NUMBER(10, 0)    NOT NULL,
    CONSTRAINT telefono_comprador_pk PRIMARY KEY (TELEFONO_COMPRADOR_ID)
        using index tablespace indices_tbs,
    constraint telefono_comprador_usuario_id_fk
        foreign key (usuario_id) references comprador(usuario_id),
    constraint telefono_num_telefono_chk check (
        regexp_like(num_telefono, '^[0-9]+$')
    )
)
;

create unique index telefono_comprador_num_telefono_iuk on telefono_comprador(NUM_TELEFONO)
    tablespace indices_tbs;

create index telefono_comprador_usuario_id_ix  on telefono_comprador(usuario_id)
    tablespace indices_tbs;

-- 
-- TABLE: VENDEDOR 
--

CREATE TABLE VENDEDOR(
    USUARIO_ID      NUMBER(10, 0)    NOT NULL,
    TIPO            VARCHAR2(15)    NOT NULL,
    DIRECCION       VARCHAR2(150)    NOT NULL,
    CALIFICACION    NUMBER(2, 0)     NOT NULL,
    CONSTRAINT vendedor_pk PRIMARY KEY (USUARIO_ID)
        using index tablespace indices_tbs,
    constraint vendedor_usuario_id_fk
        foreign key (usuario_id) references usuario(usuario_id)
)
;


-- 
-- TABLE: CALIFICACION_COMPRADOR 
--

CREATE TABLE CALIFICACION_COMPRADOR(
    CALIFICACION_ID    NUMBER(10, 0)    NOT NULL,
    CALIFICACION       NUMBER(2, 0),
    COMENTARIOS        VARCHAR2(400)    NOT NULL,
    COMPRADOR_ID       NUMBER(10, 0)    NOT NULL,
    VENDEDOR_ID        NUMBER(10, 0)    NOT NULL,
    CONSTRAINT calificacion_comprador_pk PRIMARY KEY (CALIFICACION_ID)
        using index tablespace indices_tbs,
    constraint calificacion_comprador_comprador_id_fk
        foreign key (comprador_id) references comprador(usuario_id),
    constraint calificacion_comprador_vendedor_id_fk
        foreign key (vendedor_id) references vendedor(usuario_id)
) tablespace calificaciones_tbs
;

create index calificacion_comprador_comprador_id_ix on calificacion_comprador(comprador_id)
    tablespace indices_tbs;

create index calificacion_comprador_vendedor_id_ix on calificacion_comprador(vendedor_id)
    tablespace indices_tbs;



-- 
-- TABLE: PRODUCTO 
--

CREATE TABLE PRODUCTO(
    PRODUCTO_ID              NUMBER(10, 0)    NOT NULL,
    NOMBRE                   VARCHAR2(100)    NOT NULL,
    DESCRIPCION              VARCHAR2(500)    NOT NULL,
    DEFECTOS                 VARCHAR2(300),
    FECHA_VIDA_UTIL          DATE             NOT NULL,
    PRECIO_INICIAL           NUMBER(8, 2)     NOT NULL,
    FECHA_STATUS             DATE             NOT NULL,
    STATUS_PRODUCTO_ID       NUMBER(2, 0)     NOT NULL,
    USUARIO_ID               NUMBER(10, 0)    NOT NULL,
    CATEGORIA_PRODUCTO_ID    NUMBER(4, 0)     NOT NULL,
    CONSTRAINT producto_pk PRIMARY KEY (PRODUCTO_ID)
        using index tablespace indices_tbs,
    constraint producto_status_producto_id_fk 
        foreign key (status_producto_id) references status_producto(status_producto_id),
    constraint producto_usuario_id_fk
        foreign key (usuario_id) references vendedor(usuario_id),
    constraint producto_categoria_producto_id_fk
        foreign key (categoria_producto_id) references categoria_producto(categoria_producto_id)
) tablespace productos_tbs
;

create index producto_usuario_id_ix on producto(usuario_id)
    tablespace indices_tbs;

create index producto_categoria_producto_id_ix on producto(categoria_producto_id)
    tablespace indices_tbs;

create index producto_status_producto_id_ix on producto(status_producto_id)
    tablespace indices_tbs;

-- 
-- TABLE: HISTORICO_STATUS_PRODUCTO 
--

CREATE TABLE HISTORICO_STATUS_PRODUCTO(
    HISTORICO_STATUS_PRODUCTO_ID    NUMBER(10, 0)    NOT NULL,
    FECHA_STATUS                    DATE             NOT NULL,
    STATUS_PRODUCTO_ID              NUMBER(2, 0)     NOT NULL,
    PRODUCTO_ID                     NUMBER(10, 0)    NOT NULL,
    CONSTRAINT historico_status_producto_pk PRIMARY KEY (HISTORICO_STATUS_PRODUCTO_ID)
        using index tablespace indices_tbs,
    constraint historico_status_producto_status_producto_id_fk
        foreign key (status_producto_id) references status_producto(status_producto_id)
) tablespace historico_producto_tbs
;

-- 
-- TABLE: MUTIMEDIA 
--

CREATE TABLE MULTIMEDIA(
    PRODUCTO_ID    NUMBER(10, 0)    NOT NULL,
    NUM            NUMBER(3, 0)     NOT NULL,
    TIPO           VARCHAR2(10)     NOT NULL,
    ARCHIVO        BLOB             NOT NULL,
    CONSTRAINT multimedia_pk PRIMARY KEY (PRODUCTO_ID, NUM)
        using index tablespace indices_tbs,
    constraint multimedia_producto_id_fk 
        foreign key (producto_id) references producto(producto_id),
    constraint multimedia_tipo_chk check (
        (tipo = 'VIDEO' or tipo = 'FOTO' )
    )
) tablespace productos_tbs 
LOB (archivo) store as securefile multimedia_archivo(
    tablespace fotos_producto_tbs
)
;


-- 
-- TABLE: SUBASTA 
--

CREATE TABLE SUBASTA(
    SUBASTA_ID               NUMBER(10, 0)    NOT NULL,
    FECHA_SUBASTA            DATE             NOT NULL,
    TOTAL_PRODUCTOS          NUMBER(5, 0),
    FECHA_CIERRE             DATE,
    CATEGORIA_PRODUCTO_ID    NUMBER(4, 0)     NOT NULL,
    CONSTRAINT subasta_pk PRIMARY KEY (SUBASTA_ID) using index
        tablespace indices_tbs,
    constraint subasta_categoria_producto_id_fk
        foreign key (categoria_producto_id) references categoria_producto(categoria_producto_id)
) tablespace subastas_tbs
;

-- 
-- TABLE: OFERTA 
--

CREATE TABLE OFERTA(
    OFERTA_ID          NUMBER(10, 0)    NOT NULL,
    FECHA_OFERTA       DATE             NOT NULL,
    IMPORTE            NUMBER(8, 2)     NOT NULL,
    ES_GANADORA        NUMBER(1, 0)     NOT NULL,
    ORDEN_COMPRA_ID    NUMBER(10, 0),
    COMPRADOR_ID       NUMBER(10, 0)    NOT NULL,
    PRODUCTO_ID        NUMBER(10, 0)    NOT NULL,
    SUBASTA_ID         NUMBER(10, 0),
    CONSTRAINT oferta_pk PRIMARY KEY (OFERTA_ID)
        using index tablespace indices_tbs,
    constraint oferta_comprador_id_fk
        foreign key (comprador_id) references comprador(usuario_id),
    constraint oferta_producto_id_fk
        foreign key (producto_id) references producto(producto_id),
    constraint oferta_subasta_id_fk
        foreign key (subasta_id) references subasta(subasta_id)
) tablespace subastas_tbs
;

create index oferta_comprador_id_ix on oferta(comprador_id)
    tablespace indices_tbs;

create index oferta_producto_id_ix on oferta(producto_id)
    tablespace indices_tbs;



