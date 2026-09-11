#Requires AutoHotkey v2.0
#SingleInstance Force

; Keyboard layout identifiers
EN := "00000409"
RU := "00000419"
JA := "00000411"

; Current EN/RU layout
currentLayout := EN

; Left Shift + Left Alt: toggle between English and Russian
LShift & LAlt::
{
    global currentLayout, EN, RU

    if (currentLayout = EN)
        SwitchLayout(RU)
    else
        SwitchLayout(EN)
}

; Left Ctrl + Left Shift: switch to Japanese
LCtrl & LShift::
{
    global currentLayout, JA

    SwitchLayout(JA)
}

SwitchLayout(layoutId)
{
    global currentLayout

    ; Convert the hexadecimal layout identifier into an HKL value
    hkl := DllCall("LoadKeyboardLayout", "Str", layoutId, "UInt", 1, "Ptr")

    ; Request the active window to switch to the specified keyboard layout
    PostMessage(
        0x50,
        0,
        hkl,
        ,
        "A"
    )

    currentLayout := layoutId
}