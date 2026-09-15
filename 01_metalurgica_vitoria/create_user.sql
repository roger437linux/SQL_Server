-- Logado como usuário sa (system administrator)

CREATE DATABASE metalurgica_vitoria;

CREATE LOGIN tux WITH PASSWORD = 'ABC123xyz';

USE metalurgica_vitoria;

CREATE USER tux FOR LOGIN tux;

ALTER ROLE db_owner ADD MEMBER tux;
