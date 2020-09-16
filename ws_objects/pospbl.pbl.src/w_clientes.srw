$PBExportHeader$w_clientes.srw
$PBExportComments$Mantenimiento de clientes
forward
global type w_clientes from window
end type
type dw_2 from datawindow within w_clientes
end type
type cb_2 from commandbutton within w_clientes
end type
type dw_1 from datawindow within w_clientes
end type
type txtcomport from singlelineedit within w_clientes
end type
type txtmessage from singlelineedit within w_clientes
end type
type txtmobilenumber from singlelineedit within w_clientes
end type
type cb_1 from commandbutton within w_clientes
end type
type dw_lista_cliente from datawindow within w_clientes
end type
type dw_datos from datawindow within w_clientes
end type
end forward

global type w_clientes from window
integer x = 823
integer y = 360
integer width = 3195
integer height = 1716
boolean titlebar = true
string title = "Seleccione un cliente"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 79741120
event insertar ( )
event eliminar ( )
event grabar ( )
dw_2 dw_2
cb_2 cb_2
dw_1 dw_1
txtcomport txtcomport
txtmessage txtmessage
txtmobilenumber txtmobilenumber
cb_1 cb_1
dw_lista_cliente dw_lista_cliente
dw_datos dw_datos
end type
global w_clientes w_clientes

event insertar;long ll_fila

if dw_datos.accepttext() < 0 then return 
dw_datos.reset()
ll_fila  = dw_datos.insertrow(0)

//dw_lista_cliente.scrolltorow(ll_fila)
dw_datos.setfocus()
dw_datos.setcolumn('nombre')
end event

event eliminar;dw_datos.deleterow(dw_datos.getrow())
end event

event grabar();


IF dw_datos.update() > 0 then
MESSAGEBOX("Atención","Registro Realizado")
commit;
end if
end event

on w_clientes.create
this.dw_2=create dw_2
this.cb_2=create cb_2
this.dw_1=create dw_1
this.txtcomport=create txtcomport
this.txtmessage=create txtmessage
this.txtmobilenumber=create txtmobilenumber
this.cb_1=create cb_1
this.dw_lista_cliente=create dw_lista_cliente
this.dw_datos=create dw_datos
this.Control[]={this.dw_2,&
this.cb_2,&
this.dw_1,&
this.txtcomport,&
this.txtmessage,&
this.txtmobilenumber,&
this.cb_1,&
this.dw_lista_cliente,&
this.dw_datos}
end on

on w_clientes.destroy
destroy(this.dw_2)
destroy(this.cb_2)
destroy(this.dw_1)
destroy(this.txtcomport)
destroy(this.txtmessage)
destroy(this.txtmobilenumber)
destroy(this.cb_1)
destroy(this.dw_lista_cliente)
destroy(this.dw_datos)
end on

event open;dw_lista_cliente.settransobject(sqlca)
dw_lista_cliente.retrieve()
dw_datos.setfocus()

end event

event key;CHOOSE CASE key
	CASE keyF7!
		this.event insertar()
	CASE  keyF6!
		this.event eliminar()
	CASE  keyF12!
		this.event grabar()
END CHOOSE

end event

type dw_2 from datawindow within w_clientes
boolean visible = false
integer x = 2354
integer y = 1324
integer width = 686
integer height = 408
integer taborder = 40
string title = "none"
string dataobject = "d_diario_notas_Act"
boolean livescroll = true
borderstyle borderstyle = styleshadowbox!
end type

event constructor;this.settransobject(sqlca)
end event

type cb_2 from commandbutton within w_clientes
boolean visible = false
integer x = 59
integer y = 1532
integer width = 169
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Verifique RUC Cliente"
end type

