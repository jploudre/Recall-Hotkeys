Setup()

SetTitleMatchMode, 2 ; Matches window titles by 'contains the title' instead of 'starts with the title". Looser matching.

#ifWinActive, Orchard Harvest LIS ; This command finds the active windo with "Orchard Harvest LIS" in the title
NumpadAdd:: ; This makes the number pad "+" key active
NumpadSub::DoublePopUpKiller() ; This makes the number pad "-" key active and tells it to follow the DouplePopUpKiller script

; This ends Window Specific Commands
#ifWinActive

DoublePopUpKiller(){
                WinGetText, WindowsText
                if InStr(WindowsText, "Order Patient Samples"){
                
                                ControlGetPos, ControlX, ControlY, ControlWidth, ControlHeight, , , , 
                                clickx := ControlX + ControlWidth - 80
                                clicky := ControlY + ControlHeight - 30
                                Click, %clickx%, %clicky% ; (Window Coordinates of Save Order)

                                                WinWait, Order Choice Information, , 5
                                                if (ErrorLevel = 0) {
                                                sleep, 100
                                                click, 517, 421 ; (Clicks "Okay" on Order Choice Information)

                                                WinWait, Confirm Labels, , 30
                                                if (ErrorLevel = 0) {
                                                sleep, 100
                                                click, 639, 318 ; (Clicks "Cancel" on Confirm Labels Screen)
						LogUsage("DoublePopUpKiller()")

                                                } else {
							LogUsage("DoublePopUpKiller()", "'Confirm Labels' didn't open in 30 seconds")
						}

                                                } else {
							LogUsage("DoublePopUpKiller()", "'Order Choice Information' didn't open in 5 seconds")
						}
                } else {
		LogUsage("DoublePopUpKiller()", "Didn't find 'Order Patient Samples'")
		}
}

return

Setup(){
    global telemetry_log, enable_logging
    #NoEnv
    
    telemetry_folder := "\\fcnjboss01\AHK_Telemetry$\" 
    telemetry_log := telemetry_folder . A_UserName . "-Usage.csv"
    enable_logging := True

    ifNotExist, %telemetry_log%
    {
    LogFileHeaders := "Year,Month,Day,Hour,User,Hotkey,Function,Error"
    FileAppend, %LogFileHeaders%`n, %telemetry_log%
    }
    Return
}

LogUsage(Function, Error=""){
global telemetry_log, enable_logging
ifExist, %telemetry_log% 
{
    if (enable_logging = True) {
        line_to_log := A_YYYY . "," A_MM . "," A_DD . "," A_Hour . "," A_UserName . "," A_ThisHotkey . "," Function . "," Error
        FileAppend, %line_to_log%`n, %telemetry_log%
    }
}
}
