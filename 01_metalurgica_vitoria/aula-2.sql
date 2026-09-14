SELECT DB_NAME();

USE metalurgica_vitoria;

SELECT NAME FROM SYS.TABLES;


-- 1. Criar a tabela Fornecedores (DDL)

CREATE TABLE Fornecedores (
	id_fornecedor INT IDENTITY(2000, 1) PRIMARY KEY,
	nome_fornecedor VARCHAR(100) NOT NULL,
	cnpj VARCHAR(18) NULL,
	telefone VARCHAR(20) NULL, 
	cidade VARCHAR(50) NULL
);


-- 2. Adicionar uma nova coluna em Produtos (DDL)

ALTER TABLE dbo.Produtos ADD id_fornecedor INT NULL;


SELECT * FROM dbo.Produtos;


-- 3. Cadastrar fornecedores (DML)
-- Insira pelo menos 2 fornecedores na tabela `Fornecedores`, com nome, CNPJ, telefone e cidade à sua escolha.

INSERT INTO Fornecedores (nome_fornecedor, cnpj, telefone, cidade) VALUES
('Casa das máquinas', '56.903.168/0001-61', '6060-8423', 'São Paulo'),
('Mutantes', '72.275.905/0001-85', '9634-5789', 'Recife'),
('Made in Brazil', '02.235.664/0001-65', '5867-5305', 'Rio de Janeiro'),
('Som nosso de cada dia', '46.337.884/0001-75', '7777-9311', 'Fortaleza'),
('Terço', '00.192.981/0001-16', '8374-9015', 'São Paulo');


-- 4. Ligar produtos aos fornecedores (DML)
-- Use `UPDATE` para preencher o `IdFornecedor` de pelo menos um produto 
-- da tabela `Produtos`, apontando para um dos fornecedores que você acabou de cadastrar.

SELECT * FROM dbo.Produtos;
SELECT * FROM dbo.Fornecedores;

UPDATE dbo.Produtos SET id_fornecedor = 2000 WHERE id_produto = 1001;
UPDATE dbo.Produtos SET id_fornecedor = 2002 WHERE id_produto = 1002;
UPDATE dbo.Produtos SET id_fornecedor = 2000 WHERE id_produto = 1003;

-- 5. Consultar (DQL)
-- Escreva uma consulta que mostre apenas os fornecedores 
-- da cidade que você escolheu (`WHERE Cidade = '...'`).

SELECT nome_fornecedor, telefone, cidade
FROM dbo.Fornecedores
WHERE cidade = 'São Paulo';

-- 6. Praticar TRUNCATE com segurança

CREATE TABLE Rascunho(
  id_rascunho INT IDENTITY(1, 1),
  teste VARCHAR(50)
);

INSERT INTO Rascunho VALUES
('A'),
('B'),
('C'),
('D'),
('E');

SELECT * FROM Rascunho;

TRUNCATE TABLE Rascunho;

-- --------------------------------------------

SELECT * FROM dbo.Produtos;
SELECT * FROM dbo.Fornecedores;

ALTER TABLE dbo.Produtos ADD CONSTRAINT FK_Produtos_Fornecedor FOREIGN KEY(id_fornecedor)
REFERENCES dbo.Fornecedores(id_fornecedor);

INSERT INTO dbo.Produtos (nome_produto, categoria_produto, qtde_estoque_produto, preco_uni_produto, id_fornecedor)
VALUES ('Furadeira manual', 'Construção', 10, 2500, 2001);

-- Retornar nome_produto, preço, fornecedor e cidade.

SELECT p.nome_produto, p.preco_uni_produto, f.nome_fornecedor, f.cidade
FROM dbo.Produtos p
INNER JOIn dbo.Fornecedores f
ON p.id_fornecedor = f.id_fornecedor;

