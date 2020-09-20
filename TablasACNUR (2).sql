use master
go
create database ACNUR
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
go



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
go

use ACNUR 
go
Create table envio(
idEnvio integer identity not null,
destino varchar(100) not null,
fecha_env date not null,
voluntario_envio int not null,
idEnvio_material int not null,
constraint PK_idEnvio
PRIMARY KEY(IdEnvio),
)
go

use ACNUR
go
Create table tipo_envio(
idTipo_Envio integer identity not null,
descripcion varchar(100) not null,
constraint PK_idTipo_Envio
PRIMARY KEY(IdTipo_Envio),
)
go

use ACNUR
go
Create table ayuda_material(
idAyudaMaterial integer identity not null,
descripcion varchar(100) not null,
cantidad int not null,
idTipo_Envio int not  null,
idTipo_Unidad int not null,
constraint PK_idAyudaMaterial
PRIMARY KEY(IdAyudaMaterial),
constraint FK_ayuda_material_tipo_envio
FOREIGN KEY(idTipo_Envio) REFERENCES tipo_envio(idTipo_Envio),
constraint FK_ayuda_material_tipo_unidad
FOREIGN KEY(idTipo_Unidad) REFERENCES tipo_unidad(idTipo_unidad)
)
go

use ACNUR 
go
Create table tipo_unidad(
idTipo_Unidad integer identity not null,
descripcion varchar(100) not null,
constraint PK_idTipo_Unidad
PRIMARY KEY(idTipo_Unidad)
)
go