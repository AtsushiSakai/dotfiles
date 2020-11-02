#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
; Ctrl + Space --> Win + S for windows file search
LCtrl & Space:: Send #s
; Ctrl + Shift 3 --> Win + Shift + S for clipboard save screen shot
;LCtrl+3:: Send #+s
LCtrl & 3::
  if GetKeyState("Shift") {
    Send #+s
    return
  }
  return

