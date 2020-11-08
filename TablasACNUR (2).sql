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

/*SEXTA*/
use ACNUR 
go
Create table envio_voluntarios(
	idEnv_Voluntatio integer identity not null,
	idVoluntario int not null,
	idEnvio int not null,
	constraint idEnv_Voluntatio PRIMARY KEY(idEnv_Voluntatio),
	constraint idVoluntario FOREIGN KEY(idVoluntario) REFERENCES voluntarios(voluntario_id),
	constraint idEnvio FOREIGN KEY(idEnvio) REFERENCES envios(idEnvio) ON DELETE CASCADE
)
ON Envios
go

use ACNUR  
go
Create table envio_sedes(
	idEnvio_Sede integer identity not null,
	idEnvio int not null,
	idSede int not null,
	constraint PK_id PRIMARY KEY(idEnvio_Sede),
	constraint FK_envioSede_envio FOREIGN KEY(idEnvio) REFERENCES envios(idEnvio) ON DELETE CASCADE,
	CONSTRAINT FK_envio_sede_sede FOREIGN KEY(idSede) REFERENCES sedes(sede_id)
)
ON Envios
go


/*TERCERA TABLA*/
use ACNUR 
go
Create table producto_envios(
	idProducto_ayuda integer identity not null,
	cantidad integer,
	producto_fk int not null,
	envio_fk int not null,
	constraint PK_idTipo_Unidad PRIMARY KEY(idProducto_ayuda),
	constraint producto_fk foreign key (producto_fk) references productos(idProducto)ON DELETE CASCADE,
	constraint envio_fk foreign key (envio_fk) references envios(idEnvio)ON DELETE CASCADE
)
ON Envios
go


use acnur
go
create table productos(
	idProducto integer identity not null,
	descripcion varchar(50),
	tipoEnv_fk integer  not null,
	constraint PK_idProducto primary key (idProducto),
	constraint tipoEnv_fk foreign key (tipoEnv_fk) references tipo_envios(idTipoEnv)
)
on Envios
go







use acnur 
go
create table tipo_envios(
	idTipoEnv int identity not null,
	descripcion varchar(30) not null,
	constraint pk_tipo_envio primary key (idTipoEnv)
)
on envios
go

 


 --SP LISTAR

 --SP CONSULTAR

 --SP AGREGAR

 --SP ACTUALIZAR 

 --SP ELIMINAR

