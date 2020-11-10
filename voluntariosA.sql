----- Insertar Voluntarios Administrativos -----

Create Procedure InsertarVoluntarios_A(@voluntario_fk int)
As
	Insert Into voluntarios_Administrativos(voluntario_fk)
	Values (@voluntario_fk)
Go

execute InsertarVoluntarios_A '2'

----- Listar Voluntarios Administrativos -----
Use ACNUR
GO
Create PROC ListadoVoluntarios_A
AS
select 
	   voluntarios.voluntario_id,
	   voluntarios_Administrativos.voluntarioA_id
from voluntarios_Administrativos
	   Inner Join voluntarios On voluntarios.voluntario_id = voluntarios_Administrativos.voluntario_fk
GO

EXEC ListadoVoluntarios_A
GO

----- Elimnar Voluntarios Administrativos -----
Use ACNUR
GO
CREATE PROC EliminarVoluntarios_A(@voluntarioA_id int)
AS
DELETE FROM voluntarios_Administrativos where voluntarioA_id=@voluntarioA_id
GO

EXEC EliminarVoluntarios_A '2'
GO

----- Buscar Voluntarios Administrativos -----
Use ACNUR
GO
CREATE PROC BuscarVoluntariosID_A(@voluntarioA_id int)
AS
IF(@voluntarioA_id= '')
   BEGIN
  PRINT 'NO SE PUEDEN INGRESAR VALORES NULOS'
   END
  ELSE
  BEGIN
 if exists(select voluntarioA_id from voluntarios_Administrativos where voluntarioA_id = @voluntarioA_id)
  begin
    select * FROM voluntarios_Administrativos where voluntarioA_id=@voluntarioA_id
 END
   ELSE 
   BEGIN
      PRINT 'No se Encontro el Id del Voluntario'
    RETURN
   END
 END
GO

EXEC BuscarVoluntariosID_A '3'
GO
--------------------------