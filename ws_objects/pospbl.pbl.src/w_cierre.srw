$PBExportHeader$w_cierre.srw
$PBExportComments$Cierre diario de Caja
forward
global type w_cierre from window
end type
type st_6 from statictext within w_cierre
end type
type sle_usuario from singlelineedit within w_cierre
end type
type dw_2 from datawindow within w_cierre
end type
type dw_1 from datawindow within w_cierre
end type
type st_5 from statictext within w_cierre
end type
type st_4 from statictext within w_cierre
end type
type sle_2 from singlelineedit within w_cierre
end type
type em_dinero from editmask within w_cierre
end type
type st_3 from statictext within w_cierre
end type
type sle_clave from singlelineedit within w_cierre
end type
type st_2 from statictext within w_cierre
end type
type st_1 from statictext within w_cierre
end type
type cb_2 from commandbutton within w_cierre
end type
type cb_1 from commandbutton within w_cierre
end type
type em_1 from editmask within w_cierre
end type
type sle_1 from singlelineedit within w_cierre
end type
type gb_1 from groupbox within w_cierre
end type
type gb_2 from groupbox within w_cierre
end type
end forward

global type w_cierre from window
integer x = 603
integer y = 512
integer width = 1792
integer height = 1040
boolean titlebar = true
string title = "Cierre Diario de Caja"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 79741120
st_6 st_6
sle_usuario sle_usuario
dw_2 dw_2
dw_1 dw_1
st_5 st_5
st_4 st_4
sle_2 sle_2
em_dinero em_dinero
st_3 st_3
sle_clave sle_clave
st_2 st_2
st_1 st_1
cb_2 cb_2
cb_1 cb_1
em_1 em_1
sle_1 sle_1
gb_1 gb_1
gb_2 gb_2
end type
global w_cierre w_cierre

type variables
string is_tipo_cierre
integer ii_tipo_comprobante
long il_nr_comprobante

end variables

forward prototypes
public function integer wf_asiento_contable (datetime ada_fecha_cierre)
end prototypes

public function integer wf_asiento_contable (datetime ada_fecha_cierre);setpointer(hourglass!)
string ls_cta_ventas,ls_cta_iva,ls_cta_costo,ls_inventario,ls_cta,ls_referencia,ls_concepto,ls_signo,ls_descripcion,ls_cuenta_ventas,ls_cuenta_contable,ls_cuenta_ret_iva,ls_cuenta_ret_fte,ls_cnta_compensacion
integer li_i,li_numcta,li_codtarj,li_j,li_cod,lli_caja,li_n,li_num
double ldb_iva,ldb_total,ldb_efectivo,ldb_cheque,ldb_cosing,ldb_cosegr,ldb_costo,ldb_sumtar,lc_tarjeta,ldb_tarjeta,ldb_cre,ldb_diferencia,ldb_dinero,ldb_ret_iva,ldb_ret_fte,ldb_compensado
string ls_fecha,ls_cta_tarj,ls_nomtarj
string ls_cta_bancos,ls_cta_efectivo,lls_com,ls_cta_clientes
boolean lbo_saldo=false

lli_caja =integer(trim(sle_1.text))
lls_com = (trim(sle_2.text))
li_cod = integer(lls_com)
ldb_dinero=double(em_dinero.text)
if isnull(ldb_dinero) then ldb_dinero=0 
if ldb_dinero=0 then
	 messagebox("Información","Tanto las Ventas como Devoluciones es Saldo Cero")
			rollback;
	 		return -1
end if			 
	
// información de las ctas. contables
SELECT cnta_ventas,cnta_iva_venta,cnta_efectivo,cnta_bancos,cnta_costo_venta,cnta_inventarios,tipo_comprob_ventas,cnta_clientes,CNTA_RET_COBRANZAS,CNTA_RET_IVA,cnta_compensacion  
into :ls_cta_ventas,:ls_cta_iva,:ls_cta_efectivo,:ls_cta_bancos,:ls_cta_costo,:ls_inventario,:ii_tipo_comprobante,:ls_cta_clientes,:ls_cuenta_ret_fte,:ls_cuenta_ret_iva,:ls_cnta_compensacion
FROM compania
WHERE cod_compania = :li_cod;
if sqlca.sqlcode < 0 then
	messagebox("Error wf_asiento_contable","No puedo recuperar los datos de compañía~r~n"+sqlca.sqlerrtext,exclamation!)
	rollback;
	return -1
end if
if isnull(ls_cta_ventas) or isnull(ls_cta_iva) or isnull(ls_cta_efectivo) or isnull(ls_cta_bancos)  or isnull(ii_tipo_comprobante) or isnull(ls_cta_clientes) then
	messagebox("Error wf_asiento_contable","No se han definido las ctas. para el asiento contable en la tabla de compañía~r~n"+sqlca.sqlerrtext,exclamation!)
	rollback;
	return -1
end if
// secuencial de comprobante de ventas
SELECT tipoc_x_mes.numseq INTO :il_nr_comprobante FROM tipoc_x_mes  
WHERE (tipoc_x_mes.tipo_comprob = :ii_tipo_comprobante) AND (tipoc_x_mes.mes = datepart(mm,:ada_fecha_cierre));
if sqlca.sqlcode < 0 then
	messagebox("Error wf_asiento_contable","No puedo recuperar el secuencial en la tabla tipo_x_mes~r~n"+sqlca.sqlerrtext,exclamation!)
	rollback;
	return -1
end if
// cabecera de comprobante
ls_descripcion='Asiento contable por cierre de la caja'+string(gi_caja)+ ' Cajero No: '+ string(gi_cod_funcionario)
INSERT INTO cnt_cab_comprob  
(tipo_comprob,nro_comprob,fecha_comprob,cod_compania,descripcion,usuario,f_ult_act,cod_sistema)  
VALUES (:ii_tipo_comprobante,:il_nr_comprobante,:ada_fecha_cierre,:lls_com,:ls_descripcion,:gs_usuario,getdate(),:gi_sistema);
if sqlca.sqlcode < 0 then
	messagebox("Error wf_asiento_contable","No puedo registrar el comprobante~r~n"+sqlca.sqlerrtext,exclamation!)
	rollback;
	return -1
