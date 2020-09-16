$PBExportHeader$w_registradora.srw
$PBExportComments$Ventana para Proceso de registro de venta  (caja)
forward
global type w_registradora from window
end type
type dw_elecfc from datawindow within w_registradora
end type
type pb_3 from picturebutton within w_registradora
end type
type pb_2 from picturebutton within w_registradora
end type
type cbx_factura from checkbox within w_registradora
end type
type cb_graba from commandbutton within w_registradora
end type
type dw_datos from datawindow within w_registradora
end type
type ddlb_iva from dropdownlistbox within w_registradora
end type
type st_1 from statictext within w_registradora
end type
type dw_notaimp from datawindow within w_registradora
end type
type dw_visualiza_precios from datawindow within w_registradora
end type
type ole_com1 from olecustomcontrol within w_registradora
end type
type dw_prop from datawindow within w_registradora
end type
type dw_col from datawindow within w_registradora
end type
type dw_tpreliminar from datawindow within w_registradora
end type
type cb_1 from commandbutton within w_registradora
end type
type dw_mov_art from datawindow within w_registradora
end type
type sle_1 from singlelineedit within w_registradora
end type
type dw_precios from datawindow within w_registradora
end type
type dw_1 from datawindow within w_registradora
end type
type cb_2 from commandbutton within w_registradora
end type
type cb_3 from commandbutton within w_registradora
end type
type cb_4 from commandbutton within w_registradora
end type
type cb_5 from commandbutton within w_registradora
end type
type cb_6 from commandbutton within w_registradora
end type
type cb_7 from commandbutton within w_registradora
end type
type cb_9 from commandbutton within w_registradora
end type
type cb_11 from commandbutton within w_registradora
end type
type cb_12 from commandbutton within w_registradora
end type
type cb_8 from commandbutton within w_registradora
end type
type dw_det from datawindow within w_registradora
end type
type dw_elecnc from datawindow within w_registradora
end type
type dw_det_pago from datawindow within w_registradora
end type
type dw_cab from datawindow within w_registradora
end type
type pb_1 from picturebutton within w_registradora
end type
type gb_1 from groupbox within w_registradora
end type
end forward

global type w_registradora from window
integer x = 5
integer y = 4
integer width = 6551
integer height = 2708
boolean titlebar = true
string title = "Caja Registradora:Facturación"
boolean controlmenu = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 80269524
boolean center = true
windowanimationstyle openanimation = leftslide!
windowanimationstyle closeanimation = bottomroll!
event limpiar ( )
event type integer grabar ( )
event eliminar ( )
event insertar ( )
event forma_pago ( )
event type integer chequeo ( )
event type integer grabar_mov ( long al_cliente )
event otro_precio ( )
event type integer ue_imprimir ( long nro_nota )
event habilita_dsto ( )
event promoc ( )
event devol ( )
event cliente ( )
event recupera ( )
event type integer modifica ( )
event listado ( )
event type integer sigraba ( )
event sucursal ( )
dw_elecfc dw_elecfc
pb_3 pb_3
pb_2 pb_2
cbx_factura cbx_factura
cb_graba cb_graba
dw_datos dw_datos
ddlb_iva ddlb_iva
st_1 st_1
dw_notaimp dw_notaimp
dw_visualiza_precios dw_visualiza_precios
ole_com1 ole_com1
dw_prop dw_prop
dw_col dw_col
dw_tpreliminar dw_tpreliminar
cb_1 cb_1
dw_mov_art dw_mov_art
sle_1 sle_1
dw_precios dw_precios
dw_1 dw_1
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
cb_5 cb_5
cb_6 cb_6
cb_7 cb_7
cb_9 cb_9
cb_11 cb_11
cb_12 cb_12
cb_8 cb_8
dw_det dw_det
dw_elecnc dw_elecnc
dw_det_pago dw_det_pago
dw_cab dw_cab
pb_1 pb_1
gb_1 gb_1
end type
global w_registradora w_registradora

type variables
boolean lbo_lista = true,lbo_dsto=false,lbo_precio=false,lbo_vizua_pre=false
long il_mov1,il_mov2,il_items
char id_tipo_cliente
end variables

event limpiar();string lst_cliente,lst_ruc,ls_subempresa
//Aspiradora	
if gi_asp = 1 then 
	ole_com1.object.output = string(char(double("31")))	
   ole_com1.object.output = "   "
end if
///////
long ll_i
long li_clie
gb_modifica = false
dw_visualiza_precios.hide()
sle_1.hide()
dw_cab.reset()
dw_cab.insertrow(0)
SELECT cod_cliente INTO :li_clie FROM cliente  
WHERE (cliente.cod_cliente) = 1 ;
if sqlca.sqlcode < 0 then
	messageBox ("Error","No pude recuperar  clientes .~r~nIngréselos en el módulo de Mantenimineto")
	halt close
end if
  SELECT cliente.nombre,cliente.ruc_ci,cliente.paga_iva,tp_id_cli
    INTO :lst_cliente,:lst_ruc,:gs_piva,:id_tipo_cliente  
    FROM cliente  
   WHERE cliente.cod_cliente = 1   ;
gc_tipo_clie=id_tipo_cliente


dw_cab.setitem(1,"nomb_cliente",lst_cliente)
dw_cab.setitem(1,"cod_cliente",li_clie)
dw_cab.setitem(1,"c_i_o_ruc",lst_ruc)
dw_cab.setitem(1,"cod_compania",gs_cod_compania)
dw_cab.setitem(1,"cod_vendedor",gi_cod_funcionario)
dw_cab.setitem(1,"nr_caja",gi_caja)
dw_cab.setitem(1,"prc_iva",gc_iva)
dw_cab.setitem(1,"paga_iva",gs_piva)
dw_cab.setitem(1,"tipocliente",id_tipo_cliente)
dw_cab.setitem(1,"TIPO_PRECIO",gs_precio)
dw_cab.object.subempresa[1] = gs_subempresa
dw_cab.settaborder('subempresa',140)
dw_cab.object.ptoemi[1] = gs_emi
dw_cab.object.estab[1] = gs_num_suc
cbx_factura.checked=false
dw_datos.reset()

dw_det.reset()
dw_det_pago.hide()
dw_det_pago.reset()
dw_mov_art.reset()
for ll_i = 1 to 4 //3
	dw_det_pago.insertrow(0)
	dw_det_pago.setitem(ll_i,"forma_pago",ll_i)
	dw_det_pago.setitem(ll_i,"aux",0)
	dw_det_pago.setitem(ll_i,"monto",0)
next
dw_det.setfocus()

end event

event type integer grabar();long ll_nota,ll_i,ll_n,ll_cliente,ll_articulo,ll_fila,ll_funcionario
double lc_prc_dsto,lc_prc_iva,desc_adc,ld_preimpreso,ldb_p
string ls_msg,ls_ref,ls_numero,ls_nom,ls_buscar,ls_tipodoc,ls_nota,ls_clave,tipo,ls_numeroc,ls_ruc
long ll_numdev,li_fp,ll_factura
datetime dt_fecha,dt_fecha_ven
integer li_pr,num,resp
char lc_tipo_iva

setpointer(hourglass!)
dw_visualiza_precios.hide()
IF dw_det_pago.rowcount()>=3 then
if dw_det_pago.object.cambio[3] < 0 then return -1
end if
ll_numdev= dw_cab.object.nr_devol[1]
dw_mov_art.reset()
double ldb_total_nv
ldb_total_nv = dw_cab.getitemnumber(1,"total")

dw_cab.accepttext()
ls_nom = mid(dw_cab.getitemstring(1,"nomb_cliente"),1,4)
ls_ruc=mid(dw_cab.getitemstring(1,"c_i_o_ruc"),1,4)
if ls_nom=''  then
	 messagebox("Informacion","Seleccione el Cliente con el botón CLIENTE presenta VAcio el nombre",information!)
 return -1	
end if 
if ls_ruc=''  then
	 messagebox("Informacion","Seleccione el Cliente con el botón CLIENTE presenta VAcio el RUC",information!)
 return -1	
end if 

 

	
ll_cliente=dw_cab.object.cod_cliente[1]
if isnull(ll_cliente) or ll_cliente<=0 then
 messagebox("Informacion","Seleccione el Cliente con el botón de busqueda",information!)
 return -1	
end if
if ll_cliente=1 then
	dw_cab.object.nomb_cliente[1]='Consumidor Final'
	dw_cab.object.c_i_o_ruc[1]='9999999999999'
	//verifico factura no mayo a $200
	if ldb_total_nv > 200 then
		 messagebox("Informacion","Factura no puede ser mayor de $200 como Consumidor Final Seleccione el Cliente con el botón de busqueda",information!)
		 return -1	
	end if	 
	
end if
 dw_cab.object.fecha_emision[1]=today()  //FE
dt_fecha =datetime(dw_cab.object.fecha_emision[1])
dt_fecha_ven=dt_fecha
			

//Cambia el efectivo en caso de haber un cambio o vuelto
if dw_det_pago.rowcount()>=3 then
if dw_det_pago.object.cambio[3] >= 0 and ll_numdev = 0 then
	dw_cab.setitem(dw_cab.getrow(),"cambio",dw_det_pago.object.cambio[3])
   dw_det_pago.object.aux[1]= dw_det_pago.object.aux[1] - dw_det_pago.object.cambio[3]
	dw_det_pago.object.monto[1]=dw_det_pago.object.aux[1]
	dw_det_pago.object.monto[2]=dw_det_pago.object.aux[2]
   dw_det_pago.object.monto[3]=dw_det_pago.object.aux[3]	
	dw_det_pago.object.monto[4]=dw_det_pago.object.aux[4]	
	dw_det_pago.object.cambio[3]=0
end if
////cambio para textielites
  if ldb_total_nv > 0 then
	if dw_det_pago.object.aux[1] < 0  then 
		messagebox("Informacion","El efectivo es menor al cambio",information!)
	   return -1	
	end if
	end if  //total_nv
end if
//////////////////////////////
//ll_cliente = dw_cab.getitemnumber(1,"cod_cliente")

ls_ref = dw_cab.getitemstring(1,"referencia")
//ls_ref = dw_cab.object.referencia[1]
ll_funcionario = dw_cab.getitemnumber(1,"cod_vendedor")
dt_fecha =datetime(dw_cab.object.fecha_emision[1])
dt_fecha_ven=dt_fecha

if this.event chequeo() <= 0 then return -1
if this.event grabar_mov(ll_cliente) < 0 then return -1
ll_nota = dw_cab.object.numero[1]
lc_tipo_iva=dw_cab.object.paga_iva[1]

if lc_tipo_iva='S' then
//ll_factura=f_secuencial ( 'FACTURA' )
//dw_cab.object.referencia[1]=string(ll_factura)
end if 
gi_caja=gi_caja
if IsNull(ll_nota) THEN	
	if ll_numdev = 0 and ldb_total_nv >= 0 then //texti
       openwithparm(w_numerofactura,string(f_secuencial_caja ( 'EV',gi_caja )))
		 ll_nota=long(gs_factura)
		 ls_tipodoc='EV'   //FE
	//	if dw_cab.object.cod_cliente[1]>1 or  cbx_factura.checked=true then
		//	openwithparm(w_numerofactura,string(f_secuencial_companias_detalle(dw_cab.object.subempresa[1],'EV')))
		//	dw_cab.object.referencia[1]=gs_factura
		    
//		end if	
	else	
      ll_nota =  f_secuencial_caja( 'ID',gi_caja )
		ls_tipodoc='ID'  //FE

	//	dw_cab.object.referencia[1]=f_secuencial_companias_detalle(dw_cab.object.subempresa[1],'ID')
		
	end if	
end if


if ll_nota <= 0 then return -1
dw_cab.setitem(1,"numero",ll_nota)
if ll_numdev = 0  and  ldb_total_nv > 0 then //textiel
   dw_cab.setitem(1,"tipo_doc",'EV')
else
 dw_cab.setitem(1,"tipo_doc",'ID')
end if
dw_cab.setitem(1,"nr_detalles",dw_mov_art.rowcount())
//dw_cab.setitem(1,"referencia",ls_ref)
dw_cab.setitem(1,"cod_compania",gs_cod_compania) //cambio **
//ls_ref = dw_cab.object.referencia[1]
// creación del detalle de pago
ll_i = dw_det_pago.rowcount()

for ll_i=dw_det_pago.rowcount()  to 1 step -1
	if dw_det_pago.object.monto[ll_i] = 0 then
	 	dw_det_pago.deleterow(ll_i)
  	  end if	
next		
////////////7
ll_i = dw_det_pago.rowcount()
if isnull(ll_i) then ll_i=0
if ll_i = 0 then
	messagebox("Información","No ha seleccionado la forma de pago",information!)
	rollback;
	return -1
end if

////////////////

ll_i = dw_det_pago.rowcount()
for ll_i =1 to dw_det_pago.rowcount()
	if ll_numdev = 0 and ldb_total_nv >= 0 then  //textil
	 	dw_det_pago.setitem(ll_i,"tipo_doc",'EV')
	else
		dw_det_pago.setitem(ll_i,"tipo_doc",'ID')
	end if	
	//FE
	if dw_det_pago.object.forma_pago[ll_i]=1 then
		dw_cab.object.formapago[dw_cab.getrow()]='01'
	else
		if dw_det_pago.object.forma_pago[ll_i]=2 then
		dw_cab.object.formapago[dw_cab.getrow()]='20'
	else
		if dw_det_pago.object.forma_pago[ll_i]=3 then
		dw_cab.object.formapago[dw_cab.getrow()]='19'
	else
		dw_cab.object.formapago[dw_cab.getrow()]='20'
	end if
	end if
     end if

	
	
 	dw_det_pago.setitem(ll_i,"numero",ll_nota)
	dw_det_pago.setitem(ll_i,"det_pago",ll_i)
	dw_det_pago.setitem(ll_i,"nr_caja",gi_caja)
	dw_det_pago.setitem(ll_i,"subempresa",gs_subempresa)
	dw_det_pago.setitem(ll_i,"cod_compania",gs_cod_compania)//cambio **
	 
next
for ll_i =1 to dw_det.rowcount()
	dw_det.setitem(ll_i,"numero",ll_nota)
	dw_det.setitem(ll_i,"cod_bodega",gi_bodega)
	dw_det.setitem(ll_i,"nr_caja",gi_caja)
	dw_det.setitem(ll_i,"subempresa",gs_subempresa)
next
//FE

    num=len(string(ll_nota))
     num=9 - num
    ls_nota=string(fill('0',num))+string(ll_nota)
	 if ldb_total_nv > 0 then
	   tipo='01'
	else
		tipo='04'
	end if	
	 
    ls_clave=f_claveacceso(date(dt_fecha),tipo,gs_ruc,gs_ambiente,(string(dw_cab.object.estab[dw_cab.getrow()])+string(dw_cab.object.ptoemi[dw_cab.getrow()])),ls_nota,gs_codigo,gs_emision)
	 if ls_clave='nn' then
			messagebox("Atención","clave no generada")
			rollback;
			return -1
	end if	
	dw_cab.object.claveacceso[dw_cab.getrow()]=ls_clave

if dw_cab.update(true) > 0 then
	
	
	
   if dw_mov_art.find("tipo_movimiento ='EV'",1,dw_mov_art.rowcount()) > 0 then
		INSERT INTO pv_nv_movimiento (cod_compania, numero, tipo_movimiento, nr_movimiento,nr_caja,subempresa)
		VALUES (:gs_cod_compania,:ll_nota,'EV',:il_mov1,:gi_caja,:gs_subempresa) ;
		if sqlca.sqlcode < 0 then
			ls_msg = sqlca.sqlerrtexT
			rollback;
			messagebox("Error","No puedo crear referencia 1~r~n"+ls_msg,exclamation!)
			return -1
		end if
	end if
	if dw_mov_art.find("tipo_movimiento ='ID'",1,dw_mov_art.rowcount()) > 0 then
		INSERT INTO pv_nv_movimiento (cod_compania,numero,tipo_movimiento,nr_movimiento,nr_caja,subempresa)  
		VALUES (:gs_cod_compania,:ll_nota,'ID',:il_mov2,:gi_caja,:gs_subempresa)  ;
		if sqlca.sqlcode < 0 then
			ls_msg = sqlca.sqlerrtext
			rollback;
			messagebox("Error","No puedo crear referencia 1~r~n"+ls_msg,exclamation!)
			return -1
		end if
		
		
	end if
   if dw_det.update(true) < 0 then 
	   messagebox("Error","No puedo crear el detalle del movimiento de ventas~r~n"+sqlca.sqlerrtext,exclamation!)
		rollback;
		return -1
	end if	
	if dw_mov_art.update(true) < 0 then 
		messagebox("Error","No puedo crear el detalle del movimiento de ventas~r~n"+sqlca.sqlerrtext,exclamation!)
		rollback;
		return -1
	end if
	if dw_det_pago.update(true) > 0 then
		//FE
         if ls_tipodoc='' or isnull(ls_tipodoc) then
				if  ldb_total_nv  > 0 then
					ls_tipodoc='EV'
				else
					ls_tipodoc='NC'
				end if
			end if			
			
		 if f_elec_impuestos_pv(ll_nota,ls_tipodoc,12,gi_caja,dw_cab.object.tot_con_iva[dw_cab.getrow()],dw_cab.object.tot_sin_iva[dw_cab.getrow()],dw_cab.object.dsto_con_iva[dw_cab.getrow()],dw_cab.object.dsto_sin_iva[dw_cab.getrow()],dw_cab.object.iva[dw_cab.getrow()]) < 0 then
				messagebox("Error","No puedo crear el detalle electronico_~r~n"+sqlca.sqlerrtext,exclamation!)
		rollback;
		return -1
	    end if
	    

		
	  commit ;		
	  double ld_credito=0,li_n=0
  //////////////////////////vamos a grabar el valor del credito////////////
  ll_numdev = ll_numdev
  if ll_numdev = 0 AND  ldb_total_nv > 0 then  //cambie aqui para NC_saldo
  	
 SELECT pv_detalle_pago.monto,pv_detalle_pago.fecha_ven INTO :ld_credito,:dt_fecha_ven FROM pv_detalle_pago,pv_nota_venta  
   WHERE (pv_nota_venta.cod_compania = pv_detalle_pago.cod_compania) and  (pv_nota_venta.nr_caja = pv_detalle_pago.nr_caja) and
   (pv_nota_venta.numero = pv_detalle_pago.numero) and ((pv_nota_venta.cod_compania = :gs_cod_compania) AND
    (pv_detalle_pago.forma_pago = 4)) and pv_nota_venta.numero = :ll_nota and pv_nota_venta.tipo_doc = 'EV' and pv_detalle_pago.nr_caja=:gi_caja;
	if sqlca.sqlcode < 0  then
		messagebox("Información","No puedo obtener el valor del credito 1~r~nConsulte a su proveedor del sistema.",information!)
		rollback;
		return -1
	end if
	
  else 
	 SELECT pv_detalle_pago.monto INTO :ld_credito FROM pv_detalle_pago,pv_nota_venta  
   WHERE pv_nota_venta.cod_compania = pv_detalle_pago.cod_compania and
	pv_nota_venta.nr_caja = pv_detalle_pago.nr_caja and
	pv_nota_venta.tipo_doc = pv_detalle_pago.tipo_doc and
 pv_nota_venta.numero = pv_detalle_pago.numero and 
	pv_nota_venta.cod_compania = :gs_cod_compania AND
  pv_detalle_pago.forma_pago = 4 and
  pv_nota_venta.numero = :ll_nota and
  pv_nota_venta.tipo_doc = 'ID' 
  and pv_detalle_pago.nr_caja=:gi_caja;
	if sqlca.sqlcode < 0  then
		messagebox("Información","No puedo obtener el valor del credito 2 ~r~nConsulte a su proveedor del sistema.",information!)
		rollback;
		return -1
	end if
