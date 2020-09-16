$PBExportHeader$w_principal.srw
$PBExportComments$Ventana principal de sistema Punto de Venta
forward
global type w_principal from window
end type
type mdi_1 from mdiclient within w_principal
end type
end forward

global type w_principal from window
integer x = 9
integer y = 8
integer width = 1413
integer height = 1048
boolean titlebar = true
string title = "Punto de Venta "
string menuname = "m_principal"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = mdihelp!
windowstate windowstate = maximized!
long backcolor = 79741120
string icon = "UserObjectIcon1!"
boolean center = true
mdi_1 mdi_1
end type
global w_principal w_principal

on w_principal.create
if this.MenuName = "m_principal" then this.MenuID = create m_principal
this.mdi_1=create mdi_1
this.Control[]={this.mdi_1}
end on

on w_principal.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
end on

event open;string ls_servidor,ls_compania
Long ll_count

open(w_busqueda_art)
w_busqueda_art.hide()
if sqlca.servername = '' then ls_servidor = 'LOCAL'
  SELECT compania.nom_compania  
    INTO :ls_compania  
    FROM compania  
   WHERE compania.cod_compania = 1   ;


this.title = this.title + '     Servidor: <'+ls_servidor+'>' +'     Compania: <'+ls_compania+'>'
this.resize(2926,1920)

if gl_tipo = 3 then
	//open(w_aviso)	//PARA QUE NO SALGA OTRA VEZ
	timer(10000)
	select count(*)
	into : ll_count
	from pv_nv_movimiento
	where tipo_movimiento = 'EV';
	If sqlca.sqlcode < 0 then
		MessageBox("Error","No se pudo recuperar la información del movimiento. " + sqlca.sqlerrtext,stopsign!)
		return	
	end if
	
	if ll_count >= 50000 then
		MessageBox("Información","En la versión Demo del Har Money solo puede realizar cierto número de transacciones. ~r~n Comuníquese con su CAS o a A.B.S. " + sqlca.sqlerrtext,stopsign!)
		Halt Close
		return	
	end if
end if
end event

event timer;Long ll_count
open(w_aviso)

select count(*)
into : ll_count
from pv_nv_movimiento
where tipo_movimiento = 'EV';
If sqlca.sqlcode < 0 then
	MessageBox("Error","No se pudo recuperar la información del movimiento. " + sqlca.sqlerrtext,stopsign!)
	return	
end if

if ll_count >= 50 then
	MessageBox("Información","En la versión Demo del Apolo solo puede realizar cierto número de transacciones. ~r~n Comuníquese con su CAS o a ENKASOFT S.A. " + sqlca.sqlerrtext,stopsign!)
	Halt Close
	return	
end if
end event

type mdi_1 from mdiclient within w_principal
long BackColor=276856960
end type

