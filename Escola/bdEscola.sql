CREATE DATABASE bdEscola
GO
USE bdEscola

CREATE TABLE tbAluno(
	codAluno INT PRIMARY KEY IDENTITY(1,1)
	,nomeAluno VARCHAR (90) 
	,dataNascAluno SMALLDATETIME 
	,rgAluno VARCHAR (15) 
	,naturalidadeAluno VARCHAR (20)
	,cpfAluno VARCHAR(15)
);

CREATE TABLE tbCurso(
	codCurso INT PRIMARY KEY IDENTITY(1,1)
	,nomeCurso VARCHAR (90) 
	,cargaHorariaCurso INT
	,valorCurso MONEY
);

CREATE TABLE tbTurma (
	codTurma INT PRIMARY KEY IDENTITY (1,1)
	,nomeTurma VARCHAR (90)
	,codCurso INT FOREIGN KEY REFERENCES tbCurso(codCurso)
	,horarioTurma SMALLDATETIME
);

CREATE TABLE tbMatricula(
	codMatricula INT PRIMARY KEY IDENTITY(1,1)
	,dataMatricula SMALLDATETIME
	,codAluno INT FOREIGN KEY REFERENCES tbAluno(codAluno)
	,codTurma INT FOREIGN KEY REFERENCES tbTurma(codTurma)
);
