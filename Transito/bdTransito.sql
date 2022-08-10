CREATE DATABASE bdTransito
USE bdTransito


CREATE TABLE tbMotorista(
	idMotorista INT PRIMARY KEY IDENTITY(1,1)
	,nomeMotorista VARCHAR(50)
	,dataNascimentoMotorista SMALLDATETIME
	,cpfMotorista VARCHAR(15)
	,CNHMotorista INT
	,pontuacaoAcumulada INT
);


CREATE TABLE tbVeiculo(
	idVeiculo INT PRIMARY KEY IDENTITY(1,1)
	,modeloVeiculo VARCHAR(40)
	,placa VARCHAR(9)
	,renavam INT
	,anoVeiculo INT
	,idMotorista INT FOREIGN KEY REFERENCES tbMotorista(idMotorista)

);

CREATE TABLE tbMultas(
	idMulta INT PRIMARY KEY IDENTITY(1,1)
	,dataMulta SMALLDATETIME
	,horaMulta SMALLDATETIME
	,pontosMulta INT
	,idVeiculo INT FOREIGN KEY REFERENCES tbVeiculo(idVeiculo)
);

