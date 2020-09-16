$PBExportHeader$w_busqueda_art_pase.srw
$PBExportComments$Selección de artículos
forward
global type w_busqueda_art_pase from window
end type
type cb_descrip from commandbutton within w_busqueda_art_pase
end type
type cb_codigo from commandbutton within w_busqueda_art_pase
end type
type dw_barras from datawindow within w_busqueda_art_pase
end type
type dw_unip from datawindow within w_busqueda_art_pase
end type
type cbx_turbo from checkbox within w_busqueda_art_pase
end type
type cb_1 from commandbutton within w_busqueda_art_pase
end type
type dw_art_suc from datawindow within w_busqueda_art_pase
end type
type r_1 from rectangle within w_busqueda_art_pase
end type
type dw_bodegas from datawindow within w_busqueda_art_pase
end type
type dw_condiciones from datawindow within w_busqueda_art_pase
end type
end forward

shared variables

end variables

global type w_busqueda_art_pase from window
integer x = 1582
integer y = 1180
integer width = 3177
integer height = 1272
boolean titlebar = true
string title = "Stock Sucursales"
boolean controlmenu = true
windowtype windowtype = child!
long backcolor = 134217741
integer transparency = 68
event mil pbm_dwnprintmarginchange
event inserta ( )
cb_descrip cb_descrip
cb_codigo cb_codigo
dw_barras dw_barras
dw_unip dw_unip
cbx_turbo cbx_turbo
cb_1 cb_1
dw_art_suc dw_art_suc
r_1 r_1
dw_bodegas dw_bodegas
dw_condiciones dw_condiciones
end type
global w_busqueda_art_pase w_busqueda_art_pase

type variables
long il_filas
integer ii_bodega


end variables

event inserta;/*long ll_fila
int li_cont,li_i  
dw_visualiza_precios.hide()
if il_items <> 0 then
if il_items > dw_det.rowcount() then
 if gdw_cab.getitemnumber(1,"nr_devol") = 0 then
	gdw_det.accepttext()
	if not dw_det_pago.visible then
		if dw_det.rowcount() > 0 then 
			if isnull(dw_det.getitemnumber(dw_det.getrow(),"cod_articulo")) then	return
		end if
		ll_fila = dw_det.insertrow(0)
		dw_det.scrolltorow(ll_fila)	
		dw_det.setitem(ll_fila,"prc_iva",gc_iva)
		dw_det.setitem(ll_fila,"cod_compania",gs_cod_compania)
      dw_det.setitem(ll_fila,"cant_pres",0.00)				
	end if
	dw_cab.accepttext()
	dw_det.event refrescar()	
	dw_det.accepttext()
	dw_det.event ue_asigna_variables ()	
	w_busqueda_art.show()
	w_busqueda_art.dw_condiciones.setfocus()	
	end if	
else
f_mensajes(617)
end if
else
	if dw_cab.getitemnumber(1,"nr_devol") = 0 then
	dw_det.accepttext()
	if not dw_det_pago.visible then
		if dw_det.rowcount() > 0 then 
			if isnull(dw_det.getitemnumber(dw_det.getrow(),"cod_articulo")) then	return
		end if
		ll_fila = dw_det.insertrow(0)
		dw_det.scrolltorow(ll_fila)	
		dw_det.setitem(ll_fila,"prc_iva",gc_iva)
		dw_det.setitem(ll_fila,"cod_compania",gs_cod_compania)
      dw_det.setitem(ll_fila,"cant_pres",0.00)				
	end if
	dw_cab.accepttext()
	dw_det.event refrescar()	
	dw_det.accepttext()
	dw_det.event ue_asigna_variables ()	
	w_busqueda_art.show()
	w_busqueda_art.dw_condiciones.setfocus()	
    	end if	
end if	
*/
end event

