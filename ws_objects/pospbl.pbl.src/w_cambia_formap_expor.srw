$PBExportHeader$w_cambia_formap_expor.srw
$PBExportComments$Cambia la forma de pago del ticket.
forward
global type w_cambia_formap_expor from window
end type
type dw_cajas from datawindow within w_cambia_formap_expor
end type
type cb_4 from commandbutton within w_cambia_formap_expor
end type
type dw_det_pago1 from datawindow within w_cambia_formap_expor
end type
type cb_3 from commandbutton within w_cambia_formap_expor
end type
type dw_det_pago from datawindow within w_cambia_formap_expor
end type
type cb_2 from commandbutton within w_cambia_formap_expor
end type
type cb_1 from commandbutton within w_cambia_formap_expor
end type
type em_1 from editmask within w_cambia_formap_expor
end type
type gb_1 from groupbox within w_cambia_formap_expor
end type
end forward

global type w_cambia_formap_expor from window
integer x = 823
integer y = 360
integer width = 3360
integer height = 1844
boolean titlebar = true
string title = "Nota de venta anterior"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
dw_cajas dw_cajas
cb_4 cb_4
dw_det_pago1 dw_det_pago1
cb_3 cb_3
dw_det_pago dw_det_pago
cb_2 cb_2
cb_1 cb_1
em_1 em_1
gb_1 gb_1
end type
global w_cambia_formap_expor w_cambia_formap_expor

type variables
integer ii_nrcaja
string is_subempresa
end variables

on w_cambia_formap_expor.create
this.dw_cajas=create dw_cajas
this.cb_4=create cb_4
this.dw_det_pago1=create dw_det_pago1
this.cb_3=create cb_3
this.dw_det_pago=create dw_det_pago
this.cb_2=create cb_2
this.cb_1=create cb_1
this.em_1=create em_1
this.gb_1=create gb_1
this.Control[]={this.dw_cajas,&
this.cb_4,&
this.dw_det_pago1,&
this.cb_3,&
this.dw_det_pago,&
this.cb_2,&
this.cb_1,&
this.em_1,&
this.gb_1}
end on

on w_cambia_formap_expor.destroy
destroy(this.dw_cajas)
destroy(this.cb_4)
destroy(this.dw_det_pago1)
destroy(this.cb_3)
destroy(this.dw_det_pago)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.em_1)
destroy(this.gb_1)
end on

event open;em_1.setfocus()
datawindowchild ldwc_x
dw_cajas.getchild('caja',ldwc_x)
ldwc_x.settransobject(SQLCA)
ldwc_x.retrieve(gs_cod_compania)
dw_cajas.settransobject(SQLCA)
dw_cajas.insertrow(0)

end event

type dw_cajas from datawindow within w_cambia_formap_expor
integer x = 471
integer y = 108
integer width = 485
integer height = 96
integer taborder = 40
string title = "none"
string dataobject = "d_dddw_cajas"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;this.accepttext()
ii_nrcaja = integer(data)
end event

type cb_4 from commandbutton within w_cambia_formap_expor
integer x = 1001
integer y = 120
integer width = 343
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Limpiar"
boolean default = true
end type

event clicked;int li_fila,li_nulo
string ls_nulo
li_fila = dw_det_pago.getrow()
setnull(ls_nulo)
setnull(li_nulo)
if li_fila > 0 then
   dw_det_pago.setitem(li_fila,"aux",li_nulo)
   dw_det_pago.setitem(li_fila,"monto",li_nulo)
   dw_det_pago.setitem(li_fila,"nr_cta",ls_nulo)
	dw_det_pago.setitem(li_fila,"nr_cheque",ls_nulo)
   dw_det_pago.setitem(li_fila,"cod_banco",li_nulo)
	dw_det_pago.setitem(li_fila,"cod_tarjeta",li_nulo)
   dw_det_pago.setitem(li_fila,"tipo_credito",ls_nulo)
	if li_fila = 1 then dw_det_pago.setitem(li_fila,"forma_pago",1)
	if li_fila = 2 then dw_det_pago.setitem(li_fila,"forma_pago",2)	
	if li_fila = 3 then dw_det_pago.setitem(li_fila,"forma_pago",3)	