end if  //dev
  ld_credito = ld_credito	
	
	if isnull(ld_credito) then ld_credito = 0
	if ld_credito <> 0 then
	   li_n = dw_det.rowcount()
		if ll_numdev > 0 or ld_credito < 0 then//cambio
	      messagebox("Atención","Aplique la Nota de Credito en CXC ") 	
			//Hay que actualizar la tabla cxc_documento y cxc_det_documento,ademas de ingresar la NC
			ls_numero = 'N'+string(string(dw_cab.object.estab[dw_cab.getrow()])+string(dw_cab.object.ptoemi[dw_cab.getrow()]))+'-'+string(ll_nota)
			ld_preimpreso = double(ls_ref)
			ld_credito = abs(ld_credito)
			//voy a ingresar el cxc_documento
			  INSERT INTO cxc_documento  
         ( tipo_documento,   
           nr_documento,   
           cod_ingreso,   
           cod_funcionario,   
           cod_nota,   
           cod_sistema,   
           cod_forma_pago,   
           tipo_mov_doc,   
           f_documento,   
           f_proceso,   
           cod_cliente,   
           subtotal,   
           descuento,   
           iva,   
           otros_cargos,   
           monto,   
           retencion,   
           saldo,   
           nr_recibo,   
           nr_comprob,   
           tipo_comprob,   
           usuario,   
           observacion,   
           nr_preimpreso,   
           ln,   
           estado,   
           nota_embarque,   
           fecha_cancelacion,   
           tarifa_0,   
           fecha_embarque,   
           porcentaje_iva,   
           descuento_iva,   
           descuento_sin_iva,   
           c_iva,   
           cod_bodega,   
           cod_transporte,
		   subempresa	  )  
  VALUES ( 'NC',   
           :ls_numero,   
           null,   
           :ll_funcionario,   
           null,   
           6,   
           4,   
           'O',   
           :dt_fecha,   
           :dt_fecha,   
           :ll_cliente,   
           :ld_credito,   
           0,   
           0,   
           0,   
           :ld_credito,   
           0,   
           :ld_credito,   
           null,   
           null,   
           null,   
           'ADM',   
           :ls_ref,   
           0,   
           '1',   
           'V',   
           null,   
           null,   
           0,   
           null,   
           0,   
           0,   
           0,   
           :gs_piva,   
           :gi_bodega,   
           1,
		   :gs_subempresa	  )  ;

	  if sqlca.sqlcode < 0 or sqlca.sqlcode = 100 then
		messagebox("Información","No puedo grabar la NC cxc_documentoo__1~r~nConsulte a su proveedor del sistema.",information!)
		rollback;
		return -1
    end if
			///ahora vamos al detalle
			  INSERT INTO cxc_det_documento  
         ( tipo_documento,   
           nr_documento,   
           det_documento,   
           cod_ingreso,   
           f_venc,   
           monto,   
           saldo,   
           observacion,
		  subempresa	  
            )  
  VALUES ( 'NC',   
           :ls_numero,   
           1,   
           null,   
           :dt_fecha_ven,   
           :ld_credito,   
           :ld_credito,   
           :ls_ref,   
            :gs_subempresa)  ;

		if sqlca.sqlcode < 0 or sqlca.sqlcode = 100 then
		messagebox("Información","No puedo grabar el detalle NC cxc_documentoo~r~nConsulte a su proveedor del sistema.",information!)
		rollback;
		return -1
    end if
			
			////////
		else
	//		ls_numero=string(dw_cab.object.estab[dw_cab.getrow()])+string(dw_cab.object.ptoemi[dw_cab.getrow()])
			ls_numeroc = 'F'+STRING(string(string(dw_cab.object.estab[dw_cab.getrow()])+string(dw_cab.object.ptoemi[dw_cab.getrow()])))+'-'+string(ll_nota)
			ld_preimpreso = double(ls_ref)
			//voy a ingresar el cxc_documento
			  INSERT INTO cxc_documento  
         ( tipo_documento,   
           nr_documento,   
           cod_ingreso,   
           cod_funcionario,   
           cod_nota,   
           cod_sistema,   
           cod_forma_pago,   
           tipo_mov_doc,   
           f_documento,   
           f_proceso,   
           cod_cliente,   
           subtotal,   
           descuento,   
           iva,   
           otros_cargos,   
           monto,   
           retencion,   
           saldo,   
           nr_recibo,   
           nr_comprob,   
           tipo_comprob,   
           usuario,   
           observacion,   
           nr_preimpreso,   
           ln,   
           estado,   
           nota_embarque,   
           fecha_cancelacion,   
           tarifa_0,   
           fecha_embarque,   
           porcentaje_iva,   
           descuento_iva,   
           descuento_sin_iva,   
           c_iva,   
           cod_bodega,   
           cod_transporte ,
		  subempresa	  )  
  VALUES ( 'FC',   
           :ls_numeroc,   
           null,   
           :ll_funcionario,   
           null,   
           6,   
           4,   
           'O',   
           :dt_fecha,   
           :dt_fecha,   
           :ll_cliente,   
           :ld_credito,   
           0,   
           0,   
           0,   
           :ld_credito,   
           0,   
           :ld_credito,   
           null,   
           null,   
           null,   
           'ADM',   
           :ls_ref,   
           0,   
           '1',   
           'V',   
           null,   
           null,   
           0,   
           null,   
           0,   
           0,   
           0,   
           :gs_piva,   
           :gi_bodega,   
           1 ,
		  :gs_subempresa )  ;

	  if sqlca.sqlcode < 0 or sqlca.sqlcode = 100 then
		messagebox("Información","No puedo grabar cxc_documentoo~r~nConsulte a su proveedor del sistema.",information!)
		rollback;
		return -1
    end if
			///ahora vamos al detalle
			  INSERT INTO cxc_det_documento  
         ( tipo_documento,   
           nr_documento,   
           det_documento,   
           cod_ingreso,   
           f_venc,   
           monto,   
           saldo,   
           observacion,
	      subempresa		  
            )  
  VALUES ( 'FC',   
           :ls_numeroc,   
           1,   
           null,   
           :dt_fecha_ven,   
           :ld_credito,   
           :ld_credito,   
           :ls_ref ,  
            :gs_subempresa)  ;
				commit;
		if sqlca.sqlcode < 0 or sqlca.sqlcode = 100 then
		messagebox("Información","No puedo grabarel detalle cxc_documentoo~r~nConsulte a su proveedor del sistema.",information!)
		rollback;
		return -1
    end if

			
			
			
		end if	
	end  if		
	//inserto retención
	ls_numero=string(dw_cab.object.numero[1])
	string ls_tipo
	for ll_i=1 to 2 
		
	choose case ll_i
     case 1  //retencion_iva
	ldb_p=dw_cab.object.reten_iva[1]  //valor
	ll_n=dw_cab.object.cod_iva[1]  //codigo_iva
	ll_factura=long(dw_cab.object.nr_reten[1])
	ls_tipo='I'
	
     case 2
	ldb_p=dw_cab.object.reten_fte[1]  //valor
	ll_n=dw_cab.object.cod_fte[1]  //codigo_fte
	ll_factura=long(dw_cab.object.nr_reten[1])
	ls_tipo='F'
	end choose	
	
	if ldb_p > 0 then
		
			INSERT INTO CXC_RET_ABONO  
         ( TIPO_DOCUMENTO,   
           NR_DOCUMENTO,   
           TIPO_RETENCION,   
           COD_COMPANIA,   
           VALOR_RETENIDO,   
           NR_RETENCION,   
           COD_RETENCION ,
		  nr_caja	  ,
		  subempresa
    )  
  VALUES ( 'EV',   
           :ls_numero,   
           :ls_tipo,   
           '1',   
           :ldb_p,   
           :ll_factura,   
           :ll_n ,
		  :gi_caja,
		   :gs_subempresa)  ;
			  
			 if sqlca.sqlcode < 0 or sqlca.sqlcode = 100 then
			messagebox("Información","No puedo grabarel detalle de la retención~r~nConsulte a su proveedor del sistema.",information!)
			rollback;
			return -1
		    end if

		
		
		
	end if	
    next 
	 
	 //elec_impuestos//FE   anterior este no aplica actual
