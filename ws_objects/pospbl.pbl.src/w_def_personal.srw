$PBExportHeader$w_def_personal.srw
$PBExportComments$definición de cajas y cajeros
forward
global type w_def_personal from window
end type
type tab_personal from tab within w_def_personal
end type
type tabpage_personal from userobject within tab_personal
end type
type dw_personal from datawindow within tabpage_personal
end type
type tabpage_personal from userobject within tab_personal
dw_personal dw_personal
end type
type tabpage_cajeros from userobject within tab_personal
end type
type dw_def_cajas from datawindow within tabpage_cajeros
end type
type tabpage_cajeros from userobject within tab_personal
dw_def_cajas dw_def_cajas
end type
type tabpage_1 from userobject within tab_personal
end type
type cb_1 from commandbutton within tabpage_1
end type
type dw_1 from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_personal
cb_1 cb_1
dw_1 dw_1
end type
type tab_personal from tab within w_def_personal
tabpage_personal tabpage_personal
tabpage_cajeros tabpage_cajeros
tabpage_1 tabpage_1
end type
end forward

global type w_def_personal from window
integer width = 4654
integer height = 1012
boolean titlebar = true
string title = "Definición de personal"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
event insertar ( )
event eliminar ( )
event type integer grabar ( )
tab_personal tab_personal
end type
global w_def_personal w_def_personal

type variables
datawindow idw_x
datawindowchild idwc_cajeros

boolean ibo_cambio = false
end variables

event insertar;idw_x.event dynamic insertar()
end event

event eliminar;idw_x.event  dynamic eliminar()
end event

event type integer grabar();setpointer(hourglass!)
boolean 	lbo_listo1,lbo_listo2
if tab_personal.tabpage_personal.dw_personal.accepttext() < 0 then return -1
if tab_personal.tabpage_cajeros.dw_def_cajas.accepttext() < 0 then return -1
if ibo_cambio then 
	if messagebox("Aviso","Se han producido cambios. Desea grabarlos ?",question!,yesno!,1) = 2 then return 0
else
	return 0
end if
//if tab_personal.tabpage_personal.dw_personal.update(true,false)  < 0 then
//	messagebox("Aviso","En registro de personal."+sqlca.sqlerrtext,stopsign!)
//	rollback;
//	return -1	
//end if
if tab_personal.tabpage_cajeros.dw_def_cajas.update() < 0 then
	messagebox("Aviso","En registro de cajero."+sqlca.sqlerrtext,stopsign!)
	rollback;
	tab_personal.tabpage_cajeros.dw_def_cajas.retrieve(gs_cod_compania,gi_caja)
	return -1	
end if
commit;

tab_personal.tabpage_personal.dw_personal.resetupdate()	
tab_personal.tabpage_cajeros.dw_def_cajas.resetupdate()	
ibo_cambio = false
lbo_listo2 = true

if lbo_listo1 or lbo_listo2 then messagebox("Aviso","Registro realizado")
if MessageBox("Pregunta","Desea reiniciar la aplicación en este momento. ", Question!,YesNo!,1) = 1 then
	close(this)
	restart ()
end if

if tab_personal.tabpage_1.dw_1.update() < 0 then
	messagebox("Aviso","No se puede actualizar secuencial."+sqlca.sqlerrtext,stopsign!)
	rollback;
	tab_personal.tabpage_1.dw_1.retrieve()
	return -1	
end if
commit;


RETURN 1
end event

on w_def_personal.create
this.tab_personal=create tab_personal
this.Control[]={this.tab_personal}
end on

on w_def_personal.destroy
destroy(this.tab_personal)
end on

event open;int li_fun
idw_x  = tab_personal.tabpage_personal.dw_personal
tab_personal.tabpage_cajeros.dw_def_cajas.getchild("cod_funcionario",idwc_cajeros)
idwc_cajeros.settransobject(SQLCA)
idwc_cajeros.setfilter("tipo_funcionario = 'J' or tipo_funcionario = 'E'")
idwc_cajeros.filter()
//tab_personal.tabpage_cajeros.dw_def_cajas.settransobject(SQLCA)
tab_personal.tabpage_cajeros.dw_def_cajas.retrieve(gs_cod_compania,gi_caja)
open(w_autoriza_pers)
li_fun = message.doubleparm
if li_fun > 0 then
  this.enabled= true
