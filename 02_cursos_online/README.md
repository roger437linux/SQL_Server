# ✅ Atividade de avaliação

**Tipo:** Atividade

**Data:** Data de entrega:  

**Situação Desafio: Sistema de Gerenciamento de Cursos**

Você foi contratado para criar um banco de dados para uma escola de cursos online.

**Tabela de Cursos:**

- ID_Curso (chave primária)
- Nome_Curso
- Descrição
- ID_Instrutor (chave estrangeira referenciando a tabela de instrutores)

**Tabela de Instrutores:**

- ID_Instrutor (chave primária)
- Nome
- Especialidade (área de atuação)

**Tabela de Matrículas:**

- ID_Matrícula (chave primária)
- ID_Curso (chave estrangeira referenciando a tabela de cursos)
- ID_Aluno (chave estrangeira referenciando a tabela de alunos)
- Data_Matrícula

**Tabela de Alunos:**

- ID_Aluno (chave primária)
- Nome
- Email

**Desafio - Funções de agregação e filtragem (adicional):**

- Contem quantos alunos estão matriculados em cada curso.
- Calculem o total de matrículas registradas em todo o banco de dados.
- Encontrem o instrutor responsável pelo maior número de cursos.
- Listem os cursos que ainda não possuem nenhum aluno matriculado.
- Mostrem a quantidade de alunos matriculados por instrutor, agrupando os resultados por instrutor.
- Identifiquem o curso com o maior número de matrículas.
- Listem os alunos que estão matriculados em mais de um curso.
- Contem quantos instrutores existem para cada especialidade.
- Mostrem os 3 cursos com mais alunos matriculados, em ordem decrescente de quantidade.
- Listem os cursos cujo nome contenha a palavra "Python".
- Calculem a média de alunos matriculados por curso.
- Listem apenas os instrutores que lecionam mais de um curso.
- Mostrem as matrículas realizadas entre duas datas específicas (usando um intervalo de datas).