end if
//// valores de iva,efectivo y cheques,credito
ls_fecha = string(date(ada_fecha_cierre),'yyyy/mm/dd')
SELECT isnull(tot_efec,0),isnull(tot_cheque,0),isnull(tot_tarjeta,0), isnull(iva,0), isnull(tot_credito,0),isnull(tot_ret_iva,0),isnull(tot_ret_fte,0),isnull(tot_compensado,0)INTO :ldb_efectivo,:ldb_cheque,:ldb_tarjeta,:ldb_iva,:ldb_cre,:ldb_ret_iva,:ldb_ret_fte,:ldb_compensado FROM pv_cierre_caja  
WHERE (cod_compania = :lls_com) AND (nr_caja = :lli_caja) AND
(convert(char(10),pv_cierre_caja.fecha_cierre,111) = :ls_fecha) AND (estado = 'P');
//pv_cierre_caja.cod_funcionario =:gi_cod_funcionario  and
if sqlca.sqlcode < 0 or sqlca.sqlcode = 100 then
	messagebox("Error wf_asiento_contable","No puedo recuperar la información del cierre de caja~r~n"+sqlca.sqlerrtext,exclamation!)
	rollback;
	return -1
end if
// valor del costo de ventas e inventario
/*
SELECT ISNULL(sum(inv_articulo_movimiento.cantidad * inv_articulo_movimiento.costo_promedio),0)
INTO :ldb_cosegr FROM pv_nv_movimiento, inv_articulo_movimiento,pv_nota_venta  
WHERE (pv_nv_movimiento.nr_movimiento = inv_articulo_movimiento.nr_movimiento) and 
(pv_nv_movimiento.tipo_movimiento = inv_articulo_movimiento.tipo_movimiento) and  
(pv_nota_venta.cod_compania = pv_nv_movimiento.cod_compania) and 
(pv_nv_movimiento.numero = pv_nota_venta.numero) and 
(pv_nv_movimiento.tipo_movimiento = pv_nota_venta.tipo_doc) and
((pv_nota_venta.cod_compania = :lls_com ) AND (convert(char(10),pv_nota_venta.fecha_emision,111) = :ls_fecha) and 
(pv_nota_venta.nr_caja = :lli_caja) AND
(pv_nv_movimiento.tipo_movimiento = 'EV') AND (pv_nota_venta.tipo_comprob is null) AND (pv_nota_venta.nr_comprob is null));

if sqlca.sqlcode < 0 or sqlca.sqlcode = 100 then
	messagebox("Error wf_asiento_contable","No puedo obtener el costo de la venta~r~n"+sqlca.sqlerrtext,exclamation!)
	rollback;
	return -1
end if

SELECT ISNULL(sum(inv_articulo_movimiento.cantidad * inv_articulo_movimiento.costo_promedio),0)
INTO :ldb_cosing FROM pv_nv_movimiento, inv_articulo_movimiento,pv_nota_venta  
WHERE (pv_nv_movimiento.nr_movimiento = inv_articulo_movimiento.nr_movimiento) and 
(pv_nv_movimiento.tipo_movimiento = inv_articulo_movimiento.tipo_movimiento) and  
(pv_nota_venta.cod_compania = pv_nv_movimiento.cod_compania) and 
(pv_nv_movimiento.numero = pv_nota_venta.numero) and  
(pv_nv_movimiento.tipo_movimiento = pv_nota_venta.tipo_doc) and
((pv_nota_venta.cod_compania = :lls_com ) AND (convert(char(10),pv_nota_venta.fecha_emision,111) = :ls_fecha) and 
(pv_nota_venta.nr_caja = :lli_caja) AND
(pv_nv_movimiento.tipo_movimiento = 'ID') AND (pv_nota_venta.tipo_comprob is null) AND (pv_nota_venta.nr_comprob is null));
if sqlca.sqlcode < 0 or sqlca.sqlcode = 100 then
	messagebox("Error wf_asiento_contable","No puedo obtener el costo de la venta~r~n"+sqlca.sqlerrtext,exclamation!)
	rollback;
	return -1
end if
ldb_costo = Round((ldb_cosegr - ldb_cosing),2)

*/
//////////////////////////////////////////////////////////////////
//VOY A LLAMAR AL DATAWINDOW DE VENTAS


