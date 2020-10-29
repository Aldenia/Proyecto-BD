Use ACNUR
Go

Create Procedure insertar_socio @nombre Varchar(25), @apellido1 Varchar(25), @apellido2 Varchar(25), 
								@direccion Varchar(200), @fecha_pago Date, @cuanta_bancaria Int,
								@tipo_cuota_fk Int, @sede_fk Int
As
	Insert Into socios (nombre, apellido1, apellido2, direccion, fecha_pago, cuanta_bancaria, tipo_cuota_fk, sede_fk)
	Values (@nombre, @apellido1, @apellido2, @direccion, @fecha_pago, @cuanta_bancaria, @tipo_cuota_fk,@sede_fk)
Go