
-- DDL -> DATA DEFINITION LANGUAGE
CREATE DATABASE MetalurgicaVitoria;

SELECT NAME FROM sys.databases;

USE MetalurgicaVitoria;

SELECT db_name();

CREATE TABLE Produtos (
	id_produto INT IDENTITY(1001, 1) PRIMARY KEY,
	nome_produto VARCHAR(100) NOT NULL,
	categoria_produto VARCHAR(100),
	qtde_estoque_produto INT NOT NULL,
	preco_uni_produto DECIMAL(10, 2),
	data_cadastro_produto DATETIME2 DEFAULT GETDATE()
);

SELECT NAME FROM SYS.TABLES;

-- DDL -> DATA MANIPULATION LANGUAGE
INSERT INTO Produtos (nome_produto, categoria_produto, qtde_estoque_produto, preco_uni_produto)
VALUES 
('Parafuso M8', 'Fixação', 5000, 0.75),
('Chapa de aço', 'Chapas', 120, 89.99),
('Engrenagem 40 dntes', 'Componentes', 300, 27.15);


-- DQL -> DATA QUERY LANGUAGE
SELECT TOP(2) * FROM dbo.Produtos;

-- INICIANDO UMA TRANSAÇÃO SQL
BEGIN TRANSACTION;

-- DML -> DATA MNIPULATION LANGUAGE
UPDATE dbo.Produtos SET qtde_estoque_produto = 200;

SELECT * FROM dbo.Produtos;

ROLLBACK TRANSACTION;

UPDATE dbo.Produtos SET qtde_estoque_produto = 200 WHERE id_produto = 1002;


BEGIN TRANSACTION;

DELETE FROM dbo.Produtos;

SELECT * FROM dbo.Produtos;

ROLLBACK TRANSACTION;

DELETE FROM dbo.Produtos WHERE id_produto = 1002;

SELECT * FROM dbo.Produtos;

