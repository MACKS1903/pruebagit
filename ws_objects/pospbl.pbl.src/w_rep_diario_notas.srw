$PBExportHeader$w_rep_diario_notas.srw
$PBExportComments$Diario de Notas de Venta
forward
global type w_rep_diario_notas from window
end type
type cbx_todascajas from checkbox within w_rep_diario_notas
end type
type dw_4 from datawindow within w_rep_diario_notas
end type
type cbx_todas from checkbox within w_rep_diario_notas
end type
type dw_cliente from datawindow within w_rep_diario_notas
end type
type st_3 from statictext within w_rep_diario_notas
end type
type ddlb_1 from dropdownlistbox within w_rep_diario_notas
end type
type cb_5 from commandbutton within w_rep_diario_notas
end type
type dw_3 from datawindow within w_rep_diario_notas
end type
type cbx_2 from checkbox within w_rep_diario_notas
end type
type cbx_1 from checkbox within w_rep_diario_notas
end type
type dw_2 from datawindow within w_rep_diario_notas
end type
type cb_3 from commandbutton within w_rep_diario_notas
end type
type dw_cia from datawindow within w_rep_diario_notas
end type
type cb_limpiar from commandbutton within w_rep_diario_notas
end type
type cb_salir from commandbutton within w_rep_diario_notas
end type
type cb_2 from commandbutton within w_rep_diario_notas
end type
type cb_1 from commandbutton within w_rep_diario_notas
end type
type st_2 from statictext within w_rep_diario_notas
end type
type st_1 from statictext within w_rep_diario_notas
end type
type em_hasta from editmask within w_rep_diario_notas
end type
type em_desde from editmask within w_rep_diario_notas
end type
type dw_1 from datawindow within w_rep_diario_notas
end type
type dw_cajas from datawindow within w_rep_diario_notas
end type
type cb_4 from commandbutton within w_rep_diario_notas
end type
type r_1 from rectangle within w_rep_diario_notas
end type
type r_2 from rectangle within w_rep_diario_notas
end type
type r_3 from rectangle within w_rep_diario_notas
end type
end forward

global type w_rep_diario_notas from window
integer x = 823
integer y = 360
integer width = 4315
integer height = 3040
boolean titlebar = true
string title = "Reporte de Diario de Notas de Venta"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
event cerrar ( )
cbx_todascajas cbx_todascajas
dw_4 dw_4
cbx_todas cbx_todas
dw_cliente dw_cliente
st_3 st_3
ddlb_1 ddlb_1
cb_5 cb_5
dw_3 dw_3
cbx_2 cbx_2
cbx_1 cbx_1
dw_2 dw_2
cb_3 cb_3
dw_cia dw_cia
cb_limpiar cb_limpiar
cb_salir cb_salir
cb_2 cb_2
cb_1 cb_1
st_2 st_2
st_1 st_1
em_hasta em_hasta
em_desde em_desde
dw_1 dw_1
dw_cajas dw_cajas
cb_4 cb_4
r_1 r_1
r_2 r_2
r_3 r_3
end type
global w_rep_diario_notas w_rep_diario_notas

type variables
int ii_nrcaja,ii_cia
string is_piva
long i_cliente
end variables

event cerrar;close(this)
end event

