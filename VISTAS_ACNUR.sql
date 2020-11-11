
-------------------------------------VISTAS VIVI,RENI--------------------------------------------

Use ACNUR
Go
Create View View_envios
As
	Select
		idEnvio,
		destino,
		fecha_env
	From
		envios
go

Use ACNUR
Go
Create View View_producto_envios
As
	Select
		idProducto_ayuda,
		cantidad,
		producto_fk,
		envio_fk
	From
		producto_envios
go

Use ACNUR
Go
Create View View_productos
As
	Select
		idProducto,
		descripcion,
		tipoEnv_fk
	From
		productos
go



Use ACNUR
Go
Create View View_tipo_envios 
As
	Select
		idTipoEnv,
		descripcion
	From
		tipo_envios
go
-------------------------------------FIN VISTAS VIVI,RENI--------------------------------------------