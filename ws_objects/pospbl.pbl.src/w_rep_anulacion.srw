$PBExportHeader$w_rep_anulacion.srw
$PBExportComments$Reimprime notas de venta
forward
global type w_rep_anulacion from window
end type
type cb_3 from commandbutton within w_rep_anulacion
end type
type rb_2 from radiobutton within w_rep_anulacion
end type
type rb_1 from radiobutton within w_rep_anulacion
end type
type dw_det_pago from datawindow within w_rep_anulacion
end type
type dw_col from datawindow within w_rep_anulacion
end type
type dw_prop from datawindow within w_rep_anulacion
end type
type cb_2 from commandbutton within w_rep_anulacion
end type
type cb_1 from commandbutton within w_rep_anulacion
end type
type dw_cajas from datawindow within w_rep_anulacion
end type
type st_2 from statictext within w_rep_anulacion
end type
type em_numero from editmask within w_rep_anulacion
end type
type dw_1 from datawindow within w_rep_anulacion
end type
type gb_1 from groupbox within w_rep_anulacion
end type
end forward

global type w_rep_anulacion from window
integer x = 823
integer y = 360
integer width = 3250
integer height = 2032
boolean titlebar = true
string title = "Anulación de N/Venta"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
event cerrar ( )
cb_3 cb_3
rb_2 rb_2
rb_1 rb_1
dw_det_pago dw_det_pago
dw_col dw_col
dw_prop dw_prop
cb_2 cb_2
cb_1 cb_1
dw_cajas dw_cajas
st_2 st_2
em_numero em_numero
dw_1 dw_1
gb_1 gb_1
end type
global w_rep_anulacion w_rep_anulacion

type variables
int ii_nrcaja
end variables

event cerrar;close(this)
end event

on w_rep_anulacion.create
this.cb_3=create cb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.dw_det_pago=create dw_det_pago
this.dw_col=create dw_col
this.dw_prop=create dw_prop
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_cajas=create dw_cajas
this.st_2=create st_2
this.em_numero=create em_numero
this.dw_1=create dw_1
this.gb_1=create gb_1
this.Control[]={this.cb_3,&
this.rb_2,&
this.rb_1,&
this.dw_det_pago,&
this.dw_col,&
this.dw_prop,&
this.cb_2,&
this.cb_1,&
this.dw_cajas,&
this.st_2,&
this.em_numero,&
this.dw_1,&
this.gb_1}
end on

on w_rep_anulacion.destroy
destroy(this.cb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.dw_det_pago)
destroy(this.dw_col)
destroy(this.dw_prop)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_cajas)
destroy(this.st_2)
destroy(this.em_numero)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event open;integer li_existe,li_fun,li_impresion=1
double ldb_det,ldb_summ,ldb_cab
string ls_cab,ls_sum,ls_columna,ls_prop,ls_mody
integer li_num,li_i,li_columna,li_num2,li_j
SELECT pv_caja.nr_caja  INTO :li_existe FROM pv_caja WHERE pv_caja.cod_compania = :gs_cod_compania;
if isnull(li_existe) then li_existe = 0
if li_existe = 0 then
	messagebox("Error","No se ha definido ninguna caja",exclamation!)
	close(this)
	return 
end if
datawindowchild ldwc_x
dw_cajas.getchild('caja',ldwc_x)
ldwc_x.settransobject(SQLCA)
ldwc_x.retrieve(gs_cod_compania)
dw_cajas.settransobject(SQLCA)
dw_cajas.insertrow(0)
open(w_autoriza_elim)
li_fun = message.doubleparm
if li_fun > 0 then
   this.enabled= true
   em_numero.setfocus()	
elseif li_fun = 0 then
	close(w_rep_anulacion)
	return
end if
//Recupera propiedades del datawindow dinamico
if li_impresion = 1 then
   dw_1.DataObject = "d_elim_nota_dinamico"
	dw_col.reset()
	dw_prop.reset()
	//matricial
   dw_1.settransobject(sqlca)
	select forma.detail,forma.summary,forma.header 
	into :ldb_det,:ldb_summ,:ldb_cab from forma 
	where (forma.cod_forma = 5) and (forma.tipo_forma = 4);
	if sqlca.sqlcode < 0 then
		messagebox("Información","No se puede recuperar los datos del Ticket dinamico",information!)
		Return
	end if
		// Recupera las medidas de las bandas del datawindow
		ls_cab = "Datawindow.header.height=" + string(ldb_cab)
	//	dw_1.Modify(ls_cab)
	//	dw_1.modify("Datawindow.Detail.Height="+string(ldb_det))
		//ls_sum = "Datawindow.summay.height=" + string(ldb_summ)
		//dw_1.modify(ls_sum)
		if dw_col.Retrieve(5) < 0 then
			messagebox("Información","No se puede recuperar las columnas del Ticket dinamico",information!)
			Return
		end if
		li_num = dw_col.rowcount()
		if li_num > 0 then
   /*	for li_i = 1 to li_num
				li_columna=dw_col.object.num_col[li_i]
				ls_columna=righttrim(dw_col.object.nom_col[li_i])
	    		if dw_prop.Retrieve(5,li_columna) < 0 then
               messagebox("Información","No se puede recuperar las propiedades del Ticket dinamico",information!)	
					Return
				end if
				li_num2 = dw_prop.rowcount()
				if li_num2 > 0 then
					// Recupera propiedades
					for li_j=1 to li_num2
						ls_prop = lefttrim(dw_prop.object.nom_prop [li_j])
						ls_mody = ""
						ls_mody = righttrim(ls_columna) + "." + (ls_prop)
						dw_1.modify(ls_mody)
					next
				else
               messagebox("Información","No hay propiedades para el Ticket dinamico",information!)						
			   	Return
				end if
			next */
		else
			messagebox("Información","No hay columnas para el Ticket dinamico",information!)						
			Return
	  end if
