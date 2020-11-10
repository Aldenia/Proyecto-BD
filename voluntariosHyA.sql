
----- Insertar Voluntarios Humanitarios -----

Create Procedure InsertarVoluntarios_H (@profesion Varchar(25), @disponibilidad Varchar(25), @cantidad_de_trabajos int, @voluntario_fk int)
As
	Insert Into voluntarios_Humanitarios(profesion, disponibilidad, cantidad_de_trabajos, voluntario_fk)
	Values (@profesion, @disponibilidad, @cantidad_de_trabajos, @voluntario_fk)
Go

execute InsertarVoluntarios_H 'Doctor','Disponible','2','2'

----- Listar Voluntarios Humanitarios -----
Use ACNUR
GO
Create PROC ListadoVoluntarios_H
AS
select 
	   voluntarios.voluntario_id,
	   voluntarios_Humanitarios.voluntarioH_id, 
	   voluntarios_Humanitarios.profesion, 
	   voluntarios_Humanitarios.disponibilidad, 
	   voluntarios_Humanitarios.cantidad_de_trabajos 
from voluntarios_Humanitarios
	   Inner Join voluntarios On voluntarios.voluntario_id = voluntarios_Humanitarios.voluntario_fk
GO

EXEC ListadoVoluntarios_H
GO


----- Actualizar Voluntarios Humanitarios -----

use ACNUR
go
Create Procedure ActualizarVoluntarios_H 
				 @voluntarioH_id Int, 
				 @profesion Varchar(25), 
				 @disponibilidad Varchar(25), 
				 @cantidad_de_trabajos int, 
				 @voluntario_fk int
As
	Update voluntarios_Humanitarios
	set 
	profesion = @profesion,
	disponibilidad = @disponibilidad,
	cantidad_de_trabajos = @cantidad_de_trabajos, 
	voluntario_fk = @voluntario_fk
	Where voluntarioH_id =  @voluntarioH_id
Go

execute ActualizarVoluntarios_H '1','Doctor','Ocupado','2','2'

----- Elimnar Voluntarios Humanitarios -----
Use ACNUR
GO
CREATE PROC EliminarVoluntarios_H(@voluntarioH_id int)
AS
DELETE FROM voluntarios_Humanitarios where voluntarioH_id=@voluntarioH_id
GO

EXEC EliminarVoluntarios_H '1'
GO

----- Buscar Voluntarios Humanitarios -----
Use ACNUR
GO
CREATE PROC BuscarVoluntariosID_H(@voluntarioH_id int)
AS
IF(@voluntarioH_id= '')
   BEGIN
  PRINT 'NO SE PUEDEN INGRESAR VALORES NULOS'
   END
  ELSE
  BEGIN
 if exists(select voluntarioH_id from voluntarios_Humanitarios where voluntarioH_id = @voluntarioH_id)
  begin
    select * FROM voluntarios_Humanitarios where voluntarioH_id=@voluntarioH_id
 END
   ELSE 
   BEGIN
      PRINT 'No se Encontro el Id del Voluntario'
    RETURN
   END
 END
GO

EXEC BuscarVoluntariosID_H '2'
GO

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

----- Actualizar Voluntarios Administrativos-----

use ACNUR
go
Create Procedure ActualizarVoluntarios_A 
				 @voluntarioA_id Int,  
				 @voluntario_fk int
As
	Update voluntarios_Administrativos
	set  
	voluntario_fk = @voluntario_fk
	Where voluntarioA_id =  @voluntarioA_id
Go

execute ActualizarVoluntarios_A '2','4'

DROP PROCEDURE ActualizarVoluntarios_A;

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

USE ACNUR
GO
CREATE VIEW View_voluntario_H
AS
	Select * From voluntarios_Humanitarios

GO