end if

end event

type dw_det_pago1 from datawindow within w_cambia_formap_expor
integer x = 14
integer y = 324
integer width = 3282
integer height = 680
integer taborder = 70
boolean enabled = false
boolean titlebar = true
string title = "Forma de pago original"
string dataobject = "d_pago_devol1"
boolean hscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_3 from commandbutton within w_cambia_formap_expor
integer x = 2071
integer y = 120
integer width = 343
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "G&rabar"
boolean default = true
end type

event clicked;long ll_num,ll_cliente
string ls_estado
double ldb_dif
dw_det_pago.accepttext()
ldb_dif = dw_det_pago.getitemnumber(dw_det_pago.rowcount(),"dif")
ll_num = long(em_1.text)
SELECT pv_nota_venta.estado INTO :ls_estado  
FROM pv_nota_venta  
WHERE ( pv_nota_venta.cod_compania = :gs_cod_compania ) AND  
( pv_nota_venta.nr_caja = :ii_nrcaja ) AND 
( pv_nota_venta.numero = :ll_num ) and
( pv_nota_venta.tipo_doc = 'EV' );
if ls_estado = 'P' then
	messagebox("Información","Este ticket esta incluido en el cierre de caja~r~n No puede cambiar la forma de pago")
	return
else
  if ldb_dif <> 0 then
		messagebox("Información","La cantidad total no es igual a la original")
		return
	else
		DELETE pv_detalle_pago   
     WHERE ( cod_compania = :gs_cod_compania ) 
	  AND (numero = :ll_num )
	  and tipo_doc = 'EV'
	  and nr_caja=:ii_nrcaja;
	  integer i,pr
	  for i=dw_det_pago.rowcount()  to 1 step -1
		i=i
		pr = dw_det_pago.object.aux[i]
	  	if dw_det_pago.object.aux[i] = 0 or isnull(pr) then
   	dw_det_pago.deleterow(i)
      end if	
     next
	  for i=1 to dw_det_pago.rowcount()
		  dw_det_pago.object.cod_compania[i] = gs_cod_compania
		  dw_det_pago.object.nr_caja[i] =ii_nrcaja
		 dw_det_pago.object.subempresa[i] =is_subempresa
		 /*
		 if dw_det_pago.object.forma_pago[i]=4 then //credito
		 ll_cliente=f_busca_cliente(ii_nrcaja,ll_num)
		 if isnull(ll_cliente) then ll_cliente=0
		 if ll_cliente > 0 then
			
			
		end if  //ll_cliente	
      	end if   //credito
			*/
     next
   	if dw_det_pago.update() < 0 then
			messagebox("Atención"," no se puede actualizar verifique" )
			return -1
			 rollback;
      end  if
		commit;
		
	end if
end if
dw_det_pago1.reset()
dw_det_pago.reset()
em_1.text = ''
commit;
end event

type dw_det_pago from datawindow within w_cambia_formap_expor
event refresca ( long al_banco )
event enter pbm_dwnprocessenter
integer x = 27
integer y = 1024
integer width = 3287
integer height = 720
integer taborder = 60
boolean titlebar = true
string title = "Nueva forma de pago"
string dataobject = "d_pago_devol"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event refresca;datawindowchild ldwch_tarjeta
this.getchild('cod_tarjeta',ldwch_tarjeta)
ldwch_tarjeta.settransobject(sqlca)
ldwch_tarjeta.retrieve(al_banco)
ldwch_tarjeta.insertrow(0)
end event

event enter;if (this.getitemnumber(this.getrow(),"forma_pago") = 1 and this.getcolumnname() = 'aux' ) or (this.getitemnumber(this.getrow(),"forma_pago") = 2 and this.getcolumnname() = 'cod_banco') and (this.getitemnumber(this.getrow(),"forma_pago") = 3) then
	return 0
end if	
send(Handle(this),256,9,Long(0,0))	
return 1

end event

event constructor;this.settransobject(SQLCA)
this.event refresca (0)
end event

event itemchanged;if this.object.aux[3] > 0 then
	if dwo.name = 'cod_banco' then
      this.event refresca (integer(data))
	end if
end if
end event

