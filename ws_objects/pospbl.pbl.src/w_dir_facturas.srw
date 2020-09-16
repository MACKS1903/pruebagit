$PBExportHeader$w_dir_facturas.srw
$PBExportComments$Directorio de clientes
forward
global type w_dir_facturas from window
end type
type sle_1 from u_std_sle_busqueda_sensitiva within w_dir_facturas
end type
type dw_1 from datawindow within w_dir_facturas
end type
end forward

global type w_dir_facturas from window
integer x = 823
integer y = 360
integer width = 2560
integer height = 1560
boolean titlebar = true
string title = "Listado de NV"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 79741120
sle_1 sle_1
dw_1 dw_1
end type
global w_dir_facturas w_dir_facturas

type variables

end variables

on w_dir_facturas.create
this.sle_1=create sle_1
this.dw_1=create dw_1
this.Control[]={this.sle_1,&
this.dw_1}
end on

on w_dir_facturas.destroy
destroy(this.sle_1)
destroy(this.dw_1)
end on

event open;dw_1.retrieve(gi_caja)
end event

type sle_1 from u_std_sle_busqueda_sensitiva within w_dir_facturas
event enter pbm_keydown
integer x = 14
integer y = 20
integer width = 1093
integer taborder = 10
integer weight = 700
fontcharset fontcharset = ansi!
end type

event enter;long ll_fila ,ll_i
ll_fila = dw_1.getselectedrow(0)
CHOOSE CASE key
	CASE  keyEnter!
		gs_nom_clie =dw_1.getitemstring(ll_fila,"nombre")
		gs_ruc_clie =dw_1.getitemstring(ll_fila,"ruc_ci")
		gs_piva =dw_1.getitemstring(ll_fila,"paga_iva")
		//gc_num_factura =dw_1.getitemnumber(ll_fila,"numero")
     	CloseWithReturn(Parent,dw_1.getitemnumber(ll_fila,"numero"))
//  window w
// w = parent.getactivesheet()

   

		

	CASE  KeyEscape!
		close(parent)
	CASE  KeyUpArrow!
		if ll_fila <=1 then return
		if ll_fila > 1 then 
			dw_1.selectrow(0, false);	dw_1.selectrow(ll_fila - 1, true);dw_1.scrolltorow(ll_fila - 1); TEXT = dw_1.getitemstring(ll_fila -1,"nombre")
			this.selecttext(1,len(TEXT))
		end if
	CASE  KeydownArrow!		
		if ll_fila = dw_1.rowcount() then return
		if ll_fila >= 1  then 
			dw_1.selectrow(0, false);	dw_1.selectrow(ll_fila + 1, true);dw_1.scrolltorow(ll_fila + 1);TEXT = dw_1.getitemstring(ll_fila + 1,"nombre")
			this.selecttext(1,len(TEXT))			
		end if
END CHOOSE
end event

event constructor;call super::constructor;uf_cambia_valor( 'nombre' , dw_1 )

end event

type dw_1 from datawindow within w_dir_facturas
integer y = 120
integer width = 2533
integer height = 1316
integer taborder = 10
string dataobject = "d_lista_nv"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;//idw_datawindow = dw_1
this.settransobject(SQLCA)
this.setrowfocusindicator(HAND!)
end event

event rowfocuschanged;this.selectrow(0,false)
this.selectrow(currentrow,true)
end event

event clicked;if row > 0 then
	sle_1.text = this.getitemstring(row,"nombre")
	this.isselected(row)
	sle_1.setfocus()
end if
end event

