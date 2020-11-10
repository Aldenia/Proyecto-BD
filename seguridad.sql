--seguridad
use master
go
use acnur
go
create table seguridad_envios
(
	idEnvio integer  not null,
	destino varchar(100) not null,
	fecha_env date not null,
	Fecha			DATE NOT NULL,
	Usuario			VARCHAR(70),
	Detalle         VARCHAR(70)
)
go

use acnur 
go
create trigger tr_insertEnvio
on envios
	for insert
as
	begin 
		set nocount on;
		insert into seguridad_envios(idEnvio,destino,fecha_env,Fecha,Usuario,Detalle)
		select idEnvio,destino,fecha_env,GETDATE(),SYSTEM_USER,'DATO INSERTADO EN LA TABLA ENVIOS'
		FROM inserted
	end
go

use acnur
go
create trigger tr_eliminarEnvio
on envios
	FOR DELETE
as
	begin
		set NOCOUNT on;
		insert into seguridad_envios(idEnvio,destino,fecha_env,Fecha,Usuario,Detalle)
		select idEnvio,destino,fecha_env,GETDATE(),SYSTEM_USER,'DATO ELIMINADO EN LA TABLA ENVIOS'
		FROM deleted
	end
go

use acnur
go
create trigger tr_editarEnvio
on envios
	for	UPDATE
as
	begin
		update seguridad_envios set 
			destino = E.destino,
			fecha_env = E.fecha_env,
			Fecha = E.fecha,
			Usuario = E.usuario,
			Detalle = E.detalle
			from seguridad_envios as E inner join inserted as Env
			on E.idEnvio = Env.idEnvio
			set nocount on;
			insert into seguridad_envios(idEnvio,destino,fecha_env,Fecha,Usuario,Detalle)
			select idEnvio,destino,fecha_env,GETDATE(),SYSTEM_USER,'DATO EDITADO EN LA TABLA ENVIOS'
			FROM inserted
	end
go


use acnur
go 
create table seguridad_envio_voluntarios(
	
	idEnv_Voluntario integer  not null,
	voluntario_fk int not null,
	envio_fk int not null,
	Fecha				date not null ,
	Usuario				VARCHAR(70),
	Detalle				VARCHAR(70)

)
go

use acnur 
go
create trigger tr_insertar_envio_voluntarios
on envio_voluntarios
	for insert 
as
	begin
		insert into seguridad_envio_voluntarios(idEnv_Voluntario,voluntario_fk,envio_fk,Fecha,Usuario,Detalle)
		select idEnv_Voluntario,voluntario_fk,envio_fk,getdate(),SYSTEM_USER,'DATO INSERTADO EN LA TABLA TPO DE ENVIO_SEDE'
		from inserted
	end
go

use acnur 
go 
create trigger tr_eliminar_envio_voluntarios
on envio_voluntarios
for delete
as
	begin
		insert into seguridad_envio_voluntarios(idEnv_Voluntario,voluntario_fk,envio_fk,Fecha,Usuario,Detalle)
		select idEnv_Voluntario,voluntario_fk,envio_fk,getdate(),SYSTEM_USER,'DATO INSERTADO EN LA TABLA TPO DE ENVIO_SEDE'
		from deleted
	end
go

use acnur
go
create trigger tr_editar_envio_voluntario
on envio_voluntarios
for update
as
	begin 
		update seguridad_envio_voluntarios set
		Fecha = Env.fecha,
		Usuario = Env.usuario,
		Detalle = Env.detalle
		from seguridad_envio_voluntarios as Env inner join inserted as E
		on Env.idEnv_Voluntario = E.idEnv_Voluntario
		set nocount on;
		insert into seguridad_envio_sedes(Fecha,Usuario,Detalle)
		select getdate(),SYSTEM_USER,'DATO EDITADO EN LA TABLA TPO DE ENVIO_SEDE'
		from inserted
	end
go


use ACNUR  
go
Create table seguridad_envio_sedes(
	idEnvio_Sede integer  not null,
	idEnvio int not null,
	idSede int not null,
	Fecha DATE not null,
	Usuario VARCHAR(70),
	Detalle VARCHAR(70)
)
go

