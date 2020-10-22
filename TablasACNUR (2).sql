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
	idDetalle integer identity not null,
	detalle varchar(100) not null,
	cantidad float,
	tipo_envio int not null,
	unidad_fk int not null,
	constraint PK_idTipo_Unidad PRIMARY KEY(idDetalle),
	constraint fk_tipo_envio foreign key (tipo_envio) references tipo_envio(tipo_id),
	constraint fk_unidad foreign key (unidad_fk) references tipo_unidad(unidad_id)
)
ON Envios
go


/*CUARTA TABLA*/
use ACNUR
go
Create table ayuda_material(
	idAyudaMaterial integer identity not null,
	idEnvio integer not null,
	idDetalle int not null,
	constraint FK_envio_material_envio FOREIGN KEY(idEnvio) REFERENCES envios(idEnvio),
	constraint FK_detalle_material_envio FOREIGN KEY(idDetalle) REFERENCES detalle(idDetalle),
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
	constraint idEnvio FOREIGN KEY(idEnvio) REFERENCES envios(idEnvio)
)
ON Envios
go



use ACNUR  
go
Create table envio_sede(
	idEnvio_Sede integer identity not null,
	idEnvio int not null,
	idSede int not null,
	idDescripcion int not null,
	constraint PK_id PRIMARY KEY(idEnvio_Sede),
	constraint FK_envioSede_envio FOREIGN KEY(idEnvio) REFERENCES envios(idEnvio),
	CONSTRAINT FK_envio_sede_sede FOREIGN KEY(idSede) REFERENCES sedes(sede_id)
)
ON Envios
go



use acnur 
go
create table tipo_envio(
	tipo_id int identity not null,
	descripcion varchar(25) not null,
	constraint pk_tipo_envio primary key (tipo_id)
)
on envios
go

use acnur 
go
create table tipo_unidad(
	unidad_id int identity not null,
	descripcion varchar(25) not null,
	constraint pk_unidad primary key (unidad_id)
)
on envios
go