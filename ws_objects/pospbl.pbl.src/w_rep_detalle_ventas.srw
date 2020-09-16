$PBExportHeader$w_rep_detalle_ventas.srw
$PBExportComments$Reporte de detalle ventas
forward
global type w_rep_detalle_ventas from window
end type
type cb_salir from commandbutton within w_rep_detalle_ventas
end type
type cb_limpiar from commandbutton within w_rep_detalle_ventas
end type
type em_desde from editmask within w_rep_detalle_ventas
end type
type cb_2 from commandbutton within w_rep_detalle_ventas
end type
type cb_1 from commandbutton within w_rep_detalle_ventas
end type
type dw_cajas from datawindow within w_rep_detalle_ventas
end type
type em_hasta from editmask within w_rep_detalle_ventas
end type
type st_2 from statictext within w_rep_detalle_ventas
end type
type st_1 from statictext within w_rep_detalle_ventas
end type
type dw_1 from datawindow within w_rep_detalle_ventas
end type
type gb_1 from groupbox within w_rep_detalle_ventas
end type
end forward

global type w_rep_detalle_ventas from window
integer width = 3470
integer height = 1516
boolean titlebar = true
string title = "Reporte de Detalle de Ventas"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
event cerrar ( )
cb_salir cb_salir
cb_limpiar cb_limpiar
em_desde em_desde
cb_2 cb_2
cb_1 cb_1
dw_cajas dw_cajas
em_hasta em_hasta
st_2 st_2
st_1 st_1
dw_1 dw_1
gb_1 gb_1
end type
global w_rep_detalle_ventas w_rep_detalle_ventas

type variables
int ii_nrcaja
end variables

event cerrar;close(this)
end event

event open;integer li_existe,li_fun
em_desde.text = string(today())
em_hasta.text = string(today())
SELECT pv_caja.nr_caja    INTO :li_existe  FROM pv_caja  WHERE pv_caja.cod_compania = :gs_cod_compania   ;
if isnull(li_existe) then li_existe = 0
if li_existe = 0 then
	messagebox("Error","No se ha definido ninguna caja",exclamation!)
	close(this);return 
end if
datawindowchild ldwc_x
dw_cajas.getchild('caja',ldwc_x)
ldwc_x.settransobject(SQLCA)
ldwc_x.retrieve(gs_cod_compania)
dw_cajas.settransobject(SQLCA)
dw_cajas.insertrow(0)
open(w_autoriza_detalle_ventas)
li_fun = message.doubleparm
if li_fun > 0 then
   this.enabled= true
   dw_cajas.setfocus()	
elseif li_fun = 0 then
	close(w_rep_detalle_ventas)
	return
end if
end event

on w_rep_detalle_ventas.create
this.cb_salir=create cb_salir
this.cb_limpiar=create cb_limpiar
this.em_desde=create em_desde
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_cajas=create dw_cajas
this.em_hasta=create em_hasta
this.st_2=create st_2
this.st_1=create st_1
this.dw_1=create dw_1
this.gb_1=create gb_1
this.Control[]={this.cb_salir,&
this.cb_limpiar,&
this.em_desde,&
this.cb_2,&
this.cb_1,&
this.dw_cajas,&
this.em_hasta,&
this.st_2,&
this.st_1,&
this.dw_1,&
this.gb_1}
end on

on w_rep_detalle_ventas.destroy
destroy(this.cb_salir)
destroy(this.cb_limpiar)
destroy(this.em_desde)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_cajas)
destroy(this.em_hasta)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event resize;dw_1.resize(this.width - 50,this.height - (dw_1.y + 150))
end event

event key;if key = keyescape! then	this.post event cerrar()

end event

type cb_salir from commandbutton within w_rep_detalle_ventas
integer x = 2807
integer y = 140
integer width = 384
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Salir"
end type

event clicked;close(parent)
end event

type cb_limpiar from commandbutton within w_rep_detalle_ventas
integer x = 2395
integer y = 52
integer width = 384
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Limpiar"
end type

event clicked;dw_cajas.reset()
dw_cajas.insertrow(0)
dw_1.reset()
ii_nrcaja=0
end event

type em_desde from editmask within w_rep_detalle_ventas
integer x = 274
integer y = 92
integer width = 343
integer height = 80
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

type cb_2 from commandbutton within w_rep_detalle_ventas
integer x = 2807
integer y = 52
integer width = 384
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Imprimir"
end type

event clicked;messagebox("Atención","Prepare la Impresora")
dw_1.print()
end event

type cb_1 from commandbutton within w_rep_detalle_ventas
integer x = 2395
integer y = 140
integer width = 384
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Buscar"
boolean default = true
end type

event clicked;setpointer(hourglass!)
string ls_sql,ls_sql_original,ls_sql_agrupa,ls_fini,ls_ffin
long ll_nro
dw_cajas.accepttext()
ls_fini = string(date(em_desde.text),'yyyy/mm/dd')
ls_ffin = string(date(em_hasta.text),'yyyy/mm/dd')
dw_1.retrieve(integer(gs_cod_compania),ii_nrcaja,ls_fini,ls_ffin)

end event

type dw_cajas from datawindow within w_rep_detalle_ventas
integer x = 1211
integer y = 96
integer width = 599
integer height = 80
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_dddw_cajas"
boolean border = false
boolean livescroll = true
end type

event itemchanged;ii_nrcaja= integer(data)
end event

type em_hasta from editmask within w_rep_detalle_ventas
integer x = 891
integer y = 92
integer width = 343
integer height = 80
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

type st_2 from statictext within w_rep_detalle_ventas
integer x = 667
integer y = 96
integer width = 215
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "Hasta:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_rep_detalle_ventas
integer x = 55
integer y = 96
integer width = 215
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "Desde:"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_rep_detalle_ventas
integer y = 268
integer width = 2560
integer height = 1044
string title = "none"
string dataobject = "d_rep_detalle_ventas"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(SQLCA)
end event

type gb_1 from groupbox within w_rep_detalle_ventas
integer width = 3259
integer height = 260
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
string text = "Fechas:"
end type

