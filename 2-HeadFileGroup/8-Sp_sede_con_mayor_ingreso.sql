Use ACNUR
go
--Stored procedure sedes con más ingresos
Create Procedure sedes_mayor_ingresos
	As
		Select sedes.nombre_sede,SUM(tipo_cuotas.cantidad) Monto from socios
		inner join sedes
		on sedes.sede_id = socios.sede_fk
		inner join tipo_cuotas
		on tipo_cuotas.cuota_id = socios.tipo_cuota_fk
		Group By sedes.nombre_sede
		Order by Monto Desc
	Go

--Stored procedure cantidad de socios y sus cuotas
Create procedure cantidad_socios_por_cuota
	As
		Select tipo_cuotas.tipo As cuota, Count(socios.socio_id) As cantidad_socios from socios
		inner join tipo_cuotas
		on tipo_cuotas.cuota_id = socios.tipo_cuota_fk
		Group by tipo_cuotas.tipo
		Order by cantidad_socios Desc
	Go