elseif gi_impresion = 0 then 
	dw_1.DataObject = "d_imp_nota_imp1"
	dw_1.settransobject(sqlca)
elseif gi_impresion = 2 then
	//ticket
	dw_1.DataObject = "d_imp_nota_imp2"
	dw_1.settransobject(sqlca)
end if




end event

event resize;dw_1.resize(this.width - 50,this.height - (dw_1.y + 150))
end event

event key;if key = keyescape! then	this.post event cerrar()

end event

type cb_3 from commandbutton within w_rep_anulacion
integer x = 2126
integer y = 156
integer width = 384
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Anular"
end type

event clicked;//messagebox("Atención","Prepare la Impresora")
//dw_1.print()
long li_filas,li_numero,li_movimiento,i,li_articulo,li_unidad,li_conver,li_bodega
string ls_tipo,ls_msg,ls_num
char ls_estado
double ldb_cantidad
li_filas = dw_1.rowcount()
//////////////////////////////
	//voy actualizar inventarios//REVISAR SI HAY STOCK AL MENOS CUANDO ES DEVOLUCUION
  if li_filas > 0 then
	
	ls_tipo = dw_1.object.tipo_doc[1]
end if
	  for i = 1 to li_filas
		li_articulo = dw_1.object.cod_articulo[i]
      li_conver = dw_1.object.conversion_1[i]
		ldb_cantidad = ABS(dw_1.object.cant_pres[i] * li_conver)
		li_bodega = dw_1.object.cod_bodega[i]
		
		if ls_tipo ='EV' then
			//sumo inventario
			  UPDATE inv_articulo  
           SET stock_disponible = stock_disponible + :ldb_cantidad  
           WHERE inv_articulo.cod_articulo = :li_articulo   
			             ;
			 if sqlca.sqlcode < 0 then
			ls_msg = sqlca.sqlerrtext
			rollback;
			messagebox("Error","No puedo ACTUALIZAR ARTICULO 1~r~n"+ls_msg,exclamation!)
			return -1
		   end if
							 
			COMMIT;				 
			  //////////////
			  
			    UPDATE inv_articulos_bodega  
     			 SET stock_disponible = stock_disponible + :ldb_cantidad  
				 WHERE ( inv_articulos_bodega.cod_bodega = :li_bodega ) AND  
		         ( inv_articulos_bodega.cod_articulo = :li_articulo )   
      		     ;
					  
					   if sqlca.sqlcode < 0 then
			ls_msg = sqlca.sqlerrtext
			rollback;
			messagebox("Error","No puedo ACTUALIZAR ARTICULOS BODEGA 1~r~n"+ls_msg,exclamation!)
			return -1
		end if
							 
			COMMIT;				 

         else
				
				
		         //resto inventario
			  UPDATE inv_articulo  
           SET stock_disponible = stock_disponible - :ldb_cantidad  
           WHERE inv_articulo.cod_articulo = :li_articulo   
           ;
			   if sqlca.sqlcode < 0 then
			ls_msg = sqlca.sqlerrtext
			rollback;
			messagebox("Error","No puedo ACTUALIZAR ARTICULO 1~r~n"+ls_msg,exclamation!)
			return -1
		   end if
							 
			COMMIT;				 
			  
			  
			  //////////////
			  
			    UPDATE inv_articulos_bodega  
     			 SET stock_disponible = stock_disponible - :ldb_cantidad  
				 WHERE ( inv_articulos_bodega.cod_bodega = :li_bodega ) AND  
		         ( inv_articulos_bodega.cod_articulo = :li_articulo )   
      		     ;
					   if sqlca.sqlcode < 0 then
			ls_msg = sqlca.sqlerrtext
			rollback;
			messagebox("Error","No puedo ACTUALIZAR ARTICULOS BODEGA 1~r~n"+ls_msg,exclamation!)
			return -1
		   end if
							 
			COMMIT;				 
	
         end if 			
			
			
		
     next

//////////////////////////////