on w_rep_diario_notas.create
this.cbx_todascajas=create cbx_todascajas
this.dw_4=create dw_4
this.cbx_todas=create cbx_todas
this.dw_cliente=create dw_cliente
this.st_3=create st_3
this.ddlb_1=create ddlb_1
this.cb_5=create cb_5
this.dw_3=create dw_3
this.cbx_2=create cbx_2
this.cbx_1=create cbx_1
this.dw_2=create dw_2
this.cb_3=create cb_3
this.dw_cia=create dw_cia
this.cb_limpiar=create cb_limpiar
this.cb_salir=create cb_salir
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_2=create st_2
this.st_1=create st_1
this.em_hasta=create em_hasta
this.em_desde=create em_desde
this.dw_1=create dw_1
this.dw_cajas=create dw_cajas
this.cb_4=create cb_4
this.r_1=create r_1
this.r_2=create r_2
this.r_3=create r_3
this.Control[]={this.cbx_todascajas,&
this.dw_4,&
this.cbx_todas,&
this.dw_cliente,&
this.st_3,&
this.ddlb_1,&
this.cb_5,&
this.dw_3,&
this.cbx_2,&
this.cbx_1,&
this.dw_2,&
this.cb_3,&
this.dw_cia,&
this.cb_limpiar,&
this.cb_salir,&
this.cb_2,&
this.cb_1,&
this.st_2,&
this.st_1,&
this.em_hasta,&
this.em_desde,&
this.dw_1,&
this.dw_cajas,&
this.cb_4,&
this.r_1,&
this.r_2,&
this.r_3}
end on

on w_rep_diario_notas.destroy
destroy(this.cbx_todascajas)
destroy(this.dw_4)
destroy(this.cbx_todas)
destroy(this.dw_cliente)
destroy(this.st_3)
destroy(this.ddlb_1)
destroy(this.cb_5)
destroy(this.dw_3)
destroy(this.cbx_2)
destroy(this.cbx_1)
destroy(this.dw_2)
destroy(this.cb_3)
destroy(this.dw_cia)
destroy(this.cb_limpiar)
destroy(this.cb_salir)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.em_hasta)
destroy(this.em_desde)
destroy(this.dw_1)
destroy(this.dw_cajas)
destroy(this.cb_4)
destroy(this.r_1)
destroy(this.r_2)
destroy(this.r_3)
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
//datawindowchild ldwc_x1
//dw_cajas.getchild('caja',ldwc_x1)
//ldwc_x1.settransobject(SQLCA)
//ldwc_x1.retrieve(gs_cod_compania)
dw_cia.settransobject(sqlca)
dw_cia.retrieve()
dw_cia.insertrow(0)

dw_cliente.settransobject(sqlca)
dw_cliente.retrieve()
dw_cliente.insertrow(0)



//dw_cajas.settransobject(SQLCA)
//dw_cajas.insertrow(0)
open(w_autoriza_diario_notas)
li_fun = message.doubleparm
if li_fun > 0 then
   this.enabled= true
   dw_cajas.setfocus()	
elseif li_fun = 0 then
	close(w_rep_diario_notas)
	return
end if

dw_1.width=3575
dw_2.width=3575
dw_3.width=3575
dw_4.width=3575

end event

event resize;dw_1.resize(this.width - 50,this.height - (dw_1.y + 150))
dw_2.resize(this.width - 50,this.height - (dw_2.y + 150))
dw_3.resize(this.width - 50,this.height - (dw_3.y + 150))
end event

event key;if key = keyescape! then	this.post event cerrar()

end event

type cbx_todascajas from checkbox within w_rep_diario_notas
integer x = 1838
integer y = 376
integer width = 471
integer height = 72
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "CajasTodas"
end type

type dw_4 from datawindow within w_rep_diario_notas
integer x = 55
integer y = 512
integer width = 3611
integer height = 1692
integer taborder = 40
string dataobject = "d_diario_notas_todas"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type cbx_todas from checkbox within w_rep_diario_notas
integer x = 119
integer y = 284
integer width = 311
integer height = 72
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Todas"
end type

event clicked;cbx_1.checked = false
cbx_2.checked = false
end event

type dw_cliente from datawindow within w_rep_diario_notas
integer x = 96
integer y = 388
integer width = 1243
integer height = 92
integer taborder = 50
string title = "none"
string dataobject = "dd_cliented"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;i_cliente= long(data)
end event

type st_3 from statictext within w_rep_diario_notas
integer x = 1358
integer y = 40
integer width = 302
integer height = 68
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 65535
string text = "Tarifa %"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_rep_diario_notas
integer x = 1367
integer y = 144
integer width = 293
integer height = 324
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 255
boolean sorted = false
string item[] = {"12","14","."}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;string i
is_piva=this.text
end event

