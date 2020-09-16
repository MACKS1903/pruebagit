$PBExportHeader$w_autoriza_dscto.srw
$PBExportComments$Autorización de descuentos
forward
global type w_autoriza_dscto from window
end type
type st_1 from statictext within w_autoriza_dscto
end type
type sle_1 from singlelineedit within w_autoriza_dscto
end type
type cb_2 from commandbutton within w_autoriza_dscto
end type
type cb_1 from commandbutton within w_autoriza_dscto
end type
end forward

global type w_autoriza_dscto from window
integer x = 494
integer y = 496
integer width = 882
integer height = 364
boolean titlebar = true
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
st_1 st_1
sle_1 sle_1
cb_2 cb_2
cb_1 cb_1
end type
global w_autoriza_dscto w_autoriza_dscto

on w_autoriza_dscto.create
this.st_1=create st_1
this.sle_1=create sle_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.st_1,&
this.sle_1,&
this.cb_2,&
this.cb_1}
end on

on w_autoriza_dscto.destroy
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.cb_2)
destroy(this.cb_1)
end on

type st_1 from statictext within w_autoriza_dscto
integer x = 96
integer y = 32
integer width = 233
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "CLAVE :"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_autoriza_dscto
integer x = 389
integer y = 20
integer width = 379
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean password = true
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_autoriza_dscto
integer x = 471
integer y = 128
integer width = 343
integer height = 92
integer taborder = 20
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

type cb_1 from commandbutton within w_autoriza_dscto
integer x = 32
integer y = 128
integer width = 343
integer height = 92
integer taborder = 10
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
ls_clave = sle_1.text
SELECT TOP 1 cod_funcionario INTO :ll_fun 
FROM pv_caja WHERE cod_compania = :gs_cod_compania  
AND  nr_caja_asigna = :gi_caja and clavelimpia = :ls_clave ;
if sqlca.sqlcode < 0 then
	ls_msg = sqlca.sqlerrtext 	
	messagebox("ERROR","En la obtención de autorización para Cierre de Caja~r~n"+ls_msg,stopsign!)
	rollback;
	return 
end if
if ll_fun = 0 or isnull(ll_fun)  then
	messagebox("ERROR","Debe ingresar un código autorizado",stopsign!)
	return 
else
   closewithreturn(parent,ll_fun)		
end if
end event

