
-- Q1. A Dona Marta quer saber quantos clientes cadastrados moram no bairro Centro.

select * from clientes
where bairro = 'Centro'
order by nome asc;

-- Q2. Liste o nome e o preço dos produtos da categoria Hambúrguer que custam 
-- mais de R$ 30,00, do mais caro para o mais barato.

select nome_produto, preco from produtos
where categoria like '%_amb_rguer%' and preco > 30
order by preco desc;

-- Q3. Quantos pedidos foram entregues e quantos foram cancelados no trimestre? 
-- Mostre as duas contagens numa consulta só.

select status, count(*) as qtde_pedidos
from pedidos
group by status
order by status desc;

-- Q4. Considerando só os pedidos entregues: quantos foram, quantos receberam avaliação, 
-- quantos ficaram sem avaliação e qual a nota média (com casas decimais)?

SELECT
    COUNT(*) AS "Pedidos entregues",
    COUNT(avaliacao) AS "Qtde com avaliação",
    COUNT(*) - COUNT(avaliacao) AS "Qtde sem avaliação",
    CAST(AVG(avaliacao) AS NUMERIC(5, 2)) AS "Média avaliação"
FROM pedidos
WHERE status = 'Entregue';

-- Q5. A Dona Marta acha que o delivery está crescendo. Mostre, mês a mês, 
-- quantos pedidos entregues foram de Delivery e quantos de Retirada.

SELECT tipo_entrega,
CASE
    WHEN MONTH(data_pedido) = 1 THEN 'Jan'
    WHEN MONTH(data_pedido) = 2 THEN 'Fev'
    WHEN MONTH(data_pedido) = 3 THEN 'Mar'
END AS "Mês", 
COUNT(*) AS qtde
from pedidos
GROUP BY MONTH(data_pedido), tipo_entrega
ORDER BY MONTH(data_pedido) ASC;

-- Q6. Liste todos os pedidos de janeiro de 2026 com número do pedido, data, 
-- nome do cliente, bairro e status, em ordem de data.

select top(5) * from pedidos;

select p.id_pedido AS "Número pedido", 
p.data_pedido AS "Data pedido", 
p.status, c.nome AS "Cliente", c.bairro
from pedidos p
inner join clientes c
on c.id_cliente = p.id_cliente
where YEAR(p.data_pedido) = 2026 and MONTH(p.data_pedido) = 1
order by p.data_pedido asc;

-- Q7. Para escolher o entregador do trimestre, a Dona Marta quer ver quantas entregas 
-- cada entregador fez (só pedidos entregues), de quem mais entregou para quem menos entregou.

SELECT e.nome_entregador AS "Entregador", 
COUNT(p.id_pedido) AS "Qtde entrega"
FROM pedidos p
INNER JOIN entregadores e
ON e.id_entregador = p.id_entregador
WHERE p.status =  'Entregue'
GROUP BY e.nome_entregador
ORDER BY "Qtde entrega" DESC;

-- Q8. Quantas unidades de cada produto foram vendidas e quanto cada um faturou? 
-- Ordene pelas unidades. O campeão em unidades é também o campeão em faturamento?

SELECT p.nome_produto AS "Produto",
SUM(i.quantidade) AS "Qtde vendida",
p.preco AS "Preço R$",
CAST(SUM(i.quantidade) * p.preco AS NUMERIC(10, 2)) AS "Faturamento R$"
FROM produtos p
INNER JOIN itenspedido i
ON p.id_produto = i.id_produto
GROUP BY p.nome_produto, p.preco
ORDER BY "Qtde vendida" DESC;

-- Q9. Qual o faturamento de produtos por categoria, da maior para a menor?

-- Q10. Em quais bairros houve pelo menos 7 pedidos entregues? Mostre o bairro e a quantidade.

-- Agrupe pelo PrecoUnitario de ItensPedido. Depois compare com o preço que aparece em Produtos: por que são diferentes?