//////////
///////////
    integer l,grupos[],gruposd[],m
		string ls_cnta_ing,ls_cnta_gas,ls_cnta_act
		double ldb_ing,ldb_gas,ldb_act
		li_num =dw_1.retrieve(lls_com,lli_caja,ls_fecha)//,gi_cod_funcionario)
		
      for l = 1 to dw_1.rowcount()
    	if l = 1 then 
		grupos[l] = l
  	   else
		if dw_1.object.cnta_contable_act[l] <> dw_1.object.cnta_contable_act[l - 1] then
			grupos[l] = l
		end if
   	end if	
     next		
      m = upperbound(grupos[])	
      integer j=2,k=0,i=0
		for l = 1 to m
			if grupos[l] > 0  then
				ls_cnta_ing = dw_1.object.cnta_contable_ing[l]
				ldb_ing = dw_1.object.tot_venta[l]
				ls_cnta_gas = dw_1.object.cnta_contable_gas[l]
		      ldb_gas = dw_1.object.tot_costo[l]
				ls_cnta_act = dw_1.object.cnta_contable_act[l]
				j=j+1 //orden del asiento
				for i=1 to 3 
				choose case i
					 case 1 // Ventas
						ls_cuenta_ventas = ls_cnta_ing
					   ldb_diferencia = round(ldb_ing,2) //cambio  new
   					ls_referencia = 'PV'
	    				ls_concepto = 'VENTAS'
			   		ls_signo = 'C'
				   	ls_cuenta_contable = ls_cuenta_ventas
			  		  case 2 // Costo de Venta
						ldb_diferencia = round(ldb_gas,2)
						ls_referencia = 'PV'
						ls_concepto = 'COSTO VENTA'
						ls_signo = 'D'
						ls_cuenta_contable = ls_cnta_gas
					  case 3 // Inventarios
						ldb_diferencia = round(ldb_gas,2)
						ls_referencia = 'PV'
						ls_concepto = 'INVENTARIOS'
						ls_signo = 'C'
						ls_cuenta_contable = ls_cnta_act
				end choose 
						k = i+ j
				if ldb_diferencia > 0 then		
				insert into cnt_det_comprob  
					( tipo_comprob,nro_comprob,   
					  fecha_comprob,cuenta,   
					  numseq,cod_compania,referencia,   
					  concepto_comprob,signo,   
					  valor )  
					  values ( :ii_tipo_comprobante,
					           :il_nr_comprobante,
								   :ada_fecha_cierre,:ls_cuenta_contable,   
								  :k,:lls_com,:ls_referencia,   
								  :ls_concepto,:ls_signo,   
								  :ldb_diferencia)  ;
								  
								  if sqlca.sqlcode < 0 then
									gs_mensaje = "cnt_det_comprobPRIMERO"
									f_mensajes(20)
									Rollback;
									Return -1
									end if		
				end if //difer				
 				next //case				  
			end if //grupos
		next //m

		//para descuentos
		/*k++
		double ldb_d
		ldb_d = idb_descuento_total
		if idb_descuento_total > 0 then
						insert into "cnt_det_comprob"  
					( "tipo_comprob","nro_comprob",   
					  "fecha_comprob","cuenta",   
					  "numseq","cod_compania","referencia",   
					  "concepto_comprob","signo",   
					  "valor" )  
					  values ( :ii_tipo_comprobante,
					           :il_nr_comprobante,
								   :ada_fecha_cierre,'4110105',   
								  :k,:lls_com,:ls_referencia,   
								  'Descuento','D',   
								  :idb_descuento_total)  ;
								  
								  if sqlca.sqlcode < 0 then
									gs_mensaje = "cnt_det_comprob_descuento"
									f_mensajes(20)
									Rollback;
									Return -1
									end if		
				end if									

*/ 

////////////////
//////////////////////////////////////////////////////////////
///////vamos con devoluciones  //////////////
     dw_2.retrieve(lls_com,lli_caja,ls_fecha)//,gi_cod_funcionario)
      for l = 1 to dw_2.rowcount()
    	if l = 1 then 
		gruposd[l] = l
  	   else
		if dw_2.object.cnta_contable_act[l] <> dw_2.object.cnta_contable_act[l - 1] then
			gruposd[l] = l
		end if
   	end if	
     next		
      m = upperbound(gruposd[])	
//     k=0 
		 i=0
		 j = 3
		for l = 1 to m
			if gruposd[l] > 0  then
				ls_cnta_ing = dw_2.object.cnta_contable_ing[l]
				ldb_ing = dw_2.object.tot_venta[l]
				ls_cnta_gas = dw_2.object.cnta_contable_gas[l]
		      ldb_gas = dw_2.object.tot_costo[l]
				ls_cnta_act = dw_2.object.cnta_contable_act[l]
				k=k+1 //orden del asiento
				for i=1 to 3 
				choose case i
					 case 1 // Ventas
						ls_cuenta_ventas = ls_cnta_ing
					   ldb_diferencia = abs(round(ldb_ing,2)) //cambio  new
   					ls_referencia = 'PV'
	    				ls_concepto = 'DEVOLUCION VENTAS'
			   		ls_signo = 'D'
				   	ls_cuenta_contable = ls_cuenta_ventas
			  		  case 2 // Costo de Venta
						ldb_diferencia = abs(round(ldb_gas,2))
						ls_referencia = 'PV'
						ls_concepto = 'DEVOLUCION COSTO VENTA'
						ls_signo = 'C'
						ls_cuenta_contable = ls_cnta_gas
					  case 3 // Inventarios
						ldb_diferencia = abs(round(ldb_gas,2))
						ls_referencia = 'PV'
						ls_concepto = 'DEVOLUCION INVENTARIOS'
						ls_signo = 'D'
						ls_cuenta_contable = ls_cnta_act
				end choose 
						 k++
				if ldb_diferencia > 0 then		
				insert into cnt_det_comprob  
					( tipo_comprob,nro_comprob,   
					  fecha_comprob,cuenta,   
					  numseq,cod_compania,referencia,   
					  concepto_comprob,signo,   
					  valor )  
					  values ( :ii_tipo_comprobante,
					           :il_nr_comprobante,
								   :ada_fecha_cierre,:ls_cuenta_contable,   
								  :k,:lls_com,:ls_referencia,   
								  :ls_concepto,:ls_signo,   
								  :ldb_diferencia)  ;
								  
								  if sqlca.sqlcode < 0 then
									gs_mensaje = "cnt_det_comprobSEGUNDO"
									f_mensajes(20)
									Rollback;
									Return -1
									end if		
				end if //difer				
 				next //case				  
			end if //grupos
		next //m



////////////////////////////////////////////
ls_referencia = 'PV'
li_numcta=w_resumen_caja.dw_1.rowcount() //antes
ldb_sumtar = 0

////////nuevo
for li_i = 1 to w_resumen_caja.dw_1.rowcount()
   if w_resumen_caja.dw_1.object.cod_monto[li_i] > 0 then
		ldb_sumtar= ldb_sumtar + w_resumen_caja.dw_1.getitemnumber(li_i,"c_monto")
	end if
next 	
	///nuevo

