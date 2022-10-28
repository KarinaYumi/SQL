--01
CREATE FUNCTION fc_DiaSemana(@codMatricula INT)
	RETURNS varchar(30) AS
BEGIN
  
	DECLARE @DataMatricula DATE = (SELECT dataMatricula FROM tbMatricula WHERE codMatricula = @codMatricula)
		DECLARE @DiadaSemana varchar(140)
		DECLARE @dia INT
		
	SET @dia= DATEPART(dw,@DataMatricula)
		
		IF @dia = 1 BEGIN
			SET @DiadaSemana = 'Domingo'
		END

		IF @dia = 2 BEGIN
			SET @DiadaSemana = 'Segunda-Feira'
		END

		IF @dia = 3 BEGIN
			SET @DiadaSemana = 'Terça-Feira'
		END

		IF @dia = 4 BEGIN
			SET @DiadaSemana = 'Quarta-Feira'
		END

		IF @dia = 5 BEGIN
			SET @DiadaSemana = 'Quinta-Feira'
		END

		IF @dia = 6 BEGIN
			SET @DiadaSemana = 'Sexta-Feira'
		END

		IF @dia = 7 BEGIN
			SET @DiadaSemana = 'Sábado'
		END

		SET @DiadaSemana = (SELECT CONVERT(VARCHAR(12), @DataMatricula) +' | '+@DiadaSemana  FROM tbMatricula WHERE codMatricula = @codMatricula)

		RETURN @DiadaSemana
		END

		SELECT teste=dbo.fc_DiaSemana(1)

		SELECT*FROM tbMatricula
    
 --02
 CREATE FUNCTION fc_ValidacargaHoraria(@idCurso INT)
 	RETURNS VARCHAR(20) AS
BEGIN
	
	DECLARE @retorno VARCHAR(20)
	DECLARE @cargaHoraria INT = (SELECT cargaHorariaCurso FROM tbCurso WHERE codCurso = @idCurso)

	IF (@cargaHoraria >=1000)
	SET @retorno = 'CURSO EXTENSO'

	ELSE
	SET @retorno = 'CURSO CURTO'

	RETURN @retorno
	END

	SELECT carga=dbo.fc_ValidacargaHoraria(2) 
  
 -- 03
CREATE FUNCTION fc_ValidaValor(@idCurso INT)
	RETURNS VARCHAR(20) AS
BEGIN
	
	DECLARE @retorno VARCHAR(20)
	DECLARE @valorCurso INT = (SELECT valorCurso FROM tbCurso WHERE codCurso = @idCurso)

	IF (@valorCurso >=400)
	SET @retorno = 'CARO'

	ELSE
	SET @retorno = 'BARATO'

	RETURN @retorno
	END

	SELECT VALOR=dbo.fc_ValidaValor(3) 


--04
CREATE FUNCTION fc_converterDataMatricula(@idMatricula INT) 
	RETURNS VARCHAR(12) AS
BEGIN

	DECLARE @DataMatricula SMALLDATETIME= (SELECT dataMatricula FROM tbMatricula WHERE codMatricula = @idMatricula)
	DECLARE @retorno VARCHAR(12)

	SET @retorno = (SELECT CONVERT(VARCHAR(12), dataMatricula, 103) FROM tbMatricula WHERE codMatricula = @idMatricula)

	RETURN @retorno

END

SELECT Data=dbo.fc_converterDataMatricula(7)