type cb_5 from commandbutton within w_rep_diario_notas
integer x = 1838
integer y = 152
integer width = 439
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Filtro FP"
end type

event clicked;string null_str

SetNull(null_str)

dw_3.SetFilter(null_str)

dw_3.Filter()


end event

type dw_3 from datawindow within w_rep_diario_notas
integer x = 91
integer y = 524
integer width = 3575
integer height = 1200
integer taborder = 30
string dataobject = "d_diario_notas_forma_pago"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type cbx_2 from checkbox within w_rep_diario_notas
integer x = 1838
integer y = 284
integer width = 471
integer height = 72
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Forma de Pago"
end type

event clicked;cbx_1.checked = false
end event

type cbx_1 from checkbox within w_rep_diario_notas
integer x = 2405
integer y = 280
integer width = 434
integer height = 72
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Por Vendedor"
end type

event clicked;cbx_2.checked = false
end event

type dw_2 from datawindow within w_rep_diario_notas
integer x = 59
integer y = 520
integer width = 3611
integer height = 1592
integer taborder = 20
string dataobject = "d_diario_notas_vendedor"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type cb_3 from commandbutton within w_rep_diario_notas
integer x = 2866
integer y = 64
integer width = 343
integer height = 152
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Guardar "
end type

event clicked;integer i
string ls_sql_original,ls_sql
datetime lda_desde,lda_hasta
lda_desde = datetime(date(em_desde.text))
lda_hasta = datetime(relativedate(date(em_hasta.text),0))

//i=dw_3.rowcount()
//messagebox("filas",string(i))

//dw_3.saveas()


if cbx_1.checked = false and cbx_2.checked=false then
	i=dw_1.rowcount()
	dw_1.saveas()
end if

if cbx_1.checked = true then
	
	i = dw_2.rowcount()
		dw_2.saveas()
end if	

if cbx_2.checked = true then
//ls_sql_original = dw_3.getsqlselect()
//ls_sql = mid(ls_sql_original,1,pos(ls_sql_original,":gs_comp )")+len(":gs_comp )"))+ " and convert(char(10),pv_nota_venta.fecha_emision ,111) between '"+string(date(lda_desde),'yyyy/mm/dd') +"' and '"+string(date(lda_hasta),'yyyy/mm/dd')+"'"
//ls_sql = ls_sql + " and pv_nota_venta.nr_caja = "+string(ii_nrcaja)
//dw_3.object.datawindow.table.select = ls_sql
//dw_3.retrieve(gs_cod_compania,gi_caja)
//dw_3.object.datawindow.table.select = ls_sql_original

	i = dw_3.rowcount()
	dw_3.saveas()
end if	


//dw_4.saveas()

end event

type dw_cia from datawindow within w_rep_diario_notas
integer x = 782
integer y = 44
integer width = 539
integer height = 88
integer taborder = 50
string title = "none"
string dataobject = "d_dddw_cias"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;ii_cia= integer(data)
datawindowchild ldwc_x1
dw_cajas.getchild('caja',ldwc_x1)
ldwc_x1.settransobject(SQLCA)
ldwc_x1.retrieve(string(ii_cia))
dw_cajas.settransobject(SQLCA)
dw_cajas.insertrow(0)

end event

type cb_limpiar from commandbutton within w_rep_diario_notas
integer x = 2299
integer y = 52
integer width = 283
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

type cb_salir from commandbutton within w_rep_diario_notas
integer x = 2592
integer y = 148
integer width = 247
integer height = 80
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

type cb_2 from commandbutton within w_rep_diario_notas
integer x = 2597
integer y = 52
integer width = 242
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

event clicked;string ls_sql_original,ls_sql
datetime lda_desde,lda_hasta
lda_desde = datetime(date(em_desde.text))
lda_hasta = datetime(relativedate(date(em_hasta.text),0))

messagebox("Atención","Prepare la Impresora")

