#SingleInstance Force


/**
 */
setMiniTransformWindowPosition()
{
	setTitleMatchMode 2
	
	$offset_right	:= 256
	$offset_top	:= 2
	
	$trans_title	:= "Move Transform Type-In"
	$max_title	:= "Autodesk 3ds Max 2016"
	
	WinGetPos,	$max_X,	$max_Y,	$max_width,	$max_height,	%$max_title% 
	WinGetPos,	$trans_X,	$trans_Y,	$trans_width,	$trans_height,	%$trans_title% 
	
	$pos_x_new	:= $max_X + $max_width - $trans_width - $offset_right

	WinMove,	%$trans_title%,, %$pos_x_new%, % $max_Y - $offset_top
	;DisableCloseButton(WinExist($trans_title))
	WinActivate, %$trans_title% 
	WinActivate, %$max_title% 
}

/** https://autohotkey.com/board/topic/80593-how-to-disable-grey-out-the-close-button/#entry58524
 */
DisableCloseButton($hwnd="")
{

	DetectHiddenWindows, On

	hSysMenu:=DllCall("GetSystemMenu","Int",$hwnd,"Int",FALSE)
   
	nCnt:=DllCall("GetMenuItemCount","Int",hSysMenu)
   
	DllCall("RemoveMenu","Int",hSysMenu,"UInt",nCnt-1,"Uint","0x400")
   
	DllCall("RemoveMenu","Int",hSysMenu,"UInt",nCnt-2,"Uint","0x400")
   
	DllCall("DrawMenuBar","Int",$hwnd)

}

/**
 */
hookWindowChange()
{
	Gui +LastFound 
	$Hwnd := WinExist()
	DllCall( "RegisterShellHookWindow", UInt, $Hwnd )
	$MsgNum := DllCall( "RegisterWindowMessage", Str,"SHELLHOOK" )
	OnMessage( $MsgNum, "ShellMessage" )
}

/**  
 */
ShellMessage( $wParam, $lParam )
{
	WinGetTitle, $title, ahk_id %$lParam%
	
	IfInString, $title, Autodesk 3Ds Max
	{
		setMiniTransformWindowPosition()
	}
		
}

/*---------------------------------------
	RUN SCRIPT
-----------------------------------------
*/
hookWindowChange()
setMiniTransformWindowPosition()
