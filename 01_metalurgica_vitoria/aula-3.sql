INSERT INTO dbo.Fornecedores (nome_fornecedor, cnpj, telefone, cidade)
VALUES
('Iron Maiden', '02.053.726/0001-18', '1234-5678', 'Belém'),
('Led Zeppelin', '89.181.585/0001-05', '7777-7777', 'Porto Alegre'),
('Pink Floyd', '70.407.737/0001-09', '99999-99999-', 'São Paulo'),
('Deep Purple', '01.261.363/0001-43', '3333-3333', 'Recife'),
('Beatles', '86.030.518/0001-93', '7878-7878', 'Salvador');

INSERT INTO dbo.Produtos (nome_produto, categoria_produto, qtde_estoque_produto, preco_uni_produto, id_fornecedor)
VALUES
('Leite', 'Alimentos', 100, 5.5, 2006),
('Sabão em pó', 'Limpeza', 150, 3.99, 2005),
('Detergente', 'Limpeza', 200, 12.5, 2005),
('Sal', 'Alimentos', 20, 8.5, 2006),
('Açucar', 'Alimentos', 200, 5.5, 2006);

SELECT * FROM dbo.Fornecedores;

SELECT * FROM dbo.Produtos;


-- Funções de agregação
-- Filtros e funções de agregação: where, count, sum, avg, max, min, etc.

-- Qtde de produtos cadastrados
select count(*) as qtde_produtos from dbo.Produtos;

-- Qtde total de produtos no estoque
SELECT SUM(qtde_estoque_produto) AS qtde_total_estoque FROM dbo.Produtos;

-- Produto cadastrado com nome que inicia com menor letra
SELECT MIN(nome_produto) FROM dbo.Produtos;


-- Produto mais barato e mais caro
SELECT MIN(preco_uni_produto) AS "Menor preço R$", MAX(preco_uni_produto) As "Maior preço R$"
FROM dbo.Produtos;

-- Produto mais barato e mais caro indicando o nome
-- Usando Union e subqueries
SELECT nome_produto, preco_uni_produto AS "Menor preço R$"
FROM dbo.Produtos
WHERE preco_uni_produto = (SELECT MIN(preco_uni_produto) FROM dbo.Produtos)

UNION ALL

SELECT nome_produto, preco_uni_produto AS "Maior preço R$"
FROM dbo.Produtos
WHERE preco_uni_produto = (SELECT MAX(preco_uni_produto) FROM dbo.Produtos);


-- Soma do estoque total por categoria
SELECT categoria_produto, SUM(preco_uni_produto) AS "Preço total p/ categoria"
FROM dbo.Produtos
GROUP BY categoria_produto
ORDER BY "Preço total p/ categoria" ASC;

-- Qtde de fornecedores cadastrados apenas em São Paulo / em uma região específica
SELECT COUNT(*) AS qtde_fornecedores_sp FROM Fornecedores
WHERE cidade =  'São Paulo';


-- --------------------
-- Aula 17/09/2026
-- --------------------

-- Agrupamento

-- Exibir a qtde de produtos (COUNT) e estoque total (sum) por categoria (GROUP BY)

SELECT Produtos.categoria_produto, 
COUNT(*) AS qtde_produtos, 
SUM(Produtos.qtde_estoque_produto) AS "soma estoque total"
FROM Produtos
GROUP BY Produtos.categoria_produto
ORDER BY qtde_produtos DESC;

-- Quantidade de fornecedores por cidade

SELECT Fornecedores.cidade, COUNT(*) AS qtde_fornecedores
FROM Fornecedores
GROUP BY Fornecedores.cidade
ORDER BY qtde_fornecedores DESC;

select * from Fornecedores;