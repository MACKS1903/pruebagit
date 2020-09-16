$PBExportHeader$w_autoriza_registradora.srw
forward
global type w_autoriza_registradora from window
end type
type cb_3 from commandbutton within w_autoriza_registradora
end type
type dw_1 from datawindow within w_autoriza_registradora
end type
type ddplb_3 from dropdownpicturelistbox within w_autoriza_registradora
end type
type st_4 from statictext within w_autoriza_registradora
end type
type ddplb_1 from dropdownpicturelistbox within w_autoriza_registradora
end type
type st_3 from statictext within w_autoriza_registradora
end type
type dp_1 from datepicker within w_autoriza_registradora
end type
type pb_1 from picturebutton within w_autoriza_registradora
end type
type sle_usuario from singlelineedit within w_autoriza_registradora
end type
type st_2 from statictext within w_autoriza_registradora
end type
type cb_2 from commandbutton within w_autoriza_registradora
end type
type cb_1 from commandbutton within w_autoriza_registradora
end type
type st_1 from statictext within w_autoriza_registradora
end type
type sle_clave from singlelineedit within w_autoriza_registradora
end type
end forward

global type w_autoriza_registradora from window
integer x = 1001
integer y = 500
integer width = 1915
integer height = 628
boolean titlebar = true
string title = "Control de acceso: Punto de Venta MACKS 19 R2  ELECTRONICO"
boolean resizable = true
windowtype windowtype = response!
long backcolor = 16777215
windowanimationstyle openanimation = bottomroll!
integer animationtime = 50
cb_3 cb_3
dw_1 dw_1
ddplb_3 ddplb_3
st_4 st_4
ddplb_1 ddplb_1
st_3 st_3
dp_1 dp_1
pb_1 pb_1
sle_usuario sle_usuario
st_2 st_2
cb_2 cb_2
cb_1 cb_1
st_1 st_1
sle_clave sle_clave
end type
global w_autoriza_registradora w_autoriza_registradora

type variables

end variables

on w_autoriza_registradora.create
this.cb_3=create cb_3
this.dw_1=create dw_1
this.ddplb_3=create ddplb_3
this.st_4=create st_4
this.ddplb_1=create ddplb_1
this.st_3=create st_3
this.dp_1=create dp_1
this.pb_1=create pb_1
this.sle_usuario=create sle_usuario
this.st_2=create st_2
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_1=create st_1
this.sle_clave=create sle_clave
this.Control[]={this.cb_3,&
this.dw_1,&
this.ddplb_3,&
this.st_4,&
this.ddplb_1,&
this.st_3,&
this.dp_1,&
this.pb_1,&
this.sle_usuario,&
this.st_2,&
this.cb_2,&
this.cb_1,&
this.st_1,&
this.sle_clave}
end on

on w_autoriza_registradora.destroy
destroy(this.cb_3)
destroy(this.dw_1)
destroy(this.ddplb_3)
destroy(this.st_4)
destroy(this.ddplb_1)
destroy(this.st_3)
destroy(this.dp_1)
destroy(this.pb_1)
destroy(this.sle_usuario)
destroy(this.st_2)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.sle_clave)
end on

event deactivate;//closewithreturn(parent,0)
close(w_registradora)


end event

event open;integer i
string ls
for i=1 to dw_1.retrieve()
ls=dw_1.object.nombre[i]
ddplb_1.additem(ls)
next


end event

type cb_3 from commandbutton within w_autoriza_registradora
boolean visible = false
integer x = 64
integer y = 380
integer width = 78
integer height = 112
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "none"
end type

event clicked;string  ls,tipo
date dt_fecha

ls=f_claveacceso1(date(dt_fecha),tipo,gs_ruc,gs_ambiente,'001','001',gs_codigo,gs_emision)
ls=ls
end event

type dw_1 from datawindow within w_autoriza_registradora
boolean visible = false
integer x = 2057
integer y = 48
integer width = 1248
integer height = 164
integer taborder = 20
string title = "none"
string dataobject = "dd_subempresa"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type ddplb_3 from dropdownpicturelistbox within w_autoriza_registradora
integer x = 2062
integer y = 256
integer width = 480
integer height = 400
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
long picturemaskcolor = 536870912
end type

