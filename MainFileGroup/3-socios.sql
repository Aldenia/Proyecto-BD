Use ACNUR
Go

Create Table socios
(
	socio_id Int Identity(1,1) not null,
	nombre Varchar(25) not null,
	apellido1 Varchar(25) not null,
	apellido2 Varchar(25) not null,
	direccion Varchar(200) not null,
	fecha_pago Date not null,
	cuanta_bancaria Int not null,
	tipo_cuota_fk Int not null,
	sede_fk Int not null,
	--Constraints
	--PK
	Constraint PK_Docios Primary key Clustered(socio_id),
	--FK
	Constraint FK_socios_cuota Foreign Key(tipo_cuota_fk) References tipo_cuotas(cuota_id),
	Constraint FK_socios_sede Foreign Key(sede_fk) References sedes(sede_id)
) on MAIN_DATA_FILEGROUP
Go