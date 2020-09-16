$PBExportHeader$w_nota_anterior.srw
$PBExportComments$Recibe la nota de venta a devolver.
forward
global type w_nota_anterior from window
end type
type dw_det_pago1 from datawindow within w_nota_anterior
end type
type dw_det1 from datawindow within w_nota_anterior
end type
type dw_cab1 from datawindow within w_nota_anterior
end type
type cb_2 from commandbutton within w_nota_anterior
end type
type cb_1 from commandbutton within w_nota_anterior
end type
type em_1 from editmask within w_nota_anterior
end type
type gb_1 from groupbox within w_nota_anterior
end type
end forward

global type w_nota_anterior from window
integer x = 823
integer y = 360
integer width = 1074
integer height = 428
boolean titlebar = true
string title = "Nota de venta anterior"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
dw_det_pago1 dw_det_pago1
dw_det1 dw_det1
dw_cab1 dw_cab1
cb_2 cb_2
cb_1 cb_1
em_1 em_1
gb_1 gb_1
end type
global w_nota_anterior w_nota_anterior

on w_nota_anterior.create
this.dw_det_pago1=create dw_det_pago1
this.dw_det1=create dw_det1
this.dw_cab1=create dw_cab1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.em_1=create em_1
this.gb_1=create gb_1
this.Control[]={this.dw_det_pago1,&
this.dw_det1,&
this.dw_cab1,&
this.cb_2,&
this.cb_1,&
this.em_1,&
this.gb_1}
end on

on w_nota_anterior.destroy
destroy(this.dw_det_pago1)
destroy(this.dw_det1)
destroy(this.dw_cab1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.em_1)
destroy(this.gb_1)
end on

event open;em_1.setfocus()
if gc_num_factura > 0 then
	em_1.text=string(gc_num_factura)
end if	
end event

type dw_det_pago1 from datawindow within w_nota_anterior
integer x = 69
integer y = 1152
integer width = 3173
integer height = 344
integer taborder = 60
string title = "none"
string dataobject = "d_detalle_pago"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type dw_det1 from datawindow within w_nota_anterior
integer y = 344
integer width = 3511
integer height = 768
integer taborder = 50
string title = "none"
string dataobject = "d_det_devol"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type dw_cab1 from datawindow within w_nota_anterior
integer x = 1106
integer y = 24
integer width = 2578
integer height = 296
integer taborder = 40
string title = "none"
string dataobject = "d_cab_devol"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type cb_2 from commandbutton within w_nota_anterior
integer x = 654
integer y = 68
integer width = 343
integer height = 100
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Aceptar"
boolean default = true
end type

event clicked;int li_cont,li_i,li_npago,li_fila,li_uni,li_sum,li_recup,li_p,li_for
double ldb_stock,ldb_total=0,ldb_cheq,ldb_tarj,li_canpres,li_candevol,li_adevol,ldb_cred,ldb_efec,ldb_f
string ls_abrev,ls_tipo,ls_id
long ll_num,ll_art,ll_cli
datetime ldt_fecha
datawindowchild dw_tarjeta
string ls_estado
ll_num = long(em_1.text)
SELECT pv_nota_venta.estado,pv_nota_venta.tipo_doc,COD_CLIENTE,fecha_emision INTO :ls_estado,:ls_tipo,:ll_cli,:ldt_fecha
FROM pv_nota_venta
WHERE (pv_nota_venta.cod_compania = :gs_cod_compania) AND
(pv_nota_venta.nr_caja = :gi_caja) AND
(pv_nota_venta.numero = :ll_num)and
(pv_nota_venta.tipo_doc = 'EV');  //FE

if ll_cli=1 then //consumidorfina
messagebox("","No Consumidor Final")	
return 
end if


select tp_id_cli
into :gc_tipo_clie
from cliente
where cliente.cod_cliente=:ll_cli;


if messagebox("ATENCION","Esta seguro ?",question!,yesno!,li_i) = 2 then
	return