if cbx_1.checked = false and cbx_2.checked=false then
dw_1.print()
end if

if cbx_1.checked = true then
ls_sql_original = dw_2.getsqlselect()
ls_sql = mid(ls_sql_original,1,pos(ls_sql_original,":gs_comp )")+len(":gs_comp )"))+ " and convert(char(10),pv_nota_venta.fecha_emision ,111) between '"+string(date(lda_desde),'yyyy/mm/dd') +"' and '"+string(date(lda_hasta),'yyyy/mm/dd')+"'"
ls_sql = ls_sql + " and pv_nota_venta.nr_caja = "+string(ii_nrcaja)
dw_2.object.datawindow.table.select = ls_sql
dw_2.retrieve(gs_cod_compania,gi_caja)
dw_2.object.datawindow.table.select = ls_sql_original


	dw_2.print()
end if	

if cbx_2.checked = true then
	ls_sql_original = dw_3.getsqlselect()
ls_sql = mid(ls_sql_original,1,pos(ls_sql_original,":gs_comp )")+len(":gs_comp )"))+ " and convert(char(10),pv_nota_venta.fecha_emision ,111) between '"+string(date(lda_desde),'yyyy/mm/dd') +"' and '"+string(date(lda_hasta),'yyyy/mm/dd')+"'"
ls_sql = ls_sql + " and pv_nota_venta.nr_caja >= "+string(ii_nrcaja)
dw_3.object.datawindow.table.select = ls_sql
dw_3.retrieve(gs_cod_compania,gi_caja)
dw_3.object.datawindow.table.select = ls_sql_original

	dw_3.print()
end if	

	

end event

type cb_1 from commandbutton within w_rep_diario_notas
integer x = 2304
integer y = 148
integer width = 279
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
string ls_sql,ls_sql_original
integer i_piva

i_piva=integer(is_piva)

dw_cajas.accepttext()
lda_desde = datetime(date(em_desde.text))
lda_hasta = datetime(relativedate(date(em_hasta.text),0))
if string(date(lda_desde)) = '01/01/1900' or string(date(lda_hasta)) = '01/01/1900' then
  messagebox("Error","Fecha mal ingresada")	  
  return
end if
if cbx_todas.checked=true then
dw_2.visible = false
dw_3.visible = false
dw_4.visible = true
dw_1.visible = false
ls_sql_original = dw_4.getsqlselect()
ls_sql = mid(ls_sql_original,1,pos(ls_sql_original,":gs_comp )")+len(":gs_comp )"))+ " and convert(char(10),pv_nota_venta.fecha_emision ,111) between '"+string(date(lda_desde),'yyyy/mm/dd') +"' and '"+string(date(lda_hasta),'yyyy/mm/dd')+"'"
ls_sql = ls_sql //+ " and pv_nota_venta.nr_caja = "+string(ii_nrcaja)
if i_piva > 0 then
	ls_sql = ls_sql + " and prc_iva = "+string(is_piva)
end if	

if i_cliente > 0 then
	ls_sql = ls_sql + " and cod_cliente = "+string(i_cliente)
end if	
dw_4.object.datawindow.table.select = ls_sql
dw_4.retrieve(gs_cod_compania,gi_caja)
dw_4.object.datawindow.table.select = ls_sql_original
dw_4.width=3575

end if	
	

if cbx_1.checked =  false and cbx_2.checked = false  and cbx_todas.checked=false then
dw_2.visible = false
dw_3.visible = false
dw_4.visible = false
dw_1.visible = true
ls_sql_original = dw_1.getsqlselect()
ls_sql = mid(ls_sql_original,1,pos(ls_sql_original,":gs_comp )")+len(":gs_comp )"))+ " and convert(char(10),pv_nota_venta.fecha_emision ,111) between '"+string(date(lda_desde),'yyyy/mm/dd') +"' and '"+string(date(lda_hasta),'yyyy/mm/dd')+"'"
ls_sql = ls_sql + " and pv_nota_venta.nr_caja = "+string(ii_nrcaja)
if i_piva > 0 then
	ls_sql = ls_sql + " and prc_iva = "+string(is_piva)
