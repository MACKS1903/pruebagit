$PBExportHeader$w_licencia.srw
forward
global type w_licencia from window
end type
type st_clave from statictext within w_licencia
end type
type sle_registro from singlelineedit within w_licencia
end type
type sle_nombre from singlelineedit within w_licencia
end type
type ln_1 from line within w_licencia
end type
type cb_yes from commandbutton within w_licencia
end type
type cb_no from commandbutton within w_licencia
end type
type p_1 from picture within w_licencia
end type
end forward

global type w_licencia from window
integer x = 480
integer width = 2377
integer height = 2204
windowtype windowtype = response!
long backcolor = 12632256
st_clave st_clave
sle_registro sle_registro
sle_nombre sle_nombre
ln_1 ln_1
cb_yes cb_yes
cb_no cb_no
p_1 p_1
end type
global w_licencia w_licencia

on w_licencia.create
this.st_clave=create st_clave
this.sle_registro=create sle_registro
this.sle_nombre=create sle_nombre
this.ln_1=create ln_1
this.cb_yes=create cb_yes
this.cb_no=create cb_no
this.p_1=create p_1
this.Control[]={this.st_clave,&
this.sle_registro,&
this.sle_nombre,&
this.ln_1,&
this.cb_yes,&
this.cb_no,&
this.p_1}
end on

on w_licencia.destroy
destroy(this.st_clave)
destroy(this.sle_registro)
destroy(this.sle_nombre)
destroy(this.ln_1)
destroy(this.cb_yes)
destroy(this.cb_no)
destroy(this.p_1)
end on

event open;st_clave.text= gs_serial		
if gb_reinstalar then
	sle_nombre.text = gs_nombre
	sle_nombre.enabled = false
else
	sle_nombre.text = ''
	sle_nombre.enabled = true
end if
end event

type st_clave from statictext within w_licencia
integer x = 526
integer y = 1736
integer width = 1179
integer height = 72
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 15780518
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_registro from singlelineedit within w_licencia
integer x = 535
integer y = 2016
integer width = 800
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_nombre from singlelineedit within w_licencia
integer x = 526
integer y = 1864
integer width = 1170
integer height = 88
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type ln_1 from line within w_licencia
integer linethickness = 1
integer beginx = 32
integer beginy = 1368
integer endx = 37
integer endy = 1528
end type

type cb_yes from commandbutton within w_licencia
integer x = 1367
integer y = 2020
integer width = 434
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Acepto"
boolean default = true
end type

event clicked;string ls_nombre,ls_serie
Datetime ldt_fecha
long li_clie, li_cajero

ls_serie = st_clave.text
ls_nombre = sle_nombre.text

select getdate() into :ldt_fecha from sysfiles using gtr_master;

if gb_despues then
	if f_num_registro_desenc (st_clave.text) <>  sle_registro.text then
		Messagebox("Información","El numero de registro es incorrecto~r~n Revise su registro en el CD")
		return
	end if
else
	if f_num_registro (st_clave.text) <>  sle_registro.text then
		Messagebox("Información","El numero de registro es incorrecto~r~n Revise su registro en el CD")
		return
	end if
end if

if gs_serial <> '' then
	if gs_serial <> ls_serie then
		Messagebox("Información","El numero de serie es incorrecto~r~n Ingrese el CD correcto.")			
		return
	end if
end if

if gb_reinstalar = false then

	INSERT INTO syslabel  
		( name,form,typed,dated)  
	  VALUES ( :ls_nombre,:ls_serie,'P',:ldt_fecha)  using gtr_master;
	if gtr_master.sqlcode < 0 then
		Messagebox("Información","No es posible insertar información")
		Rollback;
		Return
	end if
end if
gs_serial = ls_serie
close(w_licencia)

// tomar el valor de la tabla de parametros
SELECT porcentaje_iva into :gc_iva from compania 
where (convert(char(2),cod_compania) = :gs_cod_compania) ;
if sqlca.sqlcode < 0 then
	messageBox ("Error","No puedo recuperar el porcentaje de iva~r~n"+sqlca.sqlerrtext)
	halt close
end if
gi_caja = Profileint ("pos.ini", "APLICACION","CAJA",0)
gs_ruc_matriz = ProfileString ("pos.ini", "APLICACION","RUC_MATRIZ",'')
gs_num_suc = Profilestring ("pos.ini","APLICACION","NUM_SUC",'')
gs_dir_matriz = Profilestring ("pos.ini", "APLICACION","DIR_MATRIZ",'')
gs_validez = Profilestring ("pos.ini", "APLICACION","VALIDEZ",'')
gs_modelo = profilestring("pos.ini","APLICACION","MODELO","")
gi_impresion = profileint("pos.ini","APLICACION","IMPRESION",0)
gi_bodega = Profileint ("pos.ini", "APLICACION","BODEGA",0)
SELECT count(*) INTO :li_clie FROM cliente  
WHERE (UPPER(cliente.nombre) = 'CASH') ;
if sqlca.sqlcode < 0 then
	messageBox ("Error","No pude recuperar el cliente CASH.~r~nIngréselos en el módulo de Mantenimineto")
	halt close
end if
if li_clie = 0 then
	messageBox ("Error","No pude recuperar el cliente CASH.~r~nIngréselos en el módulo de Mantenimineto")
	halt close
end if
if li_clie > 1 then
	messageBox ("Error","No pude haber mas de un cliente CASH.~r~nCorriga en el módulo de Mantenimineto")
	halt close
end if

select isnull (count (*), 0) into :li_cajero from funcionario
where tipo_funcionario in ('E','J') ;
if sqlca.sqlcode < 0 then
	messageBox ("Error","No pude recuperar los cajeros definidos.~r~nIngréselos en el módulo de Mantenimineto")
	halt close
end if
if li_cajero = 0 then
	messageBox ("Error","No existen cajeros definidos.~r~nIngréselos en el módulo de Mantenimineto")
	halt close
end if
SELECT funcionario.cod_funcionario,funcionario.nom_funcionario
INTO :gi_cod_funcionario,:gs_nomb_funcionario  
FROM funcionario, pv_caja  
WHERE ( funcionario.cod_funcionario = pv_caja.cod_funcionario ) and  
		( ( pv_caja.nr_caja = :gi_caja ))   ;
if sqlca.sqlcode < 0 then
	messageBox ("Error","No existen cajeros definidos.~r~nIngréselos en el módulo de Mantenimineto")
	halt close
end if

gi_paga_iva = Profileint ("pos.ini", "APLICACION","PAGA_IVA",0)
gs_decimales = profilestring("pos.ini","APLICACION","DECIMALES","S")
gs_sri = profilestring("pos.ini","APLICACION","SRI","")
if gi_caja = 0 then 
	messagebox("Error","No se ha definido el numero de caja en el Archivo POS.ini");
	halt close
end if		


open(w_principal)

FileDelete('C:\PUNTO\PUNTO.TXT')


end event

type cb_no from commandbutton within w_licencia
integer x = 1861
integer y = 2024
integer width = 448
integer height = 76
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Cancelar"
end type

event clicked;HALT CLOSE
end event

type p_1 from picture within w_licencia
integer x = 5
integer width = 2359
integer height = 2200
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

