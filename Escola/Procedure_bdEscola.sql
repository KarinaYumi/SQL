USE bdEscola

----------------------------------------------------------------------------------------------------------------------------------------------
 -- 1) Criar uma stored procedure �Busca_Aluno� que receba o c�digo do aluno e retorne seu nome e data de nascimento.

CREATE PROCEDURE spBusca_ALuno
	@codALuno INT
	AS
		IF EXISTS(SELECT codAluno FROM tbAluno WHERE codAluno = @codALuno) BEGIN
			SELECT nomeAluno AS 'NOME', dataNascAluno AS 'NASCIMENTO' FROM tbAluno 
				WHERE codAluno = @codALuno
		END
		ELSE BEGIN
			PRINT('USUARIO INEXISTENTE!')
		END

EXEC spBusca_ALuno 5

----------------------------------------------------------------------------------------------------------------------------------------------
-- 2) Criar uma stored procedure �Insere_Aluno� que insira um registro na tabela de Alunos.

CREATE PROCEDURE sp_Insere_Aluno
	@nomeAluno VARCHAR(50)
	,@dataNascAluno SMALLDATETIME
	,@rgAluno VARCHAR(15)
	,@naturalidade VARCHAR(30)

	AS
		IF EXISTS(SELECT rgAluno FROM tbAluno WHERE rgAluno LIKE @rgAluno)
		BEGIN 
			PRINT('RG j� existente no banco de dados!')
		END
		ELSE BEGIN
			INSERT INTO tbAluno(nomeAluno, dataNascAluno, rgAluno, naturalidadeAluno)
				VALUES 
					(@nomeAluno, @dataNascAluno, @rgAluno, @naturalidade)
			PRINT('Aluno cadastrado com sucesso!')
		END

	EXEC sp_Insere_Aluno 'Karina linda', '03-01-2022', '15.552.478-90', 'Angola'

	SELECT*FROM tbAluno

----------------------------------------------------------------------------------------------------------------------------------------------
-- 3) Criar uma stored procedure �Aumenta_Preco� que, dados o nome do curso e um percentual, aumente o valor do curso com a porcentagem informada.

CREATE PROCEDURE spAumenta_Preco
	@nomeCurso VARCHAR(50), @percentual DECIMAL
	AS
	IF EXISTS(SELECT nomeCurso FROM tbCurso WHERE nomeCurso = @nomeCurso) BEGIN
		UPDATE tbCurso SET valorCurso = valorCurso + valorCurso*@percentual WHERE nomeCurso = @nomeCurso
	END
	ELSE BEGIN
		PRINT('DEU PAU')
	END
EXEC spAumenta_Preco 'Ingl�s', 25
SELECT * FROM tbCurso
----------------------------------------------------------------------------------------------------------------------------------------------
-- 4) Criar uma stored procedure �Exibe_Turma� que, dado o nome da turma exiba todas as informa��es dela.

CREATE PROCEDURE spExibe_Turma 
	@nomeTurma VARCHAR(30)
	AS
	IF EXISTS(SELECT nomeTurma FROM tbTurma WHERE nomeTurma = @nomeTurma) BEGIN
		SELECT * FROM tbTurma WHERE nomeTurma = @nomeTurma
	END
	ELSE BEGIN
		PRINT('DEU PAU')
	END

EXEC spExibe_Turma '1AA'
----------------------------------------------------------------------------------------------------------------------------------------------
-- 5) Criar uma stored procedure �Exibe_AlunosdaTurma� que, dado o nome da turma exiba os seus alunos.

CREATE PROCEDURE spExibe_AlunosTurma
	@nomeTurma VARCHAR(30)
	AS
	IF EXISTS(SELECT nomeTurma FROM tbTurma WHERE nomeTurma = @nomeTurma) BEGIN
		SELECT tbAluno.nomeAluno FROM tbAluno, tbMatricula, tbTurma 
			WHERE tbMatricula.codAluno = tbAluno.codAluno 
				AND tbTurma.codTurma = tbMatricula.codTurma AND tbTurma.nomeTurma = @nomeTurma;
	END
	ELSE BEGIN
		PRINT('DEU PAU')
	END

EXEC spExibe_AlunosTurma '1AA'
----------------------------------------------------------------------------------------------------------------------------------------------
-- 6) Criar uma stored procedure para inserir alunos, verificando pelo cpf se o aluno existe ou n�o, e informar essa condi��o via mensagem.

CREATE PROCEDURE sp_InsereAlunoCpf
	@nomeAluno VARCHAR(50)
	,@dataNascAluno SMALLDATETIME
	,@rgAluno VARCHAR(15)
	,@naturalidade VARCHAR(30)
	,@cpfAluno VARCHAR(15)

	AS
		IF EXISTS(SELECT cpfAluno FROM tbAluno WHERE cpfAluno LIKE @cpfAluno)
		BEGIN 
			PRINT('CPF j� existente no banco de dados!')
		END
		ELSE BEGIN
			INSERT INTO tbAluno(nomeAluno, dataNascAluno, rgAluno, naturalidadeAluno, cpfAluno)
				VALUES 
					(@nomeAluno, @dataNascAluno, @rgAluno, @naturalidade, @cpfAluno)
			PRINT('Aluno cadastrado com sucesso!')
		END

	EXEC sp_InsereAlunoCpf 'Karina linda', '03-01-2022', '15.552.478-90', 'Brasil', '142.445.987-99'

	SELECT*FROM tbAluno

----------------------------------------------------------------------------------------------------------------------------------------------
-- 7) Criar uma stored procedure que receba o nome do curso e o nome do aluno e matricule o mesmo no curso pretendido.

	CREATE PROCEDURE spInsereAlunoCurso
	@nomeAluno VARCHAR(50)
	,@dataNascAluno SMALLDATETIME
	,@rgAluno VARCHAR(15)
	,@naturalidade VARCHAR(30)
	,@cpfAluno VARCHAR(15)
	,@nomeCurso

	IF EXISTS(SELECT nomeCurso FROM tbCurso WHERE nomeCurso = @nomeCurso) BEGIN
		INSERT INTO tbAluno(nomeAluno, dataNascAluno, rgAluno, naturalidadeAluno, cpfAluno)
				VALUES 
					(@nomeAluno, @dataNascAluno, @rgAluno, @naturalidade, @cpfAluno)
			PRINT('Aluno cadastrado com sucesso!')
	END