event clicked;integer i,cuenta,j
long li_cli
string ls_tp_id,ls_ruc,ls_msg,ls_tp_id_cli
/*
for i=1 to dw_1.retrieve()
	ls_tp_id=dw_1.object.tp_id_cli[i]
	ls_ruc=dw_1.object.ruc_ci[i]
	li_cli=dw_1.object.cod_cliente[i]
	if isnull(ls_tp_id) or ls_tp_id='' then
		cuenta=len(trim(ls_ruc))
		if cuenta=10 then
			dw_1.object.tp_id_cli[i]='C'
		end if	
		if cuenta=13 then
			dw_1.object.tp_id_cli[i]='R'
		end if	
	end if	  //tp_id_cli
	dw_1.accepttext()
	if ((dw_1.object.tp_id_cli[i]='C' ) or (integer(mid(dw_1.object.ruc_ci[i],3,1)) < 6)) then
		j=f_digito_verificador( dw_1.object.ruc_ci[i],dw_1.object.tp_id_cli[i] )
	else
      j=f_digito_verificador69( dw_1.object.ruc_ci[i],dw_1.object.tp_id_cli[i] ) 		
	end if	
	
	if j > 0 then
    update pv_nota_venta
	 set validado='S'
	 from pv_nota_venta
	 where pv_nota_venta.C_I_O_RUC=:ls_ruc ;
	 if sqlca.sqlcode < 0 then
			ls_msg = sqlca.sqlerrtext
			rollback;
			messagebox("Error","No actualizo la validación del RUc en notade venta: "+ls_msg,exclamation!)
			return -1
	end if
	commit;
	    end if		
		
	
next	
dw_1.update()
commit;


messagebox("Atención","termino 1")
*/
//para clientes ingresados directo
for i=1 to dw_2.retrieve()
	j=0
	ls_ruc=dw_2.object.c_i_o_ruc[i]
	
	cuenta=len(trim(ls_ruc))
		if cuenta=10 then
			ls_tp_id_cli='C'
		else
		if cuenta=13 then
			ls_tp_id_cli='R'
		else
			ls_tp_id_cli=' '
		end if	
     	end if

	if   ls_tp_id_cli='C'  or (integer(mid(ls_ruc,3,1)) < 6) then
	j=f_digito_verificador( ls_ruc,ls_tp_id_cli)
	else
		if  ls_tp_id_cli='R' then
		      j=f_digito_verificador69( ls_ruc,ls_tp_id_cli) 		
	end if	
    end if
	 if j>0 then
		dw_2.object.validado[i]='S'
	 end if	
	 dw_2.update()

		
next

COMMIT;
messagebox("Atención","termino 2")
end event

type dw_1 from datawindow within w_clientes
boolean visible = false
integer x = 27
integer y = 1160
integer width = 2263
integer height = 400
integer taborder = 20
string title = "none"
string dataobject = "d_lista_cliente1"
boolean livescroll = true
borderstyle borderstyle = styleshadowbox!
end type

event constructor;this.settransobject(SQLCA)
end event

type txtcomport from singlelineedit within w_clientes
boolean visible = false
integer x = 1911
integer y = 140
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
end type

type txtmessage from singlelineedit within w_clientes
boolean visible = false
integer x = 1911
integer y = 252
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
end type

type txtmobilenumber from singlelineedit within w_clientes
boolean visible = false
integer x = 1911
integer y = 20
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_clientes
boolean visible = false
integer x = 2039
integer y = 384
integer width = 233
integer height = 68
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;// de http://groups.yahoo.com/neo/groups/PowerObject/conversations/topics/25239

integer li_FileNum
string mobileNumber
string Smsmessage
string comPort
string szEnd
string szCommand

mobilenumber = txtmobilenumber.text
Smsmessage = txtmessage.text
comPort = txtComPort.text

li_FileNum = FileOpen(comPort,TextMode!,Write!,LockWrite!,Append!)
if li_FileNum <> 1 then
	MessageBox("Sms Application" , "Unable to open com port....")
else 
	FileWriteEx(li_FileNum, "AT+CMGF=1")
	FileWriteEx(li_FileNum, "~n~r")
    szCommand="AT+CMGS=" 
	szCommand+="~""+mobilenumber+"~""
	FileWriteEx(li_FileNum, szCommand)
	FileWriteEx(li_FileNum, "~r") 
	FileWriteEx(li_FileNum, Smsmessage)
	szEnd = char(26)
	FileWriteEx(li_FileNum, szEnd)
	FileClose(li_FileNum) 
	messageBox("Sms Application","Sms send successfully....") 
//	txtmobilenumber.text = "" txtmessage.text = ""
End If