event itemerror;if this.object.aux[2] > 0 or this.object.aux[3] > 0 then
if dwo.name = 'nr_cta' or dwo.name = 'nr_cheque' or dwo.name = 'cod_banco' or dwo.name = 'cod_tarjeta' or dwo.name = 'tipo_credito'  then
	messagebox("Información","Este dato es obligatorio",information!)
	return -1
end if
end if
end event

event editchanged;double ldb_dif
if this.getcolumnname() = "aux" then 
	this.accepttext()
	this.object.monto[1] = this.object.aux[1]
	this.object.monto[2] = this.object.aux[2]
	this.object.monto[3] = this.object.aux[3]
	this.object.monto[4] = this.object.aux[4]
end if

end event

type cb_2 from commandbutton within w_cambia_formap_expor
integer x = 1358
integer y = 120
integer width = 343
integer height = 100
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Buscar"
boolean default = true
end type

event clicked;int li_cont,li_i,li_npago,li_banco
datawindowchild dw_tarj,dw_tarjeta
string ls_abrev
double ldb_total
long ll_num
ll_num = long(em_1.text)
if ll_num = 0 then
	if messagebox("ERROR","Debe digitar un número de ticket válido. Desea continuar con la devolución ?",question!,yesno!,li_i) = li_i then
		CloseWithReturn (parent,long(em_1.text))		
		return
	end if
end if
SELECT sum(pv_nota_venta.total) INTO :ldb_total  
FROM pv_nota_venta WHERE ( pv_nota_venta.cod_compania = :gs_cod_compania ) AND  
( pv_nota_venta.nr_caja = :ii_nrcaja ) AND  
( pv_nota_venta.numero = :ll_num )   and
 ( pv_nota_venta.tipo_doc = 'EV' );
if ldb_total < 0 then
	messagebox("Aviso","Este ticket es por devolucion")
	em_1.setfocus()
	return
end if

dw_det_pago.reset()
dw_det_pago1.reset()
dw_det_pago1.settransobject(sqlca)
dw_det_pago1.getchild("cod_tarjeta",dw_tarjeta)
dw_tarjeta.settransobject(sqlca)
dw_tarjeta.retrieve(0)
dw_tarjeta.insertrow(0)
dw_tarjeta.setitem(1,"cod_banco",0)
li_cont = dw_det_pago1.retrieve(gs_cod_compania,ll_num,ii_nrcaja) //gs_cod_compania
for li_i = 1 to dw_det_pago1.rowcount()
  dw_det_pago1.setitem(li_i,"aux",dw_det_pago1.getitemnumber(li_i,"monto"))	
  li_banco = dw_det_pago1.getitemnumber(li_i,"cod_banco")
  dw_det_pago1.getchild("cod_tarjeta",dw_tarjeta)
  dw_tarjeta.settransobject(sqlca)
  dw_tarjeta.retrieve(li_banco)
  dw_tarjeta.insertrow(0)
  dw_tarjeta.setitem(1,"cod_banco",0)
next	
dw_det_pago1.accepttext()
if li_cont < 1 then
	messagebox("Información","Este ticket no existe")
	return
end if
for li_i = 1 to 4
	dw_det_pago.getchild("cod_tarjeta",dw_tarj)
	dw_tarj.settransobject(sqlca)
	dw_tarj.retrieve(0)
	dw_tarj.insertrow(0)
	dw_tarj.setitem(1,"cod_banco",0)
	dw_det_pago.insertrow(0)
	dw_det_pago.setitem(li_i,"det_pago",li_i)
	dw_det_pago.setitem(li_i,"numero",long(em_1.text))
//	
	if li_i= 1 then dw_det_pago.setitem(li_i,"forma_pago",1)
	if li_i= 2 then dw_det_pago.setitem(li_i,"forma_pago",2)
	if li_i= 3 then dw_det_pago.setitem(li_i,"forma_pago",3)
	if li_i= 4 then dw_det_pago.setitem(li_i,"forma_pago",4)
