$PBExportHeader$w_aviso.srw
forward
global type w_aviso from window
end type
type st_3 from statictext within w_aviso
end type
type p_1 from picture within w_aviso
end type
type cb_1 from commandbutton within w_aviso
end type
type st_2 from statictext within w_aviso
end type
type st_1 from statictext within w_aviso
end type
end forward

global type w_aviso from window
integer x = 384
integer y = 432
integer width = 1888
integer height = 1176
boolean titlebar = true
string title = "Acerca de este sistema"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 79741120
st_3 st_3
p_1 p_1
cb_1 cb_1
st_2 st_2
st_1 st_1
end type
global w_aviso w_aviso

on w_aviso.create
this.st_3=create st_3
this.p_1=create p_1
this.cb_1=create cb_1
this.st_2=create st_2
this.st_1=create st_1
this.Control[]={this.st_3,&
this.p_1,&
this.cb_1,&
this.st_2,&
this.st_1}
end on

on w_aviso.destroy
destroy(this.st_3)
destroy(this.p_1)
destroy(this.cb_1)
destroy(this.st_2)
destroy(this.st_1)
end on

type st_3 from statictext within w_aviso
integer x = 768
integer y = 460
integer width = 224
integer height = 56
integer textsize = -11
integer weight = 700
fontcharset fontcharset = russiancharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial CYR"
boolean italic = true
long textcolor = 32768
long backcolor = 16777215
string text = "Demo"
boolean focusrectangle = false
end type

type p_1 from picture within w_aviso
integer x = 654
integer y = 8
integer width = 475
integer height = 544
string picturename = "C:\harmoney\HARMONEY-demo.bmp"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_aviso
integer x = 759
integer y = 960
integer width = 375
integer height = 88
integer taborder = 1
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Aceptar"
end type

event clicked;close(parent)
end event

type st_2 from statictext within w_aviso
integer x = 41
integer y = 572
integer width = 1609
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "Copyright © 2003 ABS. Reservados todos los derechos."
boolean focusrectangle = false
end type

type st_1 from statictext within w_aviso
integer x = 46
integer y = 676
integer width = 1897
integer height = 296
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "Advertencia: Este programa está protegido por las leyes de derechos de autor y otros tratados internacionales. La reproducción o distribución ilícitas de este programa, o de cualquier parte del mismo, está penada por la ley con severas sanciones civiles y penales, y será objeto de todas las acciones judiciales que correspondan."
boolean focusrectangle = false
end type

