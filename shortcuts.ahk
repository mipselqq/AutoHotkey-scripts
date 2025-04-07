#Requires AutoHotkey v2.0

!+q:: TerminateActiveWindow
!q:: CloseActiveWindow
!a:: MinimizeActiveWindow
!d:: MaximizeActiveWindow
!+s:: SleepPc
!+p:: ShutdownPc
!+r:: ReloadYourself
!w:: OpenRegularBrowserTab
!x:: GoNextBrowserTab
!z:: GoPrevBrowserTab

ReloadYourself := Reload

GoNextBrowserTab() {
    try {
        if (CheckIsBrowserActive()) {
            Send("^{tab}")
        }
    }
}

GoPrevBrowserTab() {
    try {
        if (CheckIsBrowserActive()) {
            Send("+^{tab}")
        }
    }
}

MinimizeActiveWindow() {
    try {
        WinMinimize("A")
    }
}

MaximizeActiveWindow() {
    try {
        WinMaximize("A")
    }
}

TerminateActiveWindow() {
    try {
        ProcessClose(GetActiveWindowPid())
    }
}

CloseActiveWindow() {
    try {
        if (CheckIsBrowserActive()) {
            CloseBrowserTab()
        } else {
            WinClose("A")
        }
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
    }
}

ShutdownPc() {
    try {
        Run("shutdown /s /f /t 0")
    }
}

GetActiveWindowPid() {
    try {
        return WinGetPID(WinGetID("A"))
    }
}

CheckIsBrowserActive() {
    try {
        processName := WinGetProcessName("A")

        return processName = "chrome.exe" || processName = "firefox.exe"
    }
}
