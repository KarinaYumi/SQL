--01
CREATE FUNCTION fc_DiaSemanaVenda(@codVenda INT)
	RETURNS varchar(30) AS
	BEGIN

		DECLARE @DataVenda DATE = (SELECT dataVenda FROM tbVenda WHERE codVenda = @codVenda)
		DECLARE @DiadaSemana varchar(140)
		DECLARE @dia INT
		
	SET @dia= DATEPART(dw,@DataVenda)
		
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

		SET @DiadaSemana = (SELECT CONVERT(VARCHAR(12), dataVenda) +' | '+@DiadaSemana  FROM tbVenda WHERE codVenda = @codVenda)

		RETURN @DiadaSemana
		END

		SELECT teste=dbo.fc_DiaSemanaVenda(2)

--02

CREATE FUNCTION fc_ClienteCompras(@codCliente INT)
	RETURNS VARCHAR(90) AS
BEGIN
	DECLARE @retorno VARCHAR(90)
	DECLARE @quantidadeCompras INT
		SET @quantidadeCompras = (SELECT COUNT(codVenda) FROM tbVenda WHERE codCliente = @codCliente)

	DECLARE @valorTotalCompras MONEY
		SET @valorTotalCompras = (SELECT SUM(valorTotalVenda) FROM tbVenda WHERE codCliente = @codCliente)

	SET @retorno = 'CLIENTE: '+(SELECT CONVERT(VARCHAR(30), @codCliente) +'  | Total de Compras: '+ CONVERT(VARCHAR(30), @quantidadeCompras)+'   | Valor total das Compras  '+ CONVERT(VARCHAR(30), @valorTotalCompras) FROM tbVenda WHERE codCliente = @codCliente GROUP BY codCliente)
	RETURN @retorno
END
	
	SELECT teste=dbo.fc_ClienteCompras(1)

--03 
CREATE FUNCTION fc_vendasVendedor(@codVendedor INT, @mes DATE)
	RETURNS VARCHAR(100) AS
BEGIN
	DECLARE @retorno VARCHAR(100)
	DECLARE @Vendas INT = (SELECT COUNT(codVendedor) FROM tbVenda WHERE dataVenda LIKE @mes)
	DECLARE @data DATE = (SELECT dataVenda FROM tbVenda WHERE codVendedor = @codVendedor and dataVenda = @mes)

	SET @retorno = 'DATA: '+CONVERT(VARCHAR(20), @data) +'|Total de vendas  '+ CONVERT(VARCHAR(10), @Vendas)

	RETURN @retorno
END

SELECT MinhaFunção=dbo.fc_vendasVendedor(1,'0000-05-00')

--04
CREATE FUNCTION fc_ValidaCPF(@codCliente INT)
    RETURNS VARCHAR(15) AS
BEGIN

    DECLARE @cpfCli VARCHAR(15) = (SELECT cpfCliente FROM tbCliente WHERE @codCliente = codCliente),
    @Soma INT,
    @Indice INT,
    @Digito1 INT,
    @Digito2 INT,
    @cpf_temp VARCHAR(11),
    @DigitosIguais CHAR(1),
    @resultado VARCHAR(30)

    SET @resultado = 'N'
    SET @cpf_temp = SUBSTRING(@cpfCli,1,1)
    SET @Indice = 1
    SET @DigitosIguais = 'S'

    WHILE (@indice <= 11) BEGIN 
        IF SUBSTRING(@cpfCli,@Indice,1) <> @cpf_temp 
        SET @DigitosIguais = 'N'
        SET @Indice = @Indice + 1
    END

    IF @DigitosIguais = 'N' BEGIN
        SET @Soma = 0 
        SET @Indice = 1

    WHILE (@INDICE <= 9)BEGIN
        SET @Soma = @Soma + CONVERT(INT,SUBSTRING(@cpfCli,@Indice,1)) * (11 -@INDICE);
        SET @INDICE = @INDICE + 1

    END

    SET @Digito1 = 11 -(@soma % 11)
        IF @Digito1 > 9
        SET @Digito1 = 0;

    SET @SOMA = 0
    SET @INDICE = 1
    WHILE (@INDICE <= 10) BEGIN
        SET @Soma = @Soma + CONVERT(INT,SUBSTRING(@cpfCli,@Indice,1)) * (12 -@Indice);
        SET @Indice = @Indice + 1
    END

    SET @Digito2 = 11 -(@Soma % 11)
        IF @Digito2 > 9
        SET @Digito2 = 0;

    IF (@Digito1 = SUBSTRING(@cpfCli,LEN(@cpfCli)-1,1)) AND (@Digito2 = SUBSTRING(@cpfCli,LEN(@cpfCli),1))
        SET @resultado = 'CPF VÁLIDO   | '+@cpfCli
    ELSE
        SET @resultado = 'CPF INVÁLIDO  | '+@cpfCli
    END

    RETURN @resultado
    END
