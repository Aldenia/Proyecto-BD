USE MASTER
GO
ALTER DATABASE ACNUR
ADD FILEGROUP Envios 
go


Use Master
GO
ALTER DATABASE ACNUR
ADD FILE
(NAME = 'Voluntatios_Data',
FILENAME = 'C:\PROYECTOBD\Envios_Data.ndf',
SIZE = 500MB,
MAXSIZE = 1GB,
FILEGROWTH = 50MB)
TO FILEGROUP Envios
GO




/*PRIMERA TABLA*/
use ACNUR 
go
Create table envio(
idEnvio integer identity not null,
destino varchar(100) not null,
fecha_env date not null,

constraint PK_idEnvio PRIMARY KEY(IdEnvio),
)
ON Envios
go



/*SEGUNDA TABLA*/
use ACNUR
go
Create table tipo_envio(
idTipo_Envio integer identity not null,
descripcion varchar(100) not null,

constraint PK_idTipo_Envio PRIMARY KEY(IdTipo_Envio),
)
ON Envios
go

/*TERCERA TABLA*/
use ACNUR 
go
Create table tipo_unidad(
idTipo_Unidad integer identity not null,
descripcion varchar(100) not null,

constraint PK_idTipo_Unidad PRIMARY KEY(idTipo_Unidad)
)
ON Envios
go


/*CUARTA TABLA*/
use ACNUR
go
Create table ayuda_material(
idAyudaMaterial integer identity not null,
descripcion varchar(100) not null,
cantidad int not null,
idTipo_Envio int not  null,
idTipo_Unidad int not null,

constraint PK_idAyudaMaterial PRIMARY KEY(IdAyudaMaterial),

constraint FK_ayuda_material_tipo_envio FOREIGN KEY(idTipo_Envio) REFERENCES tipo_envio(idTipo_Envio),

constraint FK_ayuda_material_tipo_unidad FOREIGN KEY(idTipo_Unidad) REFERENCES tipo_unidad(idTipo_unidad)
)
ON Envios
go



/*QUINTA*/
use ACNUR 
go
Create table envio_material(
idEnvioMaterial integer identity not null,
idEnvio int not null,
idAyudaMaterial int not null,

constraint PK_idEnvioMaterial
PRIMARY KEY(idEnvioMaterial),

constraint FK_envio_material_envio
FOREIGN KEY(idEnvio) REFERENCES envio(idEnvio),

constraint FK_envio_material_ayuda_material
FOREIGN KEY(idAyudaMaterial) REFERENCES ayuda_material(idAyudaMaterial),
)
ON Envios
go



/*SEXTA*/
use ACNUR 
go
Create table envio_voluntario(
idEnv_Voluntatio integer identity not null,
idVoluntario int not null,
idEnvio int null,

constraint idEnv_Voluntatio PRIMARY KEY(idEnv_Voluntatio),

constraint idVoluntario FOREIGN KEY(idVoluntario) REFERENCES voluntarios(voluntario_id),

constraint idEnvio FOREIGN KEY(idEnvio) REFERENCES envio(idEnvio)
)
ON Envios
go



use ACNUR  
go
Create table envio_sede(
idEnvio_Sede integer identity not null,
idEnvio int not null,
idSede int not null,
constraint PK_id
PRIMARY KEY(idEnvio_Sede),
constraint FK_envioSede_envio
FOREIGN KEY(idEnvio) REFERENCES envio(idEnvio),
CONSTRAINT FK_envio_sede_sede
FOREIGN KEY(idSede) REFERENCES sede(idSede)
)
ON Envios
go