/*   antes
for li_i=3 to li_numcta
	 ldb_sumtar= ldb_sumtar + w_resumen_caja.dw_1.getitemnumber(li_i,"c_monto")
next
*/
for li_i = 1 to 7
	
	CHOOSE CASE li_i
		CASE 1
			// Efectivo
			ldb_total = ldb_efectivo 
			ls_cta =gs_cta_efectivo // ls_cta_efectivo 
			ls_concepto = 'CAJA GENERAL EFECTIVO'
			if ldb_total > 0 then
				ls_signo = 'D'
			else
				ls_signo = 'C'
			end if
			ldb_total = Abs(ldb_total)
		CASE 2
			// Cheque
			ldb_total = ldb_cheque
			ls_cta = ls_cta_bancos
			ls_concepto = 'CAJA GENERAL CHEQUE'
			if ldb_total > 0 then
				ls_signo = 'D'
			else
				ls_signo = 'C'
			end if
			ldb_total = Abs(ldb_total)
		CASE 3 
			// iva			
			ldb_total = ldb_iva
			ls_cta = ls_cta_iva
			ls_concepto = 'IVA'	
			if ldb_total > 0 then
				ls_signo = 'C'
			else
				ls_signo = 'D'
			end if
			ldb_total = Abs(ldb_total)
		CASE 4
			 // credito			
			ldb_total = ldb_cre
			ls_cta = ls_cta_clientes
			ls_concepto = 'Clientes'			
			if ldb_total > 0 then
				ls_signo = 'D'
			else
				ls_signo = 'C'
			end if
			ldb_total = Abs(ldb_total)			
			CASE  5   //RETENCION IVA
			ldb_total = ldb_ret_iva
			ls_cta = ls_cuenta_ret_iva
			ls_concepto = 'Retención IVA'			
			if ldb_total > 0 then
				ls_signo = 'D'
			else
				ls_signo = 'C'
			end if
			ldb_total = Abs(ldb_total)			
				
				
			CASE 6	//RETENCION FTE
			ldb_total = ldb_ret_fte
			ls_cta = ls_cuenta_ret_fte
			ls_concepto = 'Retención Fuente'			
			if ldb_total > 0 then
				ls_signo = 'D'
			else
				ls_signo = 'C'
			end if
			ldb_total = Abs(ldb_total)	
			
			CASE 7 
			// compensado			
			ldb_total = ldb_compensado
			ls_cta = ls_cnta_compensacion
			ls_concepto = 'Compensación Solidaria'	
			if ldb_total > 0 then
				ls_signo = 'D'
			else
				ls_signo = 'C'
			end if
			ldb_total = Abs(ldb_total)
				
		
			
	END CHOOSE
	if ldb_total > 0  then
		  INSERT INTO cnt_det_comprob  
		  (tipo_comprob,nro_comprob,fecha_comprob,cuenta,numseq,cod_compania,referencia,concepto_comprob,signo,valor)
		  VALUES (:ii_tipo_comprobante,:il_nr_comprobante,:ada_fecha_cierre,:ls_cta,:li_i,:lls_com,:ls_referencia,:ls_concepto,:ls_signo,abs(:ldb_total));
			if sqlca.sqlcode < 0 then
				messagebox("Error wf_asiento_contable","No puedo registrar el detalle del comprobante~r~n"+sqlca.sqlerrtext,exclamation!)
				rollback;
				return -1
			end if
	elseif ldb_total = 0  and (li_i=9) then
		if ldb_tarjeta > 0 then 
			ls_cta_tarj= w_resumen_caja.dw_1.getitemstring(li_i,"cnta") //3//SI SOLO HAY TARJETA AQUI ESTA EL PROBLEMA
			ldb_total = ldb_tarjeta
		//else
        // messagebox("Información","Tanto las Ventas como Devoluciones es Saldo Cero")
			//rollback;
	 		//return -1
		
		 IF ls_signo = 'D' THEN
			ls_signo = 'C'
		 ELSE
			ls_signo = 'D'
		 END IF
		 INSERT INTO cnt_det_comprob  
		 (tipo_comprob,nro_comprob,fecha_comprob,cuenta,numseq,cod_compania,referencia,concepto_comprob,signo,valor)
		 VALUES (:ii_tipo_comprobante,:il_nr_comprobante,:ada_fecha_cierre,:ls_cta_tarj,:li_i,:lls_com,:ls_referencia,:ls_concepto,:ls_signo,abs(:ldb_total));
		 if sqlca.sqlcode < 0 then
			messagebox("Error wf_asiento_contable","No puedo AA registrar el detalle del comprobante~r~n"+sqlca.sqlerrtext,exclamation!)
			rollback;
			return -1
		 end if
	end if
end if
next

// Datos para asiento contable con tarjetas de credito
if ldb_sumtar > 0  then
   for li_i = 3 to li_numcta
	 if  w_resumen_caja.dw_1.object.cod_monto[li_i] > 0 then  //new
		li_codtarj= w_resumen_caja.dw_1.getitemnumber(li_i,"cod_monto")
		lc_tarjeta= w_resumen_caja.dw_1.getitemnumber(li_i,"c_monto")
		if lc_tarjeta > 0 then
			ls_cta_tarj= w_resumen_caja.dw_1.getitemstring(li_i,"cnta")
			ls_nomtarj= w_resumen_caja.dw_1.getitemstring(li_i,"nom_monto")
			if isnull(lc_tarjeta) then lc_tarjeta = 0	
			ldb_total = lc_tarjeta;ls_signo = 'D';
			if ldb_total > 0 then
			  li_j= li_i + 3
			  INSERT INTO cnt_det_comprob  
			  (tipo_comprob,nro_comprob,fecha_comprob,cuenta,numseq,cod_compania,referencia,concepto_comprob,signo,valor)
			  VALUES (:ii_tipo_comprobante,:il_nr_comprobante,:ada_fecha_cierre,:ls_cta_tarj,:li_j,:lls_com,:ls_referencia,:ls_nomtarj,:ls_signo,abs(:ldb_total));
				if sqlca.sqlcode < 0 then
					messagebox("Error wf_asiento_contable","No puedo registrar el detalle  11 del comprobante~r~n"+sqlca.sqlerrtext,exclamation!)
					rollback;
					return -1
				end if
			end if		
	  end if
   end if  //nuevo
   next
