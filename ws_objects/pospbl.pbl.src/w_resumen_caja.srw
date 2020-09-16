$PBExportHeader$w_resumen_caja.srw
$PBExportComments$Resumen diario de caja
forward
global type w_resumen_caja from window
end type
type dw_2 from datawindow within w_resumen_caja
end type
type pb_1 from picturebutton within w_resumen_caja
end type
type dw_1 from datawindow within w_resumen_caja
end type
end forward

global type w_resumen_caja from window
integer x = 823
integer y = 360
integer width = 2158
integer height = 1156
boolean titlebar = true
string title = "Resumen de Caja"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
event cerrar ( )
dw_2 dw_2
pb_1 pb_1
dw_1 dw_1
end type
global w_resumen_caja w_resumen_caja

event cerrar;close(this)
end event

event resize;dw_1.resize(dw_1.width,this.height -  150)
end event

on w_resumen_caja.create
this.dw_2=create dw_2
this.pb_1=create pb_1
this.dw_1=create dw_1
this.Control[]={this.dw_2,&
this.pb_1,&
this.dw_1}
end on

on w_resumen_caja.destroy
destroy(this.dw_2)
destroy(this.pb_1)
destroy(this.dw_1)
end on

event open;int  li_i,li_codtarj,li_num,li_cajero
string ls_fecha,ls_nomf,ls_cta
double ldb_totiva,ldb_totciva,ldb_totsiva,ldb_nticket,ldb_dstociva,ldb_compensado
double ldb_dstosiva,ldb_totefec,ldb_totcheq,ldb_totarj,lc_tarjeta,ldb_credito,ldb_ret_iva,ldb_ret_fte
datetime ld_fecha
ls_fecha= string(date(message.stringparm),'yyyy/mm/dd')
dw_2.retrieve()
li_cajero= gi_cod_funcionario   //aumento 08-abril-2009
dw_1.retrieve('1',gi_caja,ls_fecha)//,li_cajero)


SELECT fecha_cierre,nr_tickets,tot_con_iva,tot_sin_iva,   
dsto_con_iva,dsto_sin_iva,iva,tot_efec,tot_cheque,tot_tarjeta,
funcionario.nom_funcionario,tot_credito,tot_ret_iva,tot_ret_fte,tot_compensado
INTO :ld_fecha,:ldb_nticket,:ldb_totciva,:ldb_totsiva,:ldb_dstociva,
:ldb_dstosiva,:ldb_totiva,:ldb_totefec,:ldb_totcheq,:ldb_totarj,:ls_nomf,:ldb_credito,:ldb_ret_iva,:ldb_ret_fte,:ldb_compensado
FROM pv_cierre_caja,funcionario  
WHERE ( funcionario.cod_funcionario = pv_cierre_caja.cod_funcionario ) and  
(pv_cierre_caja.cod_compania = :ls_com) AND 
(pv_cierre_caja.nr_caja = :li_caja) AND  
convert(char(10),pv_cierre_caja.fecha_cierre,111) = :ls_fecha AND pv_cierre_caja.estado = 'P' and
pv_cierre_caja.cod_funcionario=:li_cajero  ;
if sqlca.sqlcode < 0 then
	messagebox("Error ","No puedo recuperar los datos de cierre"+sqlca.sqlerrtext,exclamation!)
	rollback;
	return -1
end if
for li_i= 1 to 2
   dw_1.insertrow(0)
   if li_i= 1 then 
	   dw_1.object.cod_monto[1]= 0
		dw_1.object.nom_monto[1]= 'EFECTIVO'
	elseif li_i = 2 then
		dw_1.object.cod_monto[2]= 0
      dw_1.object.nom_monto[2]= 'CHEQUES'
   end if
next
for li_i= 1 to dw_2.rowcount()
	dw_1.insertrow(0)
	dw_1.object.cod_monto[li_i + 2 ]= dw_2.object.cod_tarjeta[li_i]
  	dw_1.object.nom_monto[li_i + 2 ]= dw_2.object.nom_tarjeta[li_i]
   if isnull(dw_2.object.cnta_contable[li_i]) then
		Messagebox("Información","No se ha asignado cuenta contable a "+ string(dw_2.object.nom_tarjeta[li_i]), Information!)
		close(w_resumen_caja)
	else
 		dw_1.object.cnta[li_i + 2 ]= dw_2.object.cnta_contable[li_i]
	end if
