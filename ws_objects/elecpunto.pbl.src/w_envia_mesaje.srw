$PBExportHeader$w_envia_mesaje.srw
forward
global type w_envia_mesaje from window
end type
type cb_7 from commandbutton within w_envia_mesaje
end type
type sle_1 from singlelineedit within w_envia_mesaje
end type
type wb_2 from u_webbrowser within w_envia_mesaje
end type
type cb_6 from commandbutton within w_envia_mesaje
end type
type cb_5 from commandbutton within w_envia_mesaje
end type
type cb_4 from commandbutton within w_envia_mesaje
end type
type cb_3 from commandbutton within w_envia_mesaje
end type
type cb_2 from commandbutton within w_envia_mesaje
end type
type cb_gofoward from commandbutton within w_envia_mesaje
end type
type cb_goback from commandbutton within w_envia_mesaje
end type
type sle_status from singlelineedit within w_envia_mesaje
end type
type wb_1 from u_webbrowser within w_envia_mesaje
end type
type sle_adress from singlelineedit within w_envia_mesaje
end type
type cb_1 from commandbutton within w_envia_mesaje
end type
type sle_mensaje from singlelineedit within w_envia_mesaje
end type
type sle_numero from singlelineedit within w_envia_mesaje
end type
end forward

global type w_envia_mesaje from window
integer width = 6816
integer height = 3000
boolean titlebar = true
string title = "Envìa"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 16777215
string icon = "AppIcon!"
boolean center = true
cb_7 cb_7
sle_1 sle_1
wb_2 wb_2
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_gofoward cb_gofoward
cb_goback cb_goback
sle_status sle_status
wb_1 wb_1
sle_adress sle_adress
cb_1 cb_1
sle_mensaje sle_mensaje
sle_numero sle_numero
end type
global w_envia_mesaje w_envia_mesaje

type variables
integer il_item
end variables

on w_envia_mesaje.create
this.cb_7=create cb_7
this.sle_1=create sle_1
this.wb_2=create wb_2
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_gofoward=create cb_gofoward
this.cb_goback=create cb_goback
this.sle_status=create sle_status
this.wb_1=create wb_1
this.sle_adress=create sle_adress
this.cb_1=create cb_1
this.sle_mensaje=create sle_mensaje
this.sle_numero=create sle_numero
this.Control[]={this.cb_7,&
this.sle_1,&
this.wb_2,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_gofoward,&
this.cb_goback,&
this.sle_status,&
this.wb_1,&
this.sle_adress,&
this.cb_1,&
this.sle_mensaje,&
this.sle_numero}
end on

on w_envia_mesaje.destroy
destroy(this.cb_7)
destroy(this.sle_1)
destroy(this.wb_2)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_gofoward)
destroy(this.cb_goback)
destroy(this.sle_status)
destroy(this.wb_1)
destroy(this.sle_adress)
destroy(this.cb_1)
destroy(this.sle_mensaje)
destroy(this.sle_numero)
end on

event open;Integer li_rtn
//Li_rtn =Wb_1.Navigate("https://web.whatsapp.com/")

//"C:\Users\clien\AppData\Local\Temp\pbcefdownload\11.pdf"
 
 

end event

type cb_7 from commandbutton within w_envia_mesaje
integer x = 91
integer y = 176
integer width = 338
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
end type

event clicked;string ls_url,ls_telef,ls_mensaje
integer li,p,i
ls_telef=sle_numero.text
ls_mensaje=sle_mensaje.text
li=len(ls_mensaje)

for i=1 to li
if mid(ls_mensaje,i,1)=' '  then
ls_mensaje= Replace(ls_mensaje,i,1, "%20")
li=len(ls_mensaje)
end if
next

ls_mensaje=ls_mensaje
ls_url = 'https://wa.me/'+ls_telef+'?text='+ls_mensaje

inet lnet_test
lnet_test = create inet

lnet_test.hyperlinktourl(ls_url)

destroy lnet_test


end event

type sle_1 from singlelineedit within w_envia_mesaje
integer x = 4169
integer y = 396
integer width = 2043
integer height = 100
integer taborder = 40
integer textsize = -8
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type wb_2 from u_webbrowser within w_envia_mesaje
integer x = 4165
integer y = 500
integer width = 2057
integer height = 2092
end type

event addresschange;call super::addresschange;sle_adress.text=newurl
end event

type cb_6 from commandbutton within w_envia_mesaje
integer x = 2546
integer y = 292
integer width = 343
integer height = 100
integer taborder = 30
integer textsize = -8
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cerrar"
end type

event clicked;w_envia_mesaje.event close()
end event

type cb_5 from commandbutton within w_envia_mesaje
integer x = 2181
integer y = 292
integer width = 343
integer height = 100
integer taborder = 50
integer textsize = -8
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Zoom 250"
end type