end if

//VERIFICO EL CUADRE 
double ldb_debito=0,ldb_credito=0,ldb_dif=0
string f_c,ls_cuadre
f_c=string(date(ada_fecha_cierre),'yyyy/mm/dd')
select sum(valor)
into :ldb_debito
from cnt_det_comprob
where signo = 'D'
and tipo_comprob = :ii_tipo_comprobante
and nro_comprob = :il_nr_comprobante
and convert(char(10),fecha_comprob,111) = :f_c;

select sum(valor)
into :ldb_credito
from cnt_det_comprob
where signo = 'C'
and tipo_comprob = :ii_tipo_comprobante
and nro_comprob = :il_nr_comprobante
and convert(char(10),fecha_comprob,111) = :f_c;
if isnull(ldb_credito) then ldb_credito=0
if isnull(ldb_debito) then ldb_debito=0

if round(ldb_credito,2) <> round(ldb_debito,2) then
  if ldb_credito > ldb_debito then
	   ldb_dif  = round(ldb_credito - ldb_debito,2)
		ls_signo ='D'
	else	
		ldb_dif = round(ldb_debito - ldb_credito,2)
      ls_signo ='C'
   end	if
   

	if ldb_dif > 0 then
	ls_concepto="cuadre"	
  SELECT COMPANIA.CNTA_GASTOS  
    INTO :ls_cuadre  
    FROM COMPANIA  
   WHERE 1 = 1   
           ;

		li_i=li_i+1
		 INSERT INTO cnt_det_comprob  
		 (tipo_comprob,nro_comprob,fecha_comprob,cuenta,numseq,cod_compania,referencia,concepto_comprob,signo,valor)
		 VALUES (:ii_tipo_comprobante,:il_nr_comprobante,:ada_fecha_cierre,:ls_cuadre,:li_i+1,:lls_com,:ls_referencia,:ls_concepto,:ls_signo,:ldb_dif);
		 if sqlca.sqlcode < 0 then
			messagebox("Error wf_asiento_contable","No puedo  registrar el cuadre~r~n"+sqlca.sqlerrtext,exclamation!)
			rollback;
			return -1
		 end if
	
    end if	 

end if

boolean lbo_cuadre
lbo_cuadre = f_comprobante(ii_tipo_comprobante,il_nr_comprobante,string(date(ada_fecha_cierre),'yyyy/mm/dd'))
if lbo_cuadre= false then
	messagebox("Información","El comprobante no se realizó en forma adecuada",information!)
	RollBack;
	Return -1
end if
update tipoc_x_mes set tipoc_x_mes.numseq = tipoc_x_mes.numseq + 1
WHERE (tipoc_x_mes.tipo_comprob = :ii_tipo_comprobante) AND (tipoc_x_mes.mes = datepart(mm,:ada_fecha_cierre));
if sqlca.sqlcode < 0 then
	messagebox("Error wf_asiento_contable","No puedo actualizar el secuencial en la tabla tipo_x_mes",exclamation!)
	rollback;
	return -1
end if

gl_tipo_comprobante = ii_tipo_comprobante
gl_nr_comprobante = il_nr_comprobante
gs_fecha_comprobante = string(date(ada_fecha_cierre),'yyyy/mm/dd')

return 1
end function

on w_cierre.create
this.st_6=create st_6
this.sle_usuario=create sle_usuario
this.dw_2=create dw_2
this.dw_1=create dw_1
this.st_5=create st_5
this.st_4=create st_4
this.sle_2=create sle_2
this.em_dinero=create em_dinero
this.st_3=create st_3
this.sle_clave=create sle_clave
this.st_2=create st_2
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.em_1=create em_1
this.sle_1=create sle_1
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.st_6,&
this.sle_usuario,&
this.dw_2,&
this.dw_1,&
this.st_5,&
this.st_4,&
this.sle_2,&
this.em_dinero,&
this.st_3,&
this.sle_clave,&
this.st_2,&
this.st_1,&
this.cb_2,&
this.cb_1,&
this.em_1,&
this.sle_1,&
this.gb_1,&
this.gb_2}
end on

on w_cierre.destroy
destroy(this.st_6)
destroy(this.sle_usuario)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.sle_2)
destroy(this.em_dinero)
destroy(this.st_3)
destroy(this.sle_clave)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.em_1)
destroy(this.sle_1)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;em_1.text = string(today())
is_tipo_cierre = message.stringparm
if is_tipo_cierre = 'final' then
	em_dinero.enabled = false
	em_dinero.text = string(w_resumen_caja.dw_1.getitemnumber(1,"total_caja"))
	em_1.text = string(w_resumen_caja.dw_1.getitemdatetime(1,"fecha_cierre"))
	em_1.enabled = false
	sle_usuario.setfocus()
else
	em_dinero.text = ""
end if
dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
end event

type st_6 from statictext within w_cierre
integer x = 50
integer y = 324
integer width = 247
integer height = 76
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Cajero:"
boolean focusrectangle = false
end type

type sle_usuario from singlelineedit within w_cierre
integer x = 334
integer y = 320
integer width = 718
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
string placeholder = "Cajero"
end type

type dw_2 from datawindow within w_cierre
boolean visible = false
integer x = 1801
integer y = 280
integer width = 622
integer height = 204
string title = "none"
string dataobject = "d_costo_ingdev"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_1 from datawindow within w_cierre
boolean visible = false
integer x = 1797
integer y = 104
integer width = 576
integer height = 160
boolean titlebar = true
string title = "none"
string dataobject = "d_costo_ing"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_5 from statictext within w_cierre
integer x = 759
integer y = 76
integer width = 219
integer height = 88
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Caja:"
boolean focusrectangle = false
end type

type st_4 from statictext within w_cierre
integer x = 55
integer y = 84
integer width = 347
integer height = 88
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Compania :"
boolean focusrectangle = false
end type

