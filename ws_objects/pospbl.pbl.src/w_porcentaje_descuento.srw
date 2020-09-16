$PBExportHeader$w_porcentaje_descuento.srw
forward
global type w_porcentaje_descuento from window
end type
type cb_2 from commandbutton within w_porcentaje_descuento
end type
type cb_1 from commandbutton within w_porcentaje_descuento
end type
type em_1 from editmask within w_porcentaje_descuento
end type
type st_1 from statictext within w_porcentaje_descuento
end type
end forward

global type w_porcentaje_descuento from window
integer x = 654
integer y = 268
integer width = 997
integer height = 412
boolean titlebar = true
string title = "Descuento"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
cb_2 cb_2
cb_1 cb_1
em_1 em_1
st_1 st_1
end type
global w_porcentaje_descuento w_porcentaje_descuento

on w_porcentaje_descuento.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.em_1=create em_1
this.st_1=create st_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.em_1,&
this.st_1}
end on

on w_porcentaje_descuento.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.em_1)
destroy(this.st_1)
end on

type cb_2 from commandbutton within w_porcentaje_descuento
integer x = 535
integer y = 188
integer width = 334
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Cancelar"
end type

event clicked;CloseWithReturn(Parent,0)
end event

type cb_1 from commandbutton within w_porcentaje_descuento
integer x = 78
integer y = 188
integer width = 334
integer height = 84
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

event clicked;if double(em_1.text) < 0 then
	messagebox("ATENCION","El porcentaje de descuento no puede ser nulo")
	return
end if
CloseWithReturn(Parent,double(em_1.text))
end event

type em_1 from editmask within w_porcentaje_descuento
integer x = 622
integer y = 36
integer width = 270
integer height = 96
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_porcentaje_descuento
integer x = 50
integer y = 40
integer width = 489
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "% de Descuento :"
boolean focusrectangle = false
end type

