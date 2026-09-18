
-- 1. Preparando banco e usuário

select suser_sname();
-- sa --

create database universidade;

use universidade;

create user tux for login tux;

alter role db_owner add member tux;

-- -------------------------------

-- 2. Login with tux

