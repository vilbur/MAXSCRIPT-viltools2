#SingleInstance Force




;CloseScript(Name)
;{
;	DetectHiddenWindows On
;	SetTitleMatchMode RegEx
;	IfWinExist, i)%Name%.* ahk_class AutoHotkey
;		{
;		WinClose
;		WinWaitClose, i)%Name%.* ahk_class AutoHotkey, , 2
;		If ErrorLevel
;			return "Unable to close " . Name
;		else
;			return "Closed " . Name
;		}
;	else
;		return Name . " not found"
;	
;	
;}
	
;MsgBox,262144,, Test,2 
setTitleMatchMode 2
WinClose, Move Transform Type-In

;$closed := CloseScript("Mini-Transform-Type-In-Set-Position.ahk")
;MsgBox,262144,closed, %$closed%,3

;Aside from Process Close, which can leave a "dead" icon in the tray, you can use WinClose to close some other script.

DetectHiddenWindows On
SetTitleMatchMode 2  ; for partial match
WinClose Mini-Transform-Type-In-Set-Position.ahk ahk_class AutoHotkey

return
