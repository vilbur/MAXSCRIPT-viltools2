#SingleInstance Force

/** Set position of MAX dialogs
  * Onbly dialogs without title are taken
  *
 */
setDialogsPosition()
{
	setTitleMatchMode 2
	
	$offset_right	:= 512
	$offset_top	:= 256
	
	$dialog_title	:= "ahk_class #32770"
	$max_title	:= "Autodesk 3ds Max"
	
	$excluded_titles := "MAXScript Listener|Move Transform Type-In|vilTools2"
	WinGetPos,	$max_X,	$max_Y,	$max_width,	$max_height,	%$max_title% 

   WinGet $GroupIDs, List, %$dialog_title%
   
   Loop %$GroupIDs%
   {
		$id := % $GroupIDs%A_Index%

		WinGetTitle, $win_title, ahk_id %$id% 
		
		if( $win_title == "" )
		{
			WinGetPos,	$dialog_X,	$dialog_Y,	$dialog_width,	$dialog_height,	ahk_id %$id% 
			$pos_x_new	:= $max_X + $max_width - $dialog_width - $offset_right
			$pos_y_new	:= $max_Y + $offset_top
			
			if( $dialog_X != $pos_x_new || $dialog_Y != $pos_y_new )
				WinMove,	ahk_id %$id%,, %$pos_x_new%, % $pos_y_new
				
			$offset_top += $dialog_height ; sort dialogs below each other
		}

   }
	
   
}


;/** https://autohotkey.com/board/topic/80593-how-to-disable-grey-out-the-close-button/#entry58524
; */
;DisableCloseButton($hwnd="")
;{
;
;	DetectHiddenWindows, On
;
;	hSysMenu:=DllCall("GetSystemMenu","Int",$hwnd,"Int",FALSE)
;   
;	nCnt:=DllCall("GetMenuItemCount","Int",hSysMenu)
;   
;	DllCall("RemoveMenu","Int",hSysMenu,"UInt",nCnt-1,"Uint","0x400")
;   
;	DllCall("RemoveMenu","Int",hSysMenu,"UInt",nCnt-2,"Uint","0x400")
;   
;	DllCall("DrawMenuBar","Int",$hwnd)
;
;}
;
;/**
; */
;hookWindowChange()
;{
;	Gui +LastFound 
;	$Hwnd := WinExist()
;	DllCall( "RegisterShellHookWindow", UInt, $Hwnd )
;	$MsgNum := DllCall( "RegisterWindowMessage", Str,"SHELLHOOK" )
;	OnMessage( $MsgNum, "ShellMessage" )
;}
;
;/**  
; */
;ShellMessage( $wParam, $lParam )
;{
;	WinGetTitle, $title, ahk_id %$lParam%
;	setTitleMatchMode 2
;	IfInString, $title, Autodesk 3Ds Max
;	{
;		;MsgBox,262144,, Test,2 
;		setDialogsPosition()
;	}
;		
;}

/*---------------------------------------
	RUN SCRIPT
-----------------------------------------
*/


setDialogsPosition()