if li_filas > 0 then
	li_numero = dw_1.object.numero[1]
	ls_num=string(li_numero)
	ls_tipo = dw_1.object.tipo_doc[1]
	ls_estado =dw_1.object.estado[1]
	if ls_estado ='C' then
		//elimino primero el detalle de las notas de venta
		  DELETE FROM pv_det_nota_venta  
        WHERE ( pv_det_nota_venta.cod_compania = :gs_cod_compania ) AND  
         ( pv_det_nota_venta.numero = :li_numero ) AND  
         ( pv_det_nota_venta.tipo_doc = :ls_tipo )  and
		( pv_det_nota_venta.nr_caja = :ii_nrcaja )          ;
			   if sqlca.sqlcode < 0 then
			ls_msg = sqlca.sqlerrtext
			rollback;
			messagebox("Error","No puedo ELIMINAR DETALLE 1~r~n"+ls_msg,exclamation!)
			return -1
		   end if
							 
			COMMIT;				 
			  
       //ahora el detalle de pago
		 
		   DELETE FROM pv_detalle_pago  
       WHERE ( pv_detalle_pago.cod_compania = :gs_cod_compania ) AND  
         ( pv_detalle_pago.numero = :li_numero ) AND  
         ( pv_detalle_pago.tipo_doc = :ls_tipo )   and
     	( pv_detalle_pago.nr_caja = :ii_nrcaja )           ;
		   if sqlca.sqlcode < 0 then
			ls_msg = sqlca.sqlerrtext
			rollback;
			messagebox("Error","No puedo ELIMINAR PAGO 1~r~n"+ls_msg,exclamation!)
			return -1
		   end if
							 
			COMMIT;		
			
					  
        //ahora pv_nv_movimiento
		  //antes voy a buscar el numero de movimiento
		  //
		    SELECT pv_nv_movimiento.nr_movimiento  
         INTO :li_movimiento  
         FROM pv_nv_movimiento  
       WHERE ( pv_nv_movimiento.cod_compania = :gs_cod_compania ) AND  
         ( pv_nv_movimiento.numero = :li_numero ) AND  
         ( pv_nv_movimiento.tipo_movimiento = :ls_tipo ) and
	   ( pv_nv_movimiento.nr_caja = :ii_nrcaja ) 		;

		  
		  //
		  
		    DELETE FROM pv_nv_movimiento  
          WHERE ( pv_nv_movimiento.cod_compania = :gs_cod_compania ) AND  
         ( pv_nv_movimiento.numero = :li_numero ) AND  
         ( pv_nv_movimiento.tipo_movimiento = :ls_tipo ) and
			( pv_nv_movimiento.nr_movimiento = :li_movimiento ) and
		( pv_nv_movimiento.nr_caja = :ii_nrcaja )         ;
			   if sqlca.sqlcode < 0 then
			ls_msg = sqlca.sqlerrtext
			rollback;
			messagebox("Error","No puedo ELIMINAR MOVIMIENTO 1~r~n"+ls_msg,exclamation!)
			return -1
		   end if
							 
			COMMIT;				 
			  

	////////////////////////////////////////////////////////////
	
							 
							 
			//ahora la nota de venta
			update pv_nota_venta
			set tot_con_iva=0,tot_sin_iva=0,iva=0,dsto_con_iva=0,dsto_sin_iva=0,total=0,referencia='ANULADA',electronico='Z',reten_iva=0,reten_fte=0
        WHERE ( pv_nota_venta.cod_compania = :gs_cod_compania ) AND  
         ( pv_nota_venta.numero = :li_numero ) AND  
         ( pv_nota_venta.tipo_doc = :ls_tipo )   and
		( pv_nota_venta.nr_caja = :ii_nrcaja )            ;
			   if sqlca.sqlcode < 0 then
			ls_msg = sqlca.sqlerrtext
			rollback;
			messagebox("Error","No puedo anular NOTA_VENTA 1~r~n"+ls_msg,exclamation!)
			return -1
		   end if
							 
			COMMIT;				 
			  
			  
	
	//ahora inv_Articulo_movimiento
	  DELETE FROM inv_articulo_movimiento  
   WHERE ( inv_articulo_movimiento.tipo_movimiento = :ls_tipo ) AND  
         ( inv_articulo_movimiento.nr_movimiento = :li_movimiento ) AND  
         ( inv_articulo_movimiento.cod_compania = :gs_cod_compania )   
           ;
			  
			if sqlca.sqlcode < 0 then
			ls_msg = sqlca.sqlerrtext
			rollback;
			messagebox("Error","No puedo ELIMINAR ARTICULO_MOVIMIENTO 1~r~n"+ls_msg,exclamation!)
			return -1
		   end if
							 
			COMMIT;				 

	
	//ahora inv_movimiento
	
	  DELETE FROM inv_movimiento  
   WHERE ( inv_movimiento.tipo_movimiento = :ls_tipo ) AND  
         ( inv_movimiento.nr_movimiento = :li_movimiento ) AND  
         ( inv_movimiento.cod_compania = :gs_cod_compania )   
			      ;
					
					 if sqlca.sqlcode < 0 then
			ls_msg = sqlca.sqlerrtext
			rollback;
			messagebox("Error","No puedo ELIMINAR INV_MOVIMINETO 1~r~n"+ls_msg,exclamation!)
			return -1
		   end if
							 
			COMMIT;				 
					
		//voy a eliminar cxc
		
		string ls_numero

		ls_numero = 'F'+string(  string(dw_1.object.cod_estab[dw_1.getrow()] ) + string(dw_1.object.ptoemi[dw_1.getrow()]))+'-'+	String(li_numero)
		if ls_tipo = 'EV' then
			
		  DELETE FROM cxc_det_documento  
        WHERE ( cxc_det_documento.tipo_documento = 'FC' ) AND  
         ( cxc_det_documento.nr_documento = :ls_numero ) AND  
         ( cxc_det_documento.cod_compania = :gs_cod_compania )   and
			cxc_det_documento.saldo = cxc_det_documento.monto 
           ;
			   if sqlca.sqlcode < 0 then
			ls_msg = sqlca.sqlerrtext
			rollback;
			messagebox("Error","No puedo ELIMINAR CXC_DET_DOCUMENTO FC 1~r~n"+ls_msg,exclamation!)
			return -1
		   end if
							 
			COMMIT;				 
			  
			  
			    DELETE FROM cxc_documento  
            WHERE ( cxc_documento.tipo_documento = 'FC' ) AND  
            ( cxc_documento.nr_documento =:ls_numero ) AND  
            ( cxc_documento.cod_compania = :gs_cod_compania ) AND  
            ( cxc_documento.saldo = cxc_documento.monto )
				          ;
							  if sqlca.sqlcode < 0 then
			ls_msg = sqlca.sqlerrtext
			rollback;
			messagebox("Error","No puedo ELIMIAR CXC_DOCUMENTO FC 1~r~n"+ls_msg,exclamation!)
			return -1
		   end if
							 
			COMMIT;				 
							 
			else

				   ls_numero = 'N'+string(string(dw_1.object.estab[dw_1.getrow()])+string(dw_1.object.ptoemi[dw_1.getrow()]))+'-'+string(li_numero) //'NC-'+string(ii_nrcaja)+'-'+String(li_numero)
						  DELETE FROM cxc_det_documento  
 				       WHERE ( cxc_det_documento.tipo_documento = 'NC' ) AND  
			         ( cxc_det_documento.nr_documento = :ls_numero ) AND  
			         ( cxc_det_documento.cod_compania = :gs_cod_compania )   and
			 			cxc_det_documento.saldo = cxc_det_documento.monto 
			           ;
						    	   if sqlca.sqlcode < 0 then
									ls_msg = sqlca.sqlerrtext
									rollback;
									messagebox("Error","No puedo ELIMINAR CXC_DET_DOCUMENTO NC 1~r~n"+ls_msg,exclamation!)
									return -1
								   end if
								 
								COMMIT;				 
						  
				  
			   		 DELETE FROM cxc_documento  
			           WHERE ( cxc_documento.tipo_documento = 'NC' ) AND  
         			   ( cxc_documento.nr_documento = :ls_numero ) AND  
			            ( cxc_documento.cod_compania = :gs_cod_compania ) AND  
         			   ( cxc_documento.saldo = cxc_documento.monto )
			             ;
							  	   if sqlca.sqlcode < 0 then
									ls_msg = sqlca.sqlerrtext
									rollback;
									messagebox("Error","No puedo ELIMINAR CXC_DET_DOCUMENTO NC 1~r~n"+ls_msg,exclamation!)
									return -1
								   end if
												 
									COMMIT;				 

					end if	
					
					DELETE FROM CXC_RET_ABONO
					WHERE TIPO_DOCUMENTO='EV' and nr_documento=:ls_num and nr_caja=:ii_nrcaja;
					if sqlca.sqlcode < 0 then
									ls_msg = sqlca.sqlerrtext
									rollback;
									messagebox("Error","No puedo ELIMINAR CXC_DET_DOCUMENTO NC 1~r~n"+ls_msg,exclamation!)
									return -1
								   end if
									
									commit;
			  
      //fin eliminar CXC
   messagebox("Atención","La nota de venta fue ANULADA")
	dw_1.reset()
		
	else
		messagebox("Atención","La nota de venta forma parte de un cierre de caja")
   end if 
