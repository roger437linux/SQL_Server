
-- 1. Preparando banco e usuário

select suser_sname();
-- sa --

CREATE DATABASE cursos_online;

CREATE LOGIN dev WITH PASSWORD = 'ABC123xyz';

USE cursos_online;

CREATE USER dev FOR LOGIN dev;

ALTER ROLE db_owner ADD MEMBER dev;

-- -------------------------------

-- 2. Login with dev

USE cursos_online;

-- ------------- Criar as tabelas -------------

CREATE TABLE instrutores (
  id_instrutor INT IDENTITY(1001, 1) PRIMARY KEY,
  nome_instrutor VARCHAR(100) NOT NULL,
  especialidade VARCHAR(100) NULL
);

CREATE TABLE alunos (
  id_aluno INT IDENTITY(10001, 1) PRIMARY KEY,
  nome_aluno VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE
);

CREATE TABLE cursos (
  id_curso INT IDENTITY(1, 1) PRIMARY KEY,
  nome_curso VARCHAR(100) NOT NULL UNIQUE,
  descricao VARCHAR(200) NULL,
  id_instrutor INT NOT NULL,
  CONSTRAINT FK_Cursos_Instrutores FOREIGN KEY(id_instrutor)
  REFERENCES instrutores(id_instrutor)
);

CREATE TABLE matriculas (
  id_matricula INT IDENTITY(101, 1) PRIMARY KEY,
  data_matricula DATE NOT NULL DEFAULT GETDATE(),
  id_curso INT NOT NULL,
  id_aluno INT NOT NULL,
  CONSTRAINT FK_Matriculas_Cursos FOREIGN KEY(id_curso)
  REFERENCES Cursos(id_curso),
  CONSTRAINT FK_Matriculas_Alunos FOREIGN KEY(id_aluno)
  REFERENCES Alunos(id_aluno)
);


-- ------------ Popular as tabelas ------------

INSERT INTO dbo.instrutores (nome_instrutor, especialidade) VALUES
('Albert Einstein', 'Física Teórica'),
('Isaac Newton', 'Física e Matemática'),
('Charles Darwin', 'Biologia Evolutiva e Naturalismo'),
('Nikola Tesla', 'Engenharia Elétrica e Mecânica'),
('Ada Lovelace', 'Matemática e Computação'),
('Stephen Hawking', 'Cosmologia e Física Teórica'),
('Jane Goodall', 'Primatologia e Antropologia'),
('Alan Turing', 'Matemática e Ciência da Computação'),
('Gregor Mendel', 'Genética e Botânica'),
('Galileu Galilei', 'Astronomia e Física'),
('Frank Rosenblatt', 'Psicólogo'),
('Julius Robert Oppenheimer', 'Física e Matemática');

INSERT INTO dbo.alunos (nome_aluno, email) VALUES
('Mônica', 'monica.donadaruas@limoeiro.com.mx'),
('Cebolinha', 'plano_infalivel_oficial@limoeiro.com.mx'),
('Cascão', 'cascao.antiagua@limoeiro.com.mx'),
('Magali', 'magali.melancia@limoeiro.com.mx'),
('Chico Bento', 'chicobento.guri@roca.com.mx'),
('Franjinha', 'franjinha.lab@ciencia.com.mx'),
('Bidu', 'bidu.azul@limoeiro.com.mx'),
('Zé Lelé', 'zelele.distraido@roca.com.mx'),
('Anjinho', 'celestino.anjinho@ceu.com.mx'),
('Capitão Feio', 'capitaofeio.sujeira@esgoto.com.mx');

INSERT INTO cursos (nome_curso, descricao, id_instrutor) VALUES
('Python Fundamentos e Automação', 'Programação moderna e automação de tarefas com Python.', 1001),
('Kubernetes na Prática', 'Orquestração e gerenciamento de microsserviços em clusters', 1004),
('Arquitetura de Nuvem na AWS', 'Computação em nuvem e infraestrutura escalável na Amazon', 1010),
('Linguagem C e Algoritmos Estruturados', 'Lógica de programação e manipulação de memória técnica', 1005),
('Docker e Containers para Desenvolvedores', 'Criação, empacotamento e distribuição de aplicações isoladas', 1004),
('Infraestrutura como Código com Terraform', 'Provisionamento automatizado e seguro de recursos multicloud', 1006),
('IoT: Sensores e Conectividade', 'Desenvolvimento de sistemas embarcados e internet das coisas', 1007),
('Administração de Oracle Database', 'Gerenciamento, performance e segurança no banco corporativo', 1010),
('Dominando o Sistema Linux', 'Administração de servidores e comandos essenciais via terminal', 1003),
('Segurança e Redes com OpenBSD', 'Configuração de firewalls e sistemas altamente seguros', 1003),
('Processamento de Big Data com Spark', 'Análise distribuída de dados em tempo real', 1002),
('Kubernetes e Docker no Fluxo DevOps', 'Do container local à orquestração escalável em produção', 1004),
('Python para Machine Learning', 'Uso da linguagem para criar modelos de ML', 1001),
('Automação de Redes com Python', 'Administrando ativos de rede com códigos', 1001);

INSERT INTO matriculas (id_curso, id_aluno) VALUES
(1, 10001),
(13, 10001),
(14, 10001),
(5, 10002),
(12, 10002),
(13, 10005),
(5, 10010),
(10, 10001),
(9, 10004),
(8, 10003),
(1, 10005),
(11, 10007),
(8, 10008),
(7, 10009),
(6, 10010),
(6, 10007),
(11, 10003),
(2, 10008),
(9, 10004),
(9, 10009),
(13, 10006);