use acnur 
go
create trigger tr_insertar_envio_sede
on envio_sedes
for insert
as	
	begin
		set nocount on;
		insert into seguridad_envio_sedes(idEnvio_Sede,idEnvio,idSede,Fecha,Usuario,Detalle)
		select idEnvio_Sede,idEnvio,idSede,GETDATE(),SYSTEM_USER,'DATO INSERTADO EN LA TABLA ENVIOS SEDES'
		from inserted
	end
go

use acnur 
go
create trigger tr_eliminar_envio_sedes
on envio_sedes
for delete
as
	begin
		set nocount on;
		insert into seguridad_envio_sedes(idEnvio_Sede,idEnvio,idSede,Fecha,Usuario,Detalle)
		select idEnvio_Sede,idEnvio,idSede,GETDATE(),SYSTEM_USER,'DATO INSERTADO EN LA TABLA ENVIOS SEDES'
		from deleted
	end
go


use acnur 
go
create table seguridad_producto_envios
(
	idProducto_ayuda integer  not null,
	cantidad integer,
	producto_fk int not null,
	envio_fk int not null,
	 Fecha DATE NOT NULL,
	 Usuario  VARCHAR(70),
	 Detalle VARCHAR(70)
)
go

use acnur 
go
create trigger tr_ingresar_producto_envios
on producto_envios
for insert 
as
	begin
		SET NOCOUNT ON; 
		insert into seguridad_producto_envios(idProducto_ayuda,cantidad,producto_fk,envio_fk,Fecha,Usuario,Detalle)
		select idProducto_ayuda,cantidad,producto_fk,envio_fk,GETDATE(),SYSTEM_USER,'DATO INSERTADO EN LA TABLA PRODUCTOS ENVIO'
		FROM inserted
	end
go

use acnur 
go
create trigger tr_eliminar_producto_envios
on producto_envios
for delete
as
	begin
		SET NOCOUNT ON; 
		insert into seguridad_producto_envios(idProducto_ayuda,cantidad,producto_fk,envio_fk,Fecha,Usuario,Detalle)
		select idProducto_ayuda,cantidad,producto_fk,envio_fk,GETDATE(),SYSTEM_USER,'DATO INSERTADO EN LA TABLA PRODUCTOS ENVIO'
		FROM deleted
	end
go

use acnur
go
create trigger tr_editar_producto_envios
on producto_envios
for update
as
	begin 
		update seguridad_producto_envios set
			cantidad = P.cantidad,
			Fecha = P.fecha,
			Usuario = P.usuario,
			Detalle = P.detalle
			from seguridad_producto_envios as P inner join inserted as Prod
			on P.idProducto_ayuda = Prod.idProducto_ayuda
			set nocount on;
			insert into seguridad_producto_envios(idProducto_ayuda,cantidad,producto_fk,envio_fk,Fecha,Usuario,Detalle)
			select idProducto_ayuda,cantidad,producto_fk,envio_fk,GETDATE(),SYSTEM_USER,'DATO INSERTADO EN LA TABLA PRODUCTOS ENVIO'
			FROM inserted
	end
go

use acnur
go
create table seguridad_productos
(
	idProducto integer  not null,
	descripcion varchar(50),
	tipoEnv_fk integer  not null,
	Fecha DATE NOT NULL,
	 Usuario  VARCHAR(70),
	 Detalle VARCHAR(70)
)
go

use acnur 
go
create trigger tr_ingresar_producto
on productos
for insert
as 
	begin
		set nocount on;
		insert into seguridad_productos(idProducto,descripcion,tipoEnv_fk,Fecha,Usuario,Detalle)
		select idProducto,descripcion,tipoEnv_fk,GETDATE(),SYSTEM_USER,'SE INSERTO UN DATO EN LA TABLA PRODUCTO'
		from inserted
	end
go
exec insertar_productos '','prueba','9'
use acnur 
go
create trigger tr_eliminar_envio
on productos
for delete
as
	begin
		SET NOCOUNT ON; 
		insert into seguridad_productos(idProducto,descripcion,tipoEnv_fk,Fecha,Usuario,Detalle)
		select idProducto,descripcion,tipoEnv_fk,GETDATE(),SYSTEM_USER,'SE INSERTO UN DATO EN LA TABLA PRODUCTO'
		from deleted
	end
