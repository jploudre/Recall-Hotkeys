; Setup
CoordMode, Mouse, Window
#Persistent
SetKeyDelay, 30
SendMode Input
Menu, Tray, NoStandard
Menu, Tray, Add, Exit, ExitScript
return

ExitScript:
ExitApp
return

#IfWinActive, Chart - ;###########################################################

;Route
#r::
imageclick("route")
return

#IfWinActive, Chart Desktop - ;###########################################################

;3 months
F3::
; In Chart Desktop, Documents
location := CheckLocation()
if (location = "Chart-Desktop-Documents") {
    WinGetPos,,,winwidth,winheight,A
    ImageSearch, ClickX, ClickY, 400, 140, %winwidth%, %winheight%, %A_ScriptDir%/files/blue.png
    Mouseclick, Right, %ClickX%, %ClickY%
    CitrixSleep()
    CitrixSleep()
    CitrixSleep()
    Send {Down 7} {Enter}
    WinWaitActive, Edit Document Properties
    CitrixSleep()
    ; Focus on the Title Field
    Mouseclick, Left, 105, 249
    CitrixSleep()
    today = 
    EnvAdd, today, 90, days
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
return

F6::
; In Chart Desktop, Documents
location := CheckLocation()
if (location = "Chart-Desktop-Documents") {
    WinGetPos,,,winwidth,winheight,A
    ImageSearch, ClickX, ClickY, 400, 140, %winwidth%, %winheight%, %A_ScriptDir%/files/blue.png
    Mouseclick, Right, %ClickX%, %ClickY%
    CitrixSleep()
    CitrixSleep()
    CitrixSleep()
    Send {Down 7} {Enter}
    WinWaitActive, Edit Document Properties
    CitrixSleep()
    ; Focus on the Title Field
    Mouseclick, Left, 105, 249
    CitrixSleep()
    today = 
    EnvAdd, today, 180, days
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
return

#+s::
Send ^j
Citrixsleep()
Send .rfu{space}
Citrixsleep()
Send !s
return

;Open Flag
#o::
imageclick("open-flag")
return

#IfWinActive, New Recall - ;###########################################################

LButton::
MouseGetPos, xpos, ypos
if ( 217 < xpos AND xpos < 274 AND 357 < ypos AND ypos < 377)
    {
    ; Click, then close windows.
    Mouseclick, Left, %xpos%, %ypos%
    SoundPlay, *64
    Citrixsleep()
    Send !{F4}
    CitrixSleep()
    Send !{F4}
    }
else
    {
    Click    
    }
return

#IfWinActive, Route Document - ;###########################################################

RButton::
MouseGetPos, xpos, ypos
; remove routing
if ( 28 < xpos AND xpos < 515 AND 168 < ypos AND ypos < 255)
    {
    ; Click, then close windows.
    Mouseclick, Left, %xpos%, %ypos%
    Citrixsleep()
    Send !m
    }
; I'm Done
if ( 373 < xpos AND xpos < 445 AND 310 < ypos AND ypos < 331)
    {
    ; Click, then close windows.
    Mouseclick, Left, %xpos%, %ypos%
    CitrixSleep()
    WinWaitActive, Chart -
    citrixsleep()
    imageclick("chart-desktop")
    WinWaitActive, Chart Desktop -
    citrixsleep()
    citrixsleep()
    citrixsleep()
    imageclick("remove")
    Citrixsleep()
    Citrixsleep()
    CitrixSleep()
    imageclick("open-flag")
    WinWaitActive, View Alerts/Flags
    citrixsleep()
    citrixsleep()
    citrixsleep()
    Send !{F4}
    }
else
    {
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
ImageSearch, FoundX, FoundY, 0, 0, %winwidth%, %winheight%, %A_ScriptDir%/files/open.png
if ( 80 < FoundY < 100) {
    ifWinActive, Chart Desktop -
    return "Chart-Desktop-Documents"
}
}
return

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
}
return