﻿#Requires AutoHotkey v2.0

!+q:: TerminateActiveWindow
!q:: CloseActiveWindow
!a:: MinimizeActiveWindow
!+s::Sleep
!+p:: Shutdown
!0:: SetActiveWindowPriority "High"
!9:: SetActiveWindowPriority "Normal"
!8:: SetActiveWindowPriority "Low"
!v:: RunApp "C:\Program Files\AmneziaVPN\AmneziaVPN.exe"
!m:: RunApp "C:\Users\mipse\AppData\Local\Programs\YandexMusic\Яндекс Музыка.exe"
!c:: Run "powershell"
!+r:: Reload()
!w:: OpenRegularBrowserTab()

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

Sleep() {
    try {
        DllCall("PowrProf\SetSuspendState", "Int", 0, "Int", 0, "Int", 0)
    } catch {
        MsgBox("ERROR: Failed to put the computer to sleep.")
    }
}

Shutdown() {
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

RunApp(path) {
    try {
        Run(path)
    } catch {
        MsgBox("ERROR: Failed to run " path ".")
    }
}
