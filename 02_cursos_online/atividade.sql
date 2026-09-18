
-- 1. Preparando banco e usuário

select suser_sname();
-- sa --

CREATE DATABASE cursos_online;

CREATE LOGIN dev WITH PASSWORD = 'ABC123xyz';

USE cursos_online;

CREATE USER dev FOR LOGIN dev;

ALTER ROLE db_owner ADD MEMBER dev;

-- -------------------------------

-- 2. Login with tux

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
  id_instrutor INT,
  CONSTRAINT FK_Cursos_Instrutores FOREIGN KEY(id_instrutor)
  REFERENCES instrutores(id_instrutor)
);

CREATE TABLE matriculas (
  id_matricula INT IDENTITY(100, 1) PRIMARY KEY,
  data_matricula DATE NOT NULL DEFAULT GETDATE(),
  id_curso INT,
  id_aluno INT,
  CONSTRAINT FK_Matriculas_Cursos FOREIGN KEY(id_curso)
  REFERENCES Cursos(id_curso),
  CONSTRAINT FK_Matriculas_Alunos FOREIGN KEY(id_aluno)
  REFERENCES Alunos(id_aluno)
);