next
ldb_ret_fte=ldb_ret_fte
dw_1.setitem(1,"nr_caja",li_caja)
dw_1.setitem(1,"nr_tickets",ldb_nticket)
dw_1.setitem(1,"fecha_cierre",ld_fecha)
dw_1.setitem(1,"nom_funcionario",ls_nomf)
dw_1.setitem(1,"tot_sin_iva",ldb_totsiva)
dw_1.setitem(1,"tot_con_iva",ldb_totciva)
dw_1.setitem(1,"tot_compensado",ldb_compensado)
dw_1.setitem(1,"dsto_sin_iva",ldb_dstosiva)
dw_1.setitem(1,"dsto_con_iva",ldb_dstociva)
dw_1.setitem(1,"iva",ldb_totiva)
dw_1.setitem(1,"tot_ret_fte",ldb_ret_fte)
dw_1.setitem(1,"tot_ret_iva",ldb_ret_iva)
dw_1.setitem(1,"c_monto",ldb_totefec)
dw_1.setitem(2,"c_monto",ldb_totcheq)

for li_i= 3 to dw_1.rowcount()
	li_codtarj= dw_1.object.cod_monto[li_i]
   SELECT sum(pv_detalle_pago.monto) INTO :lc_tarjeta FROM pv_detalle_pago,pv_nota_venta  
   WHERE (pv_nota_venta.cod_compania = pv_detalle_pago.cod_compania) and
  (pv_nota_venta.NR_CAJA = pv_detalle_pago.NR_CAJA) AND
   (pv_nota_venta.numero = pv_detalle_pago.numero) and ((pv_nota_venta.cod_compania = :ls_com) AND
   (pv_nota_venta.nr_caja = :li_caja) AND (convert(char(10),pv_nota_venta.fecha_emision,111) = :ls_fecha) AND
   (pv_nota_venta.estado = 'C') AND  (pv_detalle_pago.cod_tarjeta = :li_codtarj) AND 
	(pv_detalle_pago.forma_pago = 3));
//	pv_nota_venta.cod_vendedor=:li_cajero  and
	if sqlca.sqlcode < 0 or sqlca.sqlcode = 100 then
		messagebox("Información","No puedo obtener el total de tarjetas~r~nConsulte a su proveedor del sistema.",information!)
		rollback;
		return 
	end if
   if isnull(lc_tarjeta) then lc_tarjeta = 0	
   dw_1.setitem(li_i,"c_monto",lc_tarjeta)
next
integer li_comp
li_comp = integer(gs_cod_compania)
if ldb_credito > 0 then
	  SELECT compania.cnta_clientes  
    INTO :ls_cta  
    FROM compania  
   WHERE compania.cod_compania = :li_comp   ;
	if sqlca.sqlcode < 0 then
	messagebox("Error","No puedo recuperar la cuenta de cliente~r~n"+sqlca.sqlerrtext,exclamation!)
	rollback;
	return -1
end if
	
end if
li_num = dw_1.rowcount()
li_num = li_num + 1
dw_1.object.cod_monto[li_num]= 0
dw_1.object.nom_monto[li_num]= 'CUENTAS X COBRAR'
dw_1.setitem(li_num,"c_monto",ldb_credito)
dw_1.setitem(li_num,"cnta",ls_cta)
dw_1.setfocus()
end event

event key;if key = keyescape! then this.post event cerrar()
end event

event activate;m_principal.m_archivo.m_cierre.enabled = true
m_principal.m_archivo.m_cierrepreliminar.enabled = false
end event

event deactivate;m_principal.m_archivo.m_cierre.enabled = false
m_principal.m_archivo.m_cierrepreliminar.enabled = true
end event

type dw_2 from datawindow within w_resumen_caja
boolean visible = false
integer x = 1065
integer y = 248
integer width = 1051
integer height = 788
integer taborder = 30
string title = "none"
string dataobject = "d_lista_tarjeta_cnta"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject(sqlca)
end event

type pb_1 from picturebutton within w_resumen_caja
integer x = 1563
integer y = 40
integer width = 320
integer height = 216
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean default = true
string picturename = "C:\pbd\bmp\PRINTER.bmp"
alignment htextalign = left!
end type

event clicked;messagebox("Atención","Prepare la Impresora")
dw_1.print()
end event

type dw_1 from datawindow within w_resumen_caja
integer width = 1454
integer height = 1016
integer taborder = 10
string dataobject = "d_resumen_caja"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(SQLCA)
end event