type st_4 from statictext within w_autoriza_registradora
integer x = 1385
integer y = 48
integer width = 434
integer height = 92
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 134217741
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type ddplb_1 from dropdownpicturelistbox within w_autoriza_registradora
integer x = 361
integer y = 44
integer width = 818
integer height = 400
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
borderstyle borderstyle = stylelowered!
string picturename[] = {"Box border_2!","BrowseClasses_2!","CheckStatus5_2!","Browse_2!"}
long picturemaskcolor = 536870912
end type

event selectionchanged;string ls_empresa
long li_seq
ls_empresa=TRIM(this.text)

select companias_detalle.subempresa
into :gs_subempresa
from companias_detalle
where companias_detalle.nombre=:ls_empresa ;

select bodega,estab,ptoemi,nr_caja
	into :gi_bodega,:gs_num_suc,:gs_emi,:gi_caja
     from companias_detalle
	  where subempresa=:gs_subempresa ;
	
	select pv_secuencia.seqno
	into :li_seq
	from pv_secuencia
	where nr_caja=:gi_caja and cod_compania='1' and tipo_movimiento='EV';

  st_4.text=string(li_seq)
if isnull(gs_subempresa) or gs_subempresa='' then
	messagebox("ATención","empresa no encontrada")
	return -1
end if
	


end event

type st_3 from statictext within w_autoriza_registradora
integer x = 14
integer y = 48
integer width = 329
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 10789024
boolean enabled = false
string text = "EMPRESA:"
boolean border = true
long bordercolor = 16711680
boolean focusrectangle = false
end type

type dp_1 from datepicker within w_autoriza_registradora
integer x = 1413
integer y = 236
integer width = 411
integer height = 92
integer taborder = 60
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2999-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2020-02-09"), Time("12:32:31.000000"))
integer textsize = -10
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type pb_1 from picturebutton within w_autoriza_registradora
integer x = 1673
integer y = 552
integer width = 402
integer height = 224
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
boolean originalsize = true
alignment htextalign = left!
end type

type sle_usuario from singlelineedit within w_autoriza_registradora
integer x = 357
integer y = 160
integer width = 1463
integer height = 72
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8421376
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event modified;cb_1.enabled = true
end event

type st_2 from statictext within w_autoriza_registradora
integer x = 18
integer y = 160
integer width = 329
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 10789024
boolean enabled = false
string text = "USUARIO :"
boolean border = true
long bordercolor = 16711680
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_autoriza_registradora
integer x = 1271
integer y = 368
integer width = 279
integer height = 140
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;//closewithreturn(parent,0)
//close (w_autoriza_registradora)/// ultimos cambios, si no sabe la clave de la registradora, se les cerrara el módulo

Halt Close
return		
//m_principal.m_insertar.enabled = false // 08-abril-2009



end event

type cb_1 from commandbutton within w_autoriza_registradora
integer x = 425
integer y = 360
integer width = 297
integer height = 148
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Aceptar"
boolean default = true
end type

event clicked;string ls_msg,ls_claveregis,ls_nombrefuncionario,ls_control
int li_fun,gi_intento
integer li_codtipotra,li_coddoc,li_control
date ld_fecha_actual
integer li_dia,li_mes,li_aio,li_dia_caduca,li_mes_caduca,li_anio_caduca
double gi_numseq
integer suma_actual, suma_caduca,suma_mesanio_actual,suma_mesanio_caduca,resta_periodos

ls_nombrefuncionario = sle_usuario.text //mio 07-abril-2009
ls_claveregis = sle_clave.text
if isnull(gs_subempresa) or gs_subempresa='' then
	messagebox("Atención","Seleccione la empresa a comenzar")
	return -1
end if	

//messagebox("caja",".. "+string(gi_caja))

//////// al 08-abril-2009//////
	SELECT FUNCIONARIO.COD_FUNCIONARIO INTO :li_fun
	FROM PV_CAJA,FUNCIONARIO
	WHERE NR_CAJA_ASIGNA=:gi_caja and claveregis = :ls_claveregis and FUNCIONARIO.NOM_FUNCIONARIO=:ls_nombrefuncionario and
      PV_CAJA.COD_FUNCIONARIO = FUNCIONARIO.COD_FUNCIONARIO and
		cod_compania = :gs_cod_compania ;
      if sqlca.sqlcode < 0 then
			ls_msg = sqlca.sqlerrtext 	
			messagebox("ERROR","En la obtención de informacion~r~n"+ls_msg,stopsign!)
			rollback; 
			sle_clave.text=""
			sle_usuario.text=""
			sle_usuario.setfocus()
			return 
		end if		
		gi_cod_funcionario=li_fun  //asigna el codigo del usuario
		ls_nombref=ls_nombrefuncionario  //04-junio-2009 
		gs_nomb_funcionario=ls_nombref