go

create trigger tr_editar_producto
on productos
for update
as
	begin
		update seguridad_productos set
		descripcion = P.Descripcion
		from seguridad_productos as P inner join inserted as Prod
		on P.idProducto = Prod.idProducto
		set nocount on;
		insert into seguridad_productos(idProducto,descripcion,tipoEnv_fk,Fecha,Usuario,Detalle)
		select idProducto,descripcion,tipoEnv_fk,GETDATE(),SYSTEM_USER,'SE EDITO UN DATO EN LA TABLA PRODUCTO'
		from inserted
	end
go 

use acnur
go 
create table seguridad_tipo_envios
(
	idTipoEnv int  not null,
	descripcion varchar(30) not null,
	Fecha          DATE NOT NULL,
	Usuario        VARCHAR(70),
	Detalle        VARCHAR(70)
)
go

use acnur 
go
create trigger tr_ingresar_tipo_envios
on tipo_envios
for insert 
as
	begin
		set nocount on;
		insert into seguridad_tipo_envios(idTipoEnv,descripcion,Fecha,Usuario,Detalle)
		select idTipoEnv,descripcion,GETDATE(),SYSTEM_USER,'DATO INSERTADO EN LA TABLA TIPO ENVIO'
		from inserted
	end
go

use acnur
go
create trigger tr_eliminar_tipo_envio
on tipo_envios
for delete 
as
	begin
		set nocount on;
		insert into seguridad_tipo_envios(idTipoEnv,descripcion,Fecha,Usuario,Detalle)
		select idTipoEnv,descripcion,GETDATE(),SYSTEM_USER,'DATO ELIMINADO EN LA TABLA TIPO ENVIO'
		from deleted
	end
go 

use acnur
go
create trigger tr_editar_tipo_envio
on tipo_envios
for update
as 
	begin
		update seguridad_tipo_envios set
		descripcion = E.descripcion
		from seguridad_tipo_envios as E inner join inserted as Env
		on E.idTipoEnv = Env.idTipoEnv
		set nocount on;
		insert into seguridad_tipo_envios(idTipoEnv,descripcion,Fecha,Usuario,Detalle)
		select idTipoEnv,descripcion,GETDATE(),SYSTEM_USER,'DATO ACTUALIZADO EN LA TABLA TIPO ENVIO'
		FROM inserted
	end
go



use acnur 
go 
create table seguridad_tipo_cuotas
(
	cuota_id Int not null,
	tipo Varchar(25) not null,
	cantidad Int not null,
	Fecha          DATE NOT NULL,
	Usuario        VARCHAR(70),
	Detalle        VARCHAR(70)
)
go

use acnur 
go
create trigger tr_agregar_tipo_cuota
on tipo_cuotas
for insert
as
	begin
		set nocount on;
		insert into seguridad_tipo_cuotas(cuota_id,tipo,cantidad,Fecha,Usuario,Detalle)
		select cuota_id,tipo,cantidad,GETDATE(),SYSTEM_USER,'DATO INSERTADO EN LA TABLA TIPO DE CUOTAS'
		from inserted
	end
go

use acnur 
go
create trigger tr_eliminar_tipo_cuota
on tipo_cuotas
for delete
as
	begin
		SET NOCOUNT ON;
		insert into seguridad_tipo_cuotas(cuota_id,tipo,cantidad,Fecha,Usuario,Detalle)
		select cuota_id,tipo,cantidad,GETDATE(),SYSTEM_USER,'DATO ELIMINADO EN LA TABLA TIPO DE CUOTAS'
		from deleted
	end
go

