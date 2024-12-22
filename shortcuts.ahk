#Requires AutoHotkey v2.0

!+q:: TerminateActiveWindow
!q:: CloseActiveWindow
!a:: MinimizeActiveWindow
!+s:: SleepPc
!+p:: ShutdownPc
!0:: SetActiveWindowPriority "High"
!9:: SetActiveWindowPriority "Normal"
!8:: SetActiveWindowPriority "Low"
!v:: ToggleVpn
!m:: RunApp MUSIC_APP_PATH
; TODO: support wildcards
!d:: RunApp TELEGRAM_APP_PATH
!c:: Run "powershell"
!+r:: Reload()
!w:: OpenRegularBrowserTab()

VPN_BUTTON_X := 200
VPN_BUTTON_Y := 168
VPN_WINDOW_NAME := "AmneziaVPNZ"

TELEGRAM_APP_PATH :=
    "C:\Program Files\WindowsApps\TelegramMessengerLLP.TelegramDesktop_5.8.3.0_x64__t4vj0pshhgkwm\Telegram.exe"
MUSIC_APP_PATH := "C:\Users\mipse\AppData\Local\Programs\YandexMusic\Яндекс Музыка.exe"

ToggleVpn() {
    CoordMode("Pixel")
    RunApp("C:\Program Files\AmneziaVPN\AmneziaVPN.exe")
    WinWaitActive("AmneziaVPN")
    CoordMode("Mouse", "Screen")
    MouseGetPos(&prevMouseX, &prevMouseY)
    CoordMode("Mouse", "Client")
    MouseClick("L", VPN_BUTTON_X, VPN_BUTTON_Y)
    CoordMode("Mouse", "Screen")
    MouseMove(prevMouseX, prevMouseY)
    CloseActiveWindow()
}

MinimizeActiveWindow() {
    WinMinimize("A")
}

TerminateActiveWindow() {
    try {
        ProcessClose(GetActiveWindowPid())
    } catch {
        MsgBox("ERROR: Failed to terminate the process of the active window.")
    }
}

CloseActiveWindow() {
    processName := WinGetProcessName("A")

    if (processName = "chrome.exe" || processName = "firefox.exe") {
        CloseBrowserTab()
    } else if (processName = "Яндекс Музыка.exe") {
        WinHide("A")
    } else {
        WinClose("A")
    }
}

CloseBrowserTab() {
    Send "^{w}"
}

OpenRegularBrowserTab() {
    Send "^{t}"
}

SleepPc() {
    try {
        DllCall("PowrProf\SetSuspendState", "Int", 0, "Int", 0, "Int", 0)
    } catch {
        MsgBox("ERROR: Failed to put the computer to sleep.")
    }
}

ShutdownPc() {
    try {
        Run("shutdown /s /f /t 0")
    } catch {
        MsgBox("ERROR: Failed to shut down the computer.")
    }
}

SetActiveWindowPriority(priority) {
    try {
        if !ProcessSetPriority(priority, GetActiveWindowPid()) {
            MsgBox("ERROR: Failed to set process priority to " priority ".")
        }
    } catch {
        MsgBox("ERROR: Failed to set process priority to " priority ".")
    }
}

GetActiveWindowPid() {
    return WinGetPID(WinGetID("A"))
}

RunApp(path, &pid := unset) {
    try {
        Run(path, unset, unset, &pid)
    } catch {
        MsgBox("ERROR: Failed to run " path ".")
    }
}
