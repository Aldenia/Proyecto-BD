Use ACNUR
go

Select sedes.nombre_sede, SUM(tipo_cuotas.cantidad) As Monto from socios
	inner join sedes
	on sedes.sede_id = socios.sede_fk
	inner join tipo_cuotas
	on tipo_cuotas.cuota_id = socios.tipo_cuota_fk
	Group By sedes.nombre_sede