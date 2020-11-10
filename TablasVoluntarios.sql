---Creamos la base de datos

Use Master
GO
Create Database ACNUR
On Primary
(NAME = 'ACNURServer_Data',
FILENAME='C:\SQLData\ACNURServer_Data.Mdf',
SIZE = 500mb,
MAXSIZE = 1Gb,
FILEGROWTH = 100Mb)
Log On 
(NAME = 'ACNURServer_Log',
FILENAME='C:\SQLLog\ACNURServer_Log.Ldf',
SIZE = 100Mb,
MAXSIZE = 500Mb,
FILEGROWTH = 20Mb)
GO

--Creamos los grupos de archivos
ALTER DATABASE ACNUR
ADD FILEGROUP voluntarios
GO

--Añadimos los archivos de datos 
Use Master
GO
ALTER DATABASE ACNUR
ADD FILE
(NAME = 'Vol01_Data',
FILENAME = '/var/opt/mssql/data/Vol01_Data.ndf',
SIZE = 500MB,
MAXSIZE = 1GB,
FILEGROWTH = 50MB)
TO FILEGROUP voluntarios
GO

--Creacion de las tablas

Use ACNUR
Go
Create Table voluntarios
(
	voluntario_id int Identity (1,1),
	cedula Varchar(25) unique not null,
	nombre Varchar(50) not null,
	apellido1 Varchar(25) not null,
	apellido2 Varchar(25) not null,
	sede_fk int not null,
	--Constraints
	--PK
	Constraint PK_voluntarios Primary Key Clustered (voluntario_id),
	--FK
	Constraint FK_voluntarios_sede Foreign Key (sede_fk) references sedes (sede_id)
)
ON voluntarios
Go

use ACNUR
GO
Create Table voluntarios_Humanitarios
(
	voluntarioH_id int Identity (1,1),
	profesion Varchar(25) not null,
	disponibilidad Varchar(25) not null,
	cantidad_de_trabajos int not null,
	voluntario_fk int not null,
	--Constraints
	--PK
	Constraint PK_voluntarioH Primary Key Clustered (voluntarioH_id),
	--FK
	Constraint FK_voluntarios_H Foreign Key (voluntario_fk) references voluntarios (voluntario_id)
)
ON voluntarios
Go

Use ACNUR
Go
Create Table voluntarios_Administrativos
(
	voluntarioA_id int Identity (1,1),
	voluntario_fk int not null,
	--Constraints
	--PK
	Constraint PK_voluntarioA Primary Key Clustered (voluntarioA_id),
	--FK
	Constraint FK_voluntarios_A Foreign Key (voluntario_fk) references voluntarios (voluntario_id)
)
ON voluntarios
Go

----- Insertar voluntarios -----
Use ACNUR
GO
CREATE PROC SP_InsertarVoluntarios (@cedula varchar(25), @nombre varchar(50), @apellido1 varchar(25), @apellido2 varchar(25), @sede_fk int)
AS
if((@cedula = '') or (@nombre = '') or (@apellido1 = '') or (@apellido2 = '') or (@sede_fk= ''))
    begin 
       print 'No se permiten campos nulos'
       return
    end
else
	if exists (select cedula from voluntarios where cedula = @cedula)
	   begin
	      print 'Ya hay un voluntario con la Cedula: ' + convert(varchar(12), @cedula) + ', por favor verificar.'
          return
	   end
	else
	   begin
		  Insert Into voluntarios (cedula, nombre, apellido1, apellido2, sede_fk)
		  Values (@cedula, @nombre, @apellido1, @apellido2, @sede_fk)
       end
GO

execute SP_InsertarVoluntarios '5432','Juan','Rodriguez','Ramirez','3'

----- Actualizar Voluntarios -----

use ACNUR
go
Create Procedure SP_ActualizarVoluntarios 
				 @voluntario_id Int, 
				 @cedula Varchar(25), 
				 @nombre Varchar(50), 
				 @apellido1 Varchar(25), 
				 @apellido2 Varchar(25), 
				 @sede_fk Int
As
	Update voluntarios
	set 
	cedula = @cedula,
	nombre = @nombre,
	apellido1 = @apellido1, 
	apellido2 = @apellido2, 
	sede_fk = @sede_fk
	Where voluntario_id =  @voluntario_id
Go

execute SP_ActualizarVoluntarios '2','5435','Juan','Rodriguez','Ramirez','3'

----- Listar Voluntarios -----
Use ACNUR
GO
Create PROC SP_ListadoVoluntarios
AS
select 
	   sedes.sede_id,
	   voluntarios.voluntario_id, 
	   voluntarios.cedula, 
	   voluntarios.nombre, 
	   voluntarios.apellido1, 
	   voluntarios.apellido2 
from voluntarios
	   Inner Join sedes On sedes.sede_id = voluntarios.sede_fk
GO

EXEC SP_ListadoVoluntarios
GO


----- Elimnar Voluntarios -----
Use ACNUR
GO
CREATE PROC SP_EliminarVoluntarios(@voluntario_id int)
AS
DELETE FROM voluntarios where voluntario_id=@voluntario_id
GO

EXEC SP_EliminarVoluntarios '1'
GO


----- Buscar Voluntarios -----
Use ACNUR
GO
CREATE PROC SP_BuscarVoluntariosID(@voluntario_id int)
AS
IF(@voluntario_id= '')
   BEGIN
  PRINT 'NO SE PUEDEN INGRESAR VALORES NULOS'
   END
  ELSE
  BEGIN
 if exists(select voluntario_id from voluntarios where voluntario_id = @voluntario_id)
  begin
    select * FROM voluntarios where voluntario_id=@voluntario_id
 END
   ELSE 
   BEGIN
      PRINT 'No se Encontro el Id del Voluntario'
    RETURN
   END
 END
GO

EXEC SP_BuscarVoluntariosID '2'
GO

USE ACNUR
GO
Create Procedure SP_BuscarVoluntarios(@nombre Varchar(50))

As
	Select 
		sedes.sede_id,
		voluntarios.voluntario_id, 
	    voluntarios.cedula, 
	    voluntarios.nombre, 
	    voluntarios.apellido1, 
	    voluntarios.apellido2  
	from voluntarios
		Inner Join sedes On sedes.sede_id = voluntarios.sede_fk
	where voluntarios.nombre = @nombre

Go

EXEC SP_BuscarVoluntarios 'Juan'
GO

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