end if	
	
	
	
	
	
	
	




end event

type rb_2 from radiobutton within w_rep_anulacion
integer x = 571
integer y = 136
integer width = 343
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "N/C"
end type

event clicked;rb_1.checked=false
end event

type rb_1 from radiobutton within w_rep_anulacion
integer x = 567
integer y = 56
integer width = 343
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Factura"
boolean checked = true
end type

event clicked;rb_2.checked = false
end event

type dw_det_pago from datawindow within w_rep_anulacion
boolean visible = false
integer x = 5
integer y = 1408
integer width = 1435
integer height = 308
integer taborder = 40
string title = "none"
string dataobject = "d_imp_det_pago"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject(sqlca)
end event

type dw_col from datawindow within w_rep_anulacion
boolean visible = false
integer x = 2382
integer y = 268
integer width = 411
integer height = 272
integer taborder = 20
string title = "none"
string dataobject = "d_columnas"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject(sqlca)
end event

type dw_prop from datawindow within w_rep_anulacion
boolean visible = false
integer x = 2373
integer y = 560
integer width = 411
integer height = 428
integer taborder = 30
string title = "none"
string dataobject = "d_prop"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject(sqlca)
end event

type cb_2 from commandbutton within w_rep_anulacion
integer x = 2560
integer y = 152
integer width = 384
integer height = 84
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Eliminar Elec"
end type

event clicked;//messagebox("Atención","Prepare la Impresora")
//dw_1.print()
long li_filas,li_numero,li_movimiento,i,li_articulo,li_unidad,li_conver,li_bodega,ll_devol
string ls_tipo,ls_msg
char ls_estado
double ldb_cantidad

li_filas = dw_1.rowcount()
//////////////////////////////
	//voy actualizar inventarios//REVISAR SI HAY STOCK AL MENOS CUANDO ES DEVOLUCUION
  if li_filas > 0 then
	ll_devol= dw_1.object.nr_devol[1]
	ls_tipo = dw_1.object.tipo_doc[1]
end if
	  for i = 1 to li_filas
		li_articulo = dw_1.object.cod_articulo[i]
      li_conver = dw_1.object.conversion_1[i]
		ldb_cantidad = ABS(dw_1.object.cant_pres[i] * li_conver)
		li_bodega = dw_1.object.cod_bodega[i]
		
		li_caja=dw_1.object.nr_caja[i]  //FE
		if ls_tipo ='EV' then
			//sumo inventario
			  UPDATE inv_articulo  
           SET stock_disponible = stock_disponible + :ldb_cantidad  
           WHERE inv_articulo.cod_articulo = :li_articulo   
			             ;
			 if sqlca.sqlcode < 0 then
			ls_msg = sqlca.sqlerrtext
			rollback;
			messagebox("Error","No puedo ACTUALIZAR ARTICULO 1~r~n"+ls_msg,exclamation!)
			return -1
		   end if
							 
			COMMIT;				 
			  //////////////
			  
			    UPDATE inv_articulos_bodega  
     			 SET stock_disponible = stock_disponible + :ldb_cantidad  
				 WHERE ( inv_articulos_bodega.cod_bodega = :li_bodega ) AND  
		         ( inv_articulos_bodega.cod_articulo = :li_articulo )   
      		     ;
					  
					   if sqlca.sqlcode < 0 then
			ls_msg = sqlca.sqlerrtext
			rollback;
			messagebox("Error","No puedo ACTUALIZAR ARTICULOS BODEGA 1~r~n"+ls_msg,exclamation!)
			return -1
		end if
		
		 
		

							 
			COMMIT;				 

         else
				
				 update pv_det_nota_venta
		 set cant_devol=cant_devol +:ldb_cantidad
		 from pv_det_nota_venta,pv_nota_venta
		 where  pv_det_nota_venta.numero=pv_nota_venta.numero
		 and pv_det_nota_venta.nr_caja=pv_nota_venta.nr_caja
		 and pv_det_nota_venta.tipo_doc=pv_nota_venta.tipo_doc
		 and pv_nota_venta.numero=:ll_devol
		 and pv_nota_venta.tipo_doc='EV'
		 and pv_nota_venta.nr_caja=:li_caja
		 and pv_det_nota_venta.cod_articulo=:li_articulo ;
		 
		 			   if sqlca.sqlcode < 0 then
			ls_msg = sqlca.sqlerrtext
			rollback;
			messagebox("Error","No puedo ACTUALIZAR devolución producto~r~n"+ls_msg,exclamation!)
			return -1
		end if
		
			
		         //resto inventario
			  UPDATE inv_articulo  
           SET stock_disponible = stock_disponible - :ldb_cantidad  
           WHERE inv_articulo.cod_articulo = :li_articulo   
           ;
			   if sqlca.sqlcode < 0 then
			ls_msg = sqlca.sqlerrtext
			rollback;
			messagebox("Error","No puedo ACTUALIZAR ARTICULO 1~r~n"+ls_msg,exclamation!)
			return -1
		   end if
							 
			COMMIT;				 
			  
			  
			  //////////////
			  
			    UPDATE inv_articulos_bodega  
     			 SET stock_disponible = stock_disponible - :ldb_cantidad  
				 WHERE ( inv_articulos_bodega.cod_bodega = :li_bodega ) AND  
		         ( inv_articulos_bodega.cod_articulo = :li_articulo )   
      		     ;
					   if sqlca.sqlcode < 0 then
			ls_msg = sqlca.sqlerrtext
			rollback;
			messagebox("Error","No puedo ACTUALIZAR ARTICULOS BODEGA 1~r~n"+ls_msg,exclamation!)
			return -1
		   end if
							 
			COMMIT;				 
	
         end if 			
			
			
		
     next

