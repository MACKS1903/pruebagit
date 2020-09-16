$PBExportHeader$w_autoriza_detalle_ventas.srw
$PBExportComments$Reporte de detalle ventas
forward
global type w_autoriza_detalle_ventas from window
end type
type cb_2 from commandbutton within w_autoriza_detalle_ventas
end type
type cb_1 from commandbutton within w_autoriza_detalle_ventas
end type
type st_1 from statictext within w_autoriza_detalle_ventas
end type
type sle_1 from singlelineedit within w_autoriza_detalle_ventas
end type
end forward

global type w_autoriza_detalle_ventas from window
integer x = 1001
integer y = 500
integer width = 882
integer height = 368
boolean titlebar = true
string title = "Autorización"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 79741120
cb_2 cb_2
cb_1 cb_1
st_1 st_1
sle_1 sle_1
end type
global w_autoriza_detalle_ventas w_autoriza_detalle_ventas

on w_autoriza_detalle_ventas.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_1=create st_1
this.sle_1=create sle_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.st_1,&
this.sle_1}
end on

on w_autoriza_detalle_ventas.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.sle_1)
end on

event deactivate;w_rep_detalle_ventas.dw_1.setfocus()
end event

type cb_2 from commandbutton within w_autoriza_detalle_ventas
integer x = 457
integer y = 148
integer width = 361
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;closewithreturn(parent,0)

end event

type cb_1 from commandbutton within w_autoriza_detalle_ventas
integer x = 41
integer y = 148
integer width = 361
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Aceptar"
boolean default = true
end type

event clicked;string ls_msg,ls_clave
long ll_fun
int li_fun
ls_clave = sle_1.text
SELECT cod_funcionario INTO :ll_fun FROM pv_caja 
WHERE cod_compania = :gs_cod_compania  
AND nr_caja = :gi_caja AND clave = :ls_clave ;
if sqlca.sqlnrows = 0 then
	messagebox("ERROR","Debe ingresar un código autorizado~r~nConsulte al administrador del Sistema",stopsign!)
	rollback;
	return -1
elseif sqlca.sqlcode < 0 then
	ls_msg = sqlca.sqlerrtext 	
	messagebox("ERROR","En la obtención de autorización para Cierre de Caja~r~n"+ls_msg,stopsign!)
	rollback;
	return -1
end if
if ll_fun = 0 or isnull(ll_fun)  then
	messagebox("ERROR","Debe ingresar un código autorizado",stopsign!)
	return -1
ELSE
  opensheet(w_rep_detalle_ventas,w_principal,1,layered!)	
  closewithreturn(parent,ll_fun)
end if


end event

type st_1 from statictext within w_autoriza_detalle_ventas
integer x = 59
integer y = 36
integer width = 247
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "CLAVE :"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_autoriza_detalle_ventas
integer x = 357
integer y = 28
integer width = 384
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
boolean password = true
borderstyle borderstyle = stylelowered!
end type

event modified;cb_1.enabled = true
end event

