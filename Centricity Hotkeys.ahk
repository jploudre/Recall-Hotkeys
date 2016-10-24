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

#e::
imageclick("registration")
Loop, 50 {
    CitrixSleep()
    IfWinActive, Warning -,
    {
        Send !{F4}
    }
    ImageSearch, , , 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, %A_ScriptDir%/files/appointments.png
    if (ErrorLevel = 0) {
        imageclick("appointments")
    }
	ImageSearch, , , 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, %A_ScriptDir%/files/appointments-selected.png
    if (ErrorLevel = 0) {
        ; Done
        break
    }
}
return

#s::
imageclick("append")
Citrixsleep()
Send .rfu{space}
Citrixsleep()
Send !s
return


#IfWinActive, Chart Desktop - ;###########################################################

;3 months Rename
F3::
location := CheckLocation()
if (location = "Chart-Desktop-Documents") {
	ChangeDocumentTitle(90)
    return
}
return

; 6 months Rename
F6::
location := CheckLocation()
if (location = "Chart-Desktop-Documents") {
	ChangeDocumentTitle(180)
    return
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
OpenFlag()
return

#r::
Imageclick("route-desktop")
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
    CitrixSleep()
    imageclick("chart-desktop")
}
else {
    Click    
}
return

#IfWinActive, Route Document - ;###########################################################

RButton::
MouseGetPos, xpos, ypos
; remove routing name
if ( 28 < xpos AND xpos < 515 AND 171 < ypos AND ypos < 255) { ; Routing Names area, right click
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
return

#IfWinActive, End Update - ;###########################################################

RButton::
MouseGetPos, xpos, ypos
; remove routing name
if ( 28 < xpos AND xpos < 515 AND 250 < ypos AND ypos < 331) { ; Routing Names area, right click
    Mouseclick, Left, %xpos%, %ypos%
    Citrixsleep()
    Send !m
}
; I'm Done
if ( 354 < xpos AND xpos < 444 AND 499 < ypos AND ypos < 520) { ; 'Route' button, right click
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

#r::
RouteToDesktop("Recall")
return

#IfWinActive, Patient Registration - ;###########################################################

/* ; Unreliable. 
#e::
Send !{e 2}
WinWaitActive, Find Recall -, , 5
If (ErrorLevel = 0){
    Send !n
}
return
*/

#IfWinActive, Find Recall - ;###########################################################
RButton::
MouseGetPos, xpos, ypos
; I'm Done
if ( 433 < xpos AND xpos < 491 AND 272 < ypos AND ypos < 292) { ; 'Close' button, right click
    Send !{F4}
    CitrixSleep()
    Send !{F4}
    CitrixSleep()
    imageclick("chart-desktop")
}
else {
    Click right
}
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
	ImageSearch, openiconx, openicony, 0, 0, %winwidth%, %winheight%, %A_ScriptDir%/files/open.png
	if ( 80 < openicony < 100) {
		ifWinActive, Chart Desktop -
		return "Chart-Desktop-Documents"
	}
    return
}

; Exits if image not found
ImageClick(imagename){
    CoordMode, Pixel, Screen
    CoordMode, Mouse, Screen
    ImagePathandName := A_ScriptDir . "\files\" . imagename . ".PNG"
    ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *n10 %ImagePathandName%
    if (ErrorLevel = 0) {
        Click, %FoundX%, %FoundY%
        CoordMode, Pixel, Window
        CoordMode, Mouse, Window
        return
    }
    
    CoordMode, Pixel, Window
    CoordMode, Mouse, Window
    ; If image is not found, do not continue Hotkey that called. 
    if (ErrorLevel = 1) {
    exit
    }
}

AfterRoutetoNextFlag(){
    CitrixSleep()
    CitrixSleep()
    IfWinActive, Chart Desktop -
    {
        citrixsleep()
        citrixsleep()
        imageclick("remove")
        Citrixsleep()
        Citrixsleep()
        OpenFlag() 
        exit
    }
    IfWinActive, View Alerts/Flags
        Send !{F4}
    IfWinActive, Care Alert Warning
        Send !c
    WinWaitActive, Chart -, , 10
    if (ErrorLevel = 0) {
        citrixsleep()
        citrixsleep()
        imageclick("chart-desktop")
        WinWaitActive, Chart Desktop - , , 10
        if (ErrorLevel = 0) {
            citrixsleep()
            citrixsleep()
            imageclick("remove")
            Citrixsleep()
            Citrixsleep()
            OpenFlag()
        }
    }
}

RouteToDesktop(desktopname){
	Send !n
	WinWaitActive, New Routing, , 5
    if (ErrorLevel = 0) {
        CitrixSleep()
        Send %desktopname% {enter}
        CitrixSleep()
        Click, 239 354
        exit
    }
}

OpenFlag(){
    imageclick("open-flag")
    WinWaitActive, View Alerts/Flags, , 20
    if (ErrorLevel = 0) {
        Citrixsleep()
        Citrixsleep()
        Send !{F4}
        citrixsleep()
        CoordMode, Pixel, Screen
        ImageSearch, , , 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, %A_ScriptDir%/files/chart.png
        CoordMode, Pixel, Window
        if (ErrorLevel = 0) {
            imageclick("chart")
        }
        CoordMode, Pixel, Screen
        ImageSearch, , , 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, %A_ScriptDir%/files/chart-alt.png
        CoordMode, Pixel, Window
        if (ErrorLevel = 0) {
            imageclick("chart-alt")
        }
        IfWinActive, Care Alert Warning
            Send !c
    }   
}

ChangeDocumentTitle(numberofdays){
    WinGetPos,,,winwidth,winheight,A
    ImageSearch, ClickX, ClickY, 400, 140, %winwidth%, %winheight%, %A_ScriptDir%/files/blue.png
    Mouseclick, Right, %ClickX%, %ClickY%
    CitrixSleep()
    CitrixSleep()
    Send {Down 7} {Enter}
    WinWaitActive, Edit Document Properties, , 5
    if (ErrorLevel = 0) {
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
}
