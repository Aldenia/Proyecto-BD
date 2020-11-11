--Actualizar envio
use acnur 
go
Create Procedure actualizar_envios
				 @idEnvio integer , 
				 @destino varchar(100),
				 @fecha_env date,
				 @PK_idEnvio int
As
	Update envios
	set 
	destino = @destino,
	fecha_env = @fecha_env, 
    idEnvio= @PK_idEnvio
	Where	idEnvio = @idEnvio

Go

--Actualizar envio-voluntario
use acnur
go
Create Procedure actualizar_envio_voluntario
				 @idEnv_Voluntario int,
				 @id_Voluntario int,
				 @idEnvio int
As
	Update envio_voluntario
	set 
	id_Voluntario = @id_Voluntario,
	idEnvio = @idEnvio
	Where idEnv_Voluntario = @idEnv_Voluntario
Go

--Actualizar envio_sede 
use acnur
go
Create Procedure actualizar_envio_sedes
				 @idEnvio_Sede int,
				 @idEnvio int,
				 @idSede int
			
As
	Update envios_sedes
	set 
	idEnvio = @idEnvio,
	idSede = @idSede
	Where	idEnvio_Sede = @idEnvio_Sede

Go

--Actualizar productos_envios
use acnur
go
Create Procedure actualizar_productos_envios
				 @idProducto_ayuda int, 
				 @cantidad int,
				 @producto_fk int,
				 @envio_fk int
As
	Update productos_envios
	set 
	cantidad = @cantidad,
	producto_fk = @producto_fk,
	envio_fk = @envio_fk
	Where	idProducto_ayuda = @idProducto_ayuda
Go


--Actualizar productos
use acnur 
go
Create Procedure actualizar_productos
				 @id int, 
				 @descripcion varchar (25),
				 @tipoEnv_fk int
As
	Update productos
	set 
	descripcion= @descripcion,
	tipoEnv_fk = @tipoEnv_fk
	Where	id = @id
Go







