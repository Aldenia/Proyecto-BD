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
FILENAME = 'C:\SQLData\Vol01_Data.ndf',
SIZE = 500MB,
MAXSIZE = 1GB,
FILEGROWTH = 50MB)
TO FILEGROUP voluntarios
GO

--Creacion de las tablas
Use ACNUR
Create Table tipo_voluntarios
(
	tipo_vol_id int Identity (1,1),
	tipo int not null,
	--Constraints
	--PK
	Constraint PK_tipo_vol Primary Key Clustered (tipo_vol_id)
)
ON voluntarios
Go

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
	tipo_vol_fk int not null,
	--Constraints
	--PK
	Constraint PK_voluntarios Primary Key Clustered (voluntario_id),
	--FK
	Constraint FK_tipo_voluntarios Foreign Key (tipo_vol_fk) references tipo_voluntarios (tipo_vol_id)
	
)
ON voluntarios
Go

Create Table voluntarios_H
(
	voluntarioH_id int Identity (1,1),
	profesion Varchar(25) unique not null,
	disponibilidad bit not null,
	apellido1 Varchar(25) not null,
	apellido2 Varchar(25) not null,
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

Create Table voluntarios_A
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

