Use ACNUR
Go
--Insertar en tabla socios
Create Procedure insertar_socio @nombre Varchar(25), @apellido1 Varchar(25), @apellido2 Varchar(25), 
								@direccion Varchar(200), @fecha_pago Date, @cuanta_bancaria Int,
								@tipo_cuota_fk Int, @sede_fk Int
As
	Insert Into socios (nombre, apellido1, apellido2, direccion, fecha_pago, cuanta_bancaria, tipo_cuota_fk, sede_fk)
	Values (@nombre, @apellido1, @apellido2, @direccion, @fecha_pago, @cuanta_bancaria, @tipo_cuota_fk,@sede_fk)
Go

--listar los socios existentes
Create Procedure listar_socios

As
	Select 
	sedes.sede_id,
	sedes.nombre_sede,
	socios.socio_id, 
	socios.nombre, 
	socios.apellido1, 
	socios.apellido2, 
	socios.direccion, 
	cuotas.cuota_id, 
	cuotas.tipo, 
	cuotas.cantidad, 
	socios.cuanta_bancaria, 
	socios.fecha_pago  
	from socios
	Inner Join sedes On sedes.sede_id = socios.sede_fk
	Inner Join tipo_cuotas cuotas On cuotas.cuota_id = socios.tipo_cuota_fk

Go

--busca los socios existentes
Create Procedure buscar_socios @nombre Varchar(25)

As
	Select 
	sedes.sede_id,
	sedes.nombre_sede,
	socios.socio_id, 
	socios.nombre, 
	socios.apellido1, 
	socios.apellido2, 
	socios.direccion, 
	cuotas.cuota_id, 
	cuotas.tipo, 
	cuotas.cantidad, 
	socios.cuanta_bancaria, 
	socios.fecha_pago  
	from socios
	Inner Join sedes On sedes.sede_id = socios.sede_fk
	Inner Join tipo_cuotas cuotas On cuotas.cuota_id = socios.tipo_cuota_fk
	where socios.nombre = @nombre

Go

--borra socio existente
Create Procedure borrar_socio @socio_id int

As
	Delete from socios
	Where socios.socio_id = @socio_id

Go

