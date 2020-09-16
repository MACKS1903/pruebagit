$PBExportHeader$w_numerofactura.srw
$PBExportComments$Autorización de descuentos
forward
global type w_numerofactura from window
end type
type st_1 from statictext within w_numerofactura
end type
type sle_1 from singlelineedit within w_numerofactura
end type
type cb_2 from commandbutton within w_numerofactura
end type
type cb_1 from commandbutton within w_numerofactura
end type
end forward

global type w_numerofactura from window
integer x = 869
integer y = 692
integer width = 882
integer height = 328
windowtype windowtype = response!
long backcolor = 134217741
boolean righttoleft = true
st_1 st_1
sle_1 sle_1
cb_2 cb_2
cb_1 cb_1
end type
global w_numerofactura w_numerofactura

on w_numerofactura.create
this.st_1=create st_1
this.sle_1=create sle_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.st_1,&
this.sle_1,&
this.cb_2,&
this.cb_1}
end on

on w_numerofactura.destroy
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event open;string ls_f
COMMIT;
ls_f=Message.StringParm

sle_1.text=ls_f
end event

type st_1 from statictext within w_numerofactura
integer x = 123
integer y = 32
integer width = 562
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217741
string text = "No. FACTURA"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_numerofactura
integer x = 78
integer y = 96
integer width = 704
integer height = 96
integer taborder = 10
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 65535
boolean displayonly = true
borderstyle borderstyle = stylelowered!
boolean hideselection = false
end type

type cb_2 from commandbutton within w_numerofactura
boolean visible = false
integer x = 754
integer y = 188
integer width = 119
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;closewithreturn(parent,0)
end event

type cb_1 from commandbutton within w_numerofactura
integer x = 215
integer y = 196
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Aceptar"
boolean default = true
end type

event clicked;string ls_msg,ls_clave
long ll_fun,l_nm
integer li_existe

l_nm=long( sle_1.text)
select  count(*)
into :li_existe
from pv_nota_venta
where pv_nota_venta.nr_caja=:gi_caja and pv_nota_venta.numero=:l_nm   and pv_nota_venta.tipo_doc='EV'  and pv_nota_venta.cod_compania='1';

if isnull(li_existe) then li_existe=0
if li_existe > 0  then
   messagebox("Atención","Número ya Existe")
	return -1
	rollback;
else
	gs_factura = sle_1.text
end if	

 closewithreturn(parent,ll_fun)		

end event