on w_busqueda_art_pase.create
this.cb_descrip=create cb_descrip
this.cb_codigo=create cb_codigo
this.dw_barras=create dw_barras
this.dw_unip=create dw_unip
this.cbx_turbo=create cbx_turbo
this.cb_1=create cb_1
this.dw_art_suc=create dw_art_suc
this.r_1=create r_1
this.dw_bodegas=create dw_bodegas
this.dw_condiciones=create dw_condiciones
this.Control[]={this.cb_descrip,&
this.cb_codigo,&
this.dw_barras,&
this.dw_unip,&
this.cbx_turbo,&
this.cb_1,&
this.dw_art_suc,&
this.r_1,&
this.dw_bodegas,&
this.dw_condiciones}
end on

on w_busqueda_art_pase.destroy
destroy(this.cb_descrip)
destroy(this.cb_codigo)
destroy(this.dw_barras)
destroy(this.dw_unip)
destroy(this.cbx_turbo)
destroy(this.cb_1)
destroy(this.dw_art_suc)
destroy(this.r_1)
destroy(this.dw_bodegas)
destroy(this.dw_condiciones)
end on

event show;datawindowchild ldwc_x
dw_bodegas.getchild('cod_bodega',ldwc_x)
ldwc_x.settransobject(SQLCA)
ldwc_x.retrieve(gi_bodega)
dw_bodegas.settransobject(SQLCA)
dw_bodegas.insertrow(0)

dw_condiciones.insertrow(0)

dw_art_suc.selectrow(0,FALSE)
if not cbx_turbo.checked then
	dw_condiciones.SetColumn ("interior")
else
	dw_condiciones.SetColumn ("descripcion")
end if


dw_condiciones.setfocus()

end event

event hide;/*dw_condiciones.reset()
if isvalid(gdw_det) then
	gdw_det.TriggerEvent ('ue_elimina_nulos')
	gdw_det.setfocus()
end if*/
end event

type cb_descrip from commandbutton within w_busqueda_art_pase
boolean visible = false
integer x = 91
integer y = 1104
integer width = 731
integer height = 72
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Artículo"
end type

event clicked;dw_art_suc.setsort("descripcion A")
dw_art_suc.Sort()
end event

type cb_codigo from commandbutton within w_busqueda_art_pase
boolean visible = false
integer x = 1385
integer y = 1104
integer width = 315
integer height = 72
integer taborder = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Item"
end type

event clicked;dw_art_suc.SetSort("cod_articulo A")
dw_art_suc.Sort()
end event

type dw_barras from datawindow within w_busqueda_art_pase
event barras ( )
boolean visible = false
integer x = 2935
integer y = 1204
integer width = 105
integer height = 148
integer taborder = 80
string title = "none"
string dataobject = "d_barras"
boolean livescroll = true
end type

event barras;int li_uni,li_fil,li_art,li_conv,li_row
string ls_descrip,ls_piva,ls_abrev,ls_barras
double ldb_stock,ldb_precio
ls_barras = righttrim(dw_condiciones.object.barras[1])
li_row = this.retrieve(ls_barras)
if li_row = 0 then 
	messagebox("Información","El código de barra no existe",information!)
	dw_condiciones.object.barras[1] = ''
	return
