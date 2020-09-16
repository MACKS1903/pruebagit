$PBExportHeader$u_std_sle_busqueda_sensitiva.sru
$PBExportComments$Objeto de busqueda sensitiva
forward
global type u_std_sle_busqueda_sensitiva from singlelineedit
end type
end forward

global type u_std_sle_busqueda_sensitiva from singlelineedit
integer width = 1326
integer height = 88
integer taborder = 1
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
event ue_getchar pbm_char
end type
global u_std_sle_busqueda_sensitiva u_std_sle_busqueda_sensitiva

type variables
PRIVATE	datawindow	idw_datawindow
PUBLIC	string		is_campo_busqueda
end variables

forward prototypes
public subroutine uf_cambia_valor (string as_columna, ref datawindow as_dw)
end prototypes

event ue_getchar;string		ls_filtro
string		ls_caracter
long		ll_found_row
integer	li_num_chars

IF IsNull(idw_datawindow) OR IsNull(is_campo_busqueda)	THEN
	Messagebox('Error ue_sle_sensitivo','No existe un datawindow asignado para la busqueda sensitiva. Coloque el siguiente código ' + &
					' en el Evento CONSTRUCTOR del Objeto. ~r~ ~r~ uf_asigna_valor( "<nombre del campo a buscar>" ,<Objeto Datawindow> )' )
	RETURN	
END IF	
idw_datawindow.SetRedraw(FALSE)
ls_filtro			= This.Text
ls_caracter	= char(message.wordparm)

IF message.wordparm = 8   THEN  // BackSpace
	li_num_chars = Len(ls_filtro)
	IF li_num_chars > 0 THEN
		ls_filtro = Left(ls_filtro, li_num_chars -1)
		IF Len(ls_filtro) = 0 THEN
			idw_datawindow.SelectRow(0,FALSE)
			idw_datawindow.ScrollToRow(1)
			idw_datawindow.SelectRow(1, TRUE)
		END IF
	END IF	
END IF

CHOOSE CASE ls_caracter
	CASE	'a' TO 'z', 'A' TO 'Z' ,'0' TO '9','-'
		ls_filtro = ls_filtro + ls_caracter
END CHOOSE

IF	Len(ls_filtro) > 0	THEN
	ll_found_row = idw_datawindow.Find(is_campo_busqueda + ">='" + ls_filtro + "'" , 1, idw_datawindow.RowCount()) 
		IF ll_found_row > 0 THEN 
			idw_datawindow.SelectRow(0,FALSE)
			idw_datawindow.SelectRow(ll_found_row, TRUE)
			idw_datawindow.ScrollToRow(ll_found_row)
		END IF
ELSE
	idw_datawindow.SelectRow(0,FALSE)
	idw_datawindow.SelectRow(1, TRUE)
	idw_datawindow.ScrollToRow(1)
END IF
idw_datawindow.SetRedraw(TRUE)

end event

public subroutine uf_cambia_valor (string as_columna, ref datawindow as_dw);is_campo_busqueda	= as_columna 
idw_datawindow		= as_dw

idw_datawindow.SetSort('is_campo_busqueda a')

idw_datawindow.Sort()

end subroutine

event constructor;/*
	Objeto		:	u_std_sle_busqueda_sensitiva
	Autor			:	Victor Barba P
	Fecha			:	02/11/1997
	Proposito	:	Permite poder ubicar un registro dentro de un DW mediante el ingreso 
						de un argumento.  La Busqueda se realiza en linea.
	Nota			:	El campo por el cual se a especificado la busqueda debe estar ordenado. 
						Este objeto lo ordena al momento de llamar a la función uf_cambia_valor().
*/

SetNull(idw_datawindow)
SetNull(is_campo_busqueda)

/* Copiar este codigo y colocarlo en este evento con los parametros correspondientes
	uf_cambia_valor( <String Columna> , <Datawindow datawindow_a_buscar> )
	Ejemplo:
	uf_cambia_valor( 'dsc_producto' , dw_producto )
*/


end event

on u_std_sle_busqueda_sensitiva.create
end on

on u_std_sle_busqueda_sensitiva.destroy
end on

