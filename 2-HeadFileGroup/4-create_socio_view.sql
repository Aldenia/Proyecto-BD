
Use ACNUR
Go

Create View View_tipo_cuota_socio
As
	Select
		cuota_id,
		tipo
	From
		tipo_cuotas
Go

Use ACNUR
Go

Create View View_sede_socio
As
	Select
		sede_id,
		nombre_sede
	From sedes
Go

execute SP_lista