end if
if li_row > 1 then messagebox("Error","existen dos codigos de barras iguales")
if li_row = 1 then
	li_uni = this.getitemnumber(this.getrow(),"cod_unidad")
	gdw_det.setitem(gdw_det.getrow(),"cod_unidad",li_uni)		
	li_art= this.getitemnumber(this.getrow(),"cod_articulo")
	gdw_det.setitem(gdw_det.getrow(),"cod_articulo",li_art)	
	ls_descrip= this.getitemstring(this.getrow(),"descripcion")
	gdw_det.setitem(gdw_det.getrow(),"descripcion",ls_descrip)	
	ls_piva= this.getitemstring(this.getrow(),"paga_iva")
	gdw_det.setitem(gdw_det.getrow(),"paga_iva",ls_piva)		
   li_conv= this.getitemnumber(this.getrow(),"conversion")	
	gdw_det.setitem(gdw_det.getrow(),"conversion",li_conv)		
	ldb_precio= this.getitemnumber(this.getrow(),"precioa")	
	gdw_det.setitem(gdw_det.getrow(),"pvp",ldb_precio)	
	ls_abrev= this.getitemstring(this.getrow(),"abreviacion")	
	gdw_det.setitem(gdw_det.getrow(),"abrev",ls_abrev)			
	ldb_stock= this.getitemnumber(this.getrow(),"stock_disponible")	
	gdw_det.setitem(gdw_det.getrow(),"c_stock",ldb_stock)		
	gdw_det.setitem(gdw_det.getrow(),"costo_prom",this.getitemnumber(this.getrow(),"costo_promedio"))			
	if ldb_stock >= li_conv then	
		gdw_det.setitem(gdw_det.getrow(),"cant_pres",1)		
		else
		Messagebox("Información","No hay stock disponible, debe utilizar la opción de refrescar",Information!)
		return
	end if
	gdw_det.setfocus()	
	gdw_det.setcolumn(16)
	gdw_det.triggerevent("refrescar")
	gdw_det.Selecttext (1,Len(gdw_det.GetText()))//PARA SOMBREAR
//	gdw_det.insertrow(0)  VER
end if
dw_unip.hide()
parent.hide()
//para que salte

//w_busqueda_art.show()
//w_busqueda_art.dw_condiciones.setfocus()	
//gdw_det.insertrow(0)

end event

event constructor;this.settransobject(sqlca)
end event

type dw_unip from datawindow within w_busqueda_art_pase
event esc pbm_dwescape
event enter pbm_dwnprocessenter
boolean visible = false
integer x = 2025
integer y = 1016
integer width = 78
integer height = 708
integer taborder = 50
string title = "Unidad"
string dataobject = "d_unid_precios"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event esc;this.hide()
dw_condiciones.setfocus()

end event

event enter;int li_uni,li_fil,li_art,li_conv
string ls_descrip,ls_piva,ls_abrev,ls_ivaart
double ldb_stock,ldb_precio
li_fil = dw_unip.rowcount()
if li_fil > 0 then
	li_uni = dw_unip.getitemnumber(dw_unip.getrow(),"cod_unidad")
	gdw_det.setitem(gdw_det.getrow(),"cod_unidad",li_uni)		
	li_art= this.getitemnumber(this.getrow(),"cod_articulo")
	gdw_det.setitem(gdw_det.getrow(),"cod_articulo",li_art)		
	//ldb_precio= this.getitemnumber(this.getrow(),"precioa")	
	//gdw_det.setitem(gdw_det.getrow(),"pvp",ldb_precio)		
	ls_descrip=dw_art_suc.getitemstring(dw_art_suc.getselectedrow(0),"descripcion")
	gdw_det.setitem(gdw_det.getrow(),"descripcion",ls_descrip)	
	ls_piva=gdw_cab.getitemstring(1,'paga_iva')
	if ls_piva= 'S' then
		ls_piva =dw_art_suc.getitemstring(dw_art_suc.getselectedrow(0),"paga_iva")
		gdw_det.setitem(gdw_det.getrow(),"paga_iva",ls_piva)			
		ldb_precio= this.getitemnumber(this.getrow(),"precioa")	
   	gdw_det.setitem(gdw_det.getrow(),"pvp",ldb_precio)	
	   else
		if ls_piva= 'N' then
		gdw_det.setitem(gdw_det.getrow(),"paga_iva",'N')		
 		ldb_precio= this.getitemnumber(this.getrow(),"precioa")	
	   gdw_det.setitem(gdw_det.getrow(),"pvp",ldb_precio)	
		 	else
		if ls_piva= 'M' then
			ls_ivaart =dw_art_suc.getitemstring(dw_art_suc.getselectedrow(0),"paga_iva")
			if ls_ivaart = 'S' then
				ls_piva = 'M'
				gdw_det.setitem(gdw_det.getrow(),"paga_iva",ls_piva)			
				ldb_precio= this.getitemnumber(this.getrow(),"precioa")	
			  	gdw_det.setitem(gdw_det.getrow(),"pvp",ldb_precio)	

				else
				gdw_det.setitem(gdw_det.getrow(),"paga_iva",'N')
				ldb_precio= this.getitemnumber(this.getrow(),"precioa")	
         	gdw_det.setitem(gdw_det.getrow(),"pvp",ldb_precio)	
				end if	
		end if
	end if
   end if
	li_conv= this.getitemnumber(this.getrow(),"conversion")	
	gdw_det.setitem(gdw_det.getrow(),"conversion",li_conv)		
	ls_abrev= this.getitemstring(this.getrow(),"abreviacion")
	gdw_det.setitem(gdw_det.getrow(),"abrev",ls_abrev)		
	SELECT stock_disponible INTO :ldb_stock FROM inv_articulos_bodega
	WHERE cod_articulo = :li_art and cod_bodega = :gi_bodega;
 	gdw_det.setitem(gdw_det.getrow(),"c_stock",ldb_stock)		
	gdw_det.setitem(gdw_det.getrow(),"costo_prom",dw_art_suc.getitemnumber(dw_art_suc.getselectedrow(0),"costo_promedio"))
   if ldb_stock > 0 and ldb_stock < 1 then
   	gdw_det.setitem(gdw_det.getrow(),"cant_pres",ldb_stock)		
   	else	
   if ldb_stock >= li_conv then	
		gdw_det.setitem(gdw_det.getrow(),"cant_pres",1)		
	else
		Messagebox("Información","No hay stock disponible, debe utilizar la opción de refrescar",Information!)
		return -1
	end if