else
    dw_cab1.reset()
    dw_det1.reset()	 
	 dw_det_pago1.reset()	 
    li_recup=dw_cab1.retrieve(gs_cod_compania,gi_caja,double(em_1.text),'EV')
	 if li_recup < 1 then 
		messagebox("Aviso", "Este ticket no existe 1")
		return
    end if
	 dw_det1.retrieve(gs_cod_compania,double(em_1.text),gi_caja,'EV')
	 dw_det_pago1.settransobject(sqlca)
	 dw_det_pago1.getchild("cod_tarjeta",dw_tarjeta)
	 dw_tarjeta.settransobject(sqlca)
	 dw_tarjeta.retrieve(0)
	 dw_tarjeta.insertrow(0)
	 dw_tarjeta.setitem(1,"cod_banco",0)
	 dw_det_pago1.retrieve(gs_cod_compania,double(em_1.text),gi_caja,'EV')
	 li_npago = dw_det_pago1.rowcount()	 
	 for li_i = 1 to li_npago
		ldb_total= ldb_total + dw_det_pago1.object.monto[li_i] 
		if dw_det_pago1.object.forma_pago[li_i] = 1 then ldb_efec = dw_det_pago1.object.monto[li_i] 
		if dw_det_pago1.object.forma_pago[li_i] = 2 then ldb_cheq = dw_det_pago1.object.monto[li_i] 
		if dw_det_pago1.object.forma_pago[li_i] = 3 then ldb_tarj = dw_det_pago1.object.monto[li_i] 
		if dw_det_pago1.object.forma_pago[li_i] = 4 then ldb_cred = dw_det_pago1.object.monto[li_i] 
    next
	 if ldb_tarj > 0 or ldb_cheq > 0 then
		if ls_estado = 'C' then
   		messagebox("Información","No se puede devolver porque no es totalmente cancelada en efectivo")
	   	return -1
		end if
	 end if
	 ////////////////////////////ENTRA  VER
	 if  ldb_efec = ldb_total then  
	 gdw_det_pago.setitem(1,"aux",ldb_total)
	 gdw_det_pago.setitem(1,"monto",ldb_total)
    else
		if  ldb_efec > 0  then
		gdw_det_pago.setitem(1,"aux",ldb_efec)
      gdw_det_pago.setitem(1,"monto",ldb_efec)
   	end if
	 if ldb_cred > 0  then
	 gdw_det_pago.setitem(4,"aux",ldb_cred)
	 gdw_det_pago.setitem(4,"monto",ldb_cred)
    end if
    end if
	///////////////////////// 
	 
 	 li_cont= dw_det1.rowcount()
	 if li_cont > 0 then
		li_sum = dw_det1.getitemnumber(1,"cant_pres")
		if li_sum < 0 then
			messagebox("Aviso","Este ticket es por devolucion")
			em_1.setfocus()
			return
		end if
		gdw_cab.reset()
		gdw_cab.insertrow(0)
		gdw_det.reset()
		gdw_det_pago.reset()
     //cabecera		
	    if gb_modifica = true then
			gdw_cab.setitem(1,"numero",ll_num)
			gdw_cab.setitem(1,"tipo_doc",ls_tipo)
			gdw_cab.setitem(1,"tipocliente",gc_tipo_clie)
		 end if	
    	gdw_cab.setitem(1,"cod_vendedor",dw_cab1.object.cod_vendedor[1])
    	gdw_cab.setitem(1,"cod_compania",gs_cod_compania)		 
		 gdw_cab.setitem(1,"tipocliente",gc_tipo_clie)
		gdw_cab.setitem(1,"nr_caja",gi_caja)
		gdw_cab.setitem(1,"subempresa",gs_subempresa)
		gdw_cab.setitem(1,"ptoemi",gs_emi)
		gdw_cab.setitem(1,"estab",gs_num_suc)
		gdw_cab.setitem(1,"nr_devol",double(em_1.text))
		gdw_cab.setitem(1,"fechamodificado",ldt_fecha)
	   gdw_cab.setitem(1,"nomb_cliente",dw_cab1.getitemstring(1,"nomb_cliente"))
		gdw_cab.setitem(1,"referencia",dw_cab1.getitemstring(1,"referencia"))
		gdw_cab.setitem(1,"c_i_o_ruc",dw_cab1.getitemstring(1,"c_i_o_ruc"))
	   gdw_cab.setitem(1,"prc_iva",dw_cab1.getitemnumber(1,"prc_iva"))		
	   gdw_cab.setitem(1,"iva",dw_cab1.getitemnumber(1,"iva"))
		gdw_cab.setitem(1,"cod_cliente",dw_cab1.getitemnumber(1,"cod_cliente"))
		gdw_cab.setitem(1,"otra_ref",dw_cab1.getitemstring(1,"otra_ref"))
		gdw_cab.setitem(1,"fecha_emision",dw_cab1.object.fecha_emision[1])
     //detalle		
		for li_i = 1 to li_cont
			li_canpres =dw_det1.getitemnumber(li_i,"cant_pres")
			if isnull(li_candevol) then li_candevol = 0			
   		li_candevol = dw_det1.getitemnumber(li_i,"cant_devol")
       	li_adevol = li_canpres + li_candevol			
			if li_adevol > 0 then
   			li_fila = gdw_det.insertrow(0)			 							
				ll_art = dw_det1.getitemnumber(li_i,"cod_articulo")				
				gdw_det.setitem(li_fila,"cod_compania",gs_cod_compania) 
				gdw_det.setitem(li_fila,"tiporuc",gc_tipo_clie) 
				gdw_det.setitem(li_fila,"cod_articulo",ll_art)
				gdw_det.setitem(li_fila,"descripcion",dw_det1.getitemstring(li_i,"descripcion"))		
				gdw_det.setitem(li_fila,"tipo",dw_det1.getitemstring(li_i,"tipo"))				
				gdw_det.setitem(li_fila,"cant_pres",li_adevol)
				gdw_det.setitem(li_fila,"c_candev",li_adevol)	
				gdw_det.setitem(li_fila,"pvp",dw_det1.getitemnumber(li_i,"pvp"))
				gdw_det.setitem(li_fila,"p_unit",dw_det1.getitemnumber(li_i,"p_unit"))
				li_uni = dw_det1.getitemnumber(li_i,"cod_unidad")
				SELECT unidad.abreviacion INTO :ls_abrev  
            FROM unidad WHERE unidad.cod_unidad = :li_uni;
            if isnull(ls_abrev) then ls_abrev= ""
				gdw_det.setitem(li_fila,"abrev",ls_abrev)			
				gdw_det.setitem(li_fila,"paga_iva",dw_det1.getitemstring(li_i,"paga_iva"))
				gdw_det.setitem(li_fila,"prc_dsto",dw_det1.getitemnumber(li_i,"prc_dsto"))
				gdw_det.setitem(li_fila,"prc_iva",dw_det1.getitemnumber(li_i,"prc_iva"))
				gdw_det.setitem(li_fila,"cod_unidad",dw_det1.getitemnumber(li_i,"cod_unidad"))
				gdw_det.setitem(li_fila,"conversion",dw_det1.getitemnumber(li_i,"conversion"))
				
				gdw_det.setitem(li_fila,"cod_bodega",dw_det1.getitemnumber(li_i,"cod_bodega"))