use acnur 
go
create trigger tr_editarTipo_envio
on tipo_cuotas
for update
as
	begin
		update seguridad_tipo_cuotas set
			tipo = C.tipo,
			cantidad  = C.cantidad,
			Fecha = C.fecha,
			Usuario = C.usuario,
			Detalle = C.detalle
			from seguridad_tipo_cuotas as C inner join inserted as Cuota
			on C.cuota_id = Cuota.cuota_id
			SET NOCOUNT ON; 
			insert into seguridad_tipo_cuotas(cuota_id,tipo,cantidad,Fecha,Usuario,Detalle)
			select cuota_id,tipo,cantidad,GETDATE(),SYSTEM_USER,'DATO EDITADO EN LA TABLA TIPO DE CUOTAS'
			from inserted
	end
go

use acnur 
go
create table seguridad_socios
(
	socio_id Int not null,
	nombre Varchar(25) not null,
	apellido1 Varchar(25) not null,
	apellido2 Varchar(25) not null,
	direccion Varchar(200) not null,
	fecha_pago Date not null,
	cuanta_bancaria Varchar(20) not null,
	tipo_cuota_fk Int not null,
	sede_fk Int not null,
	 Fecha DATE not null, 
	Usuario VARCHAR(70),
	Detalle VARCHAR(70)
)
go

use acnur
go
create trigger tr_ingresar_socio
on socios
for insert
as
	begin
		set nocount on;
		insert into seguridad_socios(socio_id,nombre,apellido1,apellido2,direccion,fecha_pago,cuanta_bancaria,
									tipo_cuota_fk,sede_fk,Fecha,Usuario,Detalle)
		select socio_id,nombre,apellido1,apellido2,direccion,fecha_pago,cuanta_bancaria,
									tipo_cuota_fk,sede_fk,GETDATE(),SYSTEM_USER,'DATO INGRESADO EN LA TABLA SOCIOS'
		from inserted
									
	end
go 


use acnur 
go
create trigger tr_eliminar_socio
on socios
for delete
as
	begin
		set nocount on;
		insert into seguridad_socios(socio_id,nombre,apellido1,apellido2,direccion,fecha_pago,cuanta_bancaria,
									tipo_cuota_fk,sede_fk,Fecha,Usuario,Detalle)
		select socio_id,nombre,apellido1,apellido2,direccion,fecha_pago,cuanta_bancaria,
									tipo_cuota_fk,sede_fk,GETDATE(),SYSTEM_USER,'DATO ELIMINADO EN LA TABLA SOCIOS'
		from deleted
	end
go

use acnur 
go
create trigger tr_editar_socio
on socios
for update
as
	begin
		update  seguridad_socios set 
			nombre = S.nombre,
			apellido1 = S.apellido1,
			apellido2 = S.apellido2,
			direccion = S.direccion,
			fecha_pago = S.fecha_pago,
			cuanta_bancaria = S.cuanta_bancaria,
			tipo_cuota_fk = S.tipo_cuota_fk,
			sede_fk = S.sede_fk,
			 Fecha = S.Fecha,
			Usuario = S.Usuario,
			Detalle = S.Detalle
			from seguridad_socios as S inner join inserted as Socio
			on S.socio_id = Socio.socio_id

			SET NOCOUNT ON;
			insert into seguridad_socios(socio_id,nombre,apellido1,apellido2,direccion,fecha_pago,cuanta_bancaria,
									tipo_cuota_fk,sede_fk,Fecha,Usuario,Detalle)
			select socio_id,nombre,apellido1,apellido2,direccion,fecha_pago,cuanta_bancaria,
									tipo_cuota_fk,sede_fk,GETDATE(),SYSTEM_USER,'DATO INGRESADO EN LA TABLA SOCIOS'
			from inserted
	end
go

use acnur
go
create table seguridad_sedes
(
	sede_id int not null,
	nombre_sede varchar(100) not null,
	domicilio Varchar (100) not null,
	nombre_director Varchar(15) not null,
	apellido1 Varchar(15) not null,
	apellido2 Varchar(15) not null,
	Fecha			DATE NOT NULL,
	Usuario			VARCHAR(70),
	Detalle         VARCHAR(70),
)
go


use acnur
go
create trigger tr_ingresar_sedes
on sedes
for insert
as
	begin
		SET NOCOUNT ON;
		insert into seguridad_sedes(sede_id,
									nombre_sede,
									domicilio,
									nombre_director,
									apellido1,
									apellido2,
									Fecha,
									Usuario, 
									Detalle)
		select sede_id,	nombre_sede, domicilio,	nombre_director, apellido1,	apellido2, GETDATE(),SYSTEM_USER,'DATO INSERTADO EN LA TABLA SEDES'
		FROM inserted
	end
