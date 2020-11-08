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
	idEnv_Voluntario integer identity not null,
	voluntario_fk int not null,
	envio_fk int not null,
	constraint idEnv_Voluntatio PRIMARY KEY(idEnv_Voluntario),
	constraint voluntario_fk FOREIGN KEY(voluntario_fk) REFERENCES [Anthony].[voluntarios](voluntario_id),
	constraint envio_fk FOREIGN KEY(envio_fk) REFERENCES [Rebeca].[envios](idEnvio) ON DELETE CASCADE
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




--lista las sedes que participan en un envio 
 use acnur
 go
 create procedure sp_sedes_envio(@id_sede int)
 as
	 begin

		 select sedes.domicilio as 'sedes' from sedes
		 inner join envio_sedes on sedes.sede_id = envio_sedes.idSede
		 inner join envios on envios.idEnvio = envio_sedes.idEnvio where sedes.sede_id = 3
 
	 end
 go

 --exec sp_listar_envio '1'
 --sp lista los productos del envio por id
 use acnur 
 go
 create procedure sp_listar_envio(@id_envio int)
 as
	if((@id_envio = ''))
		begin
			PRINT 'Inserte un dato'
		return
	end
	else 
		begin
			if not exists (select @id_envio from envios where envios.idEnvio = @id_envio)
				begin 
					print 'El envio a constultar no existe'
				return
			end
			else
				--lista la ayuda material segun el id del envio
				if exists (select producto_envios.idProducto_ayuda from producto_envios where producto_envios.envio_fk = @id_envio)
					begin
						 select envios.destino,productos.descripcion,producto_envios.cantidad,tipo_envios.descripcion
						 from envios 
						 inner join producto_envios on envios.idEnvio = producto_envios.envio_fk
						 inner join productos on producto_envios.producto_fk = productos.idProducto
						 inner join tipo_envios on tipo_envios.idTipoEnv = productos.tipoEnv_fk
						 where envios.idEnvio = @id_envio
					end
				else 
					begin
						print 'El envio no cuenta con ayuda ayuda material'
					end
				--lista el envio voluntariado segun el id del envio
				if exists (select envio_voluntarios.idEnvio from envio_voluntarios where envio_voluntarios.idEnvio = @id_envio)
					begin 
						select envios.destino,voluntarios.nombre,voluntarios.apellido1,voluntarios_H.cantidad_de_trabajos,voluntarios_H.profesion,
						CASE
							WHEN voluntarios_H.disponibilidad > 0 THEN 'Disponible'
							WHEN voluntarios_H.disponibilidad = 0 THEN 'No disponible'
							ELSE 'Error'
						END AS disponibilidad
						from envios
						inner join envio_voluntarios on envios.idEnvio = envio_voluntarios.idEnvio
						inner join voluntarios on envio_voluntarios.idVoluntario = voluntarios.voluntario_id
						inner join voluntarios_H on voluntarios_H.voluntarioH_id = voluntarios.voluntario_id
						where envio_voluntarios.idEnvio = @id_envio
					end
				else 
					begin
						print 'El envio no cuenta con ayuda ayuda material'
					end
		end
 go


Use ACNUR
Go
--Insertar un nuevo registro en la tabla envío sedes
Create Procedure insertar_envio_sedes 
	@EsIdEnvio_Sede int,
	@EsIdEnvio int,
    @EsIdSede int
	
	As 
		Insert Into envio_sedes(idEnvio_Sede,idEnvio,idSede)
		Values(@EsIdEnvio_Sede,@EsIdEnvio,@EsIdSede)
	Go

USE ACNUR
GO
EXeC insertar_envio_sedes '','',''
Go




Use ACNUR
GO
--Insertar un nuevo registro en la tabla envíos
Create Procedure insertar_envio 
	@EsId int,
	@EsDestino varchar(30),
	@Esfecha_env varchar(30)
	
	As 
		if exists(select envios.idEnvio from envios where envios.idEnvio = @EsId) --valida si el envio existe
			begin
				print 'El envio ya existe'
			return
			end
		else 
			begin
					Insert Into envios(destino,fecha_env)
					Values(@EsDestino,@Esfecha_env)
					print 'Agregado correctamente'
			end
	Go

Execute insertar_envio '3', 'prueba', '12/12/12'
Go

use ACNUR
select * from envios
go



Use ACNUR
GO
--Insertar un nuevo registro en la tabla producto envíos
Create Procedure insertar_producto_envios 
	@EsIdProducto_ayuda int,
	@EsCantidad int,
	@EsProducto_fk int,
	@EsEnvio_fk int
	
	As 
		if exists (select producto_envios.idProducto_ayuda from producto_envios where producto_envios.idProducto_ayuda = @EsIdProducto_ayuda)
			begin
				print 'El producto ya ha sido agregado anteriormente'
			return
		end
		else
			begin
				Insert Into producto_envios(cantidad,producto_fk,envio_fk)
				Values(@EsCantidad,@EsProducto_fk,@EsEnvio_fk)
				print 'Producto agregado'
			end
	Go

Execute insertar_producto_envios '', '10', '10', '1'
Go


Use ACNUR
GO
--Insertar un nuevo registro en la tabla productos
Create Procedure insertar_productos 
	@EsIdProducto int,
	@EsDescripcion varchar(30),
	@EsTipoEnv_fk int
	
	As 
		if exists(select productos.descripcion from productos where TRIM(productos.descripcion) = TRIM(@EsDescripcion))
			begin
				print 'El producto ya ha sido agregado'
				return
			end
		else 
			begin
				Insert Into productos(descripcion,tipoEnv_fk)
				Values(TRIM(@EsDescripcion),@EsTipoEnv_fk)
				print 'Producto agregado correctamente'
			end
		
	Go

Execute insertar_productos '', '', ''
Go


Use ACNUR
GO
--Insertar un nuevo registro en la tabla tipo envíos
Create Procedure insertar_tipo_envios 
	@EsIdTipoEnv int,
	@EsDescripcion varchar(200)
	
	As 
		if exists(select tipo_envios.descripcion from tipo_envios where tipo_envios.descripcion = @EsDescripcion)
			begin
				print 'El tipo de envio ya ha sido agregado'
				return
			end
		else
			begin
					Insert Into tipo_envios(descripcion)
					Values(@EsDescripcion)
					print 'Tipo de envio agregado correctamente'
			end
	
	Go

Execute insertar_tipo_envios '', 'alimentos  sa'
Go

Use ACNUR
GO
--Insertar un nuevo registro en la tabla envío voluntarios
Create Procedure insertar_envio_voluntarios 
	@EsIdEnv_Voluntario int,
	@EsIdVoluntario int,
	@EsIdEnvio int
	
	As
		
		if exists(select envio_voluntarios.idVoluntario, envio_voluntarios.idEnvio from envio_voluntarios where (envio_voluntarios.idVoluntario = @EsIdVoluntario) and (envio_voluntarios.idEnvio = @EsIdEnvio))
			begin
				print 'El voluntario ya ha sido agregado al envio'
			return
		end
		begin
			Insert Into envio_voluntarios(idVoluntario,idEnvio)
			Values(@EsIdVoluntario,@EsIdEnvio)
			print 'Voluntario agregado'
		end
		
	Go

Execute insertar_envio_voluntarios'', '3', '2'
Go



 --SP ACTUALIZAR 

 --SP ELIMINAR