event clicked;Wb_1.zoom(250)
end event

type cb_4 from commandbutton within w_envia_mesaje
integer x = 1815
integer y = 292
integer width = 343
integer height = 100
integer taborder = 20
integer textsize = -8
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Zoom 100"
end type

event clicked;Wb_1.zoom(100)
end event

type cb_3 from commandbutton within w_envia_mesaje
integer x = 1193
integer y = 292
integer width = 343
integer height = 100
integer taborder = 30
integer textsize = -8
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Whatsapp"
end type

event clicked;Wb_1.Navigate("https://web.whatsapp.com/")
//https://web.whatsapp.com/
//https://whatsapp://send?phone=5930969760138text=Hello%2C%20World!
//https://api.whatsapp.com/send?phone=5930969760138

//https://faq.whatsapp.com/es/android/26000030/?lang=en
end event

type cb_2 from commandbutton within w_envia_mesaje
integer x = 832
integer y = 292
integer width = 343
integer height = 100
integer taborder = 40
integer textsize = -8
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stop"
end type

event clicked;wb_1.stopNavigation()
end event

type cb_gofoward from commandbutton within w_envia_mesaje
integer x = 471
integer y = 292
integer width = 343
integer height = 100
integer taborder = 20
integer textsize = -8
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Adelante"
end type

event clicked;wb_1.goforward()
end event

type cb_goback from commandbutton within w_envia_mesaje
integer x = 96
integer y = 292
integer width = 343
integer height = 100
integer taborder = 30
integer textsize = -8
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Regresar"
end type

event clicked;wb_1.goback()
end event

type sle_status from singlelineedit within w_envia_mesaje
integer x = 96
integer y = 2580
integer width = 4270
integer height = 112
integer taborder = 30
integer textsize = -8
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 134217728
borderstyle borderstyle = stylelowered!
end type

type wb_1 from u_webbrowser within w_envia_mesaje
integer x = 96
integer y = 492
integer width = 4059
integer height = 2076
string defaulturl = "www.google.com.ec"
end type

event addresschange;call super::addresschange;sle_adress.text=newurl
end event

event downloadingstart;call super::downloadingstart;sle_status.text="Download Started : " +filename
il_item=itemid

wb_1.navigate( "http://localhost/11.pdf")

//Wb_2.Navigate(filename)
//wb_1.Refresh()
end event

event navigationerror;call super::navigationerror;sle_status.text="Error en Navegación: " +errortext
end event

event navigationprogressindex;call super::navigationprogressindex;if progressindex = 100 then
	sle_status.text="Completo"
else
	sle_status.text="Progress  "+ String(progressindex)+  " %"
end if	
end event

event navigationstart;call super::navigationstart;sle_status.text="Navegación Empezó"
end event

event navigationstatechanged;call super::navigationstatechanged;cb_goback.enabled=cangoback
cb_gofoward.enabled=cangoforward
end event

event pdfprintfinished;call super::pdfprintfinished;sle_status.text=" PDF print finalizado : "  + pdffile
end event

event titletextchanged;call super::titletextchanged;Parent.title=titletext
end event

event downloadingstatechanged;call super::downloadingstatechanged;// wb_1.CancelDownload(il_item)


//wb_1.Refresh()
end event

type sle_adress from singlelineedit within w_envia_mesaje
integer x = 101
integer y = 396
integer width = 4055
integer height = 100
integer taborder = 20
integer textsize = -8
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event modified;string ls_c

ls_c=sle_adress.text
Wb_1.Navigate(ls_c)
wb_1.Refresh()
end event

type cb_1 from commandbutton within w_envia_mesaje
integer x = 1010
integer y = 32
integer width = 343
integer height = 100
integer taborder = 30
integer textsize = -8
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "send"
end type

event clicked;string ls_tele
ls_tele='5930969760138'

Wb_1.Navigate("https://api.whatsapp.com/send?phone="+ls_tele)
end event

type sle_mensaje from singlelineedit within w_envia_mesaje
integer x = 1408
integer y = 24
integer width = 2702
integer height = 112
integer taborder = 10
integer textsize = -8
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string placeholder = "Mensaje"
end type

event modified;string ls

//ls="https://wa.me/"+sle_numero.text+"?text="+"Me%20interesa%20in%20el%20auto%20que%20vende"

ls="https://wa.me/5930969760138"
//0?text=Me%20interesa%20in%20el%20auto%20que%20vende"


//Wb_1.Navigate(ls)
end event

type sle_numero from singlelineedit within w_envia_mesaje
integer x = 82
integer y = 32
integer width = 823
integer height = 104
integer taborder = 20
integer textsize = -8
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string placeholder = "Teléfono:"
end type