else
	close(w_def_personal)
	return
end if
tab_personal.tabpage_personal.dw_personal.enabled = false
tab_personal.tabpage_1.dw_1.retrieve()
end event

event resize;tab_personal.resize(this.width - 100,this.height - 200)
tab_personal.tabpage_cajeros.dw_def_cajas.resize(tab_personal.tabpage_cajeros.dw_def_cajas.width,tab_personal.height - 100)
tab_personal.tabpage_personal.dw_personal.resize(tab_personal.tabpage_personal.dw_personal.width,tab_personal.height - 100)
end event

event key;CHOOSE CASE key
	CASE keyF7!
		this.event insertar()
	CASE keyF6!
		this.event eliminar()
	CASE keyF12!
		this.event grabar()
END CHOOSE
end event

type tab_personal from tab within w_def_personal
event create ( )
event destroy ( )
integer y = 4
integer width = 4498
integer height = 864
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_personal tabpage_personal
tabpage_cajeros tabpage_cajeros
tabpage_1 tabpage_1
end type

on tab_personal.create
this.tabpage_personal=create tabpage_personal
this.tabpage_cajeros=create tabpage_cajeros
this.tabpage_1=create tabpage_1
this.Control[]={this.tabpage_personal,&
this.tabpage_cajeros,&
this.tabpage_1}
end on

on tab_personal.destroy
destroy(this.tabpage_personal)
destroy(this.tabpage_cajeros)
destroy(this.tabpage_1)
end on

event selectionchanged;if newindex = 1 then
	tab_personal.tabpage_personal.dw_personal.setfocus()
	idw_x = tab_personal.tabpage_personal.dw_personal
else
	tab_personal.tabpage_cajeros.dw_def_cajas.setfocus()
	idw_x = tab_personal.tabpage_cajeros.dw_def_cajas
end if
end event

event selectionchanging;if w_def_personal.event grabar() < 0 then return 1
if tab_personal.tabpage_cajeros.dw_def_cajas.event ue_refresh() <= 0 then
	messagebox("Atención","No se han definido cajeros")
	return 1
end if
tab_personal.tabpage_cajeros.dw_def_cajas.settransobject(SQLCA)
tab_personal.tabpage_cajeros.dw_def_cajas.retrieve(gs_cod_compania,gi_caja)

end event

type tabpage_personal from userobject within tab_personal
integer x = 18
integer y = 112
integer width = 4462
integer height = 736
long backcolor = 67108864
string text = "Personal"
long tabtextcolor = 33554432
string picturename = "Custom076_2!"
long picturemaskcolor = 536870912
dw_personal dw_personal
end type

on tabpage_personal.create
this.dw_personal=create dw_personal
this.Control[]={this.dw_personal}
end on

on tabpage_personal.destroy
destroy(this.dw_personal)
end on

type dw_personal from datawindow within tabpage_personal
event insertar ( )
event eliminar ( )
event ue_tecla_funcion pbm_dwnkey
event ue_enter pbm_dwnprocessenter
integer y = 12
integer width = 2299
integer height = 700
integer taborder = 30
string title = "none"
string dataobject = "d_def_empleados"
boolean border = false
boolean livescroll = true
end type

event ue_tecla_funcion;CHOOSE CASE key
	CASE keyF7!
		w_def_personal.event insertar()
	CASE keyF6!
		w_def_personal.event eliminar()
	CASE keyF12!
		w_def_personal.event grabar()
END CHOOSE
end event

event ue_enter;send(Handle(this),256,9,Long(0,0))	
return 1
end event

event constructor;this.settransobject(SQLCA)
this.retrieve()
this.setrowfocusindicator(hand!)
end event

