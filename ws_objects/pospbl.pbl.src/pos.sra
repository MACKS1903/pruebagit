$PBExportHeader$pos.sra
$PBExportComments$Punto de venta para Apolo.  version 1.2
forward
global type pos from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
// variables para control de cabecera - detalle - pago
datawindow gdw_cab,gdw_det,gdw_det_pago
// variables generales
string gs_usuario,gs_cod_compania,gs_nomb_funcionario,gs_nom_clie,gs_piva,gs_mensaje,ls_com,gs_CAMINO,gs_precio,gs_emi,gs_factura,gs_server
integer gi_caja = 1,gi_sistema,gi_impresion,gi_paga_iva = 1,gi_mensaje
integer gi_cod_funcionario,gi_bodega,gi_asp,si_barra,li_caja
// valor del iva
double gc_iva,gc_num_factura
string gs_decimales,gs_num_suc,gs_validez,gs_modelo,gs_ruc_clie
string gs_sri,gs_ruc_matriz,gs_dir_matriz,gs_ciudad,gs_slogan
transaction gtr_master
string gs_serial, gs_nombre,gs_precios,gs_cta_efectivo,gs_ruc,gs_ambiente,gs_emision,gs_codigo,gs_clavecert
Boolean gb_reinstalar, gb_despues,gb_modifica
Long gl_licencia, gl_tipo_comprobante, gl_nr_comprobante, gl_tipo
String gs_fecha_comprobante,gs_subempresa
double idb_descuento_total
pn_conexion  gnv_connect
string ls_nombref
char gc_tipo_clie

end variables

global type pos from application
string appname = "pos"
string microhelpdefault = "Listo"
string dwmessagetitle = "Error"
string themepath = "C:\Program Files (x86)\Appeon\Shared\PowerBuilder\theme190"
string themename = "Flat Design Blue"
boolean nativepdfvalid = true
boolean nativepdfincludecustomfont = false
string nativepdfappname = ""
long richtextedittype = 2
long richtexteditversion = 1
string richtexteditkey = ""
string appicon = "F:\PUNTOELECTRONICO\users.ico"
end type
global pos pos

type variables

end variables

on pos.create
appname="pos"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on pos.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;int li_cajero,li_conectado
String ls_cadena, ls_form, ls_server, ls_comando, ls_serie, ls_temp, ls_aux, ls_database
string ls_servername,ls_dbms,ls_database1,ls_logid,ls_userid,ls_dbpass,ls_logpass,ls_lock
integer li_FileNum,li_existe, li_numsys
long ll_FLength, ll_num_dias, ll_n, ll_num_usuario
long li_clie
Date ldt_fecha, ldt_fecha_actual, ldt_fecha_cd

