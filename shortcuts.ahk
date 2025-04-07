#Requires AutoHotkey v2.0

try {
    !+q:: TerminateActiveWindow
    !q:: CloseActiveWindow
    !a:: MinimizeActiveWindow
    !d:: MaximizeActiveWindow
    !+s:: SleepPc
    !+p:: ShutdownPc
    !+r:: Reload()
    !w:: OpenRegularBrowserTab()
    !x:: GoNextBrowserTab()
    !z:: GoPrevBrowserTab()
} catch {
}

GoNextBrowserTab() {
    if (CheckIsBrowserActive()) {
        Send("^{tab}")
    }
}

GoPrevBrowserTab() {
    if (CheckIsBrowserActive()) {
        Send("+^{tab}")
    }
}

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
    if (CheckIsBrowserActive()) {
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

GetActiveWindowPid() {
    return WinGetPID(WinGetID("A"))
}

CheckIsBrowserActive() {
    processName := WinGetProcessName("A")

    return processName = "chrome.exe" || processName = "firefox.exe"
}
