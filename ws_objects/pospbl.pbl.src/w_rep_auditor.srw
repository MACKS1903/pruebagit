$PBExportHeader$w_rep_auditor.srw
$PBExportComments$Diario de Notas de Venta
forward
global type w_rep_auditor from window
end type
type rb_detalle from radiobutton within w_rep_auditor
end type
type rb_diario from radiobutton within w_rep_auditor
end type
type cb_limpiar from commandbutton within w_rep_auditor
end type
type cb_salir from commandbutton within w_rep_auditor
end type
type cb_2 from commandbutton within w_rep_auditor
end type
type cb_1 from commandbutton within w_rep_auditor
end type
type dw_cajas from datawindow within w_rep_auditor
end type
type st_2 from statictext within w_rep_auditor
end type
type st_1 from statictext within w_rep_auditor
end type
type em_hasta from editmask within w_rep_auditor
end type
type em_desde from editmask within w_rep_auditor
end type
type dw_1 from datawindow within w_rep_auditor
end type
type gb_1 from groupbox within w_rep_auditor
end type
end forward

global type w_rep_auditor from window
integer x = 823
integer y = 360
integer width = 3456
integer height = 1204
boolean titlebar = true
string title = "Auditor"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
event cerrar ( )
rb_detalle rb_detalle
rb_diario rb_diario
cb_limpiar cb_limpiar
cb_salir cb_salir
cb_2 cb_2
cb_1 cb_1
dw_cajas dw_cajas
st_2 st_2
st_1 st_1
em_hasta em_hasta
em_desde em_desde
dw_1 dw_1
gb_1 gb_1
end type
global w_rep_auditor w_rep_auditor

type variables
int ii_nrcaja,ii_reporte
end variables

event cerrar;close(this)
end event

on w_rep_auditor.create
this.rb_detalle=create rb_detalle
this.rb_diario=create rb_diario
this.cb_limpiar=create cb_limpiar
this.cb_salir=create cb_salir
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_cajas=create dw_cajas
this.st_2=create st_2
this.st_1=create st_1
this.em_hasta=create em_hasta
this.em_desde=create em_desde
this.dw_1=create dw_1
this.gb_1=create gb_1
this.Control[]={this.rb_detalle,&
this.rb_diario,&
this.cb_limpiar,&
this.cb_salir,&
this.cb_2,&
this.cb_1,&
this.dw_cajas,&
this.st_2,&
this.st_1,&
this.em_hasta,&
this.em_desde,&
this.dw_1,&
this.gb_1}
end on

on w_rep_auditor.destroy
destroy(this.rb_detalle)
destroy(this.rb_diario)
destroy(this.cb_limpiar)
destroy(this.cb_salir)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_cajas)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.em_hasta)
destroy(this.em_desde)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event open;integer li_existe,li_fun
em_desde.text = string(today())
em_hasta.text = string(today())
SELECT pv_caja.nr_caja INTO :li_existe  FROM pv_caja  WHERE pv_caja.cod_compania = :gs_cod_compania;
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
open(w_autoriza_auditor)
li_fun = message.doubleparm
if li_fun > 0 then
   this.enabled= true
   dw_cajas.setfocus()	
elseif li_fun = 0 then
	close(w_rep_auditor)
	return
end if
rb_diario.SetFocus()
end event

event resize;dw_1.resize(this.width - 50,this.height - (dw_1.y + 150))
end event

event key;if key = keyescape! then	this.post event cerrar()

end event

type rb_detalle from radiobutton within w_rep_auditor
integer x = 1719
integer y = 140
integer width = 667
integer height = 72
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Detalle &Notas de Venta"
borderstyle borderstyle = stylelowered!
end type

event clicked;// Programa principal
ii_reporte = 2
dw_1.DataObject = "d_rep_detalle_ventas_auditor"
dw_1.SetTransObject(sqlca)

end event

type rb_diario from radiobutton within w_rep_auditor
integer x = 1728
integer y = 60
integer width = 517
integer height = 72
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Diario de &Ventas"
borderstyle borderstyle = stylelowered!
end type

event clicked;// Programa principal
ii_reporte = 1
dw_1.DataObject = "d_diario_notas_auditor"
dw_1.SetTransObject(sqlca)


end event

type cb_limpiar from commandbutton within w_rep_auditor
integer x = 2437
integer y = 52
integer width = 384
integer height = 84
integer taborder = 20
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

type cb_salir from commandbutton within w_rep_auditor
integer x = 2853
integer y = 136
integer width = 384
integer height = 84
integer taborder = 20
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

type cb_2 from commandbutton within w_rep_auditor
integer x = 2853
integer y = 52
integer width = 384
integer height = 84
integer taborder = 50
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

type cb_1 from commandbutton within w_rep_auditor
integer x = 2437
integer y = 136
integer width = 384
integer height = 84
integer taborder = 50
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
datetime lda_desde,lda_hasta
string ls_sql,ls_sql_original,ls_fini,ls_ffin
dw_cajas.accepttext()
lda_desde = datetime(date(em_desde.text))
lda_hasta = datetime(relativedate(date(em_hasta.text),0))
if string(date(lda_desde)) = '01/01/1900' or string(date(lda_hasta)) = '01/01/1900' then
  messagebox("Error","Fecha mal ingresada")	  
  return
end if
choose case ii_reporte
	case 1	
     ls_sql_original = dw_1.getsqlselect()
     ls_sql = mid(ls_sql_original,1,pos(ls_sql_original,":gs_comp )")+len(":gs_comp )"))+ " and convert(char(10),pv_nota_venta.fecha_emision ,111) between '"+string(date(lda_desde),'yyyy/mm/dd') +"' and '"+string(date(lda_hasta),'yyyy/mm/dd')+"'"
     ls_sql = ls_sql + " and pv_nota_venta.nr_caja = "+string(ii_nrcaja) 
     dw_1.object.datawindow.table.select = ls_sql
     dw_1.retrieve(gs_cod_compania,gi_caja)
     dw_1.object.datawindow.table.select = ls_sql_original
   case 2
     ls_fini = string(date(em_desde.text),'yyyy/mm/dd')
     ls_ffin = string(date(em_hasta.text),'yyyy/mm/dd')
     dw_1.retrieve(integer(gs_cod_compania),ii_nrcaja,ls_fini,ls_ffin)
end choose
dw_1.SetFocus()
end event

type dw_cajas from datawindow within w_rep_auditor
integer x = 1239
integer y = 88
integer width = 443
integer height = 80
integer taborder = 40
string dataobject = "d_dddw_cajas"
boolean border = false
boolean livescroll = true
end type

event itemchanged;ii_nrcaja= integer(data)
end event

type st_2 from statictext within w_rep_auditor
integer x = 667
integer y = 92
integer width = 187
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
string text = "Hasta:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_rep_auditor
integer x = 55
integer y = 92
integer width = 197
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

type em_hasta from editmask within w_rep_auditor
integer x = 846
integer y = 88
integer width = 343
integer height = 80
integer taborder = 30
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

type em_desde from editmask within w_rep_auditor
integer x = 279
integer y = 88
integer width = 343
integer height = 80
integer taborder = 20
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

type dw_1 from datawindow within w_rep_auditor
integer y = 248
integer width = 2583
integer height = 756
integer taborder = 10
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_rep_auditor
integer width = 3278
integer height = 240
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Fechas:"
borderstyle borderstyle = stylelowered!
end type