end if
	gdw_det.setfocus()	
	gdw_det.setcolumn(16)
	gdw_cab.triggerevent("refrescar")
	gdw_det.Selecttext (1,Len(gdw_det.GetText()))
end if
dw_unip.hide()
parent.hide()
return 1
end event

event rowfocuschanged;this.selectrow(0,false)
this.selectrow(currentrow,true)
end event

event constructor;this.settransobject(SQLCA)
//this.setrowfocusindicator(HAND!)

end event

type cbx_turbo from checkbox within w_busqueda_art_pase
boolean visible = false
integer x = 2766
integer y = 84
integer width = 530
integer height = 76
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Código de Barra"
end type

event clicked;if cbx_turbo.checked then
	si_barra=1
	dw_condiciones.settaborder("barras",10)
	dw_condiciones.settaborder("interior",20)
	dw_condiciones.settaborder("descripcion",30)
	dw_condiciones.reset()
	dw_condiciones.insertrow(0)	
	dw_art_suc.selectrow(0,false)	
else
	si_barra=0
	dw_unip.hide()
	dw_condiciones.settaborder("barras",0)
	dw_art_suc.selectrow(0,false)
end if
dw_condiciones.setfocus()
end event

type cb_1 from commandbutton within w_busqueda_art_pase
integer x = 928
integer y = 1084
integer width = 425
integer height = 96
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Actualizar"
end type

event clicked;dw_unip.hide()
il_filas=dw_art_suc.retrieve(ii_bodega)
dw_condiciones.setfocus()
end event

type dw_art_suc from datawindow within w_busqueda_art_pase
event tecla pbm_dwnkey
event esc pbm_dwescape
event enter pbm_dwnprocessenter
integer x = 14
integer y = 348
integer width = 3150
integer height = 708
integer taborder = 40
string dataobject = "d_selecc_articulo_suc"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event tecla;CHOOSE CASE key
	CASE KeyUpArrow!
		f_tecla_navegar ( THIS,8,this)
	CASE KeyDownArrow!
		f_tecla_navegar ( THIS,2,this)			
	CASE KeyPageUp!		
		dw_condiciones.setfocus()
	CASE Keyescape!			
		//this.event esc()
