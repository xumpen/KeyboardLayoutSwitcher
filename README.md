# Windows Keyboard Layout Switcher

A lightweight [AutoHotkey v2](https://www.autohotkey.com/) script for switching between English, Russian, and Japanese keyboard layouts using custom hotkeys.

## Features

* Toggle between **English** and **Russian** layouts.
* Switch directly to the **Japanese** layout.
* Uses the left-side modifier keys only.
* Works globally across Windows applications.
* Runs silently in the background.
* No additional software is required apart from AutoHotkey v2.

## Hotkeys

| Hotkey           | Action                             |
| ---------------- | ---------------------------------- |
| `LShift + LAlt`  | Toggle between English and Russian |
| `LCtrl + LShift` | Switch to Japanese                 |

### English / Russian toggle

Press:

```text
LShift + LAlt
```

The script alternates between:

```text
English → Russian → English → Russian → ...
```

### Japanese layout

Press:

```text
LCtrl + LShift
```

The script switches directly to the Japanese keyboard layout.

After switching to Japanese, pressing `LShift + LAlt` will continue the English/Russian toggle according to the script's current EN/RU state.

## Requirements

* Windows
* [AutoHotkey v2](https://www.autohotkey.com/)
* English (US), Russian, and Japanese keyboard layouts installed in Windows

The script requires **AutoHotkey v2**. It is not intended for AutoHotkey v1.

## Installation

### 1. Install AutoHotkey v2

Download and install AutoHotkey v2 from the official website:

https://www.autohotkey.com/

Make sure you install **AutoHotkey v2**, not the legacy v1 version.

### 2. Download the script

Clone this repository or download the `.ahk` file.

For example:

```text
KeyboardLayoutSwitcher.ahk
```

### 3. Run the script

Double-click the `.ahk` file.

If AutoHotkey v2 is installed correctly, the script will start and run in the background.

There is no window that needs to remain open.

You should see the AutoHotkey icon in the Windows system tray while the script is running.

## Windows Keyboard Layouts

The script expects the following Windows keyboard layouts:

| Language     | Layout ID  |
| ------------ | ---------- |
| English (US) | `00000409` |
| Russian      | `00000419` |
| Japanese     | `00000411` |

Make sure these keyboard layouts are installed before using the script.

To check your installed layouts:

1. Open **Windows Settings**.
2. Go to **Time & language**.
3. Open **Language & region**.
4. Check the installed languages and keyboard layouts.

The exact names of the settings may differ slightly depending on your Windows version.

## Configuration

The layout identifiers are defined near the top of the script:

```ahk
EN := "00000409"
RU := "00000419"
JA := "00000411"
```

These correspond to:

```text
00000409 = English (US)
00000419 = Russian
00000411 = Japanese
```

If you want to use different layouts, replace the corresponding identifiers.

The initial EN/RU state is defined here:

```ahk
currentLayout := EN
```

This means the script initially assumes that the active layout is English.

If you normally start Windows with Russian active, you can change this to:

```ahk
currentLayout := RU
```

## Running at Windows Startup

There are several ways to start the script automatically when Windows starts.

The simplest method is to use the Windows Startup folder.

### Method 1 — Startup Folder

#### 1. Create a shortcut

Right-click the `.ahk` script and select:

```text
Show more options → Create shortcut
```

You should get a shortcut similar to:

```text
KeyboardLayoutSwitcher - Shortcut.lnk
```

#### 2. Open the Startup folder

Press:

```text
Win + R
```

Enter:

```text
shell:startup
```

and press **Enter**.

Windows will open your personal Startup folder.

#### 3. Move the shortcut

Move or copy the shortcut to this folder.

For example:

```text
C:\Users\YourUsername\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
```

You do not need to move the actual `.ahk` file. The shortcut is enough.

#### 4. Restart Windows

After restarting Windows, AutoHotkey should automatically launch the script.

The keyboard shortcuts should then work without manually starting the script.

## Starting the Compiled EXE at Startup

If you prefer not to require AutoHotkey to handle the script every time, you can compile the `.ahk` script into an executable.

AutoHotkey v2 includes a compiler.

Right-click the `.ahk` file and select the appropriate **Compile Script** option.

This creates an `.exe` file.

For example:

```text
KeyboardLayoutSwitcher.exe
```

You can then place a shortcut to this `.exe` in:

```text
shell:startup
```

This is useful if you want to distribute the script to another Windows computer.

## Stopping the Script

To stop the script:

1. Find the AutoHotkey icon in the Windows system tray.
2. Right-click it.
3. Select **Exit**.

The custom keyboard shortcuts will stop working immediately.

## Restarting the Script

If you make changes to the `.ahk` file while the script is running, you can restart it by:

1. Right-clicking the AutoHotkey tray icon.
2. Selecting **Reload Script**.

Alternatively, close the script and launch it again.

## Source Code

The complete script is:

```ahk
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
```

## Troubleshooting

### The hotkeys do not work

Make sure that:

* AutoHotkey **v2** is installed.
* The script is currently running.
* The AutoHotkey icon is visible in the system tray.
* The required keyboard layouts are installed in Windows.

### The Japanese layout does not activate

Check that the Japanese keyboard layout is installed in:

```text
Windows Settings → Time & language → Language & region
```

The script uses:

```text
00000411
```

for Japanese.

### English/Russian switching starts from the wrong language

The script keeps track of the EN/RU state internally.

By default:

```ahk
currentLayout := EN
```

If the script is started while Russian is already active, change it to:

```ahk
currentLayout := RU
```

Alternatively, switch to English once before beginning normal use.

### Windows also switches the layout

If another Windows keyboard shortcut is configured to switch keyboard layouts, it may conflict with this script.

Check the keyboard shortcut settings under the Windows language/input settings and disable conflicting shortcuts if necessary.

## License

This project is provided as-is for personal use.

You are free to modify the script for your own needs.