//	 if f_elec_impuestos(ll_nota,ls_tipodoc,gc_iva,gi_caja,gs_cod_compania) < 0 then
	//		messagebox("Información","No puedo grabarel detalle de elec_impuestos.",information!)
		//	rollback;
		//	return -1
		//end if		
		 	 
         	//FE
				
				 if ls_tipodoc='EV' then
					    if dw_elecfc.retrieve(ls_tipodoc,ll_nota,gi_caja) < 0 then
        					   messagebox("Atención","XML FC no Generado")   
				            return -1
                    	   end if				//192.168.100.90
	               resp=dw_elecfc.SaveAs("\\"+gs_server+"\Z\COMPROBANTES\GENERADOS\FC\"+string(ls_clave)+".XML", XML!, True)
//                      resp=dw_elecfc.SaveAs("\\POWER2017\Z\COMPROBANTES\GENERADOS\FC\"+string(ls_clave)+".XML", XML!, True)							
	                else
					   if dw_elecnc.retrieve(ls_tipodoc,ll_nota,gi_caja) < 0 then
        					   messagebox("Atención","XML NC no Generado")   
				            return -1
                    	   end if				
 						resp=dw_elecnc.SaveAs("\\"+gs_server+"\Z\COMPROBANTES\GENERADOS\NC\"+string(ls_clave)+".XML", XML!, True)
						//resp=dw_elecnc.SaveAs("\\POWER2017\Z\COMPROBANTES\GENERADOS\NC\"+string(ls_clave)+".XML", XML!, True)
				end if
							
		
	
	if isnull(resp)then resp=0
	if resp <=0 then
			messagebox("Atención","XML FC no Guardado en Ruta")   
				//return -1
			end if			

	
	   //FE
	 
	commit;
		  /////////////////////////////////////////////////////////////////////////
	  
     if this.event ue_imprimir(ll_nota) < 0 then  return -1
//	  run ("VbSample.exe")
	  messagebox("Atención","Venta registrada")
	  this.event limpiar()
	  return 1
	else
	  ls_msg = sqlca.sqlerrtext
	  rollback;
	end if
else
	ls_msg = sqlca.sqlerrtext
	rollback;
end if
messagebox("Error","No puedo crear el detalle del movimiento~r~n"+ls_msg,exclamation!)
return -1

end event

event eliminar();/*
long ll_fila,ll_numdev
int li_cont,li_i
dw_visualiza_precios.hide()
ll_numdev=dw_cab.object.nr_devol[1]
if not dw_det_pago.visible then
	dw_det.deleterow(dw_det.getrow())
//	if li_numdev <> 0 then dw_det_pago.insertrow(0)
end if
li_cont = dw_det.rowcount()
if li_cont < 1 then return
if ll_numdev <> 0 then
	for li_i= 1 to li_cont
	   if dw_det.object.cant_pres[1] > 0 then dw_det.object.cant_pres[1]= dw_det.object.cant_pres[1]*(-1)
	next
end if
dw_cab.event refrescar()	
*/
long ll_fila,ll_numdev,ll_fun
int li_cont,li_i
double ldb_totahorro

dw_visualiza_precios.hide()
ll_numdev=dw_cab.object.nr_devol[1]


/////////////////////////////////////////
open(w_autoriza_borrafila)       //desde aqui activa claves
ll_fun = message.doubleparm
	  if ll_fun = 0 or isnull(ll_fun) then
		 return
	else
		if not dw_det_pago.visible then//esto es propio, sin claves
	dw_det.deleterow(dw_det.getrow()) //esto es propio, sin claves
		
	  end if              // hasta aqui activa claves, menos las dos filas propio

///////////////////////////////////////////
//if not dw_det_pago.visible then
//	dw_det.deleterow(dw_det.getrow())


//	if li_numdev <> 0 then dw_det_pago.insertrow(0)
end if
li_cont = dw_det.rowcount()
if li_cont < 1 then return
if ll_numdev <> 0 then
	for li_i= 1 to li_cont
	   if dw_det.object.cant_pres[1] > 0 then dw_det.object.cant_pres[1]= dw_det.object.cant_pres[1]*(-1)
	next
end if
dw_cab.event refrescar()	

end event

event insertar();long ll_fila
int li_cont,li_i
dw_visualiza_precios.hide()
if il_items <> 0 then
gc_iva=double(ddlb_iva.text	)
if il_items > dw_det.rowcount() then
 if dw_cab.getitemnumber(1,"nr_devol") = 0 then
	dw_det.accepttext()
	if not dw_det_pago.visible then
		if dw_det.rowcount() > 0 then 
			if isnull(dw_det.getitemnumber(dw_det.getrow(),"cod_articulo")) then	return
		end if
		ll_fila = dw_det.insertrow(0)
		
		dw_det.scrolltorow(ll_fila)	
		dw_det.setitem(ll_fila,"prc_iva",gc_iva)
		dw_det.setitem(ll_fila,"tiporuc",gc_tipo_clie)
		dw_det.setitem(ll_fila,"solidario",0.00)
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
		dw_det.setitem(ll_fila,"solidario",0.00)
	end if
	dw_cab.accepttext()
	dw_det.event refrescar()	
	dw_det.accepttext()
	dw_det.event ue_asigna_variables ()	
	w_busqueda_art.show()
	w_busqueda_art.dw_condiciones.setfocus()	
    	end if	
end if	
/*long ll_fila
int li_cont,li_i
dw_visualiza_precios.hide()
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
	
end if	*/
end event

event forma_pago;long ll_numdev
dw_visualiza_precios.hide()
ll_numdev = dw_cab.object.nr_devol[1]
if ll_numdev <> 0 then return 
if dw_det.rowcount() < 1 then return
dw_det_pago.visible = not dw_det_pago.visible
if dw_det_pago.visible then
	dw_det_pago.setcolumn("aux")
	dw_det_pago.setfocus()
	dw_det_pago.Selecttext (1, Len(dw_det_pago.GetText()))
else
	dw_det.setfocus()
	dw_det.setcolumn(16)
end if

end event

event type integer chequeo();setpointer(hourglass!)
long ll_n,ll_i,ll_eliminar,ll_art,ll_art1,li_existe,li_cli
integer li_colnbr = 0,li_neg=0,li_pos=0,li_cont=0,li_i,li_j,li_c=0
double tot1,tot,ldb_cant,ldb_cant1,ldb_cantot,ldb_stock,ldb_total_nv
string ls_colname,ls_textname,ls_referencia,ls_ruc,ls_buscar,ls_direc,ls_telefono,ls_email
long ll_numdev
ll_numdev = dw_cab.object.nr_devol[1]
li_cont = dw_det.rowcount()
ldb_total_nv = dw_cab.object.total[1]


if dw_cab.accepttext() < 0 then return -1


//ls_buscar=trim(dw_cab.object.c_i_o_ruc[1])
li_cli=dw_cab.object.cod_cliente[1]
if isnull(li_cli) then li_cli=0

select  (cod_cliente),direccion,telefono,direc_electronica
into :li_existe,:ls_direc,:ls_telefono,:ls_email
from cliente
where cliente.cod_cliente=:li_cli;


if len(ls_email)<=2  then ls_email=''
if len(ls_direc)<=2  then ls_direc=''
if len(ls_telefono)<=2  then ls_telefono=''
if (isnull(ls_direc)or ls_direc='') or (isnull(ls_telefono)or ls_telefono='')  or(isnull(ls_email) or ls_email='')  then
	Messagebox("Información","Falta datos en el cliente: Correo,telefono o direccion,revise primero",Information!)
	return -1
end if
	


if isnull(li_existe) then li_existe=0

if li_existe=0 or isnull(li_cli) then
	Messagebox("Información","Seleccione el Cliente con F8;o  Ingreselo-Chequeo",Information!)
	return -1
end if



if dw_cab.object.reten_fte[1]> 0 or dw_cab.object.reten_iva[1]> 0 then
ls_referencia=dw_cab.object.nr_reten[1]
if isnull(ls_referencia) or  ls_referencia='' then
	Messagebox("Información","Ingrese el Número de Retención",Information!)
	return -1
end if

if dw_cab.object.reten_fte[1]> 0 then
ls_referencia=string(dw_cab.object.cod_fte[1])
if ls_referencia ='0' or ls_referencia='' or isnull(ls_referencia) then
	Messagebox("Información","Tipo de Retención No seleccionado",Information!)
	return -1
end if
end if

if dw_cab.object.reten_iva[1]> 0 then
ls_referencia=string(dw_cab.object.cod_iva[1])
if ls_referencia ='0' or ls_referencia='' or isnull(ls_referencia) then
	Messagebox("Información","Tipo de Retención No seleccionado",Information!)
	return -1
end if
end if

end  if	


ls_referencia=dw_cab.object.referencia[1]
/*if isnull(ls_referencia) or  ls_referencia='' then
	Messagebox("Información","Ingrese el Número de Factura o Pedido",Information!)
			return -1
		else
			//busco si se repite
			
	 SELECT count(PV_NOTA_VENTA.REFERENCIA )
   INTO :li_c  
    FROM PV_NOTA_VENTA  
   WHERE PV_NOTA_VENTA.REFERENCIA = :ls_referencia   ;
	
	if isnull(li_c) then li_c=0
	
	if li_c >=1 then
			Messagebox("Información","El Número de Factura o Pedido ya Existe",Information!)
			return -1
		end if		
		end if			
*/

//Verificar el stock disponible para el caso de varios usuarios
if ll_numdev = 0 then
	for li_i=1 to li_cont 
		ll_art= dw_det.object.cod_articulo[li_i]
		ldb_cant= dw_det.object.canr[li_i]
		ldb_cantot= ldb_cant
		for li_j= li_i + 1 to dw_det.rowcount()
			ll_art1= dw_det.object.cod_articulo[li_j]
			ldb_cant1= dw_det.object.canr[li_j]
			if ll_art = ll_art1 then
				ldb_cantot= ldb_cantot + ldb_cant1
			else
				ldb_cantot= ldb_cant
			end if
		next
 	   SELECT inv_articulos_bodega.stock_disponible 
		INTO :ldb_stock FROM inv_articulos_bodega with( holdlock)
      WHERE (inv_articulos_bodega.cod_articulo= :ll_art) AND  
      (inv_articulos_bodega.cod_bodega = :gi_bodega);
      if ldb_cantot > ldb_stock then      
			Messagebox("Información","No hay stock disponible, debe utilizar la opción de refrescar :producto: "+ STRING(ll_art),Information!)
			ROLLBACK;
			return -1
   	end if
   next
end if
//////////////
if isnull(li_cont) then li_cont= 0
if li_cont= 0 then return -1
//Valida los datos del detalle del pago
if dw_det_pago.accepttext() < 0 then return -1
if dw_det_pago.rowcount() = 1 then 
	tot=0
	return -1
elseif dw_det_pago.rowcount() > 1 then 
	tot=abs(dw_det_pago.object.aux[2])
	tot1=abs(dw_det_pago.object.aux[3])
end if
if tot > 0 then
	if isnull(dw_det_pago.object.nr_cta[2]) then
		messagebox("Información","El Nro. Cta/Tarj. debe ser ingresado",Information!)
		dw_det_pago.setcolumn("nr_cta")
		dw_det_pago.setfocus()
   	return -1		
	end if
	if isnull(dw_det_pago.object.nr_cheque[2]) then
		messagebox("Información","El Nro. Cheq./Aut. debe ser ingresado",Information!)
		dw_det_pago.setcolumn("nr_cheque")
		dw_det_pago.setfocus()
		return -1
	end if
	if isnull(dw_det_pago.object.cod_banco[2]) then
		messagebox("Información","El Banco debe ser ingresado",Information!)
		dw_det_pago.setcolumn("cod_banco")
		dw_det_pago.setfocus()
		return -1
	end if
end if
if tot1 > 0 then
	if isnull(dw_det_pago.object.nr_cta[3]) then
		messagebox("Información","El Nro. Cta/Tarj. debe ser ingresado",Information!)
		dw_det_pago.setcolumn("nr_cta")
		dw_det_pago.setfocus()
		return -1
	end if
	if isnull(dw_det_pago.object.nr_cheque[3]) then
		messagebox("Información","El Nro. Cheq./Aut. debe ser ingresado",Information!)
		dw_det_pago.setcolumn("nr_cheque")
		dw_det_pago.setfocus()
		return -1
	end if
	if isnull(dw_det_pago.object.cod_banco[3]) then
		messagebox("Información","El Banco debe ser ingresado",Information!)
		dw_det_pago.setcolumn("cod_banco")
		dw_det_pago.setfocus()
		return -1
	end if
	if isnull(dw_det_pago.object.cod_tarjeta[3]) then
		messagebox("Información","La Tarjeta debe ser ingresado",Information!)
		dw_det_pago.setcolumn("cod_tarjeta")
		dw_det_pago.setfocus()
		return -1
	end if
	if isnull(dw_det_pago.object.tipo_credito[3]) then
		messagebox("Información","El tipo de pago debe ser ingresado",Information!)
		dw_det_pago.setcolumn("tipo_credito")
		dw_det_pago.setfocus()
		return -1
	end if
end if
///////////
if dw_det.accepttext() < 0 then return -1
ll_n = dw_det.rowcount()
if ll_n = 0 then return 0
for ll_i = 1 to li_cont
	if isnull(dw_det.object.cant_pres[ll_i]) then 
		messagebox("Información","Hay una cantidad que no fue ingresada",information!)
		return -1
	end if
	if dw_det.object.cant_pres[ll_i] > 0 then 
		li_pos++
	elseif dw_det.object.cant_pres[ll_i] < 0 then 
		li_neg++
	end if
	if li_pos > 0 and li_neg > 0 then
		messagebox("Información","No puede combinar cantidades positivas y negativas",information!)
		return -1
	end if
next
for ll_i = 1 to li_cont
	if isnull(dw_det.object.p_unit[ll_i]) or dw_det.object.p_unit[ll_i]= 0 then
		messagebox("Información","Hay un precio unitario qu e no fue ingresada",information!)
		return -1
	end if
	if isnull(dw_det.object.cant_pres[ll_i]) or dw_det.object.cant_pres[ll_i]= 0 then 
		messagebox("Información","Hay una cantidad que no fue ingresada",information!)
		return -1
	end if
	if ll_numdev <> 0 then
		if dw_det.object.cant_pres[ll_i] > 0 then 
  		  messagebox("Información","Ticket por Devolución. Las cantidades deben ser negativas",information!)
		  return -1
	   end if
	elseif ll_numdev =0 then
	if dw_det.object.cant_pres[ll_i] < 0 and ldb_total_nv > 0 then 
  		  messagebox("Información","Las cantidades deben ser positivas",information!)
		  return -1
	   end if
	end if
next
// Eliminar el registro invalido
ll_i = 1
DO WHILE ll_i > 0 
	ll_i = dw_det.find("cant_pres = 0",ll_i,dw_det.rowcount())
	if ll_i > 0 then
		messagebox("Información","Registro invalido.~r~nEliminelo o complete la información",information!)
		dw_det.selectrow(0,false)
		dw_det.selectrow(ll_i,true)
		dw_det.setrow(ll_i)
		dw_det.scrolltorow(ll_i)
		return -1
	end if
LOOP
if double(dw_cab.getitemnumber(1,"total")) <> double(dw_det_pago.getitemnumber(1,"total")) then
	messagebox("Información","El valor a Pagar no concuerda con el detalle de pago",information!);
	dw_det_pago.show()
	dw_det_pago.setfocus()
	return -1
end if
if dw_det_pago.accepttext() < 0 then return -1
if dw_cab.object.total[1] > 0 then
	for li_i= 4 to 1 step -1
	 if dw_det_pago.getitemnumber(li_i,"aux") = 0 then 
		dw_det_pago.deleterow(li_i)
	 end if
	next
elseif dw_cab.object.total[1] = 0 then
	for li_i= 4 to 2 step -1
	 if dw_det_pago.getitemnumber(li_i,"aux") = 0 then 
		dw_det_pago.deleterow(li_i)
	 end if
	next
end if
ll_n = dw_det_pago.rowcount()
if ll_n = 0 then
	messagebox("Información","No ha seleccionado la forma de pago",information!)
	return -1
end if
return 1
end event

event type integer grabar_mov(long al_cliente);int li_i,li_n,li_uni,i,li_revisanc=0
double   li_canr,li_canpres  //LE PONGO DOBLE PARA QUER NO REDONDEE LA Cantidad
double ldb_monto,ldb_iva,ldb_csu,ldb_csv,ldb_costor,ldb_punit,ldb_porc,ldb_pvp,ldb_porciva
double ldb_dstosiva,ldb_dstociva
string ls_msg,ls_piva
long ll_numnv,ll_stock,ll_art
datetime dt_fecha
dt_fecha = datetime(dw_cab.object.fecha_emision[1])
for i = 1 to dw_det_pago.rowcount()
dw_det_pago.object.fecha_cobro[i] = dt_fecha
next
il_mov1 = -1;il_mov2 = -1
li_n = dw_det.rowcount()
dw_visualiza_precios.hide()
if isnull(li_n) then li_n = 0
ll_numnv = dw_cab.object.nr_devol[1]
if dw_det.find("cant_pres > 0",1,li_n) > 0 then
	li_revisanc = 1
	il_mov1 = f_secuencial ( 'MOVIMIENTO') 
	
	long ll_max_movi
	select max(nr_movimiento) 
	into :ll_max_movi
	from inv_movimiento;
	
if il_mov1 <= ll_max_movi then
		il_mov1 = ll_max_movi +1
		ll_max_movi = ll_max_movi +2
  UPDATE SEQNO
   SET NUMSEQ = :ll_max_movi
 WHERE SEQNO.TABLA = 'MOVIMIENTO' ;
IF SQLCA.SqlCode < 0 then
	gs_mensaje="seqno"
	f_mensajes(18)
	rollback;
	return  0
 END IF
 
END IF
	IF il_mov1 < 0 THEN RETURN -1
	INSERT INTO inv_movimiento  
   (tipo_movimiento,nr_movimiento,cod_compania,f_movimiento, cod_cliente,usuario,subempresa)
	VALUES ('EV',:il_mov1,:gs_cod_compania,:dt_fecha,:al_cliente,:gs_usuario,:gs_subempresa); //getdate()
	if sqlca.sqlcode < 0 then
		ls_msg = sqlca.sqlerrtext
		rollback;
		messagebox("Información","No puedo crear el movimiento de ventas 1~r~n"+ls_msg,information!)
		return -1
	end if
end if
if dw_det.find("cant_pres < 0",1,li_n) > 0 then
	il_mov2 = f_secuencial ( 'MOVIMIENTO') 
	IF il_mov2 < 0 THEN RETURN -1
	INSERT INTO inv_movimiento  
   (tipo_movimiento,nr_movimiento,cod_compania,f_movimiento,cod_cliente,usuario,subempresa)
	VALUES ('ID',:il_mov2,:gs_cod_compania,:dt_fecha,:al_cliente,:gs_usuario,:gs_subempresa);
	if sqlca.sqlcode < 0 then
		ls_msg = sqlca.sqlerrtext
		rollback;
		messagebox("Información","No puedo crear el movimiento de ventas 2~r~n"+ls_msg,information!)
		return -1
	end if
end if	
//busca costo promedio
integer li_art
double ldb_co
for li_i = 1 to li_n
li_art=dw_det.object.cod_articulo[li_i]
ldb_co = f_costo_promedio(li_art,dt_fecha)
if isnull(ldb_co) then ldb_co=0
if ldb_co > 0 then
dw_det.object.costo_prom[li_i] = ldb_co
end if
next	
dw_det.accepttext()
for li_i = 1 to li_n
	dw_mov_art.insertrow(0)
	dw_det.setitem(li_i,"secuencial",li_i)			
	dw_mov_art.setitem(li_i,"secuencial",li_i)		
	ll_art= dw_det.object.cod_articulo[li_i]
	dw_mov_art.setitem(li_i,"cod_articulo",dw_det.object.cod_articulo[li_i])
	dw_mov_art.setitem(li_i,"subempresa",gs_subempresa)
	dw_mov_art.setitem(li_i,"cod_bodega",gi_bodega)	
	if dw_det.getitemnumber(li_i,"cant_pres") > 0 then
		dw_det.setitem(li_i,"pv_det_nota_venta_tipo_doc",'EV')			
		dw_mov_art.setitem(li_i,"nr_movimiento",il_mov1)
		dw_mov_art.setitem(li_i,"tipo_movimiento",'EV')
		li_canr = dw_det.object.canr[li_i]
		li_canpres = dw_det.object.cant_pres[li_i]
		dw_mov_art.setitem(li_i,"cantidad",li_canr)
		dw_mov_art.setitem(li_i,"tipo",dw_det.object.tipo[li_i])
		ldb_iva = dw_det.object.iva_linea[li_i]
		ldb_porc = dw_det.object.prc_dsto[li_i]		
		dw_mov_art.setitem(li_i,"porc_descuento",ldb_porc)
		ls_piva = dw_det.object.paga_iva[li_i]
		if isnull(ldb_iva) then ldb_iva= 0
		ldb_punit=dw_det.object.p_unit[li_i]
		ldb_monto = dw_det.object.subtotal[li_i]
		dw_det.object.monto[li_i] = ldb_monto
		dw_mov_art.setitem(li_i,"monto",round(li_canr*ldb_punit,2))
		dw_mov_art.setitem(li_i,"p_unit",dw_det.object.p_unit[li_i])
		dw_mov_art.setitem(li_i,"cod_unidad",dw_det.object.cod_unidad[li_i])
		dw_mov_art.setitem(li_i,"conversion",dw_det.object.conversion[li_i])
      dw_mov_art.setitem(li_i,"paga_iva",dw_det.object.paga_iva[li_i])		
		if ls_piva = 'S' or ls_piva='M' then
        dw_det.setitem(li_i,"dsto_con_iva",round(ldb_punit*li_canpres*ldb_porc/100,4))
		else
	     dw_det.setitem(li_i,"dsto_sin_iva",round(ldb_punit*li_canpres*ldb_porc/100,4))
   	end if
		dw_det.setitem(li_i,"iva",ldb_iva)
      dw_mov_art.setitem(li_i,"cantidad_devuelta",0)										
      dw_mov_art.setitem(li_i,"cant_presentacion",dw_det.object.cant_pres[li_i])
      dw_mov_art.setitem(li_i,"costo_promedio",dw_det.object.costo_prom[li_i])
	elseif dw_det.getitemnumber(li_i,"cant_pres") < 0 then
   	dw_det.setitem(li_i,"pv_det_nota_venta_tipo_doc",'ID')			
		dw_mov_art.setitem(li_i,"nr_movimiento",il_mov2)		
		dw_mov_art.setitem(li_i,"tipo_movimiento",'ID')
		li_canpres = dw_det.object.cant_pres[li_i]		
      li_canr = dw_det.object.canr[li_i]
		li_uni= abs(dw_det.object.cod_unidad[li_i])
		ldb_porc = dw_det.object.prc_dsto[li_i]				
		dw_mov_art.setitem(li_i,"cantidad",abs(li_canr))
		dw_mov_art.setitem(li_i,"tipo",dw_det.object.tipo[li_i])
		dw_mov_art.setitem(li_i,"porc_descuento",ldb_porc)
		ldb_iva = dw_det.object.iva_linea[li_i]
		if isnull(ldb_iva) then ldb_iva= 0
		ldb_punit=dw_det.object.p_unit[li_i]
		ldb_monto = dw_det.object.subtotal[li_i]
		ldb_pvp = dw_det.object.pvp[li_i]
		dw_det.object.monto[li_i] = ldb_monto
		dw_mov_art.setitem(li_i,"p_unit",ldb_punit)
		ldb_porciva = dw_det.object.prc_iva[li_i]		
		ls_piva = dw_det.object.paga_iva[li_i]
		if ls_piva = 'S' then
         ldb_dstociva= round(round(li_canpres*ldb_pvp/(1 + ldb_porciva/100),4)*(ldb_porc/100),4)
//         dw_det.object.dsto_con_iva[li_i] =ldb_dstociva
         dw_det.setitem(li_i,"dsto_con_iva",ldb_dstociva)
	  	else
			ldb_dstosiva= round((li_canpres * ldb_pvp)*(ldb_porc/100),4)
//         dw_det.object.dsto_sin_iva[li_i] = ldb_dstosiva
         dw_det.setitem(li_i,"dsto_sin_iva",ldb_dstosiva)			
    	end if
		dw_det.setitem(li_i,"iva",ldb_iva)
   	dw_mov_art.setitem(li_i,"monto",round(ldb_punit*abs(li_canr),2))
		dw_mov_art.setitem(li_i,"cod_unidad",li_uni)
		dw_mov_art.setitem(li_i,"conversion",abs(dw_det.object.conversion[li_i]))
      dw_mov_art.setitem(li_i,"paga_iva",dw_det.object.paga_iva[li_i])
		dw_det.setitem(li_i,"iva",ldb_iva)
      dw_mov_art.setitem(li_i,"cantidad_devuelta",0)
	   dw_mov_art.setitem(li_i,"cant_presentacion",li_canpres)
      SELECT costo_promedio,stock_disponible INTO :ldb_csu,:ll_stock
		FROM inv_articulo with(holdlock) WHERE cod_articulo = :ll_art;
		if sqlca.sqlcode < 0 then
			ls_msg = sqlca.sqlerrtext
			rollback;
			messagebox("Información","No puedo actualizar el costo 1~r~n"+ls_msg,information!)
			return -1
		end if
		ldb_csv=abs(dw_det.object.costo_prom[li_i])
		ldb_costor = ll_stock*ldb_csu + abs(li_canr)*ldb_csv
      ldb_costor = round(ldb_costor /(ll_stock + abs(li_canr)),5)
      dw_mov_art.setitem(li_i,"costo_promedio",ldb_costor)
		dw_det.setitem(li_i,"costo_prom",ldb_costor)
      UPDATE pv_det_nota_venta SET cant_devol= cant_devol + :li_canpres
		WHERE (cod_compania = :gs_cod_compania) AND
      (cod_articulo = :ll_art) AND (numero = :ll_numnv) AND
      (cod_bodega = :gi_bodega) AND (cod_unidad = :li_uni);
		if sqlca.sqlcode < 0 then
			ls_msg = sqlca.sqlerrtext
			rollback;
			messagebox("Información","No puedo actualizar la devolucion 1~r~n"+ls_msg,information!)
			return -1
		end if
		if ldb_costor > 0 then
      UPDATE inv_articulo SET costo_promedio= :ldb_costor 
		WHERE cod_articulo = :ll_art;
		if sqlca.sqlcode < 0 then
			ls_msg = sqlca.sqlerrtext
			rollback;
			messagebox("Información","No puedo actualizar la devolucion 1~r~n"+ls_msg,information!)
			return -1
		end if
	end if
end if  //ldb_costor
	//Actualiza el stock y el costo promedio
	UPDATE inv_articulos_bodega SET stock_disponible = stock_disponible - :li_canr
	WHERE cod_bodega = :gi_bodega AND cod_articulo = :ll_art;
	if sqlca.sqlcode < 0 then
		ls_msg = sqlca.sqlerrtext
		rollback;
		messagebox("información","No puedo actualizar el stock en bodega~r~n"+ls_msg,information!)
		return -1
	end if
	UPDATE inv_articulo  SET stock_disponible = stock_disponible  - :li_canr , movimiento='S'
	WHERE cod_articulo = :ll_art;
	if sqlca.sqlcode < 0 then
		ls_msg = sqlca.sqlerrtext
		rollback;
		messagebox("Información","No puedo actualizar el stock~r~n"+ls_msg,information!)
		return -1
	end if
next



return 0

end event

event otro_precio();int li_uni
string ls_personal,ls_msg
long ll_fun,ll_art
dw_visualiza_precios.hide()
if dw_det.rowcount() > 0 then
	if not lbo_precio then
	  lbo_precio=true
    // open(w_autoriza_dscto)
	  ll_fun = message.doubleparm
	  ll_fun=1 //cambio
	  if ll_fun = 0 or isnull(ll_fun) then
		 lbo_precio = false	
		 dw_precios.visible = false
		 return
	  end if
	else
	  lbo_precio=false
   end if
	if lbo_precio then
	  SELECT nom_funcionario INTO :ls_personal
	  FROM funcionario WHERE cod_funcionario = :ll_fun ;
	  if sqlca.sqlcode < 0 then
		 ls_msg = sqlca.sqlerrtext
		 rollback;
		 messagebox("Error","No existe funcionario 1~r~n"+ls_msg,exclamation!)
		 return 
	  end if
	  if dw_det.getcolumnname() = "cant_pres" then
		 dw_precios.visible = not dw_precios.visible
		 IF dw_det.getselectedrow(0)> 0 THEN
		 ll_art=dw_det.getitemnumber(dw_det.getselectedrow(0),"cod_articulo")
		 li_uni=dw_det.getitemnumber(dw_det.getselectedrow(0),"cod_unidad")		
		 dw_precios.retrieve(ll_art,li_uni)
	     END IF
	 end if
	 if dw_precios.visible then dw_precios.setfocus() 
	 lbo_precio=false
  else
	 dw_precios.visible = false
  end if	
end if
end event

event type integer ue_imprimir(long nro_nota);string ls_modelo,ls_msg,ls_ruc,ls_nbanco,ls_ntarj,ls_nom,ls_tipo
int li_banco,li_tarj,li_i,li_fefec,li_fcheq,li_ftarj,li_formap,li_cont,li_prom
double ldb_vcheq,ldb_vtarj,ldb_vefec,ldb_items
char lc_paga_iva
if dw_cab.object.total[dw_cab.getrow()]> 0 then
	ls_tipo='EV'
else
	ls_tipo='ID'
end if	

lc_paga_iva=dw_cab.object.paga_iva[1]

if lc_paga_iva='N' then
messagebox("","cliente no ingresado con valor de IVA")
dw_notaimp.retrieve(	gs_cod_compania,nro_nota,gi_caja,ls_tipo)
dw_notaimp.print()
else
	

dw_1.settransobject(SQLCA)
if dw_1.retrieve(gs_cod_compania,nro_nota,gi_caja,ls_tipo) > 0 then
  if messagebox("Atención","Desea imprimir  ?",question!,yesno!,1) = 1 then	 // imprime

//		dw_1.modify("modelo.text='"+gs_modelo+"'")
//		dw_1.modify("sri.text = '"+gs_sri+"'")
//		dw_1.modify("num_suc.text='"+gs_num_suc+"'")
//		dw_1.modify("validez.text = '"+gs_validez+"'")
	//	dw_1.modify("ruc_matriz.text = " +gs_ruc_matriz+"'")
     // dw_1.modify("dir_matriz.text = '"+gs_dir_matriz+"'")		
//		dw_1.modify("ciudad.text = '"+gs_ciudad+"'")	
		dw_1.modify ("slogan.text = '"+gs_slogan+"'")	
		if gi_impresion = 1 then		
    	   //matricial			
			//dw_1.setitem(1,"ruc_matriz",gs_ruc_matriz)
//		   dw_1.setitem(1,"dir_matriz",gs_dir_matriz)		
	    	select forma.items into :ldb_items from forma 
			where (forma.cod_forma = 5) and (forma.tipo_forma = 4);
			if sqlca.sqlcode < 0 then
				messagebox("Información","No se puede recuperar el número de items del Ticket dinamico",information!)
				Return -1
			end if
			dw_1.accepttext()
			double ldb_tot_desc
			li_cont = dw_1.rowcount()
			
			if li_cont > 0 then
			ldb_tot_desc= dw_1.object.tot_desc[li_cont]
			ls_nom=dw_1.object.nom_funcionario[li_cont]
   		end if
			li_cont = dw_1.rowcount()
			li_prom = dw_1.rowcount()
			li_cont++
			for li_i = li_cont to ldb_items
			  dw_1.insertrow(li_i)
			next
			if ldb_items > 0 then
			dw_1.object.tot_desc[ldb_items]=ldb_tot_desc
			dw_1.object.nom_funcionario[ldb_items]=ls_nom
			end if
			
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
			if ldb_vefec > 0 then 
				dw_1.object.val_efec.visible= false  //le cambio para que no imprima
			else
				dw_1.object.val_efec.visible= false
			end if
			if ldb_vcheq > 0 then 
				dw_1.object.val_cheque.visible= true
			else
				dw_1.object.val_cheque.visible= false
			end if
			if ldb_vtarj > 0 then 
				dw_1.object.val_tarj.visible= true
			else
				dw_1.object.val_tarj.visible= false
			end if
	  	  if li_prom <> 0  and ldb_vefec = 0 and ldb_vtarj = 0 and ldb_vcheq= 0 then
				dw_1.object.val_efec.visible= true
	//			dw_1.setitem(dw_1.rowcount(),"val_efec",dw_det_pago.object.monto[li_fefec])
				dw_1.setitem(dw_1.rowcount(),"forma_efec",'E')
		  end if
		end if	
   //   dw_1.Print(true, true)
	if dw_1.print() < 0 then
   messagebox("ATención","reimprima  cola de impresora no lista")
 end if
				/* if messagebox("Atención","Va la Copia ?",question!,yesno!,1) = 1 then	
					dw_1.print()
				else
					dw_1.print()
				end if	
				*/

  end if  //pregunta si imprime
else
	messagebox("Atención","Reimprima")
	end if	
end if
return 1
end event

event habilita_dsto();string ls_personal,ls_msg
long ll_fun,ll_numdev
dw_visualiza_precios.hide()
if dw_det.rowcount() < 1 then return
if not lbo_dsto then
   ll_numdev = dw_cab.getitemnumber(1,"nr_devol")	
	if ll_numdev <> 0 then return
	lbo_dsto=true
//	open(w_autoriza_dscto)
	//ll_fun = message.doubleparm
	ll_fun=1
	if ll_fun = 0 or isnull(ll_fun) then
		lbo_dsto = false	
		dw_det.settaborder("prc_dsto",0)
		return
	end if
else
	lbo_dsto=false
end if
if lbo_dsto then
  SELECT nom_funcionario INTO :ls_personal
  FROM funcionario WHERE cod_funcionario = :ll_fun ;
  if sqlca.sqlcode < 0 then
		ls_msg = sqlca.sqlerrtext
		rollback;
		messagebox("Error","No existe funcionario 1~r~n"+ls_msg,exclamation!)
		return 
  end if
  dw_det.settaborder("prc_dsto",20)
  dw_det.setcolumn("prc_dsto")
  dw_det.settaborder("descuentom",30)
//  dw_det.setcolumn("prc_dsto")
  
  dw_det.setfocus()
else
  dw_det.settaborder("prc_dsto",0)
  dw_det.settaborder("descuentom",0)
end if	
end event

event promoc;long ll_fil,ll_art
int li_uni
double ldb_promoc,ldb_cant
string ls_tipo,ls_msg
dw_visualiza_precios.hide()
if dw_det.rowcount() < 1 then return
ll_fil = dw_det.getselectedrow(0)
if ll_fil > 0 then ldb_cant = dw_det.getitemnumber(dw_det.getselectedrow(0),"cant_pres")	
if isnull(ldb_cant) or ldb_cant = 0 then return
if ll_fil > 0 and ldb_cant > 0 then 
    ls_tipo= dw_det.getitemstring(ll_fil,"tipo")
	 if ls_tipo = 'N' then 
		 ll_art= dw_det.getitemnumber(ll_fil,"cod_articulo")
		 li_uni= dw_det.getitemnumber(ll_fil,"cod_unidad")
		 SELECT porc_promocion INTO :ldb_promoc 
		 FROM inv_presentacion
		 WHERE (cod_articulo = :ll_art ) AND  
		 (cod_unidad = :li_uni );
		 if sqlca.sqlcode < 0 then
			ls_msg = sqlca.sqlerrtext
			rollback;
			messagebox("Error","No dar promociones 1~r~n"+ls_msg,exclamation!)
			return 
		 end if
		 if isnull(ldb_promoc) then ldb_promoc = 0
		 dw_det.setitem(ll_fil,"prc_dsto",ldb_promoc)
		 dw_det.setitem(ll_fil,"tipo",'P')
	else
		 dw_det.setitem(ll_fil,"prc_dsto",0.0)
		 dw_det.setitem(ll_fil,"tipo",'N')
	end if
   dw_cab.event refrescar()
end if
end event

event devol();string ls_personal,ls_msg
long ll_fun
int li_i,li_cont
dw_visualiza_precios.hide()
open(w_autoriza_devol)
ll_fun = message.doubleparm
if ll_fun = 0 or isnull(ll_fun) then return
dw_det.event ue_asigna_variables ()	
open(w_nota_anterior)
ll_fun = message.doubleparm
if isnull(ll_fun) then ll_fun= 0
if ll_fun > 0 then 
	li_cont= dw_det.rowcount()
	if li_cont > 0 then
		 lbo_dsto = false
		 for li_i= 1 to li_cont
			dw_det.object.cant_pres[li_i] = dw_det.object.cant_pres[li_i]*(-1)
    		dw_cab.event refrescar()			
		 next
		 /////////////////////voy a verificar //
       
//		 gdw_det_pago.rowcount()
       double p
   	 if dw_det_pago.object.aux[4] < 0 then
//		 dw_det_pago.setitem(4,'aux',dw_det.getitemnumber(1,"total")) //cambio le quite
		 p=dw_det_pago.rowcount()
       p=dw_det_pago.object.monto[4]
//       dw_det_pago.setitem(4,'monto',dw_det.getitemnumber(1,"total"))		 //cambio le quite
       dw_det_pago.setitem(4,'monto',p) //new le puse
           if dw_det_pago.accepttext() < 0 then return
     	 else
       dw_det.settaborder('prc_dsto',0)
		 dw_det_pago.setitem(1,'aux',dw_det.getitemnumber(1,"total"))
       dw_det_pago.setitem(1,'monto',dw_det.getitemnumber(1,"total"))		 
		 if dw_det_pago.accepttext() < 0 then return
       end if
   else
		 Messagebox("Aviso","Ya no hay productos por devolver")
		 this.event limpiar()
   end if
end if
end event

event cliente();long ll_cod_clie,ll_art,ll_numdev
int li_i
double ldb_cant,ldb_prc_des
string ls_piva
ll_numdev = dw_cab.object.nr_devol[1] 
if ll_numdev <> 0 then return 
dw_visualiza_precios.hide()
open(w_dir_clientes)
ll_cod_clie = Message.doubleparm
if isnull(ll_cod_clie) then ll_cod_clie=0
if ll_cod_clie= 0 then
	return
else
	dw_cab.object.cod_cliente[1] = ll_cod_clie
	dw_cab.object.nomb_cliente[1] = gs_nom_clie
	dw_cab.object.c_i_o_ruc[1] = gs_ruc_clie
	dw_cab.object.paga_iva[1] = gs_piva
	dw_cab.object.tipocliente[1]=gc_tipo_clie
	if dw_det.rowcount() > 0 then
     for li_i=1 to dw_det.rowcount()
    	 ldb_prc_des= dw_det.object.prc_dsto[li_i]
		 ll_art= dw_det.object.cod_articulo[li_i]
		 if gs_piva = 'N' then
   		 dw_det.object.prc_iva[li_i] = 0
			 dw_det.object.iva[li_i] = 0
          dw_det.object.paga_iva[li_i] = 'N'
			 dw_det.object.prc_dsto[li_i] = ldb_prc_des
		 else
			if gs_piva = 'S' then
          SELECT inv_articulo.paga_iva INTO :ls_piva  
          FROM inv_articulo  
          WHERE inv_articulo.cod_articulo = :ll_art;
			 dw_det.object.paga_iva[li_i] = ls_piva
   		 dw_det.object.prc_iva[li_i] = gc_iva
			 dw_det.object.prc_dsto[li_i] = ldb_prc_des
    		else
 			if gs_piva = 'M' then
				 SELECT inv_articulo.paga_iva INTO :ls_piva  
          FROM inv_articulo  
          WHERE inv_articulo.cod_articulo = :ll_art;
			  if ls_piva='S' then
			  dw_det.object.paga_iva[li_i] = 'M'
			  dw_det.object.prc_iva[li_i] = gc_iva
      	  else
      	  dw_det.object.paga_iva[li_i] = 'N'
			  dw_det.object.prc_iva[li_i] = 0
      	  end if
			  dw_det.object.prc_dsto[li_i] = ldb_prc_des
			end if
       end if
	end if
		 ldb_cant=dw_det.object.cant_pres[li_i]
		 dw_det.object.cant_pres[li_i] = 0
		 dw_det.object.cant_pres[li_i] = ldb_cant
	  next
	  dw_cab.event refrescar()
	end if
end if



end event

event recupera();string ls_personal,ls_msg
long ll_fun
int li_i,li_cont
dw_visualiza_precios.hide()
open(w_autoriza_dscto)
ll_fun = message.doubleparm
if ll_fun = 0 or isnull(ll_fun) then return
dw_det.event ue_asigna_variables ()	

open(w_nota_anterior)
ll_fun = message.doubleparm
if isnull(ll_fun) then ll_fun= 0
if ll_fun > 0 then 
	li_cont= dw_det.rowcount()
	if li_cont > 0 then
gb_modifica= true		
		 lbo_dsto = false
		 for li_i= 1 to li_cont
			dw_det.object.cant_pres[li_i] = dw_det.object.cant_pres[li_i]
    		dw_cab.event refrescar()			
		 next
		 /////////////////////voy a verificar //
       gb_modifica= true
	end if
end if	
	
//		 gdw_det_pago.rowcount()
//       double p
		 
   	/* if dw_det_pago.object.aux[4] < 0 then
//		 dw_det_pago.setitem(4,'aux',dw_det.getitemnumber(1,"total")) //cambio le quite
		 p=dw_det_pago.rowcount()
       p=dw_det_pago.object.monto[4]
//       dw_det_pago.setitem(4,'monto',dw_det.getitemnumber(1,"total"))		 //cambio le quite
       dw_det_pago.setitem(4,'monto',p) //new le puse
     //      if dw_det_pago.accepttext() < 0 then return
     	 else
       dw_det.settaborder('prc_dsto',0)
		 dw_det_pago.setitem(1,'aux',dw_det.getitemnumber(1,"total"))
       dw_det_pago.setitem(1,'monto',dw_det.getitemnumber(1,"total"))		 
	//	 if dw_det_pago.accepttext() < 0 then return
       end if
 //  else
	//	 Messagebox("Aviso","Ya no hay productos por devolver")
		// this.event limpiar()
   end if
end if*/
end event

event type integer modifica();long ll_nota,ll_i,ll_n,ll_cliente,ll_articulo,ll_fila,ll_funcionario
double lc_prc_dsto,lc_prc_iva,desc_adc,ld_preimpreso,ldb_p
string ls_msg,ls_ref,ls_numero,ls_otra_ref,ls_tipo,ls_compa
long ll_numdev,li_fp
datetime dt_fecha
integer li_pr

//setpointer(hourglass!)


dw_visualiza_precios.hide()

ll_numdev= dw_cab.object.nr_devol[1]

double ldb_total_nv

ldb_total_nv = dw_cab.getitemnumber(1,"total")
ll_cliente = dw_cab.getitemnumber(1,"cod_cliente")
dw_cab.accepttext()
ls_ref = dw_cab.getitemstring(1,"referencia")
ls_otra_ref = dw_cab.getitemstring(1,"otra_ref")
ll_funcionario = dw_cab.getitemnumber(1,"cod_vendedor")
dt_fecha =datetime(dw_cab.object.fecha_emision[1])
ll_nota = dw_cab.object.numero[1]
ls_tipo = 'EV'//dw_cab.object.tipo_doc[1]
dw_cab.resetupdate()
dw_det.resetupdate()
dw_det_pago.resetupdate()

  UPDATE pv_nota_venta  
     SET referencia = :ls_ref ,otra_ref=:ls_otra_ref ,cod_vendedor = :ll_funcionario,fecha_emision = :dt_fecha
   WHERE ( pv_nota_venta.cod_compania = :gs_cod_compania ) AND  
         ( pv_nota_venta.numero = :ll_numdev ) AND  
         ( pv_nota_venta.tipo_doc = :ls_tipo )   
           ;
			  commit;
			  	  
if sqlca.sqlcode < 0  then
		messagebox("Información","No actualiza.",information!)
		rollback;
		return -1
	end if
	
//	ahora fecha del movimiento
   long li_movi
  SELECT pv_nv_movimiento.nr_movimiento  
    INTO :li_movi  
    FROM pv_nv_movimiento  
   WHERE ( pv_nv_movimiento.cod_compania = :gs_cod_compania ) AND  
         ( pv_nv_movimiento.numero = :ll_numdev ) AND  
         ( pv_nv_movimiento.tipo_movimiento = :ls_tipo )   ;
if sqlca.sqlcode < 0  then
		messagebox("Información","No hay numero",information!)
		rollback;
		return -1
	end if
			
			//acu
			
       if li_movi > 0  then
			
			  UPDATE inv_movimiento  
     SET f_movimiento = :dt_fecha  
   WHERE ( inv_movimiento.tipo_movimiento = :ls_tipo ) AND  
         ( inv_movimiento.nr_movimiento = :li_movi )   
           ;
			  commit;
			  if sqlca.sqlcode < 0  then
		messagebox("Información","No hay numero",information!)
		rollback;
		return -1
	end if


       end if



	
messagebox("OK","Actualizado")

this.event limpiar()





return 1
end event

event listado();string ls_personal,ls_msg
long ll_fun
int li_i,li_cont
dw_visualiza_precios.hide()

//open(w_autoriza_dscto)
//ll_fun = message.doubleparm
//if ll_fun = 0 or isnull(ll_fun) then return
dw_det.event ue_asigna_variables ()	

open(w_dir_facturas)
ll_fun = message.doubleparm
gc_num_factura=ll_fun
open(w_nota_anterior)
if isnull(ll_fun) then ll_fun= 0
if ll_fun > 0 then 
	li_cont= dw_det.rowcount()
	if li_cont > 0 then
gb_modifica= true		
		 lbo_dsto = false
		 for li_i= 1 to li_cont
			dw_det.object.cant_pres[li_i] = dw_det.object.cant_pres[li_i]
    		dw_cab.event refrescar()			
		 next
		 /////////////////////voy a verificar //
       gb_modifica= true
	end if
end if	

end event

event type integer sigraba();double li_valor_total=0

if dw_cab.rowcount() > 0 then
li_valor_total=dw_cab.object.total[dw_cab.getrow()]
end if

if li_valor_total >0 then
	return 1
	
else
	return -1
	
end if	
	
end event

event sucursal();dw_visualiza_precios.hide()
open(w_busqueda_art_pase)

w_busqueda_art_pase.show()
end event

event wf_filtra_repetidos;long ll_nota,ll_i,ll_n,ll_cliente,ll_articulo,ll_fila,ll_funcionario
double lc_prc_dsto,lc_prc_iva,desc_adc,ld_preimpreso,ldb_p
string ls_msg,ls_ref,ls_numero
long ll_numdev,li_fp
datetime dt_fecha
integer li_pr

setpointer(hourglass!)

messagebox("m","modi")

/*dw_visualiza_precios.hide()
if dw_det_pago.object.cambio[3] < 0 then return -1
ll_numdev= dw_cab.object.nr_devol[1]
dw_mov_art.reset()
double ldb_total_nv
ldb_total_nv = dw_cab.getitemnumber(1,"total")

//Cambia el efectivo en caso de haber un cambio o vuelto

if dw_det_pago.object.cambio[3] >= 0 and ll_numdev = 0 then
	dw_cab.setitem(dw_cab.getrow(),"cambio",dw_det_pago.object.cambio[3])
   dw_det_pago.object.aux[1]= dw_det_pago.object.aux[1] - dw_det_pago.object.cambio[3]
	dw_det_pago.object.monto[1]=dw_det_pago.object.aux[1]
	dw_det_pago.object.monto[2]=dw_det_pago.object.aux[2]
   dw_det_pago.object.monto[3]=dw_det_pago.object.aux[3]	
	dw_det_pago.object.monto[4]=dw_det_pago.object.aux[4]	
	dw_det_pago.object.cambio[3]=0
////cambio para textielites
  if ldb_total_nv > 0 then
	if dw_det_pago.object.aux[1] < 0  then 
		messagebox("Informacion","El efectivo es menor al cambio",information!)
	   return -1	
	end if
	end if  //total_nv
end if
//////////////////////////////
ll_cliente = dw_cab.getitemnumber(1,"cod_cliente")

ls_ref = dw_cab.getitemstring(1,"referencia")
//ls_ref = dw_cab.object.referencia[1]
ll_funcionario = dw_cab.getitemnumber(1,"cod_vendedor")
dt_fecha =datetime(dw_cab.object.fecha_emision[1])

if this.event chequeo() <= 0 then return -1
if this.event grabar_mov(ll_cliente) < 0 then return -1
ll_nota = dw_cab.object.numero[1]
if IsNull(ll_nota) THEN	
	if ll_numdev = 0 and ldb_total_nv > 0 then //texti
      ll_nota = f_secuencial ( 'NOTA_VENTA' )
	else	
      ll_nota =  f_secuencial ( 'NC_CLIENTE' )
	end if	
end if


if ll_nota < 0 then return -1
dw_cab.setitem(1,"numero",ll_nota)
if ll_numdev = 0  and  ldb_total_nv > 0 then //textiel
 dw_cab.setitem(1,"tipo_doc",'EV')
else
 dw_cab.setitem(1,"tipo_doc",'ID')
end if
dw_cab.setitem(1,"nr_detalles",dw_mov_art.rowcount())
//dw_cab.setitem(1,"referencia",ls_ref)
dw_cab.setitem(1,"cod_compania",gs_cod_compania) //cambio **
//ls_ref = dw_cab.object.referencia[1]
// creación del detalle de pago
ll_i = dw_det_pago.rowcount()

for ll_i=dw_det_pago.rowcount()  to 1 step -1
	if dw_det_pago.object.monto[ll_i] = 0 then
  	dw_det_pago.deleterow(ll_i)
  end if	
next		

ll_i = dw_det_pago.rowcount()
for ll_i =1 to dw_det_pago.rowcount()
	if ll_numdev = 0 and ldb_total_nv > 0 then  //textil
	 	dw_det_pago.setitem(ll_i,"tipo_doc",'EV')
	else
		dw_det_pago.setitem(ll_i,"tipo_doc",'ID')
	end if	
 	dw_det_pago.setitem(ll_i,"numero",ll_nota)
	dw_det_pago.setitem(ll_i,"det_pago",ll_i)
	dw_det_pago.setitem(ll_i,"cod_compania",gs_cod_compania)//cambio **
next
for ll_i =1 to dw_det.rowcount()
	dw_det.setitem(ll_i,"numero",ll_nota)
	dw_det.setitem(ll_i,"cod_bodega",gi_bodega)
next
if dw_cab.update(true) > 0 then
   if dw_mov_art.find("tipo_movimiento ='EV'",1,dw_mov_art.rowcount()) > 0 then
		INSERT INTO pv_nv_movimiento (cod_compania, numero, tipo_movimiento, nr_movimiento)
		VALUES (:gs_cod_compania,:ll_nota,'EV',:il_mov1) ;
		if sqlca.sqlcode < 0 then
			ls_msg = sqlca.sqlerrtext
			rollback;
			messagebox("Error","No puedo crear referencia 1~r~n"+ls_msg,exclamation!)
			return -1
		end if
	end if
	if dw_mov_art.find("tipo_movimiento ='ID'",1,dw_mov_art.rowcount()) > 0 then
		INSERT INTO pv_nv_movimiento (cod_compania,numero,tipo_movimiento,nr_movimiento)  
		VALUES (:gs_cod_compania,:ll_nota,'ID',:il_mov2)  ;
		if sqlca.sqlcode < 0 then
			ls_msg = sqlca.sqlerrtext
			rollback;
			messagebox("Error","No puedo crear referencia 1~r~n"+ls_msg,exclamation!)
			return -1
		end if
	end if
   if dw_det.update(true) < 0 then 
	   messagebox("Error","No puedo crear el detalle del movimiento de ventas~r~n"+sqlca.sqlerrtext,exclamation!)
		rollback;
		return -1
	end if	
	if dw_mov_art.update(true) < 0 then 
		messagebox("Error","No puedo crear el detalle del movimiento de ventas~r~n"+sqlca.sqlerrtext,exclamation!)
		rollback;
		return -1
	end if
	if dw_det_pago.update(true) > 0 then
	  commit ;		
	  double ld_credito=0,li_n=0
  //////////////////////////vamos a grabar el valor del credito////////////
  ll_numdev = ll_numdev
  if ll_numdev = 0 then
  	
	 SELECT pv_detalle_pago.monto INTO :ld_credito FROM pv_detalle_pago,pv_nota_venta  
   WHERE (pv_nota_venta.cod_compania = pv_detalle_pago.cod_compania) and
   (pv_nota_venta.numero = pv_detalle_pago.numero) and ((pv_nota_venta.cod_compania = :gs_cod_compania) AND
    (pv_detalle_pago.forma_pago = 4)) and pv_nota_venta.numero = :ll_nota and pv_nota_venta.tipo_doc = 'EV';
	if sqlca.sqlcode < 0  then
		messagebox("Información","No puedo obtener el valor del credito~r~nConsulte a su proveedor del sistema.",information!)
		rollback;
		return -1
	end if
	
  else 
	 SELECT pv_detalle_pago.monto INTO :ld_credito FROM pv_detalle_pago,pv_nota_venta  
   WHERE (pv_nota_venta.cod_compania = pv_detalle_pago.cod_compania) and
   (pv_nota_venta.numero = pv_detalle_pago.numero) and ((pv_nota_venta.cod_compania = :gs_cod_compania) AND
    (pv_detalle_pago.forma_pago = 4)) and pv_nota_venta.numero = :ll_nota and pv_nota_venta.tipo_doc = 'ID';
	if sqlca.sqlcode < 0  then
		messagebox("Información","No puedo obtener el valor del credito~r~nConsulte a su proveedor del sistema.",information!)
		rollback;
		return -1
	end if
end if  //dev
  ld_credito = ld_credito	
	
	if isnull(ld_credito) then ld_credito = 0
	if ld_credito <> 0 then
	   li_n = dw_det.rowcount()
		if ll_numdev > 0 or ld_credito < 0 then//cambio
	      messagebox("Atención","Aplique la Nota de Credito en CXC ") 	
			//Hay que actualizar la tabla cxc_documento y cxc_det_documento,ademas de ingresar la NC
			ls_numero = 'NC-'+string(ll_nota)
			ld_preimpreso = double(ls_ref)
			ld_credito = abs(ld_credito)
			//voy a ingresar el cxc_documento
			  INSERT INTO cxc_documento  
         ( tipo_documento,   
           nr_documento,   
           cod_ingreso,   
           cod_funcionario,   
           cod_nota,   
           cod_sistema,   
           cod_forma_pago,   
           tipo_mov_doc,   
           f_documento,   
           f_proceso,   
           cod_cliente,   
           subtotal,   
           descuento,   
           iva,   
           otros_cargos,   
           monto,   
           retencion,   
           saldo,   
           nr_recibo,   
           nr_comprob,   
           tipo_comprob,   
           usuario,   
           observacion,   
           nr_preimpreso,   
           ln,   
           estado,   
           nota_embarque,   
           fecha_cancelacion,   
           tarifa_0,   
           fecha_embarque,   
           porcentaje_iva,   
           descuento_iva,   
           descuento_sin_iva,   
           c_iva,   
           cod_bodega,   
           cod_transporte )  
  VALUES ( 'NC',   
           :ls_numero,   
           null,   
           :ll_funcionario,   
           null,   
           6,   
           4,   
           'O',   
           :dt_fecha,   
           :dt_fecha,   
           :ll_cliente,   
           :ld_credito,   
           0,   
           0,   
           0,   
           :ld_credito,   
           0,   
           :ld_credito,   
           null,   
           null,   
           null,   
           'ADM',   
           :ls_ref,   
           0,   
           '1',   
           'V',   
           null,   
           null,   
           0,   
           null,   
           0,   
           0,   
           0,   
           :gs_piva,   
           :gi_bodega,   
           1 )  ;
     commit;
	  if sqlca.sqlcode < 0 or sqlca.sqlcode = 100 then
		messagebox("Información","No puedo grabar la NC cxc_documentoo~r~nConsulte a su proveedor del sistema.",information!)
		rollback;
		return -1
    end if
			///ahora vamos al detalle
			  INSERT INTO cxc_det_documento  
         ( tipo_documento,   
           nr_documento,   
           det_documento,   
           cod_ingreso,   
           f_venc,   
           monto,   
           saldo,   
           observacion   
            )  
  VALUES ( 'NC',   
           :ls_numero,   
           1,   
           null,   
           :dt_fecha,   
           :ld_credito,   
           :ld_credito,   
           :ls_ref   
            )  ;
				commit;
		if sqlca.sqlcode < 0 or sqlca.sqlcode = 100 then
		messagebox("Información","No puedo grabar el detalle NC cxc_documentoo~r~nConsulte a su proveedor del sistema.",information!)
		rollback;
		return -1
    end if
			
			////////
		else
			ls_numero = 'NV-'+string(ll_nota)
			ld_preimpreso = double(ls_ref)
			//voy a ingresar el cxc_documento
			  INSERT INTO cxc_documento  
         ( tipo_documento,   
           nr_documento,   
           cod_ingreso,   
           cod_funcionario,   
           cod_nota,   
           cod_sistema,   
           cod_forma_pago,   
           tipo_mov_doc,   
           f_documento,   
           f_proceso,   
           cod_cliente,   
           subtotal,   
           descuento,   
           iva,   
           otros_cargos,   
           monto,   
           retencion,   
           saldo,   
           nr_recibo,   
           nr_comprob,   
           tipo_comprob,   
           usuario,   
           observacion,   
           nr_preimpreso,   
           ln,   
           estado,   
           nota_embarque,   
           fecha_cancelacion,   
           tarifa_0,   
           fecha_embarque,   
           porcentaje_iva,   
           descuento_iva,   
           descuento_sin_iva,   
           c_iva,   
           cod_bodega,   
           cod_transporte )  
  VALUES ( 'FC',   
           :ls_numero,   
           null,   
           :ll_funcionario,   
           null,   
           6,   
           4,   
           'O',   
           :dt_fecha,   
           :dt_fecha,   
           :ll_cliente,   
           :ld_credito,   
           0,   
           0,   
           0,   
           :ld_credito,   
           0,   
           :ld_credito,   
           null,   
           null,   
           null,   
           'ADM',   
           :ls_ref,   
           0,   
           '1',   
           'V',   
           null,   
           null,   
           0,   
           null,   
           0,   
           0,   
           0,   
           :gs_piva,   
           :gi_bodega,   
           1 )  ;
     commit;
	  if sqlca.sqlcode < 0 or sqlca.sqlcode = 100 then
		messagebox("Información","No puedo grabar cxc_documentoo~r~nConsulte a su proveedor del sistema.",information!)
		rollback;
		return -1
    end if
			///ahora vamos al detalle
			  INSERT INTO cxc_det_documento  
         ( tipo_documento,   
           nr_documento,   
           det_documento,   
           cod_ingreso,   
           f_venc,   
           monto,   
           saldo,   
           observacion   
            )  
  VALUES ( 'FC',   
           :ls_numero,   
           1,   
           null,   
           :dt_fecha,   
           :ld_credito,   
           :ld_credito,   
           :ls_ref   
            )  ;
				commit;
		if sqlca.sqlcode < 0 or sqlca.sqlcode = 100 then
		messagebox("Información","No puedo grabarel detalle cxc_documentoo~r~nConsulte a su proveedor del sistema.",information!)
		rollback;
		return -1
    end if

			
			
			
		end if	
	end  if		
	
		  /////////////////////////////////////////////////////////////////////////
	  
     if this.event ue_imprimir(ll_nota) < 0 then  return -1
//	  run ("VbSample.exe")
	  messagebox("Atención","Venta registrada")
	  this.event limpiar()
	  return 1
	else
	  ls_msg = sqlca.sqlerrtext
	  rollback;
	end if
else
	ls_msg = sqlca.sqlerrtext
	rollback;
end if
messagebox("Error","No puedo crear el detalle del movimiento~r~n"+ls_msg,exclamation!)
return -1
*/

end event

on w_registradora.create
this.dw_elecfc=create dw_elecfc
this.pb_3=create pb_3
this.pb_2=create pb_2
this.cbx_factura=create cbx_factura
this.cb_graba=create cb_graba
this.dw_datos=create dw_datos
this.ddlb_iva=create ddlb_iva
this.st_1=create st_1
this.dw_notaimp=create dw_notaimp
this.dw_visualiza_precios=create dw_visualiza_precios
this.ole_com1=create ole_com1
this.dw_prop=create dw_prop
this.dw_col=create dw_col
this.dw_tpreliminar=create dw_tpreliminar
this.cb_1=create cb_1
this.dw_mov_art=create dw_mov_art
this.sle_1=create sle_1
this.dw_precios=create dw_precios
this.dw_1=create dw_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
this.cb_5=create cb_5
this.cb_6=create cb_6
this.cb_7=create cb_7
this.cb_9=create cb_9
this.cb_11=create cb_11
this.cb_12=create cb_12
this.cb_8=create cb_8
this.dw_det=create dw_det
this.dw_elecnc=create dw_elecnc
this.dw_det_pago=create dw_det_pago
this.dw_cab=create dw_cab
this.pb_1=create pb_1
this.gb_1=create gb_1
this.Control[]={this.dw_elecfc,&
this.pb_3,&
this.pb_2,&
this.cbx_factura,&
this.cb_graba,&
this.dw_datos,&
this.ddlb_iva,&
this.st_1,&
this.dw_notaimp,&
this.dw_visualiza_precios,&
this.ole_com1,&
this.dw_prop,&
this.dw_col,&
this.dw_tpreliminar,&
this.cb_1,&
this.dw_mov_art,&
this.sle_1,&
this.dw_precios,&
this.dw_1,&
this.cb_2,&
this.cb_3,&
this.cb_4,&
this.cb_5,&
this.cb_6,&
this.cb_7,&
this.cb_9,&
this.cb_11,&
this.cb_12,&
this.cb_8,&
this.dw_det,&
this.dw_elecnc,&
this.dw_det_pago,&
this.dw_cab,&
this.pb_1,&
this.gb_1}
end on

on w_registradora.destroy
destroy(this.dw_elecfc)
destroy(this.pb_3)
destroy(this.pb_2)
destroy(this.cbx_factura)
destroy(this.cb_graba)
destroy(this.dw_datos)
destroy(this.ddlb_iva)
destroy(this.st_1)
destroy(this.dw_notaimp)
destroy(this.dw_visualiza_precios)
destroy(this.ole_com1)
destroy(this.dw_prop)
destroy(this.dw_col)
destroy(this.dw_tpreliminar)
destroy(this.cb_1)
destroy(this.dw_mov_art)
destroy(this.sle_1)
destroy(this.dw_precios)
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.cb_5)
destroy(this.cb_6)
destroy(this.cb_7)
destroy(this.cb_9)
destroy(this.cb_11)
destroy(this.cb_12)
destroy(this.cb_8)
destroy(this.dw_det)
destroy(this.dw_elecnc)
destroy(this.dw_det_pago)
destroy(this.dw_cab)
destroy(this.pb_1)
destroy(this.gb_1)
end on

event open;double ldb_det,ldb_summ,ldb_cab
string ls_cab,ls_sum,ls_columna,ls_prop,ls_mody,ls_cliente,ls_ruc
long l_cliente,l_compa
integer li_existe,li_num,li_i,li_columna,li_num2,li_j,li_fun,li_fil

SELECT Anex_MidEmpresa.numeroRuc,   
         Anex_MidEmpresa.tipoAmbiente,   
         Anex_MidEmpresa.tipoEmision,   
         Anex_MidEmpresa.codigo_numérico  ,
			Anex_MidEmpresa.clavecert
    INTO :gs_ruc,   
         :gs_ambiente,   
         :gs_emision,   
         :gs_codigo ,
			:gs_clavecert
    FROM Anex_MidEmpresa  ;
	 

//open(w_autoriza_regis)  //ESTO QUITAR PARA WINFORM
li_fun = message.doubleparm
if li_fun > 0 then
   
elseif li_fun = 0 then
	close(w_registradora)
	
	return
end if

//
gb_modifica = false
    SELECT compania.cod_compania  
    INTO :l_compa  
    FROM compania  
   WHERE 1 = 1   ;

gs_cod_compania = string(l_compa)
//camino
ddlb_iva.text=string(gc_iva)

// gs_camino = profilestring("repor_facturas.ini","database","camino","c:\macks\informes")


if gi_asp = 1 then
	ole_com1.object.commport = 1
   ole_com1.object.portopen = true
end if
this.event limpiar()
if gi_impresion = 1 then
	//matricial
   dw_1.DataObject = "d_nota_dinamico"
   dw_1.settransobject(sqlca)
	select forma.detail,forma.summary,forma.header,forma.items
	into :ldb_det,:ldb_summ,:ldb_cab,:il_items from forma 
	where (forma.cod_forma = 5) and (forma.tipo_forma = 4);
	if sqlca.sqlcode < 0 then
		messagebox("Información","No se puede recuperar los datos del Ticket dinamico",information!)
		Return
	end if
		// Recupera las medidas de las bandas del datawindow
		ls_cab = "Datawindow.header.height=" + string(ldb_cab)
		dw_1.Modify(ls_cab)
		dw_1.modify("Datawindow.Detail.Height="+string(ldb_det))
		ls_sum = "Datawindow.summay.height=" + string(ldb_summ)
		dw_1.modify(ls_sum)
		if dw_col.Retrieve(5) < 0 then
			messagebox("Información","No se puede recuperar las columnas del Ticket dinamico",information!)
			Return
		end if
		li_num = dw_col.rowcount()
		if li_num > 0 then
			for li_i = 1 to li_num
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
			next
   	else
			messagebox("Información","No hay columnas para el Ticket dinamico",information!)						
			Return
	  end if
		////////////
elseif gi_impresion = 0 then
	//ticket
	dw_1.DataObject = "d_imp_nota_imp3"
elseif gi_impresion = 2 then
	//ticket
	dw_1.DataObject = "d_imp_nota_imp3p"
end if
SELECT count(*) INTO :li_existe FROM pv_caja WHERE pv_caja.nr_caja = :gi_caja;
if li_existe = 0 then
	messagebox("Error","No se ha definido la caja")
	close(this)
	return
end if
dw_det.setfocus()
this.title = this.title +' '+ string(gi_caja)

  SELECT cliente.cod_cliente,   
         cliente.nombre,
			cliente.ruc_ci,
			cliente.paga_iva,
			cliente.tp_id_cli
    INTO :l_cliente,   
         :ls_cliente,
			:ls_ruc,
			:gs_piva,
			 :id_tipo_cliente 
    FROM cliente  
   WHERE cliente.cod_cliente = 1   ;

// gs_emi='00'+string(gi_caja)  //FE
	dw_cab.object.cod_cliente[1] = l_cliente
	dw_cab.object.nomb_cliente[1] = ls_cliente
	dw_cab.object.c_i_o_ruc[1] = ls_ruc
	dw_cab.object.nr_caja[1] = gi_caja
	dw_cab.object.paga_iva[1] = gs_piva
	dw_cab.object.ptoemi[1] = gs_emi  //emi
   dw_cab.object.otra_ref[1] = string(gi_bodega)
	dw_cab.object.estab[1] = gs_num_suc
	dw_cab.object.tipo_precio[1] = gs_precio
	dw_cab.object.tipocliente[1] = id_tipo_cliente
	dw_cab.object.subempresa[1] = gs_subempresa
	gc_tipo_clie=id_tipo_cliente
//	dw_det.setcolumn(14)
	//dw_det.setfocus()
	
	dw_cab.setfocus()
	dw_det.setcolumn(5)
	
	
//this.event insertar()
//w_busqueda_art.show()
	//
	//PARA EL IVA S/N/*O M
	
	
end event

event resize;dw_det.resize(this.width -2100,this.height - (dw_det.y + 170 + sle_1.height))  //-2100  EN LA MIA  //2500 mas grande //1600
sle_1.y = dw_det.height+dw_cab.height + 50
end event

event close;w_busqueda_art.hide()
SetProfileString("pos.ini","POS","Prompt", "0")
end event

type dw_elecfc from datawindow within w_registradora
boolean visible = false
integer x = 229
integer y = 1488
integer width = 352
integer height = 400
integer taborder = 290
string title = "none"
string dataobject = "elec_dwfactura"
boolean livescroll = true
borderstyle borderstyle = styleshadowbox!
end type

event constructor;this.settransobject(sqlca)
end event

type pb_3 from picturebutton within w_registradora
integer x = 5536
integer y = 724
integer width = 256
integer height = 112
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "StatusBar!"
string disabledname = "Control Ole Database_2!"
alignment htextalign = left!
end type

event clicked;window w
w = parent.getactivesheet()
if isvalid(w) then w.event dynamic sucursal()
end event

type pb_2 from picturebutton within w_registradora
integer x = 3689
integer y = 80
integer width = 215
integer height = 64
integer taborder = 270
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Custom076_2!"
alignment htextalign = left!
end type

type cbx_factura from checkbox within w_registradora
boolean visible = false
integer x = 37
integer y = 444
integer width = 169
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 16711680
string text = "F"
end type

type cb_graba from commandbutton within w_registradora
integer x = 3643
integer y = 36
integer width = 311
integer height = 540
integer taborder = 160
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cliente"
end type

event clicked;long li_cliente
string ls_n,ls_r,ls_tpidcli,ls_direc,ls_telf,ls_mail,ls_ruc,ls_nombre,ls_tp_id_cli
integer li_cuenta,i
boolean lbo_nuevo=false

if dw_datos.rowcount()>0  then
dw_datos.accepttext()
dw_cab.accepttext()
ls_n= dw_datos.object.nombre[1]
ls_direc=dw_datos.object.direccion[1]
ls_mail=dw_datos.object.direc_electronica[1]
ls_telf=dw_datos.object.telefono[1]
ls_ruc=dw_datos.object.ruc_ci[1]
ls_tp_id_cli=dw_datos.object.tp_id_cli[1]


li_cliente=dw_datos.object.cod_cliente[1]
if dw_datos.object.nuevo[1]=1 then
	
	if f_valida_mail( dw_datos.object.direc_electronica[dw_datos.getrow()]) =false then
			messagebox("Atención","Direc_Electronica mal ingresado")	
         	dw_datos.object.direc_electronica[dw_datos.getrow()]=''
	ROLLBACK;
	RETURN -1
	commit;
   end if
			if ls_telf='' or isnull(ls_telf) then
		messagebox("Atención","Ingrese el teléfono")	
		rollback;
		return -1
	end if	
	
		if ls_mail='' or isnull(ls_mail) then
		messagebox("Atención","Ingrese el correo")	
		rollback;
		return -1
	end if	


	
	
	

	
	
	   IF dw_datos.update() > 0 then
		commit;
         li_cliente= dw_datos.object.cod_cliente[1]
		if isnull(li_cliente) then li_cliente=0
		
		if li_cliente > 0 then
			dw_cab.object.cod_cliente[1] =li_cliente
	   else
			select top 1 cod_cliente,nombre,ruc_ci
			into    :li_cliente,:ls_nombre,:ls_ruc
	   		from  cliente
			where cliente.ruc_ci LIKE :ls_ruc ;
			dw_cab.object.cod_cliente[1] =li_cliente
			dw_cab.object.nomb_cliente[1] =ls_nombre
			dw_cab.object.c_i_o_ruc[1] =ls_ruc
		end if	
		
		
		dw_cab.object.nomb_cliente[1] =dw_datos.object.nombre[1]
		dw_cab.object.c_i_o_ruc[1] =dw_datos.object.ruc_ci[1]
		dw_det.setfocus()
		dw_det.setcolumn(5)
		commit;
	END IF
	commit;
end if

	if dw_datos.object.nuevo[1]=0 then
	//verifique RUC
		
  if dw_datos.object.tp_id_cli[dw_datos.getrow()]='F' then
    if  dw_datos.object.ruc_ci[dw_datos.getrow()]<>'9999999999999' then
			messagebox("Atención","consumidor final debe ser :9999999999999")	
			dw_datos.object.ruc_ci[dw_datos.getrow()]=''
	ROLLBACK;
	RETURN -1
	commit;
   end if
	end if
string ls_f	
	ls_f=dw_datos.object.tp_id_cli[dw_datos.getrow()]
	
	i=f_valida_ruc(dw_datos.object.tp_id_cli[dw_datos.getrow()],dw_datos.object.ruc_ci[dw_datos.getrow()])
	
	if i < 0 then
	messagebox("Atención","Ruc/CI mal ingresado")	
	dw_datos.object.ruc_ci[dw_datos.getrow()]=''
	ROLLBACK;
	RETURN -1
	commit;
	end if		
	if f_valida_mail( dw_datos.object.direc_electronica[dw_datos.getrow()]) =false then
			messagebox("Atención","Direc_Electronica mal ingresado")	
	dw_datos.object.direc_electronica[dw_datos.getrow()]=''
	ROLLBACK;
	RETURN -1
	commit;
   end if

if isnull(dw_datos.object.direccion[dw_datos.getrow()]) or  dw_datos.object.direccion[dw_datos.getrow()]='' then
messagebox("Atención","Ingrese la Dirección")	
	ROLLBACK;
	RETURN -1
	commit;
end if
	
 //pasa

		dw_datos.resetupdate()
		dw_datos.accepttext()
		dw_datos.Modify("cod_ciente.Update=No")
		update cliente
		set nombre=:ls_n,direccion=:ls_direc,telefono=:ls_telf,direc_electronica=:ls_mail,ruc_ci=:ls_ruc,tp_id_cli=:ls_tp_id_cli
		where cliente.cod_cliente=:li_cliente  and cliente.cod_cliente<> 1;
		IF SQLCA.SqlCode < 0 then
			gs_mensaje="actuallizadatos lciente"
			f_mensajes(18)
			rollback;
			return  -1
		 END IF
			commit;
			
			
		
		
		dw_cab.object.cod_cliente[1] =dw_datos.object.cod_cliente[1]
		dw_cab.object.nomb_cliente[1] =dw_datos.object.nombre[1]
		dw_cab.object.c_i_o_ruc[1] =dw_datos.object.ruc_ci[1]
		dw_cab.setfocus()

		
	end if
	
end if


end event

type dw_datos from datawindow within w_registradora
integer x = 3625
integer y = 20
integer width = 2542
integer height = 576
integer taborder = 180
string title = "Cliente"
string dataobject = "d_clientes_ingresa"
richtexttoolbaractivation richtexttoolbaractivation = richtexttoolbaractivationalways!
boolean controlmenu = true
borderstyle borderstyle = styleraised!
end type

event constructor;this.settransobject(sqlca)
end event

event other;/*
int li_returncode
if Message.Number = 274 and &
(Message.WordParm > 61535 and Message.WordParm < 61552) then
li_returncode = MessageBox('Aviso','¿Esta usted seguros que desea cerrar el ingreso del Cliente', QUESTION!,YESNO!, 1)
if li_returncode = 2 then
	
Message.Processed = true
end if

if li_returncode = 1 then
dw_datos.visible=false	
cb_graba.visible=false	
dw_cab.object.c_i_o_ruc[1]=''
Message.Processed = true
end if


end if

*/
end event

event updatestart;long li_datos,i,j

string ls_ruc,ls
dw_datos.accepttext()
ls_ruc=dw_datos.object.tp_id_cli[dw_datos.getrow()]
ls=dw_datos.object.ruc_ci[dw_datos.getrow()]

select count(*)
into :j
from cliente
where cliente.ruc_ci=:ls;

if isnull(j) then j=0
if j > 0 then
	messagebox("Atencion","Identificación ya existe ;Consulte de nuevo con el botón de Busqueda(..............)")
	return -1
	rollbacK;
end if	
	
	




if isnull(ls_ruc) or ls_ruc='' then
	messagebox("Atencion","Tipo de identificacion no válida")
	return -1
	rollbacK;
	commit;
end iF

if dw_datos.object.tp_id_cli[dw_datos.getrow()]<>'P'   and  dw_datos.object.tp_id_cli[dw_datos.getrow()]<>'F' then
i=f_valida_ruc(dw_datos.object.tp_id_cli[dw_datos.getrow()],dw_datos.object.ruc_ci[dw_datos.getrow()])
  	
	if i < 0 then
	messagebox("Atención","Ruc/CI mal ingresado")	
	ROLLBACK;
	RETURN -1
	commit;
	end if		
end if	


if f_valida_mail(dw_datos.object.direc_electronica[dw_datos.getrow()])=false then
	messagebox("Atención","Correo no esta Correcto")	
	ROLLBACK;
	RETURN -1
	commit;
end if	

	
	if isnull(dw_datos.object.direccion[dw_datos.getrow()]) or  dw_datos.object.direccion[dw_datos.getrow()]='' then
			messagebox("Atención","Ingrese la Dirección")	
	ROLLBACK;
	RETURN -1
	commit;
end if

		
end event

type ddlb_iva from dropdownlistbox within w_registradora
boolean visible = false
integer x = 6208
integer y = 848
integer width = 315
integer height = 552
integer taborder = 140
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 65535
boolean enabled = false
string item[] = {"12","14"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;gc_iva=double(this.text)
w_registradora.event limpiar()
end event

type st_1 from statictext within w_registradora
boolean visible = false
integer x = 6094
integer y = 612
integer width = 265
integer height = 104
integer taborder = 250
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 16777215
string text = "IVA %"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_notaimp from datawindow within w_registradora
boolean visible = false
integer x = 3031
integer y = 824
integer width = 686
integer height = 400
integer taborder = 50
string title = "none"
string dataobject = "d_imp_nota_imp2"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type dw_visualiza_precios from datawindow within w_registradora
event show pbm_showwindow
event hide pbm_hidewindow
boolean visible = false
integer x = 3890
integer y = 640
integer width = 375
integer height = 480
integer taborder = 70
boolean enabled = false
string title = "none"
string dataobject = "d_selecc_precio"
boolean livescroll = true
borderstyle borderstyle = styleshadowbox!
end type

event show;long ll_art
int li_uni
IF (dw_det.getitemnumber(dw_det.getselectedrow(0),"cod_articulo"))>0 THEN
ll_art=dw_det.getitemnumber(dw_det.getselectedrow(0),"cod_articulo")
li_uni=dw_det.getitemnumber(dw_det.getselectedrow(0),"cod_unidad")		
return dw_visualiza_precios.retrieve(ll_art,li_uni)
END IF


end event

event hide;reset()
return 1
end event

event constructor;settransobject(sqlca)
end event

type ole_com1 from olecustomcontrol within w_registradora
event oncomm ( )
boolean visible = false
integer y = 12
integer width = 78
integer height = 72
integer taborder = 20
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_registradora.win"
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

type dw_prop from datawindow within w_registradora
boolean visible = false
integer x = 2176
integer y = 1924
integer width = 411
integer height = 432
integer taborder = 150
string title = "none"
string dataobject = "d_prop"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject(sqlca)
end event

type dw_col from datawindow within w_registradora
boolean visible = false
integer x = 1486
integer y = 1892
integer width = 411
integer height = 432
integer taborder = 80
string title = "none"
string dataobject = "d_columnas"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject(sqlca)
end event

type dw_tpreliminar from datawindow within w_registradora
boolean visible = false
integer x = 859
integer y = 1296
integer width = 2075
integer height = 852
integer taborder = 90
string title = "none"
string dataobject = "d_ticket_prelim"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject(sqlca)
end event

type cb_1 from commandbutton within w_registradora
boolean visible = false
integer x = 4370
integer y = 568
integer width = 434
integer height = 80
integer taborder = 190
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Tick. Preliminar"
end type

event clicked;int li_codtarj,li_codbanco
string ls_nomtarj,ls_banco,ls_msg,ls_nrtarj
double ldb_totciva,ldb_totsiva,ldb_totiva
if gi_impresion = 1 then
	//matricial
   dw_tpreliminar.DataObject = "d_ticket_prelim"
elseif gi_impresion = 0 then
	//ticket
	dw_tpreliminar.DataObject = "d_ticket_prelim1"
end if
dw_tpreliminar.settransobject(sqlca)
dw_tpreliminar.reset()
dw_tpreliminar.insertrow(0)
if dw_det_pago.object.aux[3] > 0 then 
	li_codtarj=dw_det_pago.object.cod_tarjeta[3]
	li_codbanco=dw_det_pago.object.cod_banco[3]
	ls_nrtarj= dw_det_pago.object.nr_cta[3]
	ldb_totciva = dw_det.object.tot_con_iva[1]
	ldb_totsiva = dw_det.object.tot_sin_iva[1]
	ldb_totiva = dw_det.object.tot_iva[1]
	SELECT tarjeta.nom_tarjeta INTO :ls_nomtarj  FROM tarjeta  
	WHERE (tarjeta.cod_tarjeta = :li_codtarj) AND  
	(tarjeta.cod_banco = :li_codbanco);
	if sqlca.sqlcode < 0 then
		ls_msg = sqlca.sqlerrtext
		rollback;
		messagebox("Información","No puedo obtener la información de la tarjeta 1~r~n"+ls_msg,information!)
		return -1
	end if
	SELECT banco.nom_banco INTO :ls_banco  
	FROM banco WHERE banco.cod_banco = :li_codbanco;
	if sqlca.sqlcode < 0 then
		ls_msg = sqlca.sqlerrtext
		rollback;
		messagebox("Información","No puedo obtener la información del banco1~r~n"+ls_msg,information!)
		return -1
	end if
   if not isnull(ls_nomtarj) then dw_tpreliminar.setitem(1,"nom_tarjeta",ls_nomtarj)
   if not isnull(ls_banco) then dw_tpreliminar.setitem(1,"nom_banco",ls_banco)
   if not isnull(ls_nrtarj) then dw_tpreliminar.setitem(1,"nr_tarjeta",ls_nrtarj)
   dw_tpreliminar.setitem(1,"iva",ldb_totiva)
   dw_tpreliminar.setitem(1,"tot_con_iva",ldb_totciva)
   dw_tpreliminar.setitem(1,"tot_sin_iva",ldb_totsiva)
	dw_tpreliminar.print()
	dw_cab.setfocus()
end if
end event

type dw_mov_art from datawindow within w_registradora
boolean visible = false
integer x = 229
integer y = 1068
integer width = 2016
integer height = 356
integer taborder = 100
string title = "none"
string dataobject = "d_mov"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type sle_1 from singlelineedit within w_registradora
boolean visible = false
integer x = 9
integer y = 1168
integer width = 2757
integer height = 140
integer taborder = 30
integer textsize = -20
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15793151
boolean autohscroll = false
borderstyle borderstyle = styleshadowbox!
end type

type dw_precios from datawindow within w_registradora
event esc pbm_dwescape
event enter pbm_dwnprocessenter
boolean visible = false
integer x = 2363
integer y = 660
integer width = 599
integer height = 428
string dataobject = "d_selecc_precio"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event esc;this.hide()
dw_det.setfocus()

end event

event enter;if dw_precios.rowcount() < 1 then return
this.accepttext()
dw_det.setitem(dw_det.getselectedrow(0),"pvp",this.getitemnumber(this.getrow(),"precioa"))
this.hide()
dw_cab.event refrescar()
dw_det.setfocus()
return 1
end event

event constructor;this.settransobject(SQLCA)
this.setrowfocusindicator(HAND!)
end event

event rowfocuschanged;this.selectrow(0,false)
this.selectrow(currentrow,true)
end event

event clicked;//this.retrieve(2,2)
end event

type dw_1 from datawindow within w_registradora
boolean visible = false
integer x = 5669
integer y = 1276
integer width = 82
integer height = 64
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_imp_nota"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_registradora
accessiblerole accessiblerole = panerole!
integer x = 5243
integer y = 2068
integer width = 402
integer height = 200
integer taborder = 200
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "F2( Descue)"
end type

event clicked;window w
w = Parent.GetActiveSheet ()
if IsValid (w) then	w.Event dynamic  habilita_dsto()
end event

type cb_3 from commandbutton within w_registradora
accessiblerole accessiblerole = windowrole!
integer x = 5243
integer y = 1792
integer width = 402
integer height = 200
integer taborder = 210
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "F3(Promoc)"
end type

event clicked;window w
w = parent.getactivesheet()
if isvalid(w) then w.event dynamic promoc()
end event

type cb_4 from commandbutton within w_registradora
accessiblerole accessiblerole = windowrole!
integer x = 5248
integer y = 1512
integer width = 402
integer height = 200
integer taborder = 230
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "F4(Deshacer)"
end type

event clicked;window w
w = parent.getactivesheet()
if isvalid(w) then w.event dynamic limpiar()
end event

type cb_5 from commandbutton within w_registradora
accessiblerole accessiblerole = windowrole!
integer x = 5243
integer y = 1248
integer width = 402
integer height = 200
integer taborder = 220
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "F5 (Devoluc)"
end type

event clicked;window w
w = parent.getactivesheet()
if isvalid(w) then w.event dynamic devol()
end event

type cb_6 from commandbutton within w_registradora
accessiblerole accessiblerole = windowrole!
integer x = 5243
integer y = 984
integer width = 402
integer height = 200
integer taborder = 240
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "F6 (Elimina)"
end type

event clicked;window w
w = parent.getactivesheet()
if isvalid(w) then w.event dynamic eliminar()
end event

type cb_7 from commandbutton within w_registradora
accessiblerole accessiblerole = windowrole!
integer x = 5664
integer y = 984
integer width = 402
integer height = 200
integer taborder = 260
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "F7 (Inserta)"
end type

event clicked;window w
w = parent.getactivesheet()
if isvalid(w) then w.event dynamic insertar()
end event

type cb_9 from commandbutton within w_registradora
accessiblerole accessiblerole = windowrole!
integer x = 5664
integer y = 1516
integer width = 402
integer height = 200
integer taborder = 280
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "F9 (F. Pago)"
end type

event clicked;window w
w = parent.getactivesheet()
if isvalid(w) then w.event dynamic forma_pago()
end event

type cb_11 from commandbutton within w_registradora
accessiblerole accessiblerole = windowrole!
integer x = 5659
integer y = 1792
integer width = 402
integer height = 200
integer taborder = 300
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "F11 (PVP)"
end type

event clicked;window w
w = parent.getactivesheet()
if isvalid(w) then w.event dynamic otro_precio()
end event

type cb_12 from commandbutton within w_registradora
accessiblerole accessiblerole = windowrole!
integer x = 5664
integer y = 2068
integer width = 402
integer height = 200
integer taborder = 310
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "F12 (Guardar)"
end type

event clicked;window w
w = getactivesheet()
if isvalid(w) and gb_modifica = false then
w.event dynamic grabar()
else
if isvalid(w) and gb_modifica = true then
messagebox("m","modifica")
w.event 	dynamic modifica()
end if
end if
	
	
end event

type cb_8 from commandbutton within w_registradora
integer x = 5669
integer y = 1244
integer width = 402
integer height = 200
integer taborder = 130
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "F8 (Clientes)"
end type

event clicked;window w
w = parent.getactivesheet()
if isvalid(w) then w.event dynamic cliente()
end event

type dw_det from datawindow within w_registradora
event tecla pbm_dwnkey
event refrescar ( )
event enter pbm_dwnprocessenter
event type boolean ue_asigna_variables ( )
event type boolean ue_elimina_nulos ( )
integer x = 32
integer y = 612
integer width = 4608
integer height = 708
string dataobject = "d_detalle_pos"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event tecla;CHOOSE CASE key
	CASE  KeyF2!
         parent.event habilita_dsto()			
	CASE  KeyF3!
         parent.event promoc()			
	CASE  KeyF4!
 //        parent.event limpiar()		
	CASE  KeyF5!
         parent.event devol()		
   CASE  KeyF6!
         parent.event eliminar()		
	CASE  KeyF7!
		   parent.event insertar()
	CASE  KeyF8!
         parent.event cliente()
   CASE  KeyF9!
         parent.event forma_pago()			
	CASE  KeyF11!
         parent.event otro_precio()			
	CASE  KeyF12!
		   if gb_modifica = false then
         parent.event grabar()
	   	else
		   parent.event modifica()
			end if	
	CASE KeyRightArrow!
		if this.getcolumnname() = "cantidad" and dw_precios.visible then	f_tecla_navegar ( THIS,6,dw_precios)		
		return 1			
	CASE KeyUpArrow!
		f_tecla_navegar ( THIS,8,this)
	CASE KeyDownArrow!
		f_tecla_navegar ( THIS,2,this)			
	CASE KeyPageUp!
		dw_cab.setfocus()
		return 1
END CHOOSE

end event

event refrescar();int li_cont,li_i,li_fila
double ldb_total,ldb_asp,ldb_efec,ldb_cre,ldb_iva,ldb_punitr,ldb_tot_cre=0,ldb_tot_efec=0
long ll_numdev
if this.accepttext() < 0 then return
ll_numdev = dw_cab.getitemnumber(1,"nr_devol")
li_cont= dw_det.rowcount()

//REFRESCAR
if li_cont > 0 then
	sle_1.hide()
		dw_det_pago.reset()
   	for li_i=1 to li_cont
			 
		this.object.prc_iva[1] = dw_cab.object.prc_iva[1]
      this.object.iva[li_i] = dw_det.object.iva_linea[li_i]		
		this.object.p_unit[li_i] = dw_det.object.p_unitr[li_i]		
		this.object.monto[li_i] = dw_det.object.subtotal[li_i]		
	   next
	dw_cab.object.iva[1] = this.object.tot_iva[li_cont]
	dw_cab.object.tot_con_iva[1] = this.object.tot_con_iva[li_cont]
	dw_cab.object.tot_sin_iva[1] = this.object.tot_sin_iva[li_cont]
	dw_cab.object.dsto_sin_iva[1] = this.object.tot_dsto_sin_iva[li_cont]
	dw_cab.object.dsto_con_iva[1] = this.object.tot_dsto_con_iva[li_cont]
	dw_cab.object.total[1] = dw_det.object.total[li_cont]	
	dw_cab.object.tot_compensado[1] = dw_det.object.tot_solidario[li_cont]	
	ldb_total = dw_det.object.total[li_cont]	
//	Ingreso de forma de pago
       /////////////
		 //veamos para cuando es devolucion y hay creditos
		 if ll_numdev >  0 then
			  SELECT pv_detalle_pago.monto  
           INTO :ldb_efec  
           FROM pv_detalle_pago  
           WHERE ( pv_detalle_pago.cod_compania = :gs_cod_compania ) AND  
           ( pv_detalle_pago.numero = :ll_numdev ) AND  
           ( pv_detalle_pago.forma_pago = 1 ) and
		  ( pv_detalle_pago.nr_caja = :gi_caja );
          
			  SELECT pv_detalle_pago.monto  
           INTO :ldb_cre  
           FROM pv_detalle_pago  
           WHERE ( pv_detalle_pago.cod_compania = :gs_cod_compania ) AND  
           ( pv_detalle_pago.numero = :ll_numdev ) AND  
           ( pv_detalle_pago.forma_pago = 4 ) and
	   ( pv_detalle_pago.nr_caja = :gi_caja );
		
				if isnull(ldb_efec) then ldb_efec = 0 ;if isnull(ldb_cre) then ldb_cre = 0
 
           if ldb_cre = 0 then
					dw_det_pago.object.forma_pago[1]  = 1
					dw_det_pago.object.monto[1] = this.object.total[1]- ( dw_cab.object.reten_iva[1 ]+  dw_cab.object.reten_fte[1])
					dw_det_pago.object.monto[2] = 0
					dw_det_pago.object.monto[3] = 0
					dw_det_pago.object.monto[4] = 0  //credito
					dw_det_pago.object.forma_pago[2] = 2
					dw_det_pago.object.aux[1] = this.object.total[1]-( dw_cab.object.reten_iva[1 ]+  dw_cab.object.reten_fte[1])
					dw_det_pago.object.aux[2] = 0
					dw_det_pago.object.aux[3] = 0		
					dw_det_pago.object.aux[4] = 0		//credito
					dw_det_pago.object.forma_pago[3] = 3
					dw_det_pago.object.aux[1] = this.object.total[1]-( dw_cab.object.reten_iva[1 ]+  dw_cab.object.reten_fte[1])
					dw_det_pago.object.aux[2] = 0
					dw_det_pago.object.aux[3] = 0
					dw_det_pago.object.aux[4] = 0 //credito
					dw_det_pago.object.forma_pago[4] = 4 //credito
					dw_det_pago.object.cambio[4] = 0
					dw_det_pago.object.total[4] = this.object.total[1]- ( dw_cab.object.reten_iva[1 ]+  dw_cab.object.reten_fte[1])
   			else
					if ldb_efec = 0 then
						dw_det_pago.object.forma_pago[4] = 4 //credito
						dw_det_pago.object.aux[4] = this.object.total[1]
						dw_det_pago.object.monto[4] = this.object.total[1]
					  //efec-cerdito
				   else
						////////////////
						if ldb_efec >= abs(this.object.total[1]) then
						dw_det_pago.object.forma_pago[1]  = 1
						dw_det_pago.object.monto[1] = this.object.total[1]-( dw_cab.object.reten_iva[1 ]+  dw_cab.object.reten_fte[1])
						dw_det_pago.object.monto[2] = 0
						dw_det_pago.object.monto[3] = 0
						dw_det_pago.object.monto[4] = 0  //credito
						dw_det_pago.object.forma_pago[2] = 2
						dw_det_pago.object.aux[1] = this.object.total[1]-  ( dw_cab.object.reten_iva[1 ]+  dw_cab.object.reten_fte[1])
						dw_det_pago.object.aux[2] = 0
						dw_det_pago.object.aux[3] = 0		
						dw_det_pago.object.aux[4] = 0		//credito
						dw_det_pago.object.forma_pago[3] = 3
						dw_det_pago.object.aux[1] = this.object.total[1] -  ( dw_cab.object.reten_iva[1 ]+  dw_cab.object.reten_fte[1])
						dw_det_pago.object.aux[2] = 0
						dw_det_pago.object.aux[3] = 0
						dw_det_pago.object.aux[4] = 0 //credito
						dw_det_pago.object.forma_pago[4] = 4 //credito
						dw_det_pago.object.cambio[4] = 0
						dw_det_pago.object.total[4] = this.object.total[1]- ( dw_cab.object.reten_iva[1 ]+  dw_cab.object.reten_fte[1])
   					else  
							 ldb_tot_cre =0
							 ldb_tot_efec=0
							ldb_tot_cre = ldb_total + ldb_efec
							ldb_tot_efec = ldb_total + (ldb_tot_cre * -1)
                     dw_det_pago.object.forma_pago[1] = 1 //efect
	   					dw_det_pago.object.aux[1] = ldb_tot_efec - ( dw_cab.object.reten_iva[1 ]+  dw_cab.object.reten_fte[1])
		   				dw_det_pago.object.monto[1] = ldb_tot_efec  - ( dw_cab.object.reten_iva[1 ]+  dw_cab.object.reten_fte[1])
							//credito
							dw_det_pago.object.forma_pago[4] = 4 //efect
	   					dw_det_pago.object.aux[4] = ldb_tot_cre
		   				dw_det_pago.object.monto[4] = ldb_tot_cre
						///////////////
					 end if
					end if //efec
				end if	//cre
								
		else //de devolucion
	 
       ///////////////    
		dw_det_pago.object.forma_pago[1]  = 1
		dw_det_pago.object.monto[1] = this.object.total[1] - ( dw_cab.object.reten_iva[1 ]+  dw_cab.object.reten_fte[1])
		dw_det_pago.object.monto[2] = 0
		dw_det_pago.object.monto[3] = 0
		dw_det_pago.object.monto[4] = 0  //credito
		dw_det_pago.object.forma_pago[2] = 2
		dw_det_pago.object.aux[1] = this.object.total[1]-  ( dw_cab.object.reten_iva[1 ]+  dw_cab.object.reten_fte[1])
		dw_det_pago.object.aux[2] = 0
		dw_det_pago.object.aux[3] = 0		
		dw_det_pago.object.aux[4] = 0		//credito
		dw_det_pago.object.forma_pago[3] = 3
		dw_det_pago.object.aux[1] = this.object.total[1]- ( dw_cab.object.reten_iva[1 ]+  dw_cab.object.reten_fte[1])
		dw_det_pago.object.aux[2] = 0
		dw_det_pago.object.aux[3] = 0
		dw_det_pago.object.aux[4] = 0 //credito
		dw_det_pago.object.forma_pago[4] = 4 //credito
		dw_det_pago.object.cambio[4] = 0
		dw_det_pago.object.total[4] = this.object.total[1] - ( dw_cab.object.reten_iva[1 ]+  dw_cab.object.reten_fte[1])
	end if //devoluci
end if
dw_cab.accepttext()
dw_det.accepttext()




end event

event enter;int li_uni
string ls_descrip,ls_cod_barra,ls_paga_iva
double lc_precio,lc_stock
long ll_articulo
if dw_det.rowcount() < 1 then return
dw_visualiza_precios.hide()
CHOOSE CASE this.getcolumnname()
	CASE 'prc_dsto'
		if	this.GetRow() = this.RowCount() then
         if lbo_dsto then 
				parent.event insertar()
		   end if
			return 0
		end if
	CASE 'descuentom'
		if	this.GetRow() = this.RowCount() then
         if lbo_dsto then 
				parent.event insertar()
		   end if
			return 0
		end if	
		
	CASE 'imei'
		this.setcolumn(15)
		
		CASE 'cantidad'
		this.setcolumn(15)
	
		
	CASE 'cant_pres' 
				if not lbo_dsto then
		   parent.event insertar()
       else
         this.setcolumn(1)			
		end if
		return 0
END CHOOSE
this.event refrescar()
//Send(Handle(this),256,9,Long(0,0))	
return 1

end event

event ue_asigna_variables;gdw_cab      = Parent.dw_cab
gdw_det      = Parent.dw_det 
gdw_det_pago = Parent.dw_det_pago

return true

end event

event ue_elimina_nulos;long ll_fila, ll_cod_art

ll_fila = gdw_det.GetSelectedRow (0)
if ll_fila > 0 then
	ll_cod_art = gdw_det.GetItemNumber (ll_fila, 'cod_articulo')
	if IsNull (ll_cod_art) or ll_cod_art = 0 then
		gdw_det.DeleteRow (ll_fila)
	end if
end if
return true
end event

event constructor;this.settransobject(SQLCA)

end event

event editchanged;int li_i,li_cont,li_j
double ldb_cansum=0,ldb_canr=0,ldb_stock=0,ldb_cant=0,ldb_canven=0,li_candevm,ldb_subtotal,ldb_d,ldb_sub_p
string ls_abrev,ls_piva
int li_conv=0
long ll_art,ll_art1,ll_numdev
if isnull(data) or data="" or data='' or data="-" then
   return
else
	   this.accepttext()
		ldb_sub_p = this.object.subtotal[row]
end if
/////////////////////////////////
double ldb_prueba,idb_porcentaje_descuento,idb_iva
if dwo.name = 'descuentom' then
	this.object.prc_dsto[row] = idb_porcentaje_descuento
	ldb_d = double(data)
	ldb_subtotal = this.object.subtotal[row]
	//////////////
	if (ldb_subtotal <= 0) or (ldb_d > ldb_subtotal) then
					messagebox("Aviso","El descuento no puede exceder al Subtotal")
         		this.object.prc_dsto[this.getrow()] = 0		  					
          		this.object.descuentom[this.getrow()] = 0		  					
				else
				if ldb_subtotal > 0 then	
				idb_porcentaje_descuento = Round((ldb_d / ldb_subtotal *  100),2)
				end if
			end if
			ls_piva = this.object.paga_iva[row]
			idb_iva = Round(((ldb_subtotal - ldb_d)  * gc_iva / 100 ),4)//2
			if ls_piva = 'N' then
				idb_iva = 0
			end if
				this.object.prc_dsto[row] = idb_porcentaje_descuento
             ldb_cant = this.object.cant_pres [row]
         	this.object.c_tot_linea[row] = (this.object.dsto_con_iva[row] + this.object.dsto_sin_iva[row])
      	if isnull(ldb_cant) then ldb_cant = 0
     	if ldb_cant = 0 then return  

 dw_cab.event refrescar()  
end if
///////////////////////////////////////new
if dwo.name = 'prc_dsto' then
	if double(data) > 100 then 
		messagebox("Aviso","El descuento no puede exceder el 100%")
		this.object.prc_dsto[this.getrow()] = 0		  					
	end if
	ldb_cant = this.object.cant_pres [row]
	this.object.c_tot_linea[row] = (this.object.dsto_con_iva[row] + this.object.dsto_sin_iva[row])
	if isnull(ldb_cant) then ldb_cant = 0
   dw_cab.event refrescar()   //RFRESCA
	if ldb_cant = 0 then return 
	
	
elseif dwo.name = 'cant_pres' then	
	ll_numdev = dw_cab.getitemnumber(1,"nr_devol")
	IF gs_precios = 'S' THEN dw_visualiza_precios.show()
	if ll_numdev <> 0 then
    	ldb_cant= this.getitemnumber(this.getrow(),"cant_pres")		  					
		li_candevm = this.getitemnumber(this.getrow(),"c_candev")
		if abs(li_candevm) < abs(double(data)) then 
		  messagebox("Información","La cantidad es mayor a la que puede devolver",information!)
		  this.setitem(this.getrow(),"cant_pres",0)
		  return 
	   else
		 dw_cab.event refrescar()  
	   end if
   end if
	if ll_numdev = 0 then
		ldb_cansum=0; ldb_canr=0; li_conv=0;ldb_stock=0		
		li_cont = this.rowcount()
		ldb_stock = round(this.getitemnumber(this.getrow(),"c_stock"),2)
		ls_abrev = this.getitemstring(this.getrow(),"abrev")	  	
		ll_art= this.getitemnumber(this.getrow(),"cod_articulo")	
		for li_j=1 to li_cont
			ll_art1= this.getitemnumber(li_j,"cod_articulo")			
			li_conv= this.getitemnumber(li_j,"conversion")	
			ldb_cant= this.getitemnumber(li_j,"cant_pres")	
			if isnull(ldb_cant) then ldb_cant = 0
			ldb_canr= round(ldb_cant* li_conv,2)				  
			if ll_art = ll_art1 then ldb_cansum = ldb_cansum + ldb_canr
		next
		if ldb_cansum > ldb_stock then dw_det.setitem(this.getrow(),"cant_pres",0.00)
		ldb_canven= ldb_stock - ldb_cansum
		if ldb_canven < 0 then      
			li_conv= this.getitemnumber(this.getrow(),"conversion")	
			if li_conv=0 then li_conv=1
			messagebox("Información","No existe stock suficiente, faltaría : " +string(round(ceiling(abs(round(ldb_canven/li_conv,2))),0))+"  "+ls_abrev,information!)							
		end if		
	end if
end if
IF row> 0 then
	if dwo.name='cantidad'  then
	if	this.object.factor[row] > 0 then
		ldb_cant=double(data)
		this.object.cant_pres[row]=ldb_cant* this.object.factor[row]
		/////////////////
		ldb_cansum=0; ldb_canr=0; li_conv=0;ldb_stock=0		
		li_cont = this.rowcount()
		ldb_stock = round(this.getitemnumber(this.getrow(),"c_stock"),2)
		ls_abrev = this.getitemstring(this.getrow(),"abrev")	  	
		ll_art= this.getitemnumber(this.getrow(),"cod_articulo")	
		for li_j=1 to li_cont
			ll_art1= this.getitemnumber(li_j,"cod_articulo")			
			li_conv= this.getitemnumber(li_j,"conversion")	
			ldb_cant= this.getitemnumber(li_j,"cant_pres")	
			if isnull(ldb_cant) then ldb_cant = 0
			ldb_canr= round(ldb_cant* li_conv,2)				  
			if ll_art = ll_art1 then ldb_cansum = ldb_cansum + ldb_canr
		next
		if ldb_cansum > ldb_stock then dw_det.setitem(this.getrow(),"cant_pres",0.00)
		ldb_canven= ldb_stock - ldb_cansum
		if ldb_canven < 0 then      
			li_conv= this.getitemnumber(this.getrow(),"conversion")	
			if li_conv=0 then li_conv=1
			messagebox("Información","No existe stock suficiente, faltaría : " +string(round(ceiling(abs(round(ldb_canven/li_conv,2))),0))+"  "+ls_abrev,information!)							
		end if		


		////////////////////
		 dw_cab.event refrescar()  
		
	end if 
		
	end if	
		
END IF
end event

event itemchanged;this.post event refrescar()

/*CHOOSE CASE DWO.NAME
	CASE'cant_pres'
	if si_barra=1 then
			 parent.event insertar()
	end if
END CHOOSE*/
end event

event clicked;if row > 0 then
	this.selectrow(0,false)
	this.selectrow(row,true)
	this.scrolltorow(row)
end if
end event

event rowfocuschanged;dw_cab.event refrescar()	
this.selectrow(0,false)
if currentrow > 0 then this.selectrow(currentrow,true)
dw_visualiza_precios.hide()
end event

event buttonclicked;double ldb_porc_descuento
int li_i,li_total,li_cont
this.accepttext()
if dwo.name = 'prc_descuento' and lbo_dsto then
	li_total = dw_det.rowcount()
	open(w_porcentaje_descuento)
	ldb_porc_descuento = Message.doubleparm
	for li_i = 1 to li_total
		if dw_det.getitemstring(li_i,"tipo") = 'N' then
   		dw_det.setitem(li_i,"prc_dsto",ldb_porc_descuento)
		end if
	next
	this.post event refrescar()	
end if
end event

event getfocus;/*if si_barra = 1 then
		
		parent.event insertar()
		w_busqueda_art.show()
	w_busqueda_art.dw_condiciones.setfocus()	
	
end if
*/
end event

type dw_elecnc from datawindow within w_registradora
boolean visible = false
integer x = 306
integer y = 1968
integer width = 686
integer height = 400
integer taborder = 170
string title = "none"
string dataobject = "elec_dwnc"
boolean livescroll = true
borderstyle borderstyle = styleshadowbox!
end type

event constructor;this.settransobject(sqlca)
end event

type dw_det_pago from datawindow within w_registradora
event tecla pbm_dwnkey
event enter pbm_dwnprocessenter
event esc pbm_dwescape
event refresca ( long al_banco )
event tarjeta ( integer banco )
event cheque ( integer banco )
integer x = 311
integer y = 24
integer width = 3127
integer height = 716
integer taborder = 110
string dataobject = "d_detalle_pago"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event tecla;CHOOSE CASE key
	CASE  KeyF4!
         parent.event limpiar()		
	CASE  KeyF6!
         parent.event eliminar()		
	CASE  KeyF7!
         parent.event insertar()
	CASE  KeyF9!
         parent.event forma_pago()
	CASE  KeyF12!
         parent.event grabar()
END CHOOSE
end event

event enter;if  (this.getitemnumber(this.getrow(),"forma_pago") = 1 and this.getcolumnname() = 'aux' ) or (this.getitemnumber(this.getrow(),"forma_pago") = 2 and this.getcolumnname() = 'cod_banco') and (this.getitemnumber(this.getrow(),"forma_pago") = 3) then
	return 0
end if	
send(Handle(this),256,9,Long(0,0))	
return 1

end event

event esc;this.hide()
dw_det.setfocus()
end event

event refresca(long al_banco);datawindowchild ldwch_tarjeta
this.getchild('cod_tarjeta',ldwch_tarjeta)
ldwch_tarjeta.settransobject(sqlca)
ldwch_tarjeta.retrieve(al_banco)
ldwch_tarjeta.insertrow(0)
end event

event tarjeta(integer banco);datawindowchild ldwch_banco
if this.object.forma_pago[this.getrow()]=3 then  //tarjetas
this.object.cod_banco.dddw.Name='d_bancostarjetas'
this.getchild('cod_banco',ldwch_banco)
ldwch_banco.settransobject(sqlca)
ldwch_banco.retrieve()
end if
end event

event cheque(integer banco);datawindowchild ldwch_banco
if this.object.forma_pago[this.getrow()]=2 then  //tarjetas
this.object.cod_banco.dddw.Name='d_lista_banco'
this.getchild('cod_banco',ldwch_banco)
ldwch_banco.settransobject(sqlca)
ldwch_banco.retrieve()
end if
end event

event constructor;this.settransobject(SQLCA)
this.event refresca (0)
end event

event editchanged;long ll_numdev
this.accepttext()
if this.getcolumnname() = "aux" then 
	ll_numdev = dw_cab.object.nr_devol[1]
	//Vuelto
	if this.getitemnumber(1,"subtotal") > (dw_cab.getitemnumber(1,"total")-(dw_cab.getitemnumber(1,"reten_iva")+ dw_cab.getitemnumber(1,"reten_fte"))) then
		this.object.monto[1] = this.object.aux[1]
		this.object.monto[2] = this.object.aux[2]
		this.object.monto[3] = this.object.aux[3]
		this.object.monto[4] = this.object.aux[4]
		sle_1.show()
		sle_1.text = 'Su Cambio es: US/. ' +string( this.getitemnumber(1,"subtotal") - (dw_cab.getitemnumber(1,"total")-(dw_cab.getitemnumber(1,"reten_iva")+ dw_cab.getitemnumber(1,"reten_fte"))),"#,##0.##")
		this.object.cambio[3] =  round(this.getitemnumber(1,"subtotal"),2) - round((dw_cab.getitemnumber(1,"total") - (dw_cab.getitemnumber(1,"reten_iva")+ dw_cab.getitemnumber(1,"reten_fte")) ),2)
		dw_det_pago.setfocus()
	end if
	if this.getitemnumber(1,"subtotal") < (dw_cab.getitemnumber(1,"total")- (dw_cab.getitemnumber(1,"reten_iva")+ dw_cab.getitemnumber(1,"reten_fte")) ) then
		this.object.cambio[3] =  round(this.getitemnumber(1,"subtotal"),2) - round((dw_cab.getitemnumber(1,"total")- (dw_cab.getitemnumber(1,"reten_iva")+ dw_cab.getitemnumber(1,"reten_fte"))),2)
		this.object.monto[1] = this.object.aux[1]
		this.object.monto[2] = this.object.aux[2]
		this.object.monto[3] = this.object.aux[3]
		this.object.monto[4] = this.object.aux[4]
	   if this.object.cambio[3]= 0 then	
			sle_1.hide()
			return
		end if		
		sle_1.show()	
		sle_1.text = 'Hay un faltante de: US/. ' +string(abs(ROUND(this.getitemnumber(1,"subtotal") - (dw_cab.getitemnumber(1,"total") - (dw_cab.getitemnumber(1,"reten_iva")+ dw_cab.getitemnumber(1,"reten_fte"))),2)),"#,##0.##")
	end if		
	if this.getitemnumber(1,"subtotal") = dw_cab.getitemnumber(1,"total") - ( (dw_cab.getitemnumber(1,"reten_iva")+ dw_cab.getitemnumber(1,"reten_fte")))then
		this.object.cambio[3] = 0
		this.object.monto[1] = this.object.aux[1]
		this.object.monto[2] = this.object.aux[2]
		this.object.monto[3] = this.object.aux[3]
		this.object.monto[4] = this.object.aux[4]
		sle_1.hide()
	end if
end if
end event

event itemerror;if dwo.name = 'nr_cta' or dwo.name = 'nr_cheque' or dwo.name = 'cod_banco' or dwo.name = 'cod_tarjeta' or dwo.name = 'tipo_credito'  then
	messagebox("Información","Este dato es obligatorio",information!)
	return -1
end if
end event

event itemchanged;if dw_det_pago.rowcount() >=3 then
if this.object.aux[3] > 0 then
	if dwo.name = 'cod_banco' then
      this.event refresca (integer(data))
	end if
end if
//// cambio
if this.object.forma_pago[this.getrow()]=3 then  //tarjetas
 this.event tarjeta (integer(data))
end if
if this.object.forma_pago[this.getrow()]=2 then  //cheque
 this.event cheque (integer(data))
end if


//// cambio
end if


end event

type dw_cab from datawindow within w_registradora
event tecla pbm_dwnkey
event refrescar ( )
event enter pbm_dwnprocessenter
integer x = 32
integer y = 8
integer width = 3575
integer height = 592
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_cabecera_pos"
boolean livescroll = true
end type

event tecla;CHOOSE CASE key
	CASE  KeyF2!
		   parent.event habilita_dsto()			
	CASE  KeyF3!
         parent.event promoc()			
	CASE  KeyF4!
         parent.event limpiar()		
	CASE  KeyF5!
         parent.event devol()		
	CASE  KeyF6!
         parent.event eliminar()		
	CASE  KeyF7!
         parent.event insertar()
	CASE  KeyF8!
         parent.event cliente()
	CASE  KeyF9!
         parent.event forma_pago()
	CASE  KeyF12!
		   if gb_modifica = false then
         parent.event grabar()
	   	else
		   parent.event modifica()
			end if	
	CASE KeyPageDown!
		dw_det.setfocus()
END CHOOSE

end event

event refrescar;dw_cab.accepttext()	
dw_det.event refrescar()	


end event

event enter;if this.getcolumnname() = "desc_adc" then 
	dw_det.setfocus()
	dw_det.setcolumn(16)
end if

end event

event constructor;Datawindowchild idc_cliente,idc_vendedor
this.getchild("cod_cliente",idc_cliente)
this.getchild("cod_vendedor",idc_vendedor)
idc_vendedor.setfilter("tipo = 'V' or tipo = 'A'")
idc_vendedor.filter()
this.settransobject(SQLCA)
end event

event editchanged;
if dwo.name = "desc_adc" then	dw_cab.event refrescar()

if dwo.name = "reten_fte" then
	dw_cab.event refrescar()
	this.object.cod_fte[dw_cab.getrow()]=0
end if
if dwo.name = "reten_iva" then
	dw_cab.event refrescar()
	this.object.cod_iva[dw_cab.getrow()]=0
end if

if dwo.name = "nr_reten" then	dw_cab.event refrescar()


end event

event getfocus;dw_visualiza_precios.hide()
if not lbo_dsto then 
	w_busqueda_art.setfocus()
else
	dw_cab.setfocus()
   dw_cab.settaborder("desc_adc",40)
end if

end event

event itemchanged;double ldb_por
integer li_codigo
dw_cab.accepttext()
if  dwo.name = "cod_fte" then
	
if dw_det.rowcount() > 0	then
li_codigo=integer(data)
select retencion.porcentaje
into :ldb_por
from retencion 
where retencion.cod_retencion=:li_codigo ;

this.object.reten_fte[dw_cab.getrow()]=dw_det.object.sub_total[dw_det.rowcount()] * (ldb_por / 100)
	dw_cab.event refrescar()
end if	
end if	

if  dwo.name = "cod_iva" then
	
if dw_det.rowcount() > 0	then
li_codigo=integer(data)
select retencion.porcentaje
into :ldb_por
from retencion 
where retencion.cod_retencion=:li_codigo ;

this.object.reten_iva[dw_cab.getrow()]=round(dw_det.object.tot_iva[dw_det.rowcount()] * (ldb_por / 100),2)
	dw_cab.event refrescar()
end if	
end if	

dw_cab.accepttext()
if  dwo.name = "subempresa" then
	gs_subempresa=string(data)
	select bodega,estab,ptoemi,nr_caja
	into :gi_bodega,:gs_num_suc,:gs_emi,:gi_caja
     from companias_detalle
	  where subempresa=:data ;
	 w_registradora.title = ' '+ string(gi_caja)
	dw_cab.object.ptoemi[1] = gs_emi
	dw_cab.object.nr_caja[1] = gi_caja
	dw_cab.object.estab[1] = gs_num_suc
	dw_cab.object.otra_ref[1] = string(gi_bodega)
	w_busqueda_art.dw_art_suc.retrieve(gi_bodega)
end if	
end event

type pb_1 from picturebutton within w_registradora
integer x = 942
integer y = 196
integer width = 352
integer height = 80
integer taborder = 120
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "..................."
boolean flatstyle = true
string disabledname = "Browse_2!"
alignment htextalign = left!
end type

event clicked;string  ls_ruc_ci,ls_c,ls_buscar
integer li_existe=0,i_digitos,i
double ldb_saldo
long ll_cod_clie

dw_cab.accepttext()
ls_ruc_ci=dw_cab.object.c_i_o_ruc[1]
i_digitos=len(ls_ruc_ci)
ls_buscar='%'+trim(ls_ruc_ci)+'%'


select top 1 cod_cliente,nombre,ruc_ci,paga_iva
into    :ll_cod_clie,
	   :gs_nom_clie,
	   :gs_ruc_clie,
	  :gs_piva	
from  cliente
where cliente.ruc_ci LIKE :ls_buscar;



if isnull(ll_cod_clie) then ll_cod_clie=0

if ll_cod_clie> 0 then

	//BUSCA SI TIENE NC PENDIENTES
	SELECT sum(SALDO)
	INTO :ldb_saldo
	from cxc_documento
	where tipo_documento='NC' and cod_cliente=:ll_cod_clie ;
	if isnull(ldb_saldo) then ldb_saldo=0
dw_cab.object.cod_cliente[1] = ll_cod_clie
dw_cab.object.nomb_cliente[1] = gs_nom_clie
dw_cab.object.c_i_o_ruc[1] = gs_ruc_clie
dw_cab.object.paga_iva[1] = gs_piva
dw_det.setcolumn(14)
dw_det.setfocus()


if ldb_saldo > 0 then
messagebox("Atención","Cliente Encontrado"+ "Tiene un Valor por NC pendiente de "+ string(ldb_saldo))	
end if
if dw_datos.retrieve(ll_cod_clie)> 0 then

//verirfica //RUC y dirección-email
		//verifique RUC
		
  if dw_datos.object.tp_id_cli[dw_datos.getrow()]='F' then
    if  dw_datos.object.ruc_ci[dw_datos.getrow()]<>'9999999999999' then
			messagebox("Atención","consumidor final debe ser :9999999999999")	
			dw_datos.object.ruc_ci[dw_datos.getrow()]=''
	ROLLBACK;
	RETURN -1
	commit;
   end if
	end if
  

	i=f_valida_ruc(dw_datos.object.tp_id_cli[dw_datos.getrow()],dw_datos.object.ruc_ci[dw_datos.getrow()])
	if i < 0 then
	messagebox("Atención","Ruc/CI mal ingresado")	
	dw_datos.object.ruc_ci[dw_datos.getrow()]=''
	dw_cab.object.c_i_o_ruc[1]=''
	dw_cab.object.nomb_cliente[1]=''
	ROLLBACK;
	RETURN -1
	commit;
	end if		
	
			if isnull(dw_datos.object.direc_electronica[dw_datos.getrow()]) or dw_datos.object.direc_electronica[dw_datos.getrow()]='' then
								messagebox("Atención","Ingreso un Correo Electrónico")	
								ROLLBACK;
                                	RETURN -1
       				end if			
			         
						if isnull(dw_datos.object.direccion[dw_datos.getrow()]) or dw_datos.object.direccion[dw_datos.getrow()]='' then
								messagebox("Atención","Ingreso La dirección del Comprador")	
															ROLLBACK;
                                	RETURN -1

    				end if			


end if//> 0
end if	

if ll_cod_clie=0 then
//messagebox("Atención","Cliente No   Encontrado")	
dw_cab.object.c_i_o_ruc[1]='9999999999999'
if i_digitos >=10 then
dw_datos.reset()
dw_datos.insertrow(0)
dw_datos.object.ruc_ci[1]=ls_ruc_ci
dw_datos.setfocus()
dw_datos.setcolumn(7)

end if
end  if	









	

end event

type gb_1 from groupbox within w_registradora
integer x = 5152
integer y = 612
integer width = 978
integer height = 1692
integer taborder = 250
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
04w_registradora.bin 
2B00000600e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe00000006000000000000000000000001000000010000000000001000fffffffe00000000fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000fffffffe00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
14w_registradora.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
