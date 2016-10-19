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

#IfWinActive, Update - ;###########################################################

#IfWinActive, End Update ;###########################################################

#IfWinActive, Chart - ;###########################################################

;Registration
#r::
ImageClick("registration")
return

#IfWinActive, Chart Desktop - ;###########################################################

F1::
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
    Send [ ] {Left 3}
    exit
}




return


return

#IfWinActive, Centricity Practice Solution Browser: ;###########################################################

; End of Window Specific Hotkeys.  #########################################
#IfWinActive

; Miscellaneous Functions ##############################

CitrixSleep(){
Sleep, 150
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

ImageClick(imagename, clicknumber:=1){
    CoordMode, Pixel, Screen
    CoordMode, Mouse, Screen
    ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, %A_ScriptDir%/files/%imagename%.png
    if (ErrorLevel = 0) {
        MouseClick, Left, %FoundX%, %FoundX%, clicknumber
    }
    CoordMode, Pixel, Window
    CoordMode, Mouse, Window
}
return