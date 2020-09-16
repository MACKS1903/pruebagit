$PBExportHeader$w_rep_articulos_resumido.srw
$PBExportComments$Ventas de articulos
forward
global type w_rep_articulos_resumido from window
end type
type dw_cliente from datawindow within w_rep_articulos_resumido
end type
type cb_salir from commandbutton within w_rep_articulos_resumido
end type
type cb_limpiar from commandbutton within w_rep_articulos_resumido
end type
type dw_articulo from datawindow within w_rep_articulos_resumido
end type
type dw_tipo from datawindow within w_rep_articulos_resumido
end type
type st_7 from statictext within w_rep_articulos_resumido
end type
type st_6 from statictext within w_rep_articulos_resumido
end type
type cb_2 from commandbutton within w_rep_articulos_resumido
end type
type cb_1 from commandbutton within w_rep_articulos_resumido
end type
type dw_cajas from datawindow within w_rep_articulos_resumido
end type
type st_2 from statictext within w_rep_articulos_resumido
end type
type st_1 from statictext within w_rep_articulos_resumido
end type
type em_hasta from editmask within w_rep_articulos_resumido
end type
type em_desde from editmask within w_rep_articulos_resumido
end type
type dw_1 from datawindow within w_rep_articulos_resumido
end type
type gb_1 from groupbox within w_rep_articulos_resumido
end type
end forward

global type w_rep_articulos_resumido from window
integer x = 823
integer y = 360
integer width = 3397
integer height = 1792
boolean titlebar = true
string title = "Reporte De Ventas por Grupo Artículo"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
event cerrar ( )
dw_cliente dw_cliente
cb_salir cb_salir
cb_limpiar cb_limpiar
dw_articulo dw_articulo
dw_tipo dw_tipo
st_7 st_7
st_6 st_6
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
global w_rep_articulos_resumido w_rep_articulos_resumido

type variables
int ii_nrcaja
long il_grupo,il_articulo,i_cliente
datawindowchild idwch_articulo
end variables

event cerrar;close(this)
end event