END CHOOSE
	
end event

event esc;		parent.hide()
end event

event enter;/*long ll_fil,ll_art,ll_nfila,ll_uni
decimal lc_stock
ll_fil = dw_art_suc.getselectedrow(0)
if ll_fil > 0 then
	ll_art = this.getitemnumber(ll_fil,"cod_articulo")
	dw_unip.retrieve(ll_art)
	dw_unip.visible= true
	dw_unip.setfocus()
	dw_unip.selectrow(1,true)
end if
dw_condiciones.accepttext()
*/
end event

event clicked;if row > 0 then
	this.selectrow(0,false)
	this.selectrow(row,true)
	this.scrolltorow(row)
end if

end event

event constructor;this.settransobject(SQLCA)
this.setrowfocusindicator(hand!)
this.retrieve(ii_bodega)

end event

event buttonclicked;if row>0 then
	this.accepttext()
	IF this.object.transfiere[row]> 0  THEN
		if f_transferencia(gi_cod_funcionario,this.object.cod_articulo[row],this.object.cod_unidad[row],ii_bodega,gi_bodega,this.object.transfiere[row]) < 0 then
     	messagebox("Atención" ,"Tranferencia No Generada")
     	rollback;
     	return -1
        else
			commit;
			w_busqueda_art.dw_art_suc.retrieve(gi_bodega)
		  	messagebox("Atención" ,"Tranferencia OK")
	  end IF
	
    END  IF
	this.object.transfiere[row]=0
end if	
end event

event itemchanged;if row > 0 then
	long ldb_s,ldb_transfiere
if dwo.name='transfiere' then
	ldb_transfiere=double(data)
	if ldb_transfiere > this.object.stock_disponible[row] then
         this.object.transfiere[row]=0
  end if
end if	
end if

end event

event editchanged;if row > 0 then
	long ldb_s,ldb_transfiere
if dwo.name='transfiere' then
	ldb_transfiere=double(data)
	if ldb_transfiere > this.object.stock_disponible[row] then
         this.object.transfiere[row]=0
  end if
end if	
end if

end event

type r_1 from rectangle within w_busqueda_art_pase
integer linethickness = 4
long fillcolor = 134217739
integer x = 1687
integer y = 52
integer width = 960
integer height = 288
end type

type dw_bodegas from datawindow within w_busqueda_art_pase
integer x = 1701
integer y = 64
integer width = 937
integer height = 108
integer taborder = 40
string title = "none"
string dataobject = "d_dddw_bodegas"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

event itemchanged;this.accepttext()
ii_bodega = integer(data)
dw_art_suc.retrieve(ii_bodega)
end event

type dw_condiciones from datawindow within w_busqueda_art_pase
event enter pbm_dwnprocessenter
event tecla pbm_dwnkey
event esc pbm_dwescape
event tecla1 ( )
integer x = 14
integer y = 48
integer width = 1669
integer height = 288
integer taborder = 10
string dataobject = "d_ext_busqueda"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event enter;long ll_fila,ll_art
double lc_stock
string barras
if this.getcolumnname() = "barras" then
 dw_barras.event barras() 
end if
ll_fila = dw_art_suc.getselectedrow(0)
dw_art_suc.event enter()
return 1

end event

event tecla;CHOOSE CASE key
	CASE KeyInsert!
  if cbx_turbo.checked = false  then
	   cbx_turbo.checked= true
	si_barra=1
	dw_condiciones.settaborder("barras",10)
	dw_condiciones.settaborder("interior",20)
	dw_condiciones.settaborder("descripcion",30)
	dw_condiciones.settaborder("alterno",40)
	dw_condiciones.reset()
	dw_condiciones.insertrow(0)	
	dw_art_suc.selectrow(0,false)	
