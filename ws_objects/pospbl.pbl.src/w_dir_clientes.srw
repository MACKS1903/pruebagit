$PBExportHeader$w_dir_clientes.srw
$PBExportComments$Directorio de clientes
forward
global type w_dir_clientes from window
end type
type dw_2 from datawindow within w_dir_clientes
end type
type st_2 from statictext within w_dir_clientes
end type
type st_1 from statictext within w_dir_clientes
end type
type sle_1 from u_std_sle_busqueda_sensitiva within w_dir_clientes
end type
type dw_1 from datawindow within w_dir_clientes
end type
end forward

global type w_dir_clientes from window
integer x = 823
integer y = 360
integer width = 2345
integer height = 1688
boolean titlebar = true
string title = "Seleccione un cliente"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 134217730
integer transparency = 10
windowanimationstyle openanimation = topslide!
windowanimationstyle closeanimation = bottomslide!
dw_2 dw_2
st_2 st_2
st_1 st_1
sle_1 sle_1
dw_1 dw_1
end type
global w_dir_clientes w_dir_clientes

type variables

end variables

on w_dir_clientes.create
this.dw_2=create dw_2
this.st_2=create st_2
this.st_1=create st_1
this.sle_1=create sle_1
this.dw_1=create dw_1
this.Control[]={this.dw_2,&
this.st_2,&
this.st_1,&
this.sle_1,&
this.dw_1}
end on

on w_dir_clientes.destroy
destroy(this.dw_2)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.dw_1)
end on

event open;dw_1.retrieve()
dw_2.insertrow(0)
end event

type dw_2 from datawindow within w_dir_clientes
event enter pbm_dwnprocessenter
event escape pbm_dwnkey
integer x = 320
integer y = 28
integer width = 850
integer height = 88
integer taborder = 10
string title = "none"
string dataobject = "d_busquedaruc"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event enter;long ll_fila ,ll_i
ll_fila = dw_1.getselectedrow(0)
if ll_fila > 0 then
gs_nom_clie =dw_1.getitemstring(ll_fila,"nombre")
gs_ruc_clie =dw_1.getitemstring(ll_fila,"ruc_ci")
gs_piva =dw_1.getitemstring(ll_fila,"paga_iva")
gc_tipo_clie=dw_1.object.tp_id_cli[ll_fila]
if f_valida_ruc(gc_tipo_clie,gs_ruc_clie) < 0 then
	messagebox("","Actualice los datos del RUC/CI con el botón de Busqueda")
	return
end if	

if dw_1.object.direccion[ll_fila]='' or isnull(dw_1.object.direccion[ll_fila]) then
     	messagebox("","Actualice la dirección del Comprador el botón de Busqueda")
	return
end if	

if dw_1.object.direc_electronica[ll_fila]='' or isnull(dw_1.object.direc_electronica[ll_fila]) then
     	messagebox("","Actualice el correo con el botón de busqueda")
	return
end if	




CloseWithReturn(Parent,dw_1.getitemnumber(ll_fila,"cod_cliente"))
end if




end event

event escape;CHOOSE CASE key
	CASE  KeyEscape!
		close(parent)
END CHOOSE
end event

event editchanged;integer li_cadena,ll_row
string ls_dato

dw_1.selectrow(0,false)
if data <> "" then
	CHOOSE CASE dwo.name
		
		CASE "ruc_ci"
			dw_1.SetSort("ruc_ci A")
             dw_1.Sort()

			li_cadena = len(data)
					if  li_cadena = 1 then
				dw_1.setsort("ruc_ci A")
				dw_1.Sort()
			end if
 			ls_dato = "upper(mid(ruc_ci,1,len('"+data+"'))) =  '"+UPPER(data)+"'"
			
	END CHOOSE
	if dwo.name <> "barras" then
		ll_row = dw_1.Find(ls_dato,1,dw_1.rowcount())
		IF ll_row > 0 THEN
			dw_1.ScrollToRow(ll_row)
			dw_1.selectrow(ll_row,true)	
		end if
	end if
end if
end event

type st_2 from statictext within w_dir_clientes
integer x = 41
integer y = 152
integer width = 283
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 134217730
string text = "NOMBRE:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_dir_clientes
integer x = 32
integer y = 40
integer width = 261
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 134217730
string text = "RUC  :"
boolean focusrectangle = false
end type

type sle_1 from u_std_sle_busqueda_sensitiva within w_dir_clientes
event enter pbm_keydown
integer x = 325
integer y = 128
integer width = 1307
integer height = 80
integer taborder = 10
integer weight = 700
fontcharset fontcharset = ansi!
long textcolor = 134217741
end type

event enter;long ll_fila ,ll_i
ll_fila = dw_1.getselectedrow(0)
CHOOSE CASE key
	CASE  keyEnter!
		gs_nom_clie =dw_1.getitemstring(ll_fila,"nombre")
		gs_ruc_clie =dw_1.getitemstring(ll_fila,"ruc_ci")
				gs_piva =dw_1.getitemstring(ll_fila,"paga_iva")
		gc_tipo_clie=dw_1.getitemstring(ll_fila,"tp_id_cli")
		if f_valida_ruc(gc_tipo_clie,gs_ruc_clie) < 0 then
	messagebox("","Actualice los datos del RUC/CI con el botón de Busqueda")
	return
end if
	if dw_1.object.direccion[ll_fila]='' or isnull(dw_1.object.direccion[ll_fila]) then
     	messagebox("","Actualice la dirección del Comprador el botón de Busqueda")
	return
end if	

if dw_1.object.direc_electronica[ll_fila]='' or isnull(dw_1.object.direc_electronica[ll_fila]) then
     	messagebox("","Actualice el correo con el botón de busqueda")
	return
end if	

	

	
   	CloseWithReturn(Parent,dw_1.getitemnumber(ll_fila,"cod_cliente"))
	
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

type dw_1 from datawindow within w_dir_clientes
integer y = 236
integer width = 2203
integer height = 1316
integer taborder = 10
string dataobject = "d_lista_cliente"
boolean hscrollbar = true
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

event clicked;String ls_old_sort, ls_column 
Char lc_sort 

/* Chequea cuando el usuario hace click en la cabecera */ 

IF Right(dwo.Name,2) = "_t" THEN 

   ls_column = LEFT(dwo.Name, LEN(String(dwo.Name)) - 2) 

   /* Guarda la última ordenación, si hubiera alguna*/ 

   ls_old_sort = dw_1.Describe("Datawindow.Table.sort") 

   /* Chequea cuando préviamente se ordenó una columna y en la que se hace click actualmente es la misma o no. Si es la misma, entonces se chequea el orden de ordenación del ordenamiento anterior (A - Ascendente, D - Descendente) y lo cambia. Si las columnas odenadas no son las mismas, las ordena en orden ascendente. */ 

 

   IF ls_column = LEFT(ls_old_sort, LEN(ls_old_sort) - 2) THEN 

      lc_sort = RIGHT(ls_old_sort, 1) 

      IF lc_sort = 'A' THEN 

         lc_sort = 'D' 

      ELSE 

         lc_sort = 'A' 

      END IF 

      dw_1.SetSort(ls_column+" "+lc_sort) 

   ELSE 

      dw_1.SetSort(ls_column+" A") 

   END IF 

   dw_1.Sort() 

END IF 

if row > 0 then
	sle_1.text = this.getitemstring(row,"nombre")
	this.isselected(row)
	sle_1.setfocus()
end if
end event