//este es de otro programador
/*integer li_FileNum
string mobileNumber
string Smsmessage
string comPort
string szEnd
string szCommand

mobilenumber = txtmobilenumber.text
Smsmessage = txtmessage.text
comPort = txtComPort.text
szEnd = char(26)

li_FileNum = FileOpen(comPort, TextMode!,Write!,LockWrite!,Append!)
if li_FileNum > 0 then 
  FileWriteEx(li_FileNum, "AT+CMGF=1")
  FileWriteEx(li_FileNum, "~n~r")
  szCommand = "AT+CMGS="
  szCommand += "~""+mobilenumber+"~""
  FileWriteEx(li_FileNum, szCommand)
  FileWriteEx(li_FileNum, "~r")
  FileWriteEx(li_FileNum, Smsmessage)
  FileWriteEx(li_FileNum, szEnd)
  FileClose(li_FileNum)
  MessageBox("Sms Application" , "Sms sent successfully....")
  txtmobilenumber.text = ""
  txtmessage.text = ""
else
  MessageBox("Sms Application" , "Unable to open comport....")
end if
*/
end event

type dw_lista_cliente from datawindow within w_clientes
event ue_tecla_funcion pbm_dwnkey
integer y = 4
integer width = 1801
integer height = 432
integer taborder = 10
string title = "none"
string dataobject = "d_lista_mant_cliente"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleshadowbox!
end type

event ue_tecla_funcion;CHOOSE CASE key
	CASE keyF7!
		parent.event insertar()
	CASE  keyF6!
		parent.event eliminar()
	CASE  keyF12!
		parent.event grabar()
END CHOOSE

end event

event clicked;if row > 0 then 
	this.selectrow( 0,false);	this.selectrow( row,true); this.scrolltorow(row)
end if
end event

event rowfocuschanged;if currentrow > 0 then 	dw_datos.scrolltorow(currentrow)

end event

type dw_datos from datawindow within w_clientes
event ue_tecla_funcion pbm_dwnkey
integer x = 9
integer y = 456
integer width = 2386
integer height = 648
integer taborder = 10
string title = "Mantenimiento de clientes"
string dataobject = "d_clientes"
boolean livescroll = true
borderstyle borderstyle = styleshadowbox!
end type

event ue_tecla_funcion;CHOOSE CASE key
	CASE keyF7!
		parent.event insertar()
	CASE  keyF6!
		parent.event eliminar()
	CASE  keyF12!
		parent.event grabar()
END CHOOSE

end event

event constructor;this.sharedata(dw_lista_cliente)
this.settransobject(SQLCA)

this.retrieve()
end event

event rowfocuschanged;if currentrow > 0 then 
	dw_lista_cliente.selectrow( 0,false)
	dw_lista_cliente.selectrow( currentrow,true)
end if
end event

event updatestart;integer li_datos,i,li_existe

string ls_ruc
string ls_buscar

ls_ruc=dw_datos.object.tp_id_cli[dw_datos.getrow()]

if isnull(ls_ruc) or ls_ruc='' then
	messagebox("Atencion","Tipo de identificacion no válida")
	return -1
	rollbacK;
	commit;
end iF

dw_datos.accepttext()

ls_buscar='%'+trim(dw_datos.object.ruc_ci[dw_datos.getrow()])+'%'
select count(cod_cliente)
into :li_existe
from cliente
where ruc_ci like:ls_buscar ;

if isnull(li_existe) then li_existe=0
if li_existe>0 then
	Messagebox("Información","El Cliente ya fue Ingresado",Information!)
	return -1
end if



	if ((dw_datos.object.tp_id_cli[dw_datos.getrow()]='C' ) or (integer(mid(dw_datos.object.ruc_ci[dw_datos.getrow()],3,1)) < 6)) then
		i=f_digito_verificador( dw_datos.object.ruc_ci[dw_datos.getrow()],dw_datos.object.tp_id_cli[dw_datos.getrow()] )
	else
      i=f_digito_verificador69( dw_datos.object.ruc_ci[dw_datos.getrow()],dw_datos.object.tp_id_cli[dw_datos.getrow()] ) 		
	end if	
	
	if i < 0 then
	messagebox("Atención","Ruc/CI mal ingresado")	
	ROLLBACK;
	RETURN -1
	commit;
	end if		

end event

