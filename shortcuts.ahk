#Requires AutoHotkey v2.0
#SingleInstance Force

^!+p:: Shutdown(9)
^!+o:: DllCall("PowrProf\SetSuspendState", "Int", 0, "Int", 0, "Int", 0)
^!+i:: Shutdown(2)
!+c:: Reload()
!a:: WinMinimize("A")

!q::
{
    if WinActive("A")
        WinClose("A")
}
!+q::
{
    try
    {
        if WinGetProcessName("A") != "explorer.exe"
            ProcessClose(WinGetPID("A"))
    }
}

~Volume_Up:: SoundSetVolume("+2")
~Volume_Down:: SoundSetVolume("-2")