type sle_2 from singlelineedit within w_cierre
integer x = 421
integer y = 72
integer width = 247
integer height = 92
integer taborder = 50
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16776960
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event constructor;this.text = string(gs_cod_compania,"1")
end event

type em_dinero from editmask within w_cierre
integer x = 617
integer y = 752
integer width = 457
integer height = 100
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###,###,##0.00"
end type

type st_3 from statictext within w_cierre
integer x = 59
integer y = 764
integer width = 512
integer height = 76
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Total Cierre:"
boolean focusrectangle = false
end type

type sle_clave from singlelineedit within w_cierre
integer x = 325
integer y = 444
integer width = 718
integer height = 84
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
boolean password = true
borderstyle borderstyle = stylelowered!
string placeholder = "Clave"
end type

type st_2 from statictext within w_cierre
integer x = 41
integer y = 444
integer width = 247
integer height = 76
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Clave:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_cierre
integer x = 55
integer y = 212
integer width = 247
integer height = 76
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Fecha:"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_cierre
integer x = 1307
integer y = 200
integer width = 411
integer height = 92
integer taborder = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_cierre
integer x = 1307
integer y = 72
integer width = 411
integer height = 92
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Aceptar"
boolean default = true
end type

event clicked;setpointer(hourglass!)
double tot_con_iva = 0,tot_sin_iva = 0,iva,dsto_con_iva= 0 ,dsto_sin_iva = 0,lc_efectivo = 0,lc_cheque= 0,desc_adc =0,tot_dinero,lc_tarjeta=0,lc_credito,tot_compensado
double ldb_efec,ldb_cheq,ldb_cre,ldb_ret_iva=0,ldb_ret_fte=0
integer li_existe,li_cajero,li_i
long nr_tickets
datetime ld_fecha
string ls_clave,ls_fecha,ls_cajero
li_caja =integer(trim(sle_1.text))
ls_com = (trim(sle_2.text))
if li_caja > 0 and  integer(ls_com) > 0 then
	
ld_fecha = datetime(date(em_1.text),now())
ls_fecha = string(date(em_1.text),'yyyy/mm/dd')
ls_clave = trim(sle_clave.text)
ls_cajero= trim(sle_usuario.text)

if ls_clave = "" then 
	messagebox("Información","Debe ingresar una clave personal",information!);sle_clave.setfocus();return
end if
if ls_cajero = "" then 
	messagebox("Información","Debe ingresar el nombre del cajero",information!);sle_clave.setfocus();return
end if
// verificación de claves

SELECT pv_caja.cod_funcionario INTO :li_cajero FROM pv_caja  
WHERE (pv_caja.cod_compania = :ls_com) AND (pv_caja.nr_caja = :li_caja) AND ((pv_caja.clave = :ls_clave) or (pv_caja.clavecie = :ls_clave)) ;
if sqlca.sqlcode = 100 then
	messagebox("Información","UstedMI no está autorizado para hacer el cierre de caja",information!);sle_clave.setfocus();	return 
elseif sqlca.sqlcode < 0 then
	messagebox("Información","No puedo obtener los datos del cajero.",information!);	return 
end if

/*
SELECT FUNCIONARIO.COD_FUNCIONARIO INTO :li_cajero
FROM PV_CAJA,FUNCIONARIO
WHERE NR_CAJA_ASIGNA=:gi_caja and clave= :ls_clave and FUNCIONARIO.NOM_FUNCIONARIO=:ls_cajero and
      PV_CAJA.COD_FUNCIONARIO = FUNCIONARIO.COD_FUNCIONARIO and (pv_caja.cod_compania = :gs_cod_compania);

*/
gi_cod_funcionario=li_cajero