go

use acnur
go
create trigger tr_eliminar_sede
on sedes
for delete
as
	begin
			SET NOCOUNT ON;
		insert into seguridad_sedes(sede_id,
									nombre_sede,
									domicilio,
									nombre_director,
									apellido1,
									apellido2,
									Fecha,
									Usuario, 
									Detalle)
		select sede_id,	nombre_sede, domicilio,	nombre_director, apellido1,	apellido2, GETDATE(),SYSTEM_USER,'DATO ELIMINADO EN LA TABLA SEDES'
		FROM DELETED
	end
go


use acnur
go
CREATE TRIGGER tr_editar_sede
on sedes
for update
as
	BEGIN 
SET NOCOUNT ON;
		update seguridad_sedes set 
			nombre_sede = S.nombre_sede,
			domicilio = S.domicilio,
			nombre_director = S.nombre_director,
			apellido1 = S.apellido1,
			apellido2 = S.apellido2,
			Fecha = S.Fecha,
			Usuario = S.Usuario, 
			Detalle = S.Detalle
			from seguridad_sedes as S inner join inserted as Socio
			on S.sede_id = Socio.sede_id
			insert into seguridad_sedes(sede_id,
									nombre_sede,
									domicilio,
									nombre_director,
									apellido1,
									apellido2,
									Fecha,
									Usuario, 
									Detalle)
			select sede_id,	nombre_sede, domicilio,	nombre_director, apellido1,	apellido2, GETDATE(),SYSTEM_USER,'DATO EDITADO EN LA TABLA SEDES'
			FROM inserted
	end
go


use acnur
go
create table seguridad_voluntarios
(
	voluntario_id int ,
	cedula Varchar(25) unique not null,
	nombre Varchar(50) not null,
	apellido1 Varchar(25) not null,
	apellido2 Varchar(25) not null,
	sede_fk int not null,
	Fecha			   DATE NOT NULL,
	Usuario			   VARCHAR(70),
	Detalle            VARCHAR(70)
)
go

use acnur 
go
create trigger tr_ingresar_voluntario
on voluntarios
for insert 
as
	begin
		set nocount on;
		insert into seguridad_voluntarios(voluntario_id,cedula,nombre,apellido1,apellido2,sede_fk,Fecha,Usuario,Detalle)
		select voluntario_id,cedula,nombre,apellido1,apellido2,sede_fk,getdate(),SYSTEM_USER,'DATO INGRESADO EN LA TABLA DE VOLUNTARIOS'
		from inserted
	end
go

use acnur 
go
create trigger tr_eliminar_voluntario
on voluntarios
for delete 
as
	begin
		set nocount on;
		insert into seguridad_voluntarios(voluntario_id,cedula,nombre,apellido1,apellido2,sede_fk,Fecha,Usuario,Detalle)
		select voluntario_id,cedula,nombre,apellido1,apellido2,sede_fk,getdate(),SYSTEM_USER,'DATO INGRESADO EN LA TABLA DE VOLUNTARIOS'
		from deleted
	end
go


use acnur
go
create trigger tr_editar_voluntario
on voluntarios
for update
as 
	begin
		update seguridad_voluntarios set 
		cedula = V.cedula,
		nombre = V.nombre,
		apellido1 = V.apellido1,
		apellido2 = V.apellido2,
		sede_fk = V.sede_fk,
		Fecha	= V.Fecha,
		Usuario = V.Usuario,
		Detalle = V.Detalle
		from seguridad_voluntarios as V inner join inserted as Vol
		on V.voluntario_id = Vol.voluntario_id
		set nocount on;
		insert into seguridad_voluntarios(voluntario_id,cedula,nombre,apellido1,apellido2,sede_fk,Fecha,Usuario,Detalle)
		select voluntario_id,cedula,nombre,apellido1,apellido2,sede_fk,getdate(),SYSTEM_USER,'DATO EDITADO EN LA TABLA DE VOLUNTARIOS'
		from inserted
	end