-- Obs.: Integridade referencial: Todo aluno inserido em matriculas, precisa previamente existir na tabela Alunos.
--                                Todo curso inserido em matriculas, precisa previamente existir na tabela Cursos.


-- ---------------- Consultas -----------------


SELECT TOP(5) * FROM instrutores;
SELECT TOP(5) * FROM alunos;
SELECT TOP(5) * FROM cursos;
SELECT TOP(5) * FROM matriculas


-- 1. Contar quantos alunos estão matriculados em cada curso.

SELECT matriculas.id_curso, 
COUNT(*) as qtde_alunos
FROM matriculas
GROUP BY matriculas.id_curso;

-- Versão final

SELECT cursos.nome_curso AS "Curso",
COUNT(*) AS "Qtde matriculas"
FROM matriculas
INNER JOIN cursos
ON matriculas.id_curso = cursos.id_curso
GROUP BY matriculas.id_curso, cursos.nome_curso
ORDER BY "Qtde matriculas" DESC;


-- 2. Calculem o total de matrículas registradas em todo o banco de dados.

SELECT COUNT(*) AS "Total matriculas" FROM matriculas


-- 3. Encontrar o instrutor responsável pelo maior número de cursos.

SELECT TOP(1) instrutores.nome_instrutor AS "Instrutor", 
COUNT(*) AS "Qtde cursos"
FROM cursos
INNER JOIN instrutores
ON instrutores.id_instrutor = cursos.id_instrutor
GROUP BY instrutores.nome_instrutor
ORDER BY "Qtde cursos" DESC;

-- 4. Listar os cursos que ainda não possuem nenhum aluno matriculado.

SELECT cursos.id_curso,
cursos.nome_curso,
matriculas.id_curso AS "id_curso em matriculas"
FROM cursos
LEFT JOIN matriculas
ON cursos.id_curso = matriculas.id_curso
WHERE matriculas.id_curso IS NULL
ORDER BY cursos.id_curso;


-- 5. Mostrar a quantidade de alunos matriculados por instrutor, agrupando os resultados por instrutor.

SELECT instrutores.nome_instrutor, 
COUNT(matriculas.id_aluno) AS "qtde matriculas"
FROM instrutores
INNER JOIN cursos
ON instrutores.id_instrutor = cursos.id_instrutor
INNER JOIN matriculas
ON cursos.id_curso = matriculas.id_curso
GROUP BY instrutores.nome_instrutor
ORDER BY "qtde matriculas" ASC;

-- 6. Identifique o curso com o maior número de matrículas.

select top(1) matriculas.id_curso, count(*) as qtde
from matriculas
group by matriculas.id_curso
order by qtde DESC;

-- Versão final

select top(1) cursos.nome_curso, count(*) as qtde_matricula
from matriculas
INNER JOIN cursos
ON cursos.id_curso = matriculas.id_curso
group by cursos.nome_curso
order by qtde_matricula DESC;

-- 7. Listar os alunos que estão matriculados em mais de um curso.

SELECT alunos.nome_aluno, COUNT(*) AS qtde_curso
FROM matriculas
INNER JOIN alunos
ON alunos.id_aluno = matriculas.id_aluno
GROUP BY alunos.nome_aluno
HAVING COUNT(*) > 1
ORDER BY qtde_curso DESC, alunos.nome_aluno ASC;

-- 8. Contar quantos instrutores existem para cada especialidade.

SELECT instrutores.especialidade, 
COUNT(*) AS "Qtde instrutor"
FROM instrutores
GROUP BY instrutores.especialidade
ORDER BY "Qtde instrutor" DESC, instrutores.especialidade ASC;

-- 9. Mostrar os 3 cursos com mais alunos matriculados, em ordem decrescente de quantidade.

SELECT TOP(3)  cursos.nome_curso, count(*) AS "Qtde matricula"
FROM matriculas
INNER JOIN cursos
ON cursos.id_curso = matriculas.id_curso
GROUP BY cursos.nome_curso
ORDER BY "Qtde matricula" DESC;

-- 10. Listar os cursos cujo nome contenha a palavra "Python".

SELECT cursos.nome_curso
FROM cursos
WHERE cursos.nome_curso LIKE '%_ython%';

-- 11. Calcular a média de alunos matriculados por curso.

SELECT AVG(CAST(total_alunos AS DECIMAL(10,2))) AS media_alunos_curso
FROM (
    SELECT COUNT(*) AS total_alunos
    FROM matriculas
    GROUP BY matriculas.id_curso
) AS subquery_matriculas;


-- 12. Listem apenas os instrutores que lecionam mais de um curso.

SELECT instrutores.nome_instrutor, COUNT(*) as qtde_curso
FROM instrutores
INNER JOIN cursos
ON instrutores.id_instrutor = cursos.id_instrutor
GROUP BY instrutores.nome_instrutor
HAVING COUNT(*) > 1
ORDER BY qtde_curso DESC;

-- 13. Mostrem as matrículas realizadas entre duas datas específicas (usando um intervalo de datas).

SELECT id_matricula, data_matricula
FROM matriculas
WHERE data_matricula BETWEEN '2026-07-01' AND GETDATE()
ORDER BY data_matricula ASC;