//////////////////////////////

if li_filas > 0 then
	li_numero = dw_1.object.numero[1]
	ls_tipo = dw_1.object.tipo_doc[1]
	ls_estado =dw_1.object.estado[1]
	
	if ls_estado ='C' then
		//elimino primero el detalle de las notas de venta
		  DELETE FROM pv_det_nota_venta  
        WHERE ( pv_det_nota_venta.cod_compania = :gs_cod_compania ) AND  
         ( pv_det_nota_venta.numero = :li_numero ) AND  
         ( pv_det_nota_venta.tipo_doc = :ls_tipo )  and
		( pv_det_nota_venta.nr_caja = :ii_nrcaja )          ;
			   if sqlca.sqlcode < 0 then
			ls_msg = sqlca.sqlerrtext
			rollback;
			messagebox("Error","No puedo ELIMINAR DETALLE 1~r~n"+ls_msg,exclamation!)
			return -1
		   end if
							 
			COMMIT;				 
			  
       //ahora el detalle de pago
		 
		   DELETE FROM pv_detalle_pago  
       WHERE ( pv_detalle_pago.cod_compania = :gs_cod_compania ) AND  
         ( pv_detalle_pago.numero = :li_numero ) AND  
         ( pv_detalle_pago.tipo_doc = :ls_tipo )   and
     	( pv_detalle_pago.nr_caja = :ii_nrcaja )           ;
		   if sqlca.sqlcode < 0 then
			ls_msg = sqlca.sqlerrtext
			rollback;
			messagebox("Error","No puedo ELIMINAR PAGO 1~r~n"+ls_msg,exclamation!)
			return -1
		   end if
							 
			COMMIT;		
			
					  
        //ahora pv_nv_movimiento
		  //antes voy a buscar el numero de movimiento
		  //
		    SELECT pv_nv_movimiento.nr_movimiento  
         INTO :li_movimiento  
         FROM pv_nv_movimiento  
       WHERE ( pv_nv_movimiento.cod_compania = :gs_cod_compania ) AND  
         ( pv_nv_movimiento.numero = :li_numero ) AND  
         ( pv_nv_movimiento.tipo_movimiento = :ls_tipo ) and
	   ( pv_nv_movimiento.nr_caja = :ii_nrcaja ) 		;

		  
		  //
		  
		    DELETE FROM pv_nv_movimiento  
          WHERE ( pv_nv_movimiento.cod_compania = :gs_cod_compania ) AND  
         ( pv_nv_movimiento.numero = :li_numero ) AND  
         ( pv_nv_movimiento.tipo_movimiento = :ls_tipo ) and
			( pv_nv_movimiento.nr_movimiento = :li_movimiento ) and
		( pv_nv_movimiento.nr_caja = :ii_nrcaja )         ;
			   if sqlca.sqlcode < 0 then
			ls_msg = sqlca.sqlerrtext
			rollback;
			messagebox("Error","No puedo ELIMINAR MOVIMIENTO 1~r~n"+ls_msg,exclamation!)
			return -1
		   end if
							 
			COMMIT;				 
			  

	////////////////////////////////////////////////////////////
	
				  DELETE FROM ELEC_IMPUESTOS_PV
			  WHERE NUMERO= :li_numero and
			              caja=:ii_nrcaja
				  and    tipo=:ls_tipo  ;
				   if sqlca.sqlcode < 0 then
			ls_msg = sqlca.sqlerrtext
			rollback;
			messagebox("Error","No puedo elec_impruestos_pv~r~n"+ls_msg,exclamation!)
			return -1
		   end if

