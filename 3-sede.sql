Use ACNUR
Go

Create Table sedes
(
	sede_id int Identity(1,1) not null,
	socio_fk Int not null,
	domicilio Varchar (100) not null,
	nombre_director Varchar(15) not null,
	apellido1 Varchar(15) not null,
	apellido2 Varchar(15) not null,
	--Constraints
	--PK
	Constraint PK_sedes Primary key Clustered(sede_id)
) on MAIN_DATA_FILEGROUP

Go