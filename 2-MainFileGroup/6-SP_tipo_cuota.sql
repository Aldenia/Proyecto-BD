Use ACNUR
go

--Store procedure encaragado de insertar nuevos registros en la tabla tipo_cuotas
Create Procedure insertar_tipo_cuota @tipo Varchar(25), @cantidad int
	As
		Insert Into tipo_cuotas(tipo, cantidad)
		Values (@tipo, @cantidad)
	Go

Execute insertar_tipo_cuota 'Básica', '25'
Go

Use ACNUR
Go
--Store procedure de actualizar registros existentes en la tabla tipo_cuotas
Create Procedure actualizar_tipo_cuota @cuota_id Int,  @tipo Varchar(25), @cantidad int
	As
		Update tipo_cuotas
		set tipo = @tipo,
			cantidad = @cantidad
		Where cuota_id = @cuota_id
	Go

Execute actualizar_tipo_cuota '1', 'Founders edition', '100'
Go
--Stored procedure encargado de eliminar un registro por id en la tabla tipo_cuotas
Create Procedure eliminar_tipo_cuota @cuota_id int
	As
		Delete From tipo_cuotas Where cuota_id = @cuota_id
	Go