end if	

if i_cliente > 0 then
	ls_sql = ls_sql + " and cod_cliente = "+string(i_cliente)
end if	
dw_1.object.datawindow.table.select = ls_sql
dw_1.retrieve(gs_cod_compania,gi_caja)
dw_1.object.datawindow.table.select = ls_sql_original
else
if cbx_1.checked =  true then
dw_1.visible = false
dw_2.visible = true
dw_3.visible = false
ls_sql_original = dw_2.getsqlselect()
ls_sql = mid(ls_sql_original,1,pos(ls_sql_original,":gs_comp )")+len(":gs_comp )"))+ " and convert(char(10),pv_nota_venta.fecha_emision ,111) between '"+string(date(lda_desde),'yyyy/mm/dd') +"' and '"+string(date(lda_hasta),'yyyy/mm/dd')+"'"
ls_sql = ls_sql + " and pv_nota_venta.nr_caja = "+string(ii_nrcaja)
if i_piva > 0 then
	ls_sql = ls_sql + " and prc_iva = "+string(is_piva)
end if	
dw_2.object.datawindow.table.select = ls_sql
dw_2.retrieve(gs_cod_compania,gi_caja)
dw_2.object.datawindow.table.select = ls_sql_original
dw_2.width=3575
else
	if cbx_2.checked =  true then
dw_1.visible = false
dw_2.visible = false
dw_3.visible = true
ls_sql_original = dw_3.getsqlselect()
ls_sql = mid(ls_sql_original,1,pos(ls_sql_original,":gs_comp )")+len(":gs_comp )"))+ " and convert(char(10),pv_nota_venta.fecha_emision ,111) between '"+string(date(lda_desde),'yyyy/mm/dd') +"' and '"+string(date(lda_hasta),'yyyy/mm/dd')+"'"
ls_sql = ls_sql + " and pv_nota_venta.nr_caja = "+string(ii_nrcaja)
dw_3.object.datawindow.table.select = ls_sql
dw_3.retrieve(gs_cod_compania,gi_caja)
dw_3.object.datawindow.table.select = ls_sql_original
dw_3.width=3575
end if
end if
end if	
end event

type st_2 from statictext within w_rep_diario_notas
integer x = 82
integer y = 156
integer width = 247
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

type st_1 from statictext within w_rep_diario_notas
integer x = 105
integer y = 60
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

type em_hasta from editmask within w_rep_diario_notas
integer x = 393
integer y = 148
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

type em_desde from editmask within w_rep_diario_notas
integer x = 389
integer y = 48
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

type dw_1 from datawindow within w_rep_diario_notas
integer x = 59
integer y = 520
integer width = 3625
integer height = 1592
integer taborder = 10
string dataobject = "d_diario_notas"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type dw_cajas from datawindow within w_rep_diario_notas
integer x = 782
integer y = 152
integer width = 535
integer height = 84
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_dddw_cajas"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;ii_nrcaja= integer(data)
end event

type cb_4 from commandbutton within w_rep_diario_notas
integer x = 1838
integer y = 56
integer width = 439
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Filtro Vendedor"
end type

event clicked;string null_str

SetNull(null_str)

dw_2.SetFilter(null_str)

dw_2.Filter()


end event

type r_1 from rectangle within w_rep_diario_notas
integer linethickness = 4
long fillcolor = 16777215
integer x = 1719
integer y = 256
integer width = 1138
integer height = 168
end type

type r_2 from rectangle within w_rep_diario_notas
integer linethickness = 4
long fillcolor = 16777215
integer x = 1719
integer y = 40
integer width = 1138
integer height = 208
end type

type r_3 from rectangle within w_rep_diario_notas
integer linethickness = 4
long fillcolor = 16777215
integer x = 64
integer y = 16
integer width = 3310
integer height = 496
end type

