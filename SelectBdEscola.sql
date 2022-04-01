USE bdEscola
--Atividade 1--
SELECT nomeAluno Aluno, dataNascAluno, rgAluno RG FROM tbAluno
WHERE natuAluno like 'SP'

--Atividade 2--
SELECT nomeAluno Aluno, rgAluno RG FROM tbAluno
WHERE nomeAluno like 'P%'

--Atividade 3--
SELECT nomeCurso Curso, cargaHorariaCurso FROM tbCurso
WHERE cargaHorariaCurso >= 2000

--Atividade 4--
SELECT nomeAluno Aluno, rgAluno RG FROM tbAluno
WHERE nomeAluno like '%Silva%'

--Atividade 5--
SELECT nomeAluno Aluno, dataNascAluno FROM tbAluno   
WHERE DATEPART (month, dataNascAluno) = 03

--Atividade 6--
SELECT codAluno, dataMatricula FROM tbMatricula   
WHERE DATEPART(month,dataMatricula) = 05

--Atividade 7--
SELECT codAluno, codTurma FROM tbMatricula
WHERE codTurma = 1 or codturma = 2

--Atividade 8--
SELECT codAluno, codTurma FROM tbMatricula
WHERE codTurma = 3

--Atividade 9--
SELECT Aluno.codAluno, Aluno.nomeAluno Nome, Aluno.rgAluno RG, Aluno.dataNascAluno, Aluno.natuAluno Naturalidade, Matri.dataMatricula,Turma.nomeTurma Turma, Turma.horarioTurma, Curso.nomeCurso Curso FROM tbAluno as Aluno, tbCurso as Curso, tbTurma as Turma, tbMatricula as Matri
WHERE  Aluno.codAluno = Matri.codAluno and Matri.codTurma = Turma.codTurma and Turma.codCurso = Curso.codCurso

--Atividade 10--
SELECT Turma.codTurma, Turma.nomeTurma Turma, Turma.horarioTurma,Curso.nomeCurso Curso
FROM tbTurma as Turma,tbCurso as Curso
WHERE Turma.codCurso = Curso.codCurso 