else
	
	cbx_turbo.checked = false  
	si_barra=0
	dw_unip.hide()
	dw_condiciones.settaborder("barras",0)
	dw_art_suc.selectrow(0,false)
end if
return 1
END CHOOSE
dw_condiciones.setfocus()		

////
CHOOSE CASE key
	CASE KeyupArrow!
		this.settext("")	
		if this.getcolumnname() = "descripcion" then
			this.setcolumn("interior")
		elseif this.getcolumnname() = "interior" then
			this.setcolumn("barras")
		end if
		return 0
	CASE KeydownArrow!
		this.settext("")	
		if this.getcolumnname() = "barras" then
			this.setcolumn("interior")
			end if	
		if this.getcolumnname() = "interior" then
			this.setcolumn("descripcion")			
		end if
		if this.getcolumnname() = "alterno" then
			this.setcolumn("descripcion")
			end if	
		
		return 0	
	CASE KeyPageDown!	
		dw_art_suc.setfocus()
	CASE KeyrightArrow!
		this.settext("")	
		if this.getcolumnname() = "interior" then
			this.setcolumn("alterno")
			end if	
		return 0	
	CASE KeyleftArrow!
		this.settext("")	
		if this.getcolumnname() = "alterno" then
			this.setcolumn("interior")
			end if	
		return 0	
		
END CHOOSE




end event

event esc;parent.hide()




end event

event editchanged;long ll_fila,ll_row, ll_len
string ls_dato,ls_descrip
integer li_cadena
//Habilita la busqueda no rápida
dw_unip.hide()
dw_art_suc.selectrow(0,false)
if data <> "" then
	CHOOSE CASE dwo.name
		CASE "barras"
        this.accepttext()
		CASE "interior"
			li_cadena = len(data)
			if  li_cadena = 1 then
				dw_art_suc.SetSort("cod_articulo A")
				dw_art_suc.Sort()
			end if
			ls_dato = "mid(string(cod_articulo),1,len('"+data+"')) = '"+data+"'"
			ls_dato = "cod_articulo  = " + data
		CASE "descripcion"
			dw_art_suc.SetSort("descripcion A")
          dw_art_suc.Sort()

			li_cadena = len(data)
					if  li_cadena = 1 then
				dw_art_suc.setsort("descrip A")
				dw_art_suc.Sort()
			end if
 			ls_dato = "upper(mid(descripcion,1,len('"+data+"'))) =  '"+UPPER(data)+"'"
		case  "alterno"
			li_cadena = len(data)
			if  li_cadena = 1 then
				dw_art_suc.setsort("cod_barra A")
				dw_art_suc.Sort()
			end if
 			ls_dato = "upper(mid(cod_barra,1,len('"+data+"'))) =  '"+data+"'"
			
	END CHOOSE
	if dwo.name <> "barras" then
		ll_row = dw_art_suc.Find(ls_dato,1,dw_art_suc.rowcount())
		IF ll_row > 0 THEN
			dw_art_suc.ScrollToRow(ll_row)
			dw_art_suc.selectrow(ll_row,true)	
		end if
	end if
end if
end event

event itemfocuschanged;if  dwo.name = "descripcion" then
	this.setitem(row,"interior","")		
elseif  dwo.name = "interior" then
	this.setitem(row,"descripcion","")		
end if
if  dwo.name <> "barras" then dw_condiciones.setfocus()
if cbx_turbo.checked then
	dw_condiciones.settaborder("barras",10)
	dw_condiciones.settaborder("interior",20)
	dw_condiciones.settaborder("descripcion",30)
	dw_condiciones.setcolumn(1)
end if
this.accepttext()
end event

event getfocus;//if this.getcolumnname() = "interior" then
////	 dw_art_suc.setsort("cod_articulo A")			
//	 dw_condiciones.SetColumn ("interior")
//elseif this.getcolumnname() = "descripcion" then
////	 dw_art_suc.setsort("descripcion A")				
//	 dw_condiciones.SetColumn ("descripcion")
//end if
end event

