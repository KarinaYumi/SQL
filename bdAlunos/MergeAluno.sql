--ALUNOS 2A

MERGE tbAlunos3A  dest
	USING tbAlunos2A ori
	ON ori.RmAluno = dest.RmAluno
  
		WHEN NOT MATCHED AND ori.statusAluno LIKE 'Aprovado' THEN 
			INSERT VALUES (ori.RmAluno, ori.nomeAluno, ori.statusaluno)
		WHEN MATCHED THEN 
			UPDATE SET dest.nomeALuno += ori.nomeALuno;

--Alunos 2B

	MERGE tbAlunos3A  dest
	  USING tbAlunos2B ori
	  ON ori.RmAluno = dest.RmAluno
    
		  WHEN NOT MATCHED AND ori.statusaluno LIKE 'Aprovado' THEN 
			  INSERT VALUES (ori.RmAluno, ori.nomeAluno, ori.statusaluno)
		  WHEN MATCHED THEN 
			  UPDATE SET dest.nomeALuno += ori.nomeALuno;
		
	
  SELECT * FROm tbAlunos3A