//ahora la nota de venta
			update pv_nota_venta
			set tot_con_iva=0,tot_sin_iva=0,iva=0,dsto_con_iva=0,dsto_sin_iva=0,total=0,referencia='ANULADA',electronico='Z',reten_iva=0,reten_fte=0
        WHERE ( pv_nota_venta.cod_compania = :gs_cod_compania ) AND  
         ( pv_nota_venta.numero = :li_numero ) AND  
         ( pv_nota_venta.tipo_doc = :ls_tipo )   and
		( pv_nota_venta.nr_caja = :ii_nrcaja )            ;
			   if sqlca.sqlcode < 0 then
			ls_msg = sqlca.sqlerrtext
			rollback;
			messagebox("Error","No puedo anular NOTA_VENTA 1~r~n"+ls_msg,exclamation!)
			return -1
		   end if
						


	
	/*						 
							 
			//ahora la nota de venta
			  DELETE FROM pv_nota_venta  
        WHERE ( pv_nota_venta.cod_compania = :gs_cod_compania ) AND  
         ( pv_nota_venta.numero = :li_numero ) AND  
         ( pv_nota_venta.tipo_doc = :ls_tipo )   and
		( pv_nota_venta.nr_caja = :ii_nrcaja )            ;
			   if sqlca.sqlcode < 0 then
			ls_msg = sqlca.sqlerrtext
			rollback;
			messagebox("Error","No puedo ELIMINAR NOTA_VENTA 1~r~n"+ls_msg,exclamation!)
			return -1
		   end if
		*/	
							 
			COMMIT;				 
			  
			  
			  
			  
	
	//ahora inv_Articulo_movimiento
	  DELETE FROM inv_articulo_movimiento  
   WHERE ( inv_articulo_movimiento.tipo_movimiento = :ls_tipo ) AND  
         ( inv_articulo_movimiento.nr_movimiento = :li_movimiento ) AND  
         ( inv_articulo_movimiento.cod_compania = :gs_cod_compania )   
           ;
			  
			if sqlca.sqlcode < 0 then
			ls_msg = sqlca.sqlerrtext
			rollback;
			messagebox("Error","No puedo ELIMINAR ARTICULO_MOVIMIENTO 1~r~n"+ls_msg,exclamation!)
			return -1
		   end if
							 
			COMMIT;				 

	
	//ahora inv_movimiento
	
	  DELETE FROM inv_movimiento  
   WHERE ( inv_movimiento.tipo_movimiento = :ls_tipo ) AND  
         ( inv_movimiento.nr_movimiento = :li_movimiento ) AND  
         ( inv_movimiento.cod_compania = :gs_cod_compania )   
			      ;
					
					 if sqlca.sqlcode < 0 then
			ls_msg = sqlca.sqlerrtext
			rollback;
			messagebox("Error","No puedo ELIMINAR INV_MOVIMINETO 1~r~n"+ls_msg,exclamation!)
			return -1
		   end if
							 
			COMMIT;				 
					
		//voy a eliminar cxc
		
		string ls_numero
		ls_numero = 'FV-'+string(ii_nrcaja)+'-'+	String(li_numero)
		if ls_tipo = 'EV' then
			
		  DELETE FROM cxc_det_documento  
        WHERE ( cxc_det_documento.tipo_documento = 'FC' ) AND  
         ( cxc_det_documento.nr_documento = :ls_numero ) AND  
         ( cxc_det_documento.cod_compania = :gs_cod_compania )   and
			cxc_det_documento.saldo = cxc_det_documento.monto 
           ;
			   if sqlca.sqlcode < 0 then
			ls_msg = sqlca.sqlerrtext
			rollback;
			messagebox("Error","No puedo ELIMINAR CXC_DET_DOCUMENTO FC 1~r~n"+ls_msg,exclamation!)
			return -1
		   end if
							 
			COMMIT;				 
			  
			  
			    DELETE FROM cxc_documento  
            WHERE ( cxc_documento.tipo_documento = 'FC' ) AND  
            ( cxc_documento.nr_documento =:ls_numero ) AND  
            ( cxc_documento.cod_compania = :gs_cod_compania ) AND  
            ( cxc_documento.saldo = cxc_documento.monto )
				          ;
							  if sqlca.sqlcode < 0 then
			ls_msg = sqlca.sqlerrtext
			rollback;
			messagebox("Error","No puedo ELIMIAR CXC_DOCUMENTO FC 1~r~n"+ls_msg,exclamation!)
			return -1
		   end if
							 
			COMMIT;				 
							 
			else
				   ls_numero = 'NC-'+string(ii_nrcaja)+'-'+String(li_numero)
						  DELETE FROM cxc_det_documento  
 				       WHERE ( cxc_det_documento.tipo_documento = 'NC' ) AND  
			         ( cxc_det_documento.nr_documento = :ls_numero ) AND  
			         ( cxc_det_documento.cod_compania = :gs_cod_compania )   and
			 			cxc_det_documento.saldo = cxc_det_documento.monto 
			           ;
						    	   if sqlca.sqlcode < 0 then
									ls_msg = sqlca.sqlerrtext
									rollback;
									messagebox("Error","No puedo ELIMINAR CXC_DET_DOCUMENTO NC 1~r~n"+ls_msg,exclamation!)
									return -1
								   end if
								 
								COMMIT;				 
						  
				  
			   		 DELETE FROM cxc_documento  
			           WHERE ( cxc_documento.tipo_documento = 'NC' ) AND  
         			   ( cxc_documento.nr_documento = :ls_numero ) AND  
			            ( cxc_documento.cod_compania = :gs_cod_compania ) AND  
         			   ( cxc_documento.saldo = cxc_documento.monto )
			             ;
							  	   if sqlca.sqlcode < 0 then
									ls_msg = sqlca.sqlerrtext
									rollback;
									messagebox("Error","No puedo ELIMINAR CXC_DET_DOCUMENTO NC 1~r~n"+ls_msg,exclamation!)
									return -1
								   end if
												 
									COMMIT;				 

					end if	
			  
      //fin eliminar CXC
   messagebox("Atención","La nota de venta fue eliminada")
	dw_1.reset()
		
	else
		messagebox("Atención","La nota de venta forma parte de un cierre de caja")
   end if 
