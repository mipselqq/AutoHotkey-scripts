#Requires AutoHotkey v2.0

try {
    !+q:: TerminateActiveWindow
    !q:: CloseActiveWindow
    !a:: MinimizeActiveWindow
    !d:: MaximizeActiveWindow
    !+s:: SleepPc
    !+p:: ShutdownPc
    !b:: Run BROWSER_APP_PATH
    !c:: Run "powershell"
    !+r:: Reload()
    !w:: OpenRegularBrowserTab()
} catch {
}

VPN_BUTTON_X := 200
VPN_BUTTON_Y := 168
VPN_WINDOW_NAME := "AmneziaVPNZ"

BROWSER_APP_PATH := "C:\Program Files\Google\Chrome\Application\chrome.exe"

MinimizeActiveWindow() {
    WinMinimize("A")
}

MaximizeActiveWindow() {
    WinMaximize("A")
}

TerminateActiveWindow() {
    ProcessClose(GetActiveWindowPid())
}

CloseActiveWindow() {
    processName := WinGetProcessName("A")

    if (processName = "chrome.exe" || processName = "firefox.exe") {
        CloseBrowserTab()
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
    DllCall("PowrProf\SetSuspendState", "Int", 0, "Int", 0, "Int", 0)
}

ShutdownPc() {
    Run("shutdown /s /f /t 0")
}

SetActiveWindowPriority(priority) {
    ProcessSetPriority(priority, GetActiveWindowPid())
}

GetActiveWindowPid() {
    return WinGetPID(WinGetID("A"))
}
