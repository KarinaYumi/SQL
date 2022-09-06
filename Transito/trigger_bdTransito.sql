-- Criar uma trigger que ao ve�culo tomar uma multa os pontos da multa sejam  atualizados na tabela do motorista no campo pontuacaoAcumulada. 
-- Caso o motorista alcance 20 pontos informar via mensagem que o mesmo poder� ter sua habilita��o suspensa.

CREATE TRIGGER tgMulta
ON tbMultas AFTER INSERT
AS
	DECLARE @pontos INT;
	DECLARE @idMulta INT;
	DECLARE @idMotorista INT;
	DECLARE @pontuacaoAcumulada INT; 

	SET @idMulta = (SELECT idMulta FROM INSERTED)
	SET @pontos = (SELECT pontosMulta FROM INSERTED)
	SET @idMotorista = (SELECT tbMotorista.idMotorista FROM tbMotorista 
						INNER JOIN tbVeiculo ON tbMotorista.idMotorista = tbVeiculo.idMotorista 
						INNER JOIN tbMultas ON tbVeiculo.idVeiculo = tbMultas.idVeiculo WHERE idMulta = @idMulta)
	UPDATE tbMotorista 
	SET pontuacaoAcumulada = pontuacaoAcumulada + @pontos
	WHERE idMotorista = @idMotorista

	IF @pontuacaoAcumulada >= 20 
		BEGIN
			PRINT ('VOC� ATINGIU +20 PONTOS NA CARTEIRA, SUA CARTA PODER� SER SUSPENSA!!!')
		END
	ELSE
		BEGIN
			PRINT('VOC� TEM '+@pontuacaoAcumulada+'PONTOS NA CARTEIRA!')
		END
GO