end if	
	
	
	
	
	
	
	




end event

type cb_1 from commandbutton within w_rep_anulacion
integer x = 2126
integer y = 52
integer width = 384
integer height = 84
integer taborder = 90
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
string ls_sql,ls_sql_original,ls_numero,ls_msg,ls_tipo
int li_fefec,li_fcheq,li_i,li_formap,li_ftarj,li_cont,li_prom
double ldb_vcheq,ldb_vefec,ldb_vtarj,ldb_items
ls_numero = (em_numero.text)
dw_cajas.accepttext()
dw_1.settransobject(SQLCA)
if rb_1.checked = true then
ls_tipo = 'EV'
else
ls_tipo = 'ID'
end if

if dw_1.retrieve(righttrim(gs_cod_compania),long(ls_numero),ii_nrcaja,ls_tipo) > 0 and dw_det_pago.retrieve(gs_cod_compania,long(ls_numero),ii_nrcaja,ls_tipo) > 0 then
  dw_1.modify("modelo.text='"+gs_modelo+"'")
  dw_1.modify("sri.text = '"+gs_sri+"'")
  dw_1.modify("num_suc.text = '"+gs_num_suc+"'")
  dw_1.modify("validez.text = '"+gs_validez+"'")
  dw_1.modify("ruc_matriz.text = " +gs_ruc_matriz+"'")
  dw_1.modify("dir_matriz.text = '"+gs_dir_matriz+"'")	
  dw_1.modify("ciudad.text = '"+gs_ciudad+"'")
  dw_1.modify("slogan.text = '"+gs_slogan+"'")
  if gi_impresion = 1 then
	  //matricial
     dw_1.setitem(1,"ruc_matriz",gs_ruc_matriz)
     dw_1.setitem(1,"dir_matriz",gs_dir_matriz)		
  	  select forma.items into :ldb_items from forma 
	  where (forma.cod_forma = 5) and (forma.tipo_forma = 4);
	  if sqlca.sqlcode < 0 then
		 messagebox("Información","No se puede recuperar el número de items del Ticket dinamico",information!)
		 Return -1
	  end if
	  dw_1.accepttext()
	  li_cont = dw_1.rowcount()
	  li_prom = dw_1.rowcount()
	  li_cont++
	  for li_i = li_cont to ldb_items
		 dw_1.insertrow(li_i)
	  next
	  for li_i=1 to dw_det_pago.rowcount()
		 li_formap=dw_det_pago.object.forma_pago[li_i]				
		 if li_formap= 1 then 
			ldb_vefec=dw_det_pago.object.monto[li_i]
			li_fefec = li_i
		 end if
		 if li_formap= 2 then 
			ldb_vcheq=dw_det_pago.object.monto[li_i]
			li_fcheq = li_i
		 end if
		 if li_formap= 3 then 
			ldb_vtarj=dw_det_pago.object.monto[li_i]
			li_ftarj = li_i
		 end if
	  next
     if ldb_vefec > 0 then 
		 dw_1.setitem(dw_1.rowcount(),"val_efec",dw_det_pago.object.monto[li_fefec])
		 dw_1.setitem(dw_1.rowcount(),"forma_efec",'E')
	  end if
	  if ldb_vcheq > 0 then
	    dw_1.setitem(dw_1.rowcount(),"val_cheque",dw_det_pago.object.monto[li_fcheq])
	    dw_1.setitem(dw_1.rowcount(),"nr_cta",dw_det_pago.object.nr_cta[li_fcheq])
		 dw_1.setitem(dw_1.rowcount(),"nr_cheque",dw_det_pago.object.nr_cheque[li_fcheq])
		 dw_1.setitem(dw_1.rowcount(),"nom_banco",dw_det_pago.object.nom_banco[li_fcheq])
		 dw_1.setitem(dw_1.rowcount(),"f_cob_cheq",string(dw_det_pago.object.fecha_cobro[li_fcheq],'dd/mm/yyyy'))
       dw_1.setitem(dw_1.rowcount(),"forma_cheq",'C')		 
	  end if				
	  if ldb_vtarj > 0 then
		 dw_1.setitem(dw_1.rowcount(),"forma_tarj",'T')
		 dw_1.setitem(dw_1.rowcount(),"val_tarj",dw_det_pago.object.monto[li_ftarj])
		 dw_1.setitem(dw_1.rowcount(),"nr_tarj",dw_det_pago.object.nr_cta[li_ftarj])
		 dw_1.setitem(dw_1.rowcount(),"nr_aut",dw_det_pago.object.nr_cheque[li_ftarj])
		 dw_1.setitem(dw_1.rowcount(),"nom_tarj",dw_det_pago.object.nom_banco[li_ftarj])
		 dw_1.setitem(dw_1.rowcount(),"f_tarj",string(dw_det_pago.object.fecha_cobro[li_ftarj],'dd/mm/yyyy'))
	  end if				
	  if ldb_vefec= 0 then 
			dw_1.object.val_efec.visible = false
		else
			dw_1.object.val_efec.visible = true
		end if
		if ldb_vcheq= 0 then
			dw_1.object.val_cheque.visible = false
		else
			dw_1.object.val_cheque.visible = true
		end if
		if ldb_vtarj= 0 then  
			dw_1.object.val_tarj.visible = false
		else
			dw_1.object.val_tarj.visible = true
		end if
  	  if li_prom <> 0  and ldb_vefec = 0 and ldb_vcheq = 0 and ldb_vtarj = 0 then
			dw_1.object.val_efec.visible= true
//		   dw_1.setitem(dw_1.rowcount(),"val_efec",dw_det_pago.object.monto[li_fefec])
		   dw_1.setitem(dw_1.rowcount(),"forma_efec",'E')
	  end if
  end if	
