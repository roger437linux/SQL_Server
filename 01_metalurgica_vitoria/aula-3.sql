insert into dbo.Fornecedores (nome_fornecedor, cnpj, telefone, cidade)
values
('Iron Maiden', '02.053.726/0001-18', '1234-5678', 'Belém'),
('Led Zeppelin', '89.181.585/0001-05', '7777-7777', 'Porto Alegre'),
('Pink Floyd', '70.407.737/0001-09', '99999-99999-', 'São Paulo'),
('Deep Purple', '01.261.363/0001-43', '3333-3333', 'Recife'),
('Beatles', '86.030.518/0001-93', '7878-7878', 'Salvador');

insert into dbo.Produtos (nome_produto, categoria_produto, qtde_estoque_produto, preco_uni_produto, id_fornecedor)
values
('Leite', 'Alimentos', 100, 5.5, 2006),
('Sabão em pó', 'Limpeza', 150, 3.99, 2005),
('Detergente', 'Limpeza', 200, 12.5, 2005),
('Sal', 'Alimentos', 20, 8.5, 2006),
('Açucar', 'Alimentos', 200, 5.5, 2006);

select * from dbo.Fornecedores;

select * from dbo.Produtos;


-- Funções de agregação
-- Filtros e funções de agregação: where, count, sum, avg, max, min, etc.

select count(*) as qtde_produtos from dbo.Produtos;

select sum(qtde_estoque_produto) as qtde_total_estoque from dbo.Produtos;

select min(nome_produto) from dbo.Produtos;


-- Produto mais barato e mais caro
select min(preco_uni_produto) as "Menor preço R$", max(preco_uni_produto) as "Maior preço R$"
from dbo.Produtos;

-- Soma do estoque total por categoria
select categoria_produto, sum(preco_uni_produto) as "Preço total p/ categoria"
from dbo.Produtos
group by categoria_produto
order by "Preço total p/ categoria" asc;

-- Qtde de fornecedores cadastrados apenas em São Paulo / em uma região específica
select count(*) as qtde_fornecedores_sp from Fornecedores
where cidade =  'São Paulo';

select * from dbo.Fornecedores;












