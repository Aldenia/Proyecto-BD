Use ACNUR
Go

--Insertar un nuevo registro en la tabla sedes
Create Procedure insertar_sede 
	@nombre_sede Varchar(100),
	@domicilio Varchar(100), 
	@nombre_director Varchar(15), 
	@apellido1 Varchar(15),
	@apellido2 Varchar(15)
	
	As 
		Insert Into sedes
		(
			nombre_sede, 
			domicilio, 
			nombre_director,
			apellido1,
			apellido2
		)
		Values
		(
			@nombre_sede, 
			@domicilio, 
			@nombre_director, 
			@apellido1, 
			@apellido2
		)
	Go

Execute insertar_sede 'Silicon Valley ACNUR Headquarters', 'California, San francisco, Silicon Valey', 'Elon', 'Reeve','Musk'
Go

--Stored Procedure para actualizar registros en la tabla sedes
Create Procedure actualizar_sede
				 @sede_id int,
				 @nombre_sede Varchar(100),
				 @domicilio Varchar(100), 
				 @nombre_director Varchar(15), 
				 @apellido1 Varchar(15),
				 @apellido2 Varchar(15)
	As
		Update sedes 
		set
		nombre_sede = @nombre_sede, 
		domicilio = @domicilio, 
		nombre_director = @nombre_director,
		apellido1 = @apellido1,
		apellido2 = @apellido2
		Where sede_id = @sede_id
	Go

Execute actualizar_sede '1', 'ACNUR Silicon Valley HeadQuarters', 'California, San francisco, Silicon Valey', 'Elon', 'Reeve','Musk'
Go

--Stored procedure para eliminar sede
Create Procedure eliminar_sede @sede_id int
	As
		Delete From sedes
		Where sede_id = @sede_id
	Go

--Stored Procedure para listar las sedes
Create Procedure SP_listar_sedes
	As
		select * from sedes;
	Go