WebBrowserSet ("DownloadPath", "C:\inetpub\wwwroot\")

setpointer(hourglass!)
ll_FLength = FileLength("C:\PUNTO\PUNTO.TXT")
li_FileNum = FileOpen("C:\PUNTO\PUNTO.TXT",StreamMode!)
IF ll_FLength < 32767 THEN
	FileRead(li_FileNum, gs_serial)
	gs_serial = left(gs_serial,ll_FLength - 3)
	FileClose(li_FileNum)
END IF
gb_reinstalar = false
gb_despues = false
// conexion con el regedit
RegistryGet("HKEY_LOCAL_MACHINE\Software\ABS\PUNTO\Conectar", "SERVERNAME", RegString!, ls_servername)
RegistryGet("HKEY_LOCAL_MACHINE\Software\ABS\PUNTO\Conectar", "DBMS", RegString!, ls_dbms)
RegistryGet("HKEY_LOCAL_MACHINE\Software\ABS\PUNTO\Conectar", "Database", RegString!, ls_database1)
RegistryGet("HKEY_LOCAL_MACHINE\Software\ABS\PUNTO\Conectar", "LogId", RegString!, ls_logid)
RegistryGet("HKEY_LOCAL_MACHINE\Software\ABS\PUNTO\Conectar", "UserId", RegString!, ls_userid)
RegistryGet("HKEY_LOCAL_MACHINE\Software\ABS\PUNTO\Conectar", "DBPass", RegString!, ls_dbpass)
RegistryGet("HKEY_LOCAL_MACHINE\Software\ABS\PUNTO\Conectar", "LogPass", RegString!, ls_logpass)
RegistryGet("HKEY_LOCAL_MACHINE\Software\ABS\PUNTO\Conectar", "Lock", RegString!, ls_lock)
// Profile POS-APOL

SQLCA.SERVERNAME = ProfileString ("pos.ini", "POS","servername","") 
SQLCA.DBMS = profilestring("pos.ini","POS","dbms","")
SQLCA.DBParm = profilestring("pos.ini","POS","DBParm","")
SQLCA.Database = ProfileString ("pos.ini", "POS","database","") 
SQLCA.LOGID = ProfileString ("pos.ini", "POS","logid","")
SQLCA.userid = ProfileString ("pos.ini", "POS","userid","") 
SQLCA.dbpass = ProfileString ("pos.ini", "POS","dbpass","")
SQLCA.LOGPASS = ProfileString ("pos.ini", "POS","logpass","")
SQLCA.Lock = ProfileString ("pos.ini", "POS","Lock","")

//SQLCA.SERVERNAME = ls_servername
//SQLCA.DBMS = ls_dbms
//SQLCA.Database = ls_database1
//SQLCA.LOGID = ls_logid
//SQLCA.userid = ls_userid
//SQLCA.dbpass = ls_dbpass
//SQLCA.LOGPASS = ls_logpass
//SQLCA.Lock = ls_lock

/*
long conexion_estatus,respuesta
pn_conexion    servicio;

//crea un objeto soap para conectar al servicio web
SoapConnection conexion_ws;
conexion_ws = create SoapConnection;

//configura un archivo de logs para ver errores de la conexion
conexion_ws.setoptions( 'SoapLog="c:\\soaplog.txt"');

//realiza la conexion al servicio web
conexion_estatus = conexion_ws.createinstance( servicio,"pn_conexion");

//Verifica que la conexion se alla realizado con exito
if (conexion_estatus <> 0) then
 MessageBox("Error", "Error al contactar el servicio web.", Exclamation!, OK!,1);
 end if
 
 respuesta=servicio.of_connectdb()
 if respuesta >= 0 then
 MessageBox("Exito"," OKconectado")
 
	
	 
else
	 MessageBox("erro"," Noconectado")
 end if	 
 



*/
connect;

if sqlca.sqlcode < 0 then
	messagebox("Error","No puedo conectarme")
	halt close
end if

 integer li_com
  SELECT compania.cod_compania  
    INTO :li_com  
    FROM compania  
   WHERE 1 = 1   ;
gs_cod_compania = string(li_com)



gtr_master = create transaction
ls_cadena = "PROVIDER='SQLOLEDB',DelimitIdentifier='No',DATASOURCE='"
ls_server = ProfileString ("pos.ini", "POS","servername","")
gs_server=ls_server
gs_precio=ProfileString ("pos.ini", "APLICACION","LISTA","")
//gs_subempresa=ProfileString ("pos.ini", "APLICACION","SUBEMPRESA","")

ls_cadena = ls_cadena + ls_server + "'"
gtr_master.DBParm = ls_cadena
gtr_master.DBMS = "OLE DB"
gtr_master.LogId = "sa"
gtr_master.LogPass = "123ma"
connect using gtr_master;
if gtr_master.Sqlcode < 0 then 
	f_mensajes_menu(2)
	rollback;
	return 
end if	 
gi_sistema = 6

ls_database = ProfileString ("pos.ini", "POS","database","") 
ls_comando = 'use ' + ls_database
execute immediate :ls_comando using sqlca ;

select getdate() into :ldt_fecha_actual from sysfiles using gtr_master;

select count(name)
into :li_numsys
from syslabel
using gtr_master;

if gtr_master.sqlcode < 0 then
	//No existe la tabla, debe instalar el APOLO
	messagebox("Información","Debe Instalar Primero MACKS")
	halt close
	return
else		
	select form, dated, name
	into :ls_serie, :ldt_fecha, :gs_nombre
	from syslabel
	where typed = 'P'
	using gtr_master;
	if gtr_master.sqlcode < 0 then
		Messagebox("Información","No es posible obtener información")
		Rollback using gtr_master;
		Return
	end if
	
	if isnull(gs_serial) or gs_serial = '' then
		if (IsNull(ls_serie) or ls_serie = '') then
			MessageBox("Error","Ha violado el sistema de seguridad, comuníquese con su CAS.",stopsign!)
			halt close
			return
		else

		gs_serial = ls_serie
		f_inserta_tabla (gs_serial,gl_licencia,ll_num_dias,gl_tipo,ldt_fecha)
		if gl_tipo = 3 then
			//OPEN (W_AVISO)	
		end if
		
		Select count(hostname)
		into :ll_num_usuario
		from sysprocesses
		Where  datalength (rtrim(hostname)) > 1
 		and loginame = 'PV'
		using gtr_master;
		
		if isnull(ll_num_usuario) then ll_num_usuario = 0
		If ll_num_usuario > gl_licencia then
			MessageBox("Información","El número de licencia se ha excedido.", information!)
			Halt close
			return
		end if
		
		
		// tomar el valor de la tabla de parametros
		SELECT porcentaje_iva into :gc_iva from compania 
		where (convert(char(2),cod_compania) = :gs_cod_compania) ;
		if sqlca.sqlcode < 0 then
			messageBox ("Error","No puedo recuperar el porcentaje de iva~r~n"+sqlca.sqlerrtext)
			halt close
		end if
		gi_asp = Profileint ("pos.ini", "APLICACION","ASP",0)
		gi_caja = Profileint ("pos.ini", "APLICACION","CAJA",0)
		gs_ruc_matriz = ProfileString ("pos.ini", "APLICACION","RUC_MATRIZ",'')
		gs_num_suc = Profilestring ("pos.ini","APLICACION","NUM_SUC",'')
		gs_emi=Profilestring ("pos.ini","APLICACION","EMI",'')
		gs_dir_matriz = Profilestring ("pos.ini", "APLICACION","DIR_MATRIZ",'')
		gs_validez = Profilestring ("pos.ini", "APLICACION","VALIDEZ",'')
		gs_modelo = profilestring("pos.ini","APLICACION","MODELO","")
		gi_impresion = profileint("pos.ini","APLICACION","IMPRESION",0)
		gi_bodega = Profileint ("pos.ini", "APLICACION","BODEGA",0)
		gs_cta_efectivo=ProfileString ("pos.ini", "APLICACION","EFECTIVO",'')
		gs_ciudad = ProfileString ("pos.ini", "APLICACION","CIUDAD",'')
		gs_slogan = ProfileString ("pos.ini", "APLICACION","slogan",'')
		SELECT count(*) INTO :li_clie FROM cliente  
		WHERE (cliente.cod_cliente) > 0  ;
		if sqlca.sqlcode < 0 then
			messageBox ("Error","No pude recuperar clientes .~r~nIngréselos en el módulo de Mantenimineto")
			halt close
		end if
		if li_clie = 0 then
			messageBox ("Error","No pude recuperar clientes .~r~nIngréselos en el módulo de Mantenimineto")
			halt close
		end if
		/*if li_clie > 1 then
			messageBox ("Error","No pude haber mas de un cliente CASH.~r~nCorriga en el módulo de Mantenimineto")
			halt close
		end if*/
		select isnull (count (*), 0) into :li_cajero from funcionario
		where tipo_funcionario in ('E','J') ;
		if sqlca.sqlcode < 0 then
			messageBox ("Error","No pude recuperar los cajeros definidos.~r~nIngréselos en el módulo de Mantenimineto")
			halt close
		end if
		if li_cajero = 0 then
			messageBox ("Error","No existen cajeros definidos.~r~nIngréselos en el módulo de Mantenimineto")
			halt close
		end if
		/*
		SELECT distinct funcionario.cod_funcionario,funcionario.nom_funcionario
		INTO :gi_cod_funcionario,:gs_nomb_funcionario  
		FROM funcionario, pv_caja  
		WHERE ( funcionario.cod_funcionario = pv_caja.cod_funcionario ) and  
				( ( pv_caja.nr_caja = :gi_caja ))   ;
		if sqlca.sqlcode < 0 then
			messageBox ("Error","No existen cajeros definidos.~r~nIngréselos en el módulo de Mantenimineto")
			halt close
		end if
		*/
	open(w_autoriza_registradora)
		
		gi_paga_iva = Profileint ("pos.ini", "APLICACION","PAGA_IVA",0)
		gs_decimales = profilestring("pos.ini","APLICACION","DECIMALES","S")
		gs_sri = profilestring("pos.ini","APLICACION","SRI","")
		gs_precios = profilestring("pos.ini","APLICACION","PRECIOS","")
		if gi_caja = 0 then 
			messagebox("Error","No se ha definido el numero de caja en el Archivo POS.ini");
			halt close
		end if		
		open(w_principal)
		disconnect using gtr_master;
	end if
	else
		f_inserta_tabla (gs_serial,gl_licencia,ll_num_dias,gl_tipo,ldt_fecha)
		if (IsNull(ls_serie) or ls_serie = '') then
			open(w_licencia)
			return
		else
			if ls_serie <> gs_serial then
				MessageBox("Información","Debe instalar la aplicación con el CD original, el número de serie no coincide.",stopsign!)
				Halt Close
				return				
			end if
			gb_reinstalar = true			
			if DaysAfter ( ldt_fecha,ldt_fecha_actual) > ll_num_dias then
				gb_despues = true
				ls_temp = f_genra_rand_serie (gs_serial)
				ls_aux = f_desenc_serie (ls_temp)
				DO UNTIL ls_aux = gs_serial
					ls_temp = f_genra_rand_serie (gs_serial)
					ls_aux = f_desenc_serie (ls_temp)			
				LOOP
				gs_serial = ls_temp
				MessageBox("Información","Debe comunicarse con su CAS para obtener su nuevo número de registro.",information!)
			end if			
			open(w_licencia)
		end if
	end if
end if


opensheet(w_registradora,w_principal,1,layered!)	 //QUITAR PARA WINFORM
w_busqueda_art.dw_condiciones.setfocus()  //21-julio-2009

end event

event systemerror;string 	ls_message

ls_message = 'Error Number '+string(error.number) & 
	+'.~r~nError text = '+Error.text &
	+'.~r~nWindow/Menu/Object = '+error.windowmenu &
	+'.~r~nError Object/Control = '+Error.object &
	+'.~r~nScript = '+Error.objectevent &
	+'.~r~nLine in Script = '+string(Error.line) + '.'

Messagebox('Error',ls_message, StopSign! )

rollback;
halt close
end event

event close;int li_codigo,li_archivo
string ls_cadena
disconnect;

end event

