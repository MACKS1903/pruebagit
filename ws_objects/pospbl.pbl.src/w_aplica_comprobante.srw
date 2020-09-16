$PBExportHeader$w_aplica_comprobante.srw
forward
global type w_aplica_comprobante from window
end type
type dw_imprimir from datawindow within w_aplica_comprobante
end type
type pb_cerrar from picturebutton within w_aplica_comprobante
end type
type pb_imprimir from picturebutton within w_aplica_comprobante
end type
type pb_guardar from picturebutton within w_aplica_comprobante
end type
type dw_detail from datawindow within w_aplica_comprobante
end type
type dw_master from datawindow within w_aplica_comprobante
end type
end forward

global type w_aplica_comprobante from window
integer x = 498
integer y = 500
integer width = 3259
integer height = 1432
boolean titlebar = true
string title = "Detalle del comprobante"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "C:\APOLO\Apolo.ico"
dw_imprimir dw_imprimir
pb_cerrar pb_cerrar
pb_imprimir pb_imprimir
pb_guardar pb_guardar
dw_detail dw_detail
dw_master dw_master
end type
global w_aplica_comprobante w_aplica_comprobante

type variables

end variables

on w_aplica_comprobante.create
this.dw_imprimir=create dw_imprimir
this.pb_cerrar=create pb_cerrar
this.pb_imprimir=create pb_imprimir
this.pb_guardar=create pb_guardar
this.dw_detail=create dw_detail
this.dw_master=create dw_master
this.Control[]={this.dw_imprimir,&
this.pb_cerrar,&
this.pb_imprimir,&
this.pb_guardar,&
this.dw_detail,&
this.dw_master}
end on

on w_aplica_comprobante.destroy
destroy(this.dw_imprimir)
destroy(this.pb_cerrar)
destroy(this.pb_imprimir)
destroy(this.pb_guardar)
destroy(this.dw_detail)
destroy(this.dw_master)
end on

event open;dw_master.retrieve(gl_tipo_comprobante,gl_nr_comprobante,gs_fecha_comprobante)
dw_detail.retrieve(gs_fecha_comprobante,gl_tipo_comprobante,gl_nr_comprobante)
end event

type dw_imprimir from datawindow within w_aplica_comprobante
boolean visible = false
integer x = 187
integer y = 1412
integer width = 169
integer height = 100
integer taborder = 30
string dataobject = "d_aplica_reporte"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;dw_imprimir.settransobject(sqlca)
end event

type pb_cerrar from picturebutton within w_aplica_comprobante
string tag = "Cerrar"
integer x = 366
integer y = 1220
integer width = 114
integer height = 88
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\pbd\bmp\exit.bmp"
alignment htextalign = left!
end type

event clicked;close(w_aplica_comprobante)
end event

type pb_imprimir from picturebutton within w_aplica_comprobante
string tag = "Imprimir"
integer x = 219
integer y = 1220
integer width = 114
integer height = 88
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\pbd\bmp\PRINTER.bmp"
alignment htextalign = left!
end type

event clicked;if dw_imprimir.Retrieve(gs_fecha_comprobante,gl_tipo_comprobante,gl_nr_comprobante) < 0 then
		gs_mensaje = 'dw_reporte'
		f_mensajes(8)
		Return
end if
dw_imprimir.print()

end event

type pb_guardar from picturebutton within w_aplica_comprobante
string tag = "Guardar"
integer x = 78
integer y = 1220
integer width = 114
integer height = 88
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\pbd\bmp\disksave.bmp"
alignment htextalign = left!
end type

event clicked;dw_master.AcceptText()
dw_detail.AcceptText()
if dw_master.update() < 0 then
	gs_mensaje = 'dw_master'
	f_mensajes(6)
	rollback;
	return
end if
if dw_detail.update() < 0 then
	gs_mensaje = 'dw_detail'
	f_mensajes(6)
	rollback;
	return
end if
COMMIT;
end event

type dw_detail from datawindow within w_aplica_comprobante
integer x = 78
integer y = 384
integer width = 3077
integer height = 788
integer taborder = 20
string title = "none"
string dataobject = "d_aplica_detalle"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;dw_detail.settransobject(sqlca)
end event

type dw_master from datawindow within w_aplica_comprobante
integer x = 78
integer y = 52
integer width = 3072
integer height = 308
integer taborder = 10
string dataobject = "d_aplica_cabecera"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;dw_master.settransobject(sqlca)
end event

