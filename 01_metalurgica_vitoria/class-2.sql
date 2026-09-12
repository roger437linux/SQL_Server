SELECT DB_NAME();

USE MetalurgicaVitoria;

SELECT NAME FROM SYS.TABLES;


-- 1. Criar a tabela Fornecedores (DDL)

CREATE TABLE Fornecedores (
	IdFornecedor INT IDENTITY(2000, 1) PRIMARY KEY,
	NomeFornecedor VARCHAR(100) NOT NULL,
	CNPJ VARCHAR(18) NULL,
	Telefone VARCHAR(20) NULL, 
	Cidade VARCHAR(50) NULL
);


-- 2. Adicionar uma nova coluna em Produtos (DDL)

ALTER TABLE dbo.Produtos ADD IdFornecedor INT 
CONSTRAINT FK_Produtos_Fornecedores FOREIGN KEY
REFERENCES dbo.Produtos(id_produto);

SELECT * FROM DBO.PRODUTOS;
