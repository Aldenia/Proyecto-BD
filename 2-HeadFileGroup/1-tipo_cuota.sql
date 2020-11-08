Use ACNUR
Go
Create Table tipo_cuotas
(
	cuota_id Int Identity(1,1) not null,
	tipo Varchar(25) not null,
	cantidad Int not null,
	--Constraints
	--PK
	Constraint PK_tipo_cuotas Primary Key Clustered(cuota_id)
) on HEAD_DATA_FILEGROUP
Go