next
for li_i = 1 to dw_det_pago1.rowcount()
	if dw_det_pago1.getitemnumber(li_i,"forma_pago") = 1 then 
		dw_det_pago.setitem(1,"forma_pago",1)
		dw_det_pago.setitem(1,"monto",dw_det_pago1.getitemnumber(li_i,"monto"))
		dw_det_pago.setitem(1,"aux",dw_det_pago1.getitemnumber(li_i,"monto"))
		dw_det_pago.setitem(1,"subempresa",dw_det_pago1.object.subempresa[li_i])
		is_subempresa=dw_det_pago1.object.subempresa[li_i]
	end if
	if dw_det_pago1.getitemnumber(li_i,"forma_pago") = 2 then 
		dw_det_pago.setitem(2,"forma_pago",2)		
		dw_det_pago.setitem(2,"monto",dw_det_pago1.getitemnumber(li_i,"monto"))
		dw_det_pago.setitem(2,"aux",dw_det_pago1.getitemnumber(li_i,"monto"))
		dw_det_pago.setitem(2,"nr_cta",dw_det_pago1.getitemstring(li_i,"nr_cta"))		
		dw_det_pago.setitem(2,"nr_cheque",dw_det_pago1.getitemstring(li_i,"nr_cheque"))
		dw_det_pago.setitem(2,"cod_banco",dw_det_pago1.getitemnumber(li_i,"cod_banco"))
		dw_det_pago.setitem(2,"subempresa",dw_det_pago1.object.subempresa[li_i])
   		is_subempresa=dw_det_pago1.object.subempresa[li_i]
		end if
	if dw_det_pago1.getitemnumber(li_i,"forma_pago") = 3 then 
		dw_det_pago.setitem(3,"forma_pago",3)
		dw_det_pago.setitem(3,"monto",dw_det_pago1.getitemnumber(li_i,"monto"))
		dw_det_pago.setitem(3,"aux",dw_det_pago1.getitemnumber(li_i,"monto"))
		dw_det_pago.setitem(3,"nr_cta",dw_det_pago1.getitemstring(li_i,"nr_cta"))
		dw_det_pago.setitem(3,"nr_cheque",dw_det_pago1.getitemstring(li_i,"nr_cheque"))				
		dw_det_pago.setitem(3,"cod_banco",dw_det_pago1.getitemnumber(li_i,"cod_banco"))
		dw_det_pago.setitem(3,"subempresa",dw_det_pago1.object.subempresa[li_i])
		is_subempresa=dw_det_pago1.object.subempresa[li_i]
      li_banco = dw_det_pago1.getitemnumber(li_i,"cod_banco")
		dw_tarj.settransobject(sqlca)
		dw_tarj.retrieve(li_banco)
		dw_tarj.insertrow(0)
		dw_tarj.setitem(1,"cod_banco",0)
		dw_det_pago.setitem(3,"cod_tarjeta",dw_det_pago1.getitemnumber(li_i,"cod_tarjeta"))
		dw_det_pago.setitem(3,"tipo_credito",dw_det_pago1.getitemstring(li_i,"tipo_credito"))
	end if
	if dw_det_pago1.getitemnumber(li_i,"forma_pago") = 4 then 
		dw_det_pago.setitem(4,"forma_pago",4)
		dw_det_pago.setitem(4,"monto",dw_det_pago1.getitemnumber(li_i,"monto"))
		dw_det_pago.setitem(4,"aux",dw_det_pago1.getitemnumber(li_i,"monto"))
		dw_det_pago.setitem(4,"subempresa",dw_det_pago1.object.subempresa[li_i])
		is_subempresa=dw_det_pago1.object.subempresa[li_i]
	end if
next
ldb_total = dw_det_pago1.getitemnumber(dw_det_pago1.rowcount(),"subtotal")
dw_det_pago.setitem(dw_det_pago.rowcount(),"total",ldb_total)


end event

type cb_1 from commandbutton within w_cambia_formap_expor
integer x = 1719
integer y = 120
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
boolean default = true
end type

event clicked;Close(w_cambia_formap)
end event

type em_1 from editmask within w_cambia_formap_expor
integer x = 82
integer y = 108
integer width = 361
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

event getfocus;dw_det_pago1.reset()
dw_det_pago.reset()
this.text = ''
end event

type gb_1 from groupbox within w_cambia_formap_expor
integer x = 37
integer y = 32
integer width = 2715
integer height = 276
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