event itemchanged;ibo_cambio = true
end event

type tabpage_cajeros from userobject within tab_personal
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 4462
integer height = 736
long backcolor = 67108864
string text = "Adminstración de Caja"
long tabtextcolor = 33554432
string picturename = "Custom026_2!"
long picturemaskcolor = 536870912
dw_def_cajas dw_def_cajas
end type

on tabpage_cajeros.create
this.dw_def_cajas=create dw_def_cajas
this.Control[]={this.dw_def_cajas}
end on

on tabpage_cajeros.destroy
destroy(this.dw_def_cajas)
end on

type dw_def_cajas from datawindow within tabpage_cajeros
event insertar ( )
event eliminar ( )
event ue_tecla_funcion pbm_dwnkey
event type integer ue_refresh ( )
event ue_enter pbm_dwnprocessenter
integer y = 16
integer width = 4329
integer height = 716
integer taborder = 20
string dataobject = "d_def_caja"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event insertar;long ll_fila 

if this.accepttext() < 0 then return
ll_fila = this.insertrow(0)
this.setcolumn("nr_caja")
this.setitem(ll_fila,"cod_compania",gs_cod_compania)
this.scrolltorow(ll_fila)
this.setfocus()
end event

event eliminar;if this.rowcount() <= 1 then
	messagebox("Aviso","No puede borra todos los cajeros")
	ibo_cambio = true	
	return
else
	this.deleterow(this.getrow())
	ibo_cambio = true
end if


end event

event ue_tecla_funcion;CHOOSE CASE key
	CASE keyF7!
		w_def_personal.event insertar()
	CASE keyF6!
		w_def_personal.event eliminar()
	CASE keyF12!
		w_def_personal.event grabar()
END CHOOSE
end event

event ue_refresh;idwc_cajeros.settransobject(SQLCA)
idwc_cajeros.retrieve()
idwc_cajeros.setfilter("tipo_funcionario = 'E' or tipo_funcionario = 'J'")
idwc_cajeros.filter()
return idwc_cajeros.rowcount()
end event

event ue_enter;send(Handle(this),256,9,Long(0,0))	
return 1
end event

event constructor;this.setrowfocusindicator(hand!)
settransobject(SQLCA)
end event

event itemerror;if dwo.name = 'nr_caja' then
	messagebox("Aviso","Debe ingresar un # de caja entre 0 y 100",exclamation!)
	return 1
end if
end event

event itemchanged;ibo_cambio = true

end event

event dberror;f_db_error (dw_def_cajas,"",sqldbcode,sqlerrtext,row)
return 1
end event

event editchanged;long ll_found
int li_nulo

setnull(li_nulo)
if this.getcolumnname() = 'nr_caja' then 
	ll_found = this.Find("nr_caja =" + data,1,this.RowCount())
	if ll_found <> row and ll_found <> 0 then
		this.object.nr_caja[row] = li_nulo
		Messagebox("Aviso","No puede repetir la caja")
		return
   end if
end if
end event

type tabpage_1 from userobject within tab_personal
integer x = 18
integer y = 112
integer width = 4462
integer height = 736
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
cb_1 cb_1
dw_1 dw_1
end type

on tabpage_1.create
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_1,&
this.dw_1}
end on

on tabpage_1.destroy
destroy(this.cb_1)
destroy(this.dw_1)
end on

type cb_1 from commandbutton within tabpage_1
integer x = 1691
integer y = 64
integer width = 343
integer height = 100
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Guarda"
end type

event clicked;if tab_personal.tabpage_1.dw_1.update() < 0 then
	messagebox("Aviso","No se puede actualizar secuencial."+sqlca.sqlerrtext,stopsign!)
	rollback;
	tab_personal.tabpage_1.dw_1.retrieve()
	return -1	
end if

COMMIT;

end event

type dw_1 from datawindow within tabpage_1
integer x = 27
integer y = 68
integer width = 1609
integer height = 400
integer taborder = 30
string title = "none"
string dataobject = "d_secuencia"
boolean border = false
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
end event

