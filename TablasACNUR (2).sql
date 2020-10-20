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
Create table envios(
	idEnvio integer identity not null,
	destino varchar(100) not null,
	fecha_env date not null,
	constraint PK_idEnvio PRIMARY KEY(idEnvio)
)
ON Envios
go



/*TERCERA TABLA*/
use ACNUR 
go
Create table detalle(
	idDescripcion integer identity not null,
	descripcion varchar(100) not null,
	cantidad float,
	unidad varchar(50) not null,
	tipo varchar(30) not null,
	constraint PK_idTipo_Unidad PRIMARY KEY(idDescripcion)
)
ON Envios
go


/*CUARTA TABLA*/
use ACNUR
go
Create table ayuda_material(
	idAyudaMaterial integer identity not null,
	idEnvio integer not null,
	constraint FK_envio_material_envio FOREIGN KEY(idEnvio) REFERENCES envios(idEnvio),
	constraint PK_idAyudaMaterial PRIMARY KEY(IdAyudaMaterial)
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
	constraint PK_id PRIMARY KEY(idEnvio_Sede),
	constraint FK_envioSede_envio FOREIGN KEY(idEnvio) REFERENCES envio(idEnvio),
	CONSTRAINT FK_envio_sede_sede FOREIGN KEY(idSede) REFERENCES sedes(sede_id)
)
ON Envios
go



use acnur 
go
create table detalle_ayuda(
	idDescripcionAyuda int identity not null,
	descripcion_fk int not null,
	ayuda_fk int not null,
	constraint pk_unidad_ayuda primary key (idDescripcionAyuda),
	constraint fk_Ayuda_M foreign key (ayuda_fk) references ayuda_material(idAyudaMaterial),
	constraint fk_descripcion foreign key (descripcion_fk) references detalle(idDescripcion)
)
on envios
go