if is_tipo_cierre = 'previo' then
	// verificar si existen notas de venta pendientes
	SELECT count(*) into :nr_tickets	 FROM pv_nota_venta  
   WHERE (pv_nota_venta.cod_compania = :ls_com) AND (pv_nota_venta.nr_caja = :li_caja) AND
     (convert(char(10),pv_nota_venta.fecha_emision,111) = :ls_fecha) AND (pv_nota_venta.estado = 'C');
	//  and 	pv_nota_venta.cod_vendedor=:li_cajero;  
	  
	if isnull(nr_tickets) or nr_tickets = 0 then
		messagebox("Información","No existen notas pendientes de cierre",information!)
		return
	end if
	//	obtención de datos
	SELECT sum(isnull(pv_nota_venta.tot_con_iva,0)),sum(pv_nota_venta.tot_sin_iva),sum(pv_nota_venta.iva),
	sum(pv_nota_venta.dsto_con_iva),sum(pv_nota_venta.dsto_sin_iva),sum(pv_nota_venta.desc_adc),count(*),sum(isnull(pv_nota_venta.reten_iva,0)),sum(isnull(pv_nota_venta.reten_fte,0)),sum(isnull(pv_nota_venta.tot_compensado,0))
	INTO :tot_con_iva,:tot_sin_iva,:iva,:dsto_con_iva,:dsto_sin_iva,:desc_adc,:nr_tickets,:ldb_ret_iva,:ldb_ret_fte,:tot_compensado
   FROM pv_nota_venta WHERE (pv_nota_venta.cod_compania = :ls_com) AND
	(pv_nota_venta.nr_caja = :li_caja) AND (convert(char(10),pv_nota_venta.fecha_emision,111) = :ls_fecha) AND 
	(pv_nota_venta.estado = 'C'); //  and pv_nota_venta.cod_vendedor=:li_cajero;  
	 if sqlca.sqlcode < 0 then
		messagebox("Información","No puedo obtener los totales de ventas~r~nConsulte a su proveedor del sistema.",information!)
		rollback;
		return 
	end if
	if isnull(tot_con_iva) then tot_con_iva = 0;if isnull(tot_sin_iva) then tot_sin_iva = 0;if isnull(iva) then iva = 0
	if isnull(tot_compensado) then tot_compensado = 0
     if isnull(ldb_ret_iva) then ldb_ret_iva = 0;if isnull(ldb_ret_fte) then ldb_ret_fte=0
	if isnull(dsto_con_iva) then dsto_con_iva = 0;if isnull(dsto_sin_iva) then dsto_sin_iva = 0
	
 	idb_descuento_total = dsto_con_iva + dsto_sin_iva
	
	  SELECT sum(pv_detalle_pago.monto)  INTO :lc_efectivo FROM pv_detalle_pago,pv_nota_venta
	  WHERE (pv_nota_venta.cod_compania = pv_detalle_pago.cod_compania) and  
	  (pv_nota_venta.NR_CAJA = pv_detalle_pago.NR_CAJA) AND
     (pv_nota_venta.numero = pv_detalle_pago.numero ) and ((pv_nota_venta.cod_compania = :ls_com) AND  
     (pv_nota_venta.nr_caja = :li_caja) and (pv_nota_venta.estado = 'C') AND ( pv_detalle_pago.forma_pago = 1)) AND (convert(char(10),pv_nota_venta.fecha_emision,111) = :ls_fecha)  and
	   pv_nota_venta.tipo_doc = pv_detalle_pago.tipo_doc  ; //and 	pv_nota_venta.cod_vendedor=:li_cajero;  
	 if sqlca.sqlcode < 0 or sqlca.sqlcode = 100 then
		messagebox("Información","No puedo obtener el total de efectivo~r~nConsulte a su proveedor del sistema.",information!)
		rollback;
		return 
	end if
	if isnull(lc_efectivo) then lc_efectivo=0
	//CHEQUE
   SELECT sum(pv_detalle_pago.monto) INTO :lc_cheque FROM pv_detalle_pago,pv_nota_venta  
   WHERE (pv_nota_venta.cod_compania = pv_detalle_pago.cod_compania) and
	  (pv_nota_venta.NR_CAJA = pv_detalle_pago.NR_CAJA) AND
   (pv_nota_venta.numero = pv_detalle_pago.numero) and ((pv_nota_venta.cod_compania = :ls_com) AND
   (pv_nota_venta.nr_caja = :li_caja) AND (convert(char(10),pv_nota_venta.fecha_emision,111) = :ls_fecha) AND
   (pv_nota_venta.estado = 'C') AND (pv_detalle_pago.forma_pago = 2)) and pv_nota_venta.tipo_doc = pv_detalle_pago.tipo_doc ;// and 	pv_nota_venta.cod_vendedor=:li_cajero;  
	if sqlca.sqlcode < 0 or sqlca.sqlcode = 100 then
		messagebox("Información","No puedo obtener el total de cheques~r~nConsulte a su proveedor del sistema.",information!)
		rollback;
		return 
	end if
	//TARJETA
   SELECT sum(pv_detalle_pago.monto) INTO :lc_tarjeta FROM pv_detalle_pago,pv_nota_venta  
   WHERE (pv_nota_venta.cod_compania = pv_detalle_pago.cod_compania) and
	  (pv_nota_venta.NR_CAJA = pv_detalle_pago.NR_CAJA) AND
   (pv_nota_venta.numero = pv_detalle_pago.numero) and ((pv_nota_venta.cod_compania = :ls_com) AND
   (pv_nota_venta.nr_caja = :li_caja) AND (convert(char(10),pv_nota_venta.fecha_emision,111) = :ls_fecha) AND
   (pv_nota_venta.estado = 'C') AND (pv_detalle_pago.forma_pago = 3)) and pv_nota_venta.tipo_doc = pv_detalle_pago.tipo_doc;//  and 	pv_nota_venta.cod_vendedor=:li_cajero;  
	if sqlca.sqlcode < 0 or sqlca.sqlcode = 100 then
		messagebox("Información","No puedo obtener el total de tarjetas~r~nConsulte a su proveedor del sistema.",information!)
		rollback;
		return 
	end if
	/////////para CREDITO
	SELECT sum(pv_detalle_pago.monto) INTO :lc_credito FROM pv_detalle_pago,pv_nota_venta  
   WHERE (pv_nota_venta.cod_compania = pv_detalle_pago.cod_compania) and
	  (pv_nota_venta.NR_CAJA = pv_detalle_pago.NR_CAJA) AND
   (pv_nota_venta.numero = pv_detalle_pago.numero) and ((pv_nota_venta.cod_compania = :ls_com) AND
   (pv_nota_venta.nr_caja = :li_caja) AND (convert(char(10),pv_nota_venta.fecha_emision,111) = :ls_fecha) AND
   (pv_nota_venta.estado = 'C') AND (pv_detalle_pago.forma_pago = 4)) and pv_nota_venta.tipo_doc = pv_detalle_pago.tipo_doc ; //and 	pv_nota_venta.cod_vendedor=:li_cajero; 
	if sqlca.sqlcode < 0 or sqlca.sqlcode = 100 then
		messagebox("Información","No puedo obtener el total de creditos~r~nConsulte a su proveedor del sistema.",information!)
		rollback;
		return 
	end if
	
	/////
	if isnull(lc_cheque) then lc_cheque = 0;if isnull(lc_efectivo) then lc_efectivo = 0;if isnull(lc_credito) then lc_credito = 0
   if isnull(lc_tarjeta) then lc_tarjeta = 0	
	SELECT count(*) INTO :li_existe  FROM pv_cierre_caja  
	WHERE ( pv_cierre_caja.cod_compania = :ls_com) AND (pv_cierre_caja.nr_caja = :li_caja) 
	AND (convert(char(10),pv_cierre_caja.fecha_cierre,111) = :ls_fecha) and pv_cierre_caja.estado = 'P' ;// and pv_cierre_caja.cod_funcionario=:gi_cod_funcionario;
	 if sqlca.sqlcode = 100 then
		messagebox("Información","No puedo verificar si existe un cierre de este día~r~nConsulte a su proveedor del sistema.",information!)
		rollback;
		return 
	 elseif sqlca.sqlcode < 0 then
		messagebox("Información","No 1 puedo obtener datos de cierre~r~nConsulte a su proveedor del sistema.",information!)
		rollback;
		return 
	end if
	
	if li_existe > 0 then
	  UPDATE pv_cierre_caja SET tot_con_iva = :tot_con_iva,tot_sin_iva = :tot_sin_iva,
	  dsto_con_iva = :dsto_con_iva,dsto_sin_iva = :dsto_sin_iva,iva = :iva,desc_adc= :desc_adc,
	  tot_efec = :lc_efectivo,tot_cheque = :lc_cheque,tot_tarjeta = :lc_tarjeta,tot_fisico_regis =0,tot_ret_fte= :ldb_ret_fte, nr_tickets= :nr_tickets,tot_credito= :lc_credito,tot_ret_iva= :ldb_ret_iva,tot_compensado=:tot_compensado
	  WHERE (pv_cierre_caja.cod_compania = :ls_com) AND (pv_cierre_caja.nr_caja = :li_caja) AND
	  (convert(char(10),pv_cierre_caja.fecha_cierre,111) = :ls_fecha) AND (pv_cierre_caja.estado = 'P') ;// and pv_cierre_caja.cod_funcionario=:li_cajero;  
		if sqlca.sqlcode < 0 then
			messagebox("Información","No puedo actualizar el cierre preliminar.~r~nConsulte a su proveedor del sistema",information!)
			rollback;
			return 
		end if
	else
		ldb_ret_fte=ldb_ret_fte
	  INSERT INTO pv_cierre_caja  
	  (cod_compania,nr_caja,fecha_cierre,cod_funcionario,nr_tickets,tot_con_iva,tot_sin_iva,dsto_con_iva,dsto_sin_iva,iva,tot_efec,tot_cheque,   
	  tot_tarjeta,tot_credito,tot_excento_iva,tot_fisico_regis,estado,desc_adc,tot_ret_iva,tot_ret_fte ,tot_compensado)  
	  VALUES (:ls_com,:li_caja,:ld_fecha,:li_cajero,:nr_tickets,:tot_con_iva,:tot_sin_iva,:dsto_con_iva,:dsto_sin_iva,:iva,:lc_efectivo,:lc_cheque,
	  :lc_tarjeta,:lc_credito,0,0,'P',:desc_adc,:ldb_ret_iva,:ldb_ret_fte,:tot_compensado);
	  if sqlca.sqlcode < 0 then
			messagebox("Información","No puedo registrar un cierre preliminar.~r~nConsulte a su proveedor del sistema",information!)
			rollback;
			return 
	  end if
	end if
	commit;
	opensheetwithparm(w_resumen_caja,em_1.text,w_principal,1,layered!)
	close(parent)	
