#Requires AutoHotkey v2.0

try {
    !+q:: TerminateActiveWindow
    !q:: CloseActiveWindow
    !a:: MinimizeActiveWindow
    !+s:: SleepPc
    !+p:: ShutdownPc
    !0:: SetActiveWindowPriority "High"
    !9:: SetActiveWindowPriority "Normal"
    !8:: SetActiveWindowPriority "Low"
    !v:: ToggleVpn
    !m:: Run MUSIC_APP_PATH
    ; TODO: support wildcards
    !d:: Run TELEGRAM_APP_PATH
    !b:: Run BROWSER_APP_PATH
    !c:: Run "powershell"
    !+r:: Reload()
    !w:: OpenRegularBrowserTab()
} catch {
}

VPN_BUTTON_X := 200
VPN_BUTTON_Y := 168
VPN_WINDOW_NAME := "AmneziaVPNZ"

TELEGRAM_APP_PATH :=
    "C:\Program Files\WindowsApps\TelegramMessengerLLP.TelegramDesktop_5.8.3.0_x64__t4vj0pshhgkwm\Telegram.exe"
MUSIC_APP_PATH := "C:\Users\mipse\AppData\Local\Programs\YandexMusic\Яндекс Музыка.exe"
BROWSER_APP_PATH := "C:\Program Files\Google\Chrome\Application\chrome.exe"

ToggleVpn() {
    ShowVpnStatus()

    Run("C:\Program Files\AmneziaVPN\AmneziaVPN.exe")
    WinWaitActive("AmneziaVPN")

    CoordMode("Mouse", "Screen")
    MouseGetPos(&prevMouseX, &prevMouseY)

    CoordMode("Mouse", "Client")
    MouseClick("L", VPN_BUTTON_X, VPN_BUTTON_Y)

    CoordMode("Mouse", "Screen")
    MouseMove(prevMouseX, prevMouseY)
    CloseActiveWindow()

    HideVpnStatus()
}

global isVpnOn := false
ShowVpnStatus() {
    global isVpnOn

    CoordMode("Mouse", "Screen")
    if isVpnOn {
        ToolTip("On", A_ScreenWidth / 2, A_ScreenHeight)
        isVpnOn := false
    } else {
        ToolTip("Off", A_ScreenWidth / 2, A_ScreenHeight)
        isVpnOn := true
    }
}

HideVpnStatus() {
    ToolTip("")
}

MinimizeActiveWindow() {
    WinMinimize("A")
}

TerminateActiveWindow() {
    ProcessClose(GetActiveWindowPid())
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