end if

end event

type dw_cajas from datawindow within w_rep_anulacion
integer x = 1344
integer y = 88
integer width = 599
integer height = 112
integer taborder = 60
string dataobject = "d_dddw_cajas"
boolean border = false
boolean livescroll = true
end type

event itemchanged;ii_nrcaja = integer(data)
end event

event buttonclicked;setpointer(hourglass!)
string ls_sql,ls_sql_original,ls_numero,ls_nbanco,ls_ntarj,ls_msg,ls_tipo
int li_fefec,li_fcheq,li_banco,li_i,li_formap,li_ftarj,li_tarj
double ldb_vcheq,ldb_vefec,ldb_vtarj
ls_numero = (em_numero.text)
dw_cajas.accepttext()
if rb_1.checked = true then
ls_tipo = 'EV'
else
ls_tipo = 'ID'
end if

dw_1.settransobject(SQLCA)
if dw_det_pago.retrieve(gs_cod_compania,integer(ls_numero),ii_nrcaja,ls_tipo) > 0 then
   messagebox("","hola")
	dw_1.modify("modelo.text='"+gs_modelo+"'")
	dw_1.modify("sri.text = '"+gs_sri+"'")
	dw_1.modify("num_suc.text='"+gs_num_suc+"'")
	dw_1.modify("validez.text = '"+gs_validez+"'")
	dw_1.setitem(1,"ruc_matriz",gs_ruc_matriz)
	dw_1.setitem(1,"dir_matriz",gs_dir_matriz)		
	if gi_impresion = 1 then
	  //matricial
	  for li_i=1 to dw_det_pago.rowcount()
		 li_formap=dw_det_pago.object.forma_pago[li_i]				
		 if li_formap= 1 then 
			ldb_vefec=dw_det_pago.object.monto[li_i]
			li_fefec = li_i
		 end if
		 if li_formap= 2 then 
			ldb_vcheq=dw_det_pago.object.monto[li_i]
			li_fcheq = li_i
		 end if
		 if li_formap= 3 then 
			ldb_vtarj=dw_det_pago.object.monto[li_i]
			li_ftarj = li_i
		 end if
	  next
     if ldb_vefec > 0 then 
		 dw_1.setitem(dw_1.rowcount(),"val_efec",dw_det_pago.object.monto[li_fefec])
		 dw_1.setitem(dw_1.rowcount(),"forma_efec",'E')
	  end if
	  if ldb_vcheq > 0 then
		 dw_1.setitem(dw_1.rowcount(),"forma_cheq",'C')
		 dw_1.setitem(dw_1.rowcount(),"val_cheque",dw_det_pago.object.monto[li_fcheq])
		 dw_1.setitem(dw_1.rowcount(),"nr_cta",dw_det_pago.object.nr_cta[li_fcheq])
		 dw_1.setitem(dw_1.rowcount(),"nr_cheque",dw_det_pago.object.nr_cheque[li_fcheq])
		 li_banco= dw_det_pago.object.cod_banco[li_fcheq]			
		 SELECT banco.nom_banco INTO :ls_nbanco  
		 FROM banco WHERE banco.cod_banco = :li_banco;
		 if sqlca.sqlcode < 0 then
			ls_msg = sqlca.sqlerrtext
			messagebox("Error","No puedo recuperar el banco 1~r~n"+ls_msg,exclamation!)
			return -1
		 end if
		 dw_1.setitem(dw_1.rowcount(),"nom_banco",ls_nbanco)			
		 dw_1.setitem(dw_1.rowcount(),"f_cob_cheq",string(dw_det_pago.object.fecha_cobro[li_fcheq],'dd/mm/yyyy'))
	  end if				
	  if ldb_vtarj > 0 then
		 dw_1.setitem(dw_1.rowcount(),"forma_tarj",'T')
		 dw_1.setitem(dw_1.rowcount(),"val_tarj",dw_det_pago.object.monto[li_ftarj])
		 dw_1.setitem(dw_1.rowcount(),"nr_tarj",dw_det_pago.object.nr_cta[li_ftarj])
		 dw_1.setitem(dw_1.rowcount(),"nr_aut",dw_det_pago.object.nr_cheque[li_ftarj])
		 li_tarj=dw_det_pago.object.cod_tarjeta[li_ftarj]
		 SELECT tarjeta.nom_tarjeta INTO :ls_ntarj  
		 FROM tarjeta WHERE tarjeta.cod_tarjeta = :li_tarj;
		 if sqlca.sqlcode < 0 then
			ls_msg = sqlca.sqlerrtext
			messagebox("Error","No puedo recuperar la tarjeta 1~r~n"+ls_msg,exclamation!)
			return -1
		 end if
		 dw_1.setitem(dw_1.rowcount(),"nom_tarj",ls_ntarj)
		 dw_1.setitem(dw_1.rowcount(),"f_tarj",string(dw_det_pago.object.fecha_cobro[li_ftarj],'dd/mm/yyyy'))
	 end if				
  end if	
end if

end event

type st_2 from statictext within w_rep_anulacion
integer x = 73
integer y = 108
integer width = 283
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
string text = "No. Ticket :"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_numero from editmask within w_rep_anulacion
integer x = 974
integer y = 92
integer width = 343
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
maskdatatype maskdatatype = stringmask!
string mask = "##########"
end type

type dw_1 from datawindow within w_rep_anulacion
integer y = 248
integer width = 2345
integer height = 1136
integer taborder = 10
string dataobject = "d_elim_nota_dinamico"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.object.DataWindow.Print.Preview = 'yes'
end event

type gb_1 from groupbox within w_rep_anulacion
integer x = 27
integer width = 3017
integer height = 240
integer taborder = 100
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 67108864
string text = "Anulación de N/V"
end type

