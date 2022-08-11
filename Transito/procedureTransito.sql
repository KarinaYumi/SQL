-- Criar 3 procedures para inserir 2 motoristas, 3 veículos e 5 multas.
-- PROCEDURE INSERIR MOTORISTAS

USE bdTransito

CREATE PROCEDURE spInserirMotorista
	@nomeMotorista VARCHAR(50)
	,@dataNascimentoMotorista SMALLDATETIME
	,@cpfMotorista VARCHAR(15)
	,@CNHMotorista INT
	,@pontuacaoAcumulada INT

	AS
	IF EXISTS(SELECT CNHMotorista FROM tbMotorista WHERE CNHMotorista = @CNHMotorista)
	BEGIN 
		PRINT('Motorista já cadastrado no sistema!')
	END ELSE
	BEGIN

	INSERT INTO tbMotorista(nomeMotorista, dataNascimentoMotorista, cpfMotorista, CNHMotorista, pontuacaoAcumulada)
		VALUES (@nomeMotorista, @dataNascimentoMotorista, @cpfMotorista, @CNHMotorista, @pontuacaoAcumulada)
		PRINT ('Motorista cadastrado com sucesso!')
	END

	EXEC spInserirMotorista 'Roger Mendes', '10-05-1989', '123.456.789-90', 548964, 25
	EXEC spInserirMotorista 'Luiz Alcides', '08-10-1975', '748.546.895-14', 477841, 15
	EXEC spInserirMotorista 'Maria Luiza Santos', '22-12-1970', '457.286.871-78', 457841, 23

	SELECT*FROM tbMotorista

--PROCEDURE INSERIR VEICULOS

CREATE PROCEDURE spInserirVeiculos
	@modeloVeiculo VARCHAR(40)
	,@placa VARCHAR(9)
	,@renavam INT
	,@anoVeiculo INT
	,@idMotorista INT

	AS
	IF EXISTS(SELECT placa FROM tbVeiculo WHERE placa = @placa)
		BEGIN 
		PRINT('Veículo já cadastrado no sistema!')
	END ELSE
		BEGIN

		INSERT INTO tbVeiculo(modeloVeiculo, placa, renavam, anoVeiculo, idMotorista)
			VALUES (@modeloVeiculo, @placa, @renavam, @anoVeiculo, @idMotorista)
			PRINT ('Veículo cadastrado com sucesso!')
	END

	EXEC spInserirVeiculos 'Audi A4', 'SQL1258', 59874125, 2021, 1
	EXEC spInserirVeiculos 'Dodge RAM 2500', 'GLQ3233', 526589, 2022, 2
	EXEC spInserirVeiculos 'Civic', 'GDW1589', 456841, 219, 3


SELECT*FROM tbVeiculo

--PROCEDURE INSERIR MULTAS
CREATE PROCEDURE spInserirMultas 
	@dataMulta SMALLDATETIME
	,@horaMulta	SMALLDATETIME
	,@pontosMulta INT
	,@idVeiculo INT

	AS
		INSERT INTO tbMultas(dataMulta,horaMulta, pontosMulta, idVeiculo)
		VALUES (@dataMulta, @horaMulta, @pontosMulta, @idVeiculo)
		PRINT ('Multa cadastrada com sucesso!')

	EXEC spInserirMultas '12-05-2022', '12-05-2022 12:52:01', 10, 2
	EXEC spInserirMultas '14-01-2021', '14-01-2021 21:58:15', 21, 1
	EXEC spInserirMultas '25-08-2022', '25-08-2022 10:02:45', 11, 1
	EXEC spInserirMultas '30-04-2022', '30-04-2022 15:42:11', 07, 3
	EXEC spInserirMultas '26-02-2021', '14-03-2022 21:52:51', 03, 2

	SELECT*FROM tbMultas

-- Criar uma stored procedure que ao ser colocada a placa do veículo apresente-se a quantidade de multas do veículo
CREATE PROCEDURE spMultasVeiculo
	@placa VARCHAR(9)
	AS
		IF EXISTS(SELECT placa FROM tbVeiculo WHERE placa = @placa) BEGIN
			SELECT COUNT(idMulta) FROM tbMultas WHERE tbMultas.idVeiculo = tbVeiculo.idMotorista;
		END 
		ELSE BEGIN
			PRINT('Não existem multas registradas no veículo')
		END

		EXEC spMultasVeiculo 'GLQ3233'



-- 3-Criar uma procedure que receba o cpf do motorista e apresenta a sua pontuação acumulada
CREATE PROCEDURE pontuacaoMotorista 
	@cpfMotorista VARCHAR(15)
	AS
		IF EXISTS(SELECT cpfMotorista FROM tbMotorista WHERE cpfMotorista = @cpfMotorista) BEGIN
			SELECT pontuacaoAcumulada AS 'Pontuação' FROM tbMotorista
			WHERE cpfMotorista = @cpfMotorista
		END
		ELSE BEGIN
			PRINT('O motorista não tem pontos acumulados!')
		END
	EXEC pontuacaoMotorista '123.456.789-90'