//   			gdw_det.setitem(li_fila,"cod_bodega",gi_bodega)
				SELECT inv_articulos_bodega.stock_disponible
				INTO :ldb_stock FROM inv_articulo,inv_articulos_bodega  
				WHERE (inv_articulos_bodega.cod_articulo = inv_articulo.cod_articulo) and
				((inv_articulos_bodega.cod_articulo = :ll_art) AND  
				( inv_articulos_bodega.cod_bodega = :gi_bodega));
				gdw_det.setitem(li_fila,"c_stock",ldb_stock)
				gdw_det.setitem(li_fila,"costo_prom",dw_det1.getitemnumber(li_i,"costo_prom"))
			end if
	   next
	 else
		messagebox("Aviso","Este ticket no existe 2")
		em_1.setfocus()		
		return
	 end if
end if
if long(em_1.text) = 0 then
	if messagebox("ERROR","Debe digitar un número de ticket válido. Desea continuar con la devolución ?",question!,yesno!,li_i) = li_i then
		CloseWithReturn (parent,long(em_1.text))		
		return
	end if
else
	CloseWithReturn (parent,long(em_1.text))		
	return	
end if
end event

type cb_1 from commandbutton within w_nota_anterior
integer x = 658
integer y = 200
integer width = 343
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Cancelar"
end type

event clicked;CloseWithReturn (parent,-1)
end event

type em_1 from editmask within w_nota_anterior
integer x = 82
integer y = 124
integer width = 411
integer height = 100
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "#########0"
end type

type gb_1 from groupbox within w_nota_anterior
integer width = 1038
integer height = 324
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Digite el numero"
end type