on w_rep_articulos_resumido.create
this.dw_cliente=create dw_cliente
this.cb_salir=create cb_salir
this.cb_limpiar=create cb_limpiar
this.dw_articulo=create dw_articulo
this.dw_tipo=create dw_tipo
this.st_7=create st_7
this.st_6=create st_6
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_cajas=create dw_cajas
this.st_2=create st_2
this.st_1=create st_1
this.em_hasta=create em_hasta
this.em_desde=create em_desde
this.dw_1=create dw_1
this.gb_1=create gb_1
this.Control[]={this.dw_cliente,&
this.cb_salir,&
this.cb_limpiar,&
this.dw_articulo,&
this.dw_tipo,&
this.st_7,&
this.st_6,&
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

on w_rep_articulos_resumido.destroy
destroy(this.dw_cliente)
destroy(this.cb_salir)
destroy(this.cb_limpiar)
destroy(this.dw_articulo)
destroy(this.dw_tipo)
destroy(this.st_7)
destroy(this.st_6)
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

dw_cliente.settransobject(sqlca)
dw_cliente.retrieve()
dw_cliente.insertrow(0)

open(w_autoriza_articulos_re)
li_fun = message.doubleparm
if li_fun > 0 then
   this.enabled= true
   dw_cajas.setfocus()	
elseif li_fun = 0 then
	close(w_rep_articulos_resumido)
	return
end if
end event

event resize;dw_1.resize(this.width - 50,this.height - (dw_1.y + 150))
end event

event key;if key = keyescape! then	this.post event cerrar()

end event

type dw_cliente from datawindow within w_rep_articulos_resumido
integer x = 1184
integer y = 160
integer width = 1207
integer height = 88
integer taborder = 60
string title = "none"
string dataobject = "dd_cliented"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;i_cliente=long(data)
end event

type cb_salir from commandbutton within w_rep_articulos_resumido
integer x = 2857
integer y = 144
integer width = 384
integer height = 84
integer taborder = 90
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

type cb_limpiar from commandbutton within w_rep_articulos_resumido
integer x = 2450
integer y = 56
integer width = 384
integer height = 84
integer taborder = 60
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
dw_tipo.reset()
dw_tipo.insertrow(0)
dw_articulo.reset()
dw_articulo.insertrow(0)
dw_1.reset()
ii_nrcaja=0
il_articulo=0
il_grupo=0

end event

type dw_articulo from datawindow within w_rep_articulos_resumido
integer x = 1550
integer y = 68
integer width = 631
integer height = 92
integer taborder = 30
string title = "none"
string dataobject = "d_dddw_articulo"
boolean border = false
boolean livescroll = true
end type

event constructor;settransobject(sqlca)
IF getchild("codigo",idwch_articulo) < 0 THEN
	messagebox("Información","No se realizo el child de Articulo")
END IF
insertrow(0)

end event

event itemchanged;long ll_codigo,ll_tot
il_articulo=long(data)
il_grupo=idwch_articulo.getitemnumber(idwch_articulo.GetSelectedRow(0),"cod_grupo")
dw_tipo.setitem(1,"codigo",il_grupo)
select count(*) into :ll_tot
from inv_articulo where cod_articulo = :il_articulo;
if sqlca.sqlcode < 0 then
	messagebox("Información","No puede recuperar el articulo " + sqlca.sqlerrtext,information!)
	return
end if
if ll_tot = 0 then
	messagebox("Información","No existe este articulo",information!)
	return
end if
end event

event losefocus;this.accepttext ()
end event

type dw_tipo from datawindow within w_rep_articulos_resumido
integer x = 667
integer y = 72
integer width = 626
integer height = 76
integer taborder = 20
string title = "none"
string dataobject = "d_dddw_grupo_art"
boolean border = false
boolean livescroll = true
end type

event constructor;settransobject(sqlca)
insertrow(0)
end event

event itemchanged;il_grupo=long(data)
IF idwch_articulo.setfilter("cod_grupo = "+ data) < 0 THEN
	messagebox("Información","No se realizo el filtro")
	return
END IF
idwch_articulo.filter()
dw_articulo.reset()
il_articulo=0
dw_articulo.insertrow(0)


end event

type st_7 from statictext within w_rep_articulos_resumido
integer x = 1312
integer y = 72
integer width = 270
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
string text = "Articulo :"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_6 from statictext within w_rep_articulos_resumido
integer x = 462
integer y = 76
integer width = 229
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
string text = "Grupo :"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_rep_articulos_resumido
integer x = 2848
integer y = 60
integer width = 384
integer height = 84
integer taborder = 80
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

type cb_1 from commandbutton within w_rep_articulos_resumido
integer x = 2441
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
string text = "&Buscar"
boolean default = true
end type

event clicked;setpointer(hourglass!)
datetime lda_desde,lda_hasta
string ls_sql='',ls_sql_original,ls_sqlfinal
dw_cajas.accepttext()
lda_desde = datetime(date(em_desde.text))
lda_hasta = datetime(relativedate(date(em_hasta.text),0))
if dw_articulo.accepttext() < 0 then return
IF isnull(ii_nrcaja) or ii_nrcaja = 0 THEN
   messagebox("Información","Seleccione la Caja")	  	
  return
END IF
if date(lda_desde) > date(lda_hasta) then
  messagebox("Información","La Fecha Inicial debe ser menor que la Final")	  
  return
end if
if i_cliente > 0 then
	dw_1.dataobject='d_rep_articulo_resumido_cliente'
	dw_1.settransobject(sqlca)
end if	

ls_sql_original = dw_1.getsqlselect()
if string(date(lda_desde)) = '01/01/1900' and string(date(lda_hasta)) = '01/01/1900' then
else
	ls_sql= " and convert(char(10),pv_nota_venta.fecha_emision ,111) between '"+string(date(lda_desde),'yyyy/mm/dd') +"' and '"+string(date(lda_hasta),'yyyy/mm/dd')+"'"
end if
IF il_grupo <> 0 THEN
	ls_sql = ls_sql + " and inv_articulo.cod_grupo = "+string(il_grupo)
END IF
IF il_articulo <> 0 THEN
	ls_sql = ls_sql + " and inv_articulo.cod_articulo = "+string(il_articulo)
END IF

IF i_cliente > 0 THEN
	ls_sql = ls_sql + " and pv_nota_venta.cod_cliente = "+string(i_cliente)
END IF


ls_sqlfinal=ls_sql_original+ls_sql
dw_1.object.datawindow.table.select = ls_sqlfinal
dw_1.retrieve(ii_nrcaja,gs_cod_compania)
dw_1.object.datawindow.table.select = ls_sql_original
end event

type dw_cajas from datawindow within w_rep_articulos_resumido
integer x = 23
integer y = 68
integer width = 462
integer height = 80
integer taborder = 10
string dataobject = "d_dddw_cajas"
boolean border = false
boolean livescroll = true
end type

event itemchanged;ii_nrcaja= integer(data)

end event

type st_2 from statictext within w_rep_articulos_resumido
integer x = 654
integer y = 172
integer width = 183
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

type st_1 from statictext within w_rep_articulos_resumido
integer x = 23
integer y = 172
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

type em_hasta from editmask within w_rep_articulos_resumido
integer x = 841
integer y = 168
integer width = 338
integer height = 80
integer taborder = 50
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

type em_desde from editmask within w_rep_articulos_resumido
integer x = 247
integer y = 168
integer width = 338
integer height = 80
integer taborder = 40
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

type dw_1 from datawindow within w_rep_articulos_resumido
integer x = 5
integer y = 288
integer width = 3200
integer height = 1188
string dataobject = "d_rep_articulo_resumido"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type gb_1 from groupbox within w_rep_articulos_resumido
integer width = 3269
integer height = 272
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Fechas:"
end type

