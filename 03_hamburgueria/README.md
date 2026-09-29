Atividade - Agregação, filtros e JOIN - Hamburgueria
Tipo: Atividade
O que você vai praticar: WHERE, COUNT, SUM, AVG, GROUP BY, HAVING, ORDER BY e JOIN, primeiro separados e depois tudo junto, em 17 perguntas que vão do fácil ao difícil.
Antes de começar: revise o material Filtros e funções de agregação e o Banco de dados - DQL, DML e DDL.
O contexto
A Brasa & Pão é uma hamburgueria de bairro que atende por delivery e retirada no balcão. A dona, Dona Marta, registra tudo num banco de dados desde que abriu o delivery, mas nunca parou para olhar os números.
O primeiro trimestre de 2026 (janeiro a março) acabou, e ela precisa tomar quatro decisões antes de abril:
Cardápio: existe algum produto que ninguém pede e deveria sair?
Entregador do trimestre: quem merece o bônus?
Fidelidade: quem são os melhores clientes para ganhar um cartão fidelidade?
Bairros: onde o negócio vai bem e onde quase não vende?
Você acabou de ser contratado(a) como estagiário(a) de dados da Brasa & Pão. Sua missão é responder às perguntas da Dona Marta usando SQL e, no final, recomendar o que ela deve fazer.
O banco de dados
São 5 tabelas. Pedidos é o centro de tudo: cada pedido pertence a um cliente, pode ter um entregador e tem vários itens.
erDiagram
    CLIENTES ||--o{ PEDIDOS : faz
    ENTREGADORES |o--o{ PEDIDOS : entrega
    PEDIDOS ||--|{ ITENSPEDIDO : contem
    PRODUTOS ||--o{ ITENSPEDIDO : aparece_em

    CLIENTES {
        int IdCliente PK
        varchar Nome
        varchar Bairro
        varchar Telefone
        date DataCadastro
    }
    ENTREGADORES {
        int IdEntregador PK
        varchar Nome
        varchar Veiculo
        date DataContratacao
    }
    PRODUTOS {
        int IdProduto PK
        varchar NomeProduto
        varchar Categoria
        decimal Preco
    }
    PEDIDOS {
        int IdPedido PK
        int IdCliente FK
        int IdEntregador FK "NULL se retirada"
        date DataPedido
        varchar TipoEntrega
        varchar Status
        decimal TaxaEntrega
        tinyint Avaliacao "NULL se nao avaliou"
    }
    ITENSPEDIDO {
        int IdPedido PK, FK
        int IdProduto PK, FK
        int Quantidade
        decimal PrecoUnitario
    }
CLIENTES

int

IdCliente

PK

varchar

Nome

varchar

Bairro

varchar

Telefone

date

DataCadastro

PEDIDOS

int

IdPedido

PK

int

IdCliente

FK

int

IdEntregador

FK

NULL se retirada

date

DataPedido

varchar

TipoEntrega

varchar

Status

decimal

TaxaEntrega

tinyint

Avaliacao

NULL se nao avaliou

ENTREGADORES

int

IdEntregador

PK

varchar

Nome

varchar

Veiculo

date

DataContratacao

ITENSPEDIDO

int

IdPedido

PK,FK

int

IdProduto

PK,FK

int

Quantidade

decimal

PrecoUnitario

PRODUTOS

int

IdProduto

PK

varchar

NomeProduto

varchar

Categoria

decimal

Preco

faz

entrega

contem

aparece_em

​
Tabela
Linhas
O que guarda
Detalhe importante
Clientes
16
Quem compra: nome, bairro, telefone
Alguns não informaram telefone (NULL)
Entregadores
5
Quem faz as entregas
Um deles foi contratado no fim de março
Produtos
14
O cardápio
Preco é o preço atual
Pedidos
40
Cada pedido feito no trimestre
Retirada no balcão tem IdEntregador NULL e taxa 0,00
ItensPedido
91
O que foi comprado em cada pedido
PrecoUnitario é o preço cobrado no dia da venda
Regras de negócio: valem para todas as perguntas
Faturamento de produtos = Quantidade * PrecoUnitario, da tabela ItensPedido.
Pedido cancelado não é venda. Só conte pedidos com Status = 'Entregue', a não ser que a pergunta diga outra coisa.
A taxa de entrega não entra no faturamento de produtos (ela é do entregador).
Como começar
Abra o SSMS e conecte no seu servidor.
Abra o script abaixo numa nova consulta e execute tudo (F5). Ele cria o banco HamburgueriaBrasa, as 5 tabelas e os dados.
Confira o resultado da última consulta do script: Clientes 16, Entregadores 5, Produtos 14, Pedidos 40, ItensPedido 91.
Se bagunçar os dados, é só rodar o script de novo: ele apaga e recria tudo.
 Script do banco hamburgueria_brasa.sql (clique para abrir e copiar)
Revisão rápida: JOIN
Até agora cada consulta usava uma tabela só. Mas o nome do cliente está em Clientes, e o pedido está em Pedidos. O JOIN junta as duas usando a coluna que elas têm em comum (a chave estrangeira).
-- Cada pedido com o nome do cliente que fez
SELECT p.IdPedido, p.DataPedido, c.Nome
FROM Pedidos p                                   -- "p" é um apelido para Pedidos
INNER JOIN Clientes c ON c.IdCliente = p.IdCliente;  -- a ponte entre as tabelas
​
INNER JOIN traz só as linhas que têm par nas duas tabelas. Um pedido de retirada (sem entregador) some num INNER JOIN com Entregadores.
LEFT JOIN traz todas as linhas da tabela da esquerda, mesmo sem par. Onde não há par, as colunas da direita vêm NULL. Ótimo para achar "quem nunca...".
Dá para encadear quantos JOIN precisar. Depois de juntar, WHERE, GROUP BY, HAVING e ORDER BY funcionam exatamente como você já aprendeu:
-- Pedidos -> ItensPedido -> Produtos
SELECT p.IdPedido, pr.NomeProduto, i.Quantidade
FROM Pedidos p
INNER JOIN ItensPedido i  ON i.IdPedido  = p.IdPedido
INNER JOIN Produtos    pr ON pr.IdProduto = i.IdProduto
WHERE p.IdPedido = 1;
​
As perguntas da Dona Marta
Resolva em ordem: cada nível usa o que você praticou no anterior. Abra a  dica só se travar. O  diz quantas linhas o resultado correto tem, para você conferir sozinho(a).
 Nível 1 — Aquecimento (uma tabela)
Q1. A Dona Marta quer saber quantos clientes cadastrados moram no bairro Centro.
 Dica
Q2. Liste o nome e o preço dos produtos da categoria Hambúrguer que custam mais de R$ 30,00, do mais caro para o mais barato.
 Dica
Q3. Quantos pedidos foram entregues e quantos foram cancelados no trimestre? Mostre as duas contagens numa consulta só.
 Dica
Q4. Considerando só os pedidos entregues: quantos foram, quantos receberam avaliação, quantos ficaram sem avaliação e qual a nota média (com casas decimais)?
 Dica
Q5. A Dona Marta acha que o delivery está crescendo. Mostre, mês a mês, quantos pedidos entregues foram de Delivery e quantos de Retirada.
 Dica
 Nível 2 — Cruzando tabelas (JOIN)
Q6. Liste todos os pedidos de janeiro de 2026 com número do pedido, data, nome do cliente, bairro e status, em ordem de data.
 Dica
Q7. Para escolher o entregador do trimestre, a Dona Marta quer ver quantas entregas cada entregador fez (só pedidos entregues), de quem mais entregou para quem menos entregou.
 Dica
Q8. Quantas unidades de cada produto foram vendidas e quanto cada um faturou? Ordene pelas unidades. O campeão em unidades é também o campeão em faturamento?
 Dica
Q9. Qual o faturamento de produtos por categoria, da maior para a menor?
 Dica
Q10. Em quais bairros houve pelo menos 7 pedidos entregues? Mostre o bairro e a quantidade.
 Dica
Q11. O X-Bacon teve reajuste de preço durante o trimestre. Por quais preços ele foi vendido, quantas unidades saíram a cada preço e quanto isso faturou?
 Dica
 Nível 3 — Desafio (tudo junto)
Cuidado neste nível: quando você junta Pedidos com ItensPedido, cada pedido vira várias linhas (uma por item). Isso muda o resultado de COUNT(*) e de SUM em colunas de Pedidos. Pense nisso antes de escrever cada consulta.
Q12. A Dona Marta vai criar um programa de fidelidade para os 3 clientes que mais gastaram em produtos. Mostre o nome, quantos pedidos cada um fez e o total gasto.
 Dica
Q13. O faturamento de produtos cresceu ou caiu ao longo do trimestre? Mostre, para cada mês, a quantidade de pedidos entregues e o faturamento de produtos.
 Dica
Q14. O entregador do trimestre precisa ter feito pelo menos 4 entregas e ter nota média de pelo menos 4. Quem se qualifica? Mostre as entregas e a nota média (com decimais).
 Dica
Q15. Mostre o valor total de cada pedido entregue em março (produtos + taxa de entrega), com o nome do cliente, do maior para o menor.
 Dica
Q16. Há clientes que se cadastraram e nunca fizeram nenhum pedido. Quem são e em que bairro moram? O que isso sugere para a Dona Marta?
 Dica
Q17. Existe algum produto do cardápio que nunca apareceu em nenhum pedido, nem cancelado? Ele é candidato a sair do cardápio.
 Dica
 Missão final: o relatório para a Dona Marta
Com base nas suas respostas, escreva de 5 a 10 linhas recomendando o que a Dona Marta deve fazer em cada uma das quatro decisões (cardápio, entregador do trimestre, fidelidade e bairros). Cite os números que você encontrou para justificar.
Para pensar: o cliente que mais fez pedidos é o mesmo que mais gastou? O produto que mais vendeu é o que mais faturou? Por que um bairro inteiro quase não compra da hamburgueria?
 O que entregar
Um arquivo .sql com as 17 consultas, cada uma precedida de um comentário com o número da questão (ex.: -- Q1).
O texto da Missão final, como comentário no fim do mesmo arquivo ou num documento à parte.
Checklist antes de entregar: todas as consultas rodam sem erro? Os resultados batem com o número de linhas do ? Os pedidos cancelados ficaram de fora quando deviam?
