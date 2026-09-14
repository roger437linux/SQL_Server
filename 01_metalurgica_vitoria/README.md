# Atividade - Metalúrgica Vitória (tabela Fornecedores)

**Tipo:** Atividade

## Continuando na Metalúrgica Vitória

Você já criou o banco `MetalurgicaVitoria` e a tabela `Produtos` na atividade anterior. A fábrica gostou tanto do resultado que pediu o próximo passo: agora também querem controlar quem são os **fornecedores** que abastecem a produção com matéria-prima.

Nesta atividade você vai criar essa nova tabela sozinho(a) — com a ajuda de uma revisão rápida logo abaixo. Não se preocupe em errar o comando de primeira: escrever, executar, ver o erro e corrigir faz parte do processo (e é assim no trabalho real também).

## Objetivo da atividade

Praticar os três grupos de comandos SQL que você vai usar o tempo todo:

- **DDL** (Data Definition Language) — define a estrutura: `CREATE`, `ALTER`, `DROP`, `TRUNCATE`.
- **DML** (Data Manipulation Language) — mexe nos dados: `INSERT`, `UPDATE`, `DELETE`.
- **DQL** (Data Query Language) — consulta os dados: `SELECT`.

## Revisão rápida

**DDL — Data Definition Language** (define tabelas e estruturas)

- `CREATE` → cria tabelas, bancos de dados, índices etc.
- `ALTER` → modifica uma tabela ou estrutura já existente (ex.: adicionar uma coluna nova).
- `DROP` → exclui uma tabela ou outro objeto do banco por completo (estrutura e dados juntos).
- `TRUNCATE` → apaga todos os registros de uma tabela de uma vez, mas mantém a estrutura da tabela intacta.

**DML — Data Manipulation Language** (mexe nos dados que já existem)

- `INSERT` → insere novos registros na tabela.
- `UPDATE` → modifica registros existentes.
- `DELETE` → remove registros específicos de uma tabela (linha por linha, conforme o `WHERE`).

**DQL — Data Query Language** (só consulta, não altera nada)

- `SELECT` → busca e filtra dados dentro do banco.

> `DELETE` x `TRUNCATE` x `DROP`, qual a diferença? `DELETE` remove linhas específicas (e pode ter `WHERE`); `TRUNCATE` esvazia a tabela inteira de uma vez (sem `WHERE`), mas a tabela continua existindo; `DROP` apaga a tabela inteira, estrutura e tudo — ela deixa de existir no banco.

## Mão na massa

Abra uma **New Query** conectada ao banco `MetalurgicaVitoria` e resolva os passos abaixo. Tente escrever os comandos você mesmo(a) antes de olhar o gabarito no final da página.

**1. Criar a tabela `Fornecedores` (DDL)**

Crie uma tabela chamada `Fornecedores` com estas colunas:

- `IdFornecedor` — identificador único, gerado automaticamente pelo banco (igual fizemos em `Produtos`).
- `NomeFornecedor` — texto, até 100 caracteres, obrigatório.
- `CNPJ` — texto, até 18 caracteres.
- `Telefone` — texto, até 20 caracteres.
- `Cidade` — texto, até 50 caracteres.

**2. Adicionar uma nova coluna em `Produtos` (DDL)**

A fábrica quer saber de qual fornecedor veio cada produto. Use `ALTER TABLE` para adicionar a coluna `IdFornecedor` (tipo `INT`) na tabela `Produtos` que você já criou.

**3. Cadastrar fornecedores (DML)**

Insira pelo menos 2 fornecedores na tabela `Fornecedores`, com nome, CNPJ, telefone e cidade à sua escolha.

**4. Ligar produtos aos fornecedores (DML)**

Use `UPDATE` para preencher o `IdFornecedor` de pelo menos um produto da tabela `Produtos`, apontando para um dos fornecedores que você acabou de cadastrar.

**5. Consultar (DQL)**

Escreva uma consulta que mostre apenas os fornecedores da cidade que você escolheu (`WHERE Cidade = '...'`).

**6. Praticar `TRUNCATE` com segurança**

Crie uma tabela de teste chamada `Rascunho` (pode ter só uma coluna, `Teste VARCHAR(50)`), insira 2 ou 3 linhas quaisquer nela e depois execute um `TRUNCATE TABLE Rascunho`. Confira com `SELECT * FROM Rascunho` que a tabela ficou vazia — mas ainda existe (tente inserir algo nela de novo). Isso evita fazer esse teste sem querer nas tabelas de verdade.