/*
////////antes del 07-abril-2009/////////
SELECT cod_funcionario INTO :li_fun FROM pv_caja 
WHERE cod_compania = :gs_cod_compania  
AND nr_caja = :gi_caja AND claveregis =:ls_claveregis;*/


////desde//////////// verifica cajas creadas y activas
         string ls_act
	if li_fun = 0 or isnull(li_fun)  then
	   messagebox("ERROR","El usuario o clave no esta autorizado",stopsign!)
	   sle_clave.text=""
	   sle_usuario.text=""
	   sle_usuario.setfocus()
	   rollback;               
	   return   
	 else		
		open (w_principal)             
      		ls_act=string(gi_caja)
            closewithreturn(parent,li_fun) 
		SetProfileString("pos.ini","POS","Prompt", ls_act)
	

END IF	
/*long handle

handle = OpenChannel("puntomacks",)
handle=handle
*/

	
	
	
	/*ulong l_handle
	string ls_wname
	
	ls_wname="Modulo:Punto de Venta"
	l_handle=FindWindowA(0,ls_wname)
	if isnull(l_handle) then l_handle=0
	
	if l_handle <> 0  then
			MessageBox("Información","PPPunto de venta ya está abierto",information!)
			Halt Close
		return				
	END IF	

*/
	
		/*
		li_dia=gi_caja
			 ld_fecha_actual=date(today())
           SELECT  estado, fecha_caducidad, autnew, numseq  INTO :ls_control,:ld_fecha_caducidad, :gs_autnew,:gi_numseq
           FROM    PV_SECUENCIA
           WHERE   nr_caja=:gi_caja and estado='A' and (coddoc=2 or coddoc=1); //and coddoc='2' and codtipotra<=8;
           if sqlca.sqlcode < 0 then
              ls_msg = sqlca.sqlerrtext 	
	           messagebox("ERROR","Error,obtener informacion asignación de cajas ~r~n"+ls_msg,stopsign!)
	           rollback; 
	           sle_clave.text=""
	           sle_usuario.text=""
	           sle_usuario.setfocus()
	           return 
           end if	
	
	     //messagebox("ld_fecha_caducidad"," ---- "+string(ld_fecha_caducidad))
		 
	    if gi_numseq >= 9999999 then
		     messagebox("Información","Caja excluida,su secuencial ha llegado al 9999999",stopsign!)
	        rollback; 
		     sle_clave.text=""
	        sle_usuario.text=""
	        sle_usuario.setfocus()
	        return 
	     else	  
			 
			  li_control = asc(mid(string(ls_control),1,1))	
			   				
			   if   ls_control <> 'A' then                //li_control=0  or isnull(ls_control) then
	            messagebox("Información","El Nro. de caja no esta creada (activa o renovada)",stopsign!)
	            rollback; 
					sle_clave.text=""
	            sle_usuario.text=""
	            sle_usuario.setfocus()
	            return 
				 else	
					date ld_control_fecha
						ld_control_fecha=	RelativeDate((ld_fecha_caducidad), -365)
						//messagebox("ld_control_fecha"," ---- "+string(ld_control_fecha))
						
						
					if (date(ld_fecha_actual)>date(ld_fecha_caducidad)) or (date(ld_fecha_actual)<date(ld_control_fecha)) then
					  messagebox("Información","La fecha, no corresponde al perido de autorización---> "+string(ld_fecha_actual))
					  sle_clave.text=""; sle_usuario.text="";sle_usuario.setfocus()
					  rollback;               
					  return												
							else
								
								end if	
					end if
            end if	
	end if
 	
*/						

end event

type st_1 from statictext within w_autoriza_registradora
integer x = 18
integer y = 256
integer width = 334
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 10789024
boolean enabled = false
string text = "CLAVE :"
boolean border = true
long bordercolor = 16711680
boolean focusrectangle = false
end type

type sle_clave from singlelineedit within w_autoriza_registradora
integer x = 357
integer y = 252
integer width = 805
integer height = 80
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8421376
boolean autohscroll = false
boolean password = true
borderstyle borderstyle = stylelowered!
end type

event modified;cb_1.enabled = true
end event

