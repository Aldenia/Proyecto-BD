---------------------------------
USE ACNUR
GO
CREATE VIEW View_sede_voluntario
AS	
	SELECT	
		sede_id,
		nombre_sede
	From sedes
GO

select * from View_sede_voluntario

--------------------------------
USE ACNUR
GO
CREATE VIEW View_voluntario_A
AS
	Select
		voluntarioA_id,
		voluntario_fk
	From	
		voluntarios_Administrativos

GO
---------------------------------
USE ACNUR
GO
CREATE VIEW View_voluntario_H
AS
	Select * From voluntarios_Humanitarios

GO
-------------------------------
USE ACNUR
GO
CREATE VIEW View_voluntario_Admin
AS
	Select 
	voluntario_id,
	nombre
	From voluntarios

GO