else
	datetime ldt_f_cierre
	ldt_f_cierre = w_resumen_caja.dw_1.getitemdatetime(1,'fecha_cierre')
	if wf_asiento_contable(ldt_f_cierre) < 0 then	return
     tot_dinero =double(em_dinero.text)
     UPDATE pv_cierre_caja SET estado = 'C',tot_fisico_regis = :tot_dinero
	  WHERE (pv_cierre_caja.cod_compania = :ls_com) AND (pv_cierre_caja.nr_caja = :li_caja) AND
	  	  (convert(char(10),pv_cierre_caja.fecha_cierre,111) = :ls_fecha) AND (pv_cierre_caja.estado = 'P')	 ;
//			  	  pv_cierre_caja.cod_funcionario=:li_cajero and // aumento 08-abril-2009;
 
     ldb_efec= w_resumen_caja.dw_1.getitemnumber(1,"c_monto")
	  ldb_cheq= w_resumen_caja.dw_1.getitemnumber(2,"c_monto")

//     UPDATE forma_pago  
//     SET monto_caja_gen = monto_caja_gen + :ldb_efec
//	  where cod_forma_pago= 1;
//     if sqlca.sqlcode < 0 then
//			messagebox("Información","No puedo actualizar el efectivo",information!)
//			rollback;
//			return 
//	  end if  
//	  UPDATE forma_pago  
//	  SET monto_caja_gen = monto_caja_gen + :ldb_cheq
//	  where cod_forma_pago= 2 ;
//	  if sqlca.sqlcode < 0 then
//			messagebox("Información","No puedo actualizar el cheque",information!)
//			rollback;
//			return 
//	  end if
	  UPDATE pv_nota_venta  set estado = 'P',fecha_proceso = getdate(),tipo_comprob =:ii_tipo_comprobante ,nr_comprob = :il_nr_comprobante
	  WHERE (pv_nota_venta.cod_compania = :ls_com) AND (pv_nota_venta.nr_caja = :li_caja) AND
	  (convert(char(10),pv_nota_venta.fecha_emision,111) = :ls_fecha) AND (pv_nota_venta.estado = 'C')  ; //AND
//   	  pv_nota_venta.cod_vendedor=:li_cajero; // aumento 08-abril-2009;;
	  if sqlca.sqlcode < 0 then
		  messagebox("Información","No puedo cerrar notas de venta.~r~nConsulte a su proveedor del sistema",information!)
		  rollback;
		  return 
	  end if
     commit;
	  
	  // Desplegar comprobante
	  open(w_aplica_comprobante)
	  messagebox("Información","Caja Cerrada",information!)
	  close(w_resumen_caja)
	  close(parent)
end if
else
	messagebox("Atención","Ingrese los datos correctamente")
end if	

end event

type em_1 from editmask within w_cierre
integer x = 302
integer y = 200
integer width = 393
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datetimemask!
string mask = "dd/mm/yyyy"
end type

type sle_1 from singlelineedit within w_cierre
integer x = 1001
integer y = 68
integer width = 247
integer height = 92
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16776960
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event constructor;this.text = string(gi_caja,"00")
end event

type gb_1 from groupbox within w_cierre
integer x = 9
integer width = 1737
integer height = 580
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
end type

type gb_2 from groupbox within w_cierre
integer x = 64
integer y = 596
integer width = 1605
integer height = 580
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "CAJA:"
end type

