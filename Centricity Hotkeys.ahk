; Setup
CoordMode, Mouse, Window
#Persistent
SetKeyDelay, 30
SendMode Input
Menu, Tray, NoStandard
Menu, Tray, Add, Reload, ReloadMacro
Menu, Tray, Add, Exit, ExitScript
return

ExitScript:
ExitApp
return

ReloadMacro:
Reload
return

#IfWinActive, Chart - ;###########################################################

;Route
#r::
imageclick("route")
return

#IfWinActive, Chart Desktop - ;###########################################################

;3 months Rename
F3::
location := CheckLocation()
if (location = "Chart-Desktop-Documents") {
	ChangeDocumentTitle(90)
}
return

; 6 months Rename
F6::
location := CheckLocation()
if (location = "Chart-Desktop-Documents") {
	ChangeDocumentTitle(180)
}
return

; Signs with .rfu quicktext
#s::
location := CheckLocation()
if (location = "Chart-Desktop-Documents") {
	Send ^j
	Citrixsleep()
	Send .rfu{space}
	Citrixsleep()
	Send !s
}
return

;Open Flag
#o::
imageclick("open-flag")
WinWaitActive, View Alerts/Flags
citrixsleep()
citrixsleep()
Send !{F4}
return

#IfWinActive, New Recall - ;###########################################################

RButton::
MouseGetPos, xpos, ypos
if ( 217 < xpos AND xpos < 274 AND 357 < ypos AND ypos < 377) { ; 'OK' button, right click
    Mouseclick, Left, %xpos%, %ypos%
    Citrixsleep()
    Send !{F4}
    CitrixSleep()
    Send !{F4}
}
else {
    Click    
}
return

#IfWinActive, Route Document - ;###########################################################

RButton::
MouseGetPos, xpos, ypos
; remove routing name
if ( 28 < xpos AND xpos < 515 AND 168 < ypos AND ypos < 255) { ; Routing Names area, right click
    Mouseclick, Left, %xpos%, %ypos%
    Citrixsleep()
    Send !m
}
; I'm Done
if ( 373 < xpos AND xpos < 445 AND 310 < ypos AND ypos < 331) { ; 'Route' button, right click
    Mouseclick, Left, %xpos%, %ypos%
    AfterRoutetoNextFlag()
}
else {
    Click right
}
return

F1::
RouteToDesktop("January")
return
F2::
RouteToDesktop("February")
return
F3::
RouteToDesktop("March")
return
F4::
RouteToDesktop("April")
return
F5::
RouteToDesktop("May")
return
F6::
RouteToDesktop("June")
return
F7::
RouteToDesktop("July")
return
F8::
RouteToDesktop("August")
return
F9::
RouteToDesktop("September")
return
F10::
RouteToDesktop("October")
return
F11::
RouteToDesktop("November")
return
F12::
RouteToDesktop("December")
return

; For In Progress Note. Route to Recall Desktop, Delete Flag
#r::
RouteToDesktop("Recall")
Send !r
AfterRoutetoNextFlag()
return

; End of Window Specific Hotkeys.  #########################################
#IfWinActive

; Miscellaneous Functions ##############################

CitrixSleep(){
Sleep, 300
}
return

CheckLocation(){
	WinGetPos,,,winwidth,winheight,A
	ImageSearch, FoundX, FoundY, 0, 0, %winwidth%, %winheight%, %A_ScriptDir%/files/open.png
	if ( 80 < FoundY < 100) {
		ifWinActive, Chart Desktop -
		return "Chart-Desktop-Documents"
	}
}

ImageClick(imagename){
    CoordMode, Pixel, Screen
    CoordMode, Mouse, Screen
    ImagePathandName := A_ScriptDir . "\files\" . imagename . ".PNG"
    ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *n10 %ImagePathandName%
    if (ErrorLevel = 0) {
        Click, %FoundX%, %FoundY%
    }
    CoordMode, Pixel, Window
    CoordMode, Mouse, Window
    if (ErrorLevel > 0) {
    exit
    }
}

AfterRoutetoNextFlag(){
    WinWaitActive, Chart -
    citrixsleep()
    citrixsleep()
    imageclick("chart-desktop")
    WinWaitActive, Chart Desktop -
    citrixsleep()
    citrixsleep()
    imageclick("remove")
    Citrixsleep()
    Citrixsleep()
    imageclick("open-flag")
    WinWaitActive, View Alerts/Flags
    citrixsleep()
    citrixsleep()
    Send !{F4}
}

RouteToDesktop(desktopname){
	Send !n
	WinWaitActive, New Routing
	CitrixSleep()
	Send %desktopname% {enter}
	Click, 239 354
}

ChangeDocumentTitle(numberofdays){
    WinGetPos,,,winwidth,winheight,A
    ImageSearch, ClickX, ClickY, 400, 140, %winwidth%, %winheight%, %A_ScriptDir%/files/blue.png
    Mouseclick, Right, %ClickX%, %ClickY%
    CitrixSleep()
    CitrixSleep()
    Send {Down 7} {Enter}
    WinWaitActive, Edit Document Properties
    CitrixSleep()
    ; Focus on the Title Field
    Mouseclick, Left, 105, 249
    CitrixSleep()
    today = 
    EnvAdd, today, %numberofdays%, days
    FormatTime, upcomingvisit, %today%, M-yyyy
    FormatTime, upcomingdaynumber, today, d
    if (upcomingdaynumber <15)
        mailingofmonth := "1st"
    else
        mailingofmonth := "2nd"
    Send [%upcomingvisit% - %mailingofmonth%]{Space}
    CitrixSleep()
    Send {Enter}
    exit
}