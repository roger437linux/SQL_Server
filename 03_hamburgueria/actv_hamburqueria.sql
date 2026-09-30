-- 1. Preparando banco e usuário

select suser_sname();
-- sa --

CREATE DATABASE hamburgueria;

CREATE LOGIN dev WITH PASSWORD = 'ABC123xyz';

USE hamburgueria;

CREATE USER dev FOR LOGIN dev;

ALTER ROLE db_owner ADD MEMBER dev;

-- -------------------------------

-- 2. Login with dev

USE hamburgueria;

SELECT DB_NAME();


-- ------------- Criar as tabelas -------------


CREATE TABLE clientes (
    id_cliente INT IDENTITY(10001, 1) PRIMARY KEY,
    nome varchar(100) NOT NULL,
    bairro varchar(100) NOT NULL,
    fone varchar(10) NULL,
    data_cadastro DATE NOT NULL DEFAULT(GETDATE())
);


create table produtos (
    id_produto INT IDENTITY(1001, 1) PRIMARY KEY,
    nome_produto VARCHAR(100) NOT NULL,
    categoria VARCHAR(200) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL CHECK (preco > 0)
);


CREATE TABLE entregadores (
    id_entregador INT IDENTITY(101, 1) PRIMARY KEY,
    nome_entregador VARCHAR(100) NOT NULL,
    veiculo VARCHAR(100) NOT NULL,
    data_contratacao DATE NOT NULL DEFAULT (GETDATE())
);

CREATE TABLE pedidos (
    id_pedido INT IDENTITY(1, 1) PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_entregador INT NULL,
    data_pedido DATE NOT NULL DEFAULT (GETDATE()),
    tipo_entrega VARCHAR(10) NOT NULL 
        CONSTRAINT CK_Pedidos_tipo_entrega  CHECK (tipo_entrega IN ('delivery', 'balcao')),
    estado  VARCHAR(10) NOT NULL
        CONSTRAINT CK_Pedidos_estado        CHECK (estado IN ('entregue', 'cancelado')),
    taxa_entrega DECIMAL(10, 2) NOT NULL DEFAULT(0),        
    avaliacao TINYINT NULL,
        CONSTRAINT CK_Pedidos_Taxa_Balcao CHECK ( (tipo_entrega = 'balcao' AND taxa_entrega = 0) OR  (tipo_entrega = 'delivery') ),
        CONSTRAINT FK_Pedidos_Cliente       FOREIGN KEY (id_cliente)    REFERENCES clientes (id_cliente),
        CONSTRAINT FK_Pedidos_Entregador    FOREIGN KEY (id_entregador) REFERENCES entregadores (id_entregador)
);