go

use acnur
go
create table seguridad_voluntarios_Administrativos
(
	voluntarioA_id int,
	voluntario_fk int,
	Fecha			   DATE NOT NULL,
	Usuario			   VARCHAR(70),
	Detalle            VARCHAR(70)
)
go


use acnur 
go
create trigger tr_insert_voluntario_admin
on voluntarios_Administrativos
for insert
as
	begin
		set nocount on;
		insert into seguridad_voluntarios_Administrativos(voluntarioA_id,voluntario_fk,Fecha,Usuario,Detalle)
		select voluntarioA_id,voluntario_fk,getdate(),SYSTEM_USER,'DATO INGRESADO EN LA TABLA DE VOLUNTARIOS ADMINISTRATIVOS'
		from inserted
	end	
go

use acnur
go
create trigger tr_eliminar_voluntario_admin
on voluntarios_Administrativos
for delete
as
	begin
		set nocount on;
		insert into seguridad_voluntarios_Administrativos(voluntarioA_id,voluntario_fk,Fecha,Usuario,Detalle)
		select voluntarioA_id,voluntario_fk,getdate(),SYSTEM_USER,'DATO INGRESADO EN LA TABLA DE VOLUNTARIOS ADMINISTRATIVOS'
		from deleted
	end
go



use acnur
go 
create table seguridad_voluntarios_Humanitarios
(

	voluntarioH_id int ,
	profesion Varchar(25) not null,
	disponibilidad bit not null,
	cantidad_de_trabajos int not null,
	voluntario_fk int not null,
	Fecha			   DATE NOT NULL,
	Usuario			   VARCHAR(70),
	Detalle            VARCHAR(70)

)
go


use acnur 
go
create trigger tr_agregar_voluntarios_h
on voluntarios_Humanitarios
for insert
as
	begin
		SET NOCOUNT ON;
		insert into  seguridad_voluntarios_Humanitarios(voluntarioH_id,profesion,disponibilidad,cantidad_de_trabajos,voluntario_fk,Fecha,Usuario,Detalle)
		select voluntarioH_id,profesion,disponibilidad,cantidad_de_trabajos,voluntario_fk,getdate(),SYSTEM_USER,'DATO INGRESADO EN LA TABLA DE AGREGAR VOLUNTARIOS H'
		from inserted
	end
go 

use acnur
go
create trigger tr_eliminar_voluntario_h
on voluntarios_Humanitarios
for delete 
as 
	begin
		SET NOCOUNT ON;
		insert into  seguridad_voluntarios_Humanitarios(voluntarioH_id,profesion,disponibilidad,cantidad_de_trabajos,voluntario_fk,Fecha,Usuario,Detalle)
		select voluntarioH_id,profesion,disponibilidad,cantidad_de_trabajos,voluntario_fk,getdate(),SYSTEM_USER,'DATO INGRESADO EN LA TABLA DE AGREGAR VOLUNTARIOS H'
		from deleted
	end
go

use acnur 
go
create trigger tr_editar_voluntario_h
on voluntarios_Humanitarios
for update 
as
	begin
		update seguridad_voluntarios_Humanitarios set
			profesion = V.profesion,
			disponibilidad = V.disponibilidad,
			cantidad_de_trabajos = V.cantidad_de_trabajos,
			voluntario_fk = V.voluntario_fk,
			Fecha = V.Fecha,
			Usuario	= V.Usuario,
			Detalle = V.Detalle
			from seguridad_voluntarios_Humanitarios as V inner join inserted as Vol
			on V.voluntarioH_id = Vol.voluntarioH_id
			set nocount on;
			insert into  seguridad_voluntarios_Humanitarios(voluntarioH_id,profesion,disponibilidad,cantidad_de_trabajos,voluntario_fk,Fecha,Usuario,Detalle)
			select voluntarioH_id,profesion,disponibilidad,cantidad_de_trabajos,voluntario_fk,getdate(),SYSTEM_USER,'DATO EDITADO EN LA TABLA DE VOLUNTARIOS H'
			from inserted
	end
go 