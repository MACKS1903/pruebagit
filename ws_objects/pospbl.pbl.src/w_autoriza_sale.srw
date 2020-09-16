$PBExportHeader$w_autoriza_sale.srw
forward
global type w_autoriza_sale from window
end type
type st_1 from statictext within w_autoriza_sale
end type
type sle_1 from singlelineedit within w_autoriza_sale
end type
type cb_2 from commandbutton within w_autoriza_sale
end type
type cb_1 from commandbutton within w_autoriza_sale
end type
end forward

global type w_autoriza_sale from window
integer x = 2501
integer y = 1000
integer width = 882
integer height = 364
boolean titlebar = true
string title = "Salir"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 15780518
st_1 st_1
sle_1 sle_1
cb_2 cb_2
cb_1 cb_1
end type
global w_autoriza_sale w_autoriza_sale

on w_autoriza_sale.create
this.st_1=create st_1
this.sle_1=create sle_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.st_1,&
this.sle_1,&
this.cb_2,&
this.cb_1}
end on

on w_autoriza_sale.destroy
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.cb_2)
destroy(this.cb_1)
end on

type st_1 from statictext within w_autoriza_sale
integer x = 82
integer y = 88
integer width = 233
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
string text = "CLAVE :"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_autoriza_sale
integer x = 425
integer y = 60
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

type cb_2 from commandbutton within w_autoriza_sale
integer x = 471
integer y = 172
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
close(w_autoriza_sale) 

end event

type cb_1 from commandbutton within w_autoriza_sale
integer x = 32
integer y = 168
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

event clicked;string ls_msg,ls_clavesale
long ll_fun
ls_clavesale = sle_1.text   
SELECT cod_funcionario INTO :ll_fun 
FROM pv_caja WHERE cod_compania = :gs_cod_compania  
AND  nr_caja_asigna = :gi_caja and clavesale = :ls_clavesale and  //10-abril-2009
pv_caja.cod_funcionario=:gi_cod_funcionario;  //10-abril-2009; 
if sqlca.sqlcode < 0 then
	ls_msg = sqlca.sqlerrtext 	
	messagebox("ERROR","En la obtención de autorización para Cierre de Caja~r~n"+ls_msg,stopsign!)
	rollback;
	sle_1.text=""
	sle_1.setfocus()
	return 
end if
if ll_fun = 0 or isnull(ll_fun)  then
	messagebox("ERROR","Debe ingresar un código autorizado",stopsign!)
	sle_1.text=""
	sle_1.setfocus()
else
   //closewithreturn(parent,ll_fun)	
	close(w_principal)
end if

end event

