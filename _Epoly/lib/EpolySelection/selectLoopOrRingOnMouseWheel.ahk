#SingleInstance force

/**
 */
sendMacro( $macro_name )
{
	$max	:= "ahk_class 3DSMAX"
	$listener	:= "MXS_Scintilla2"

	WinActivate, %$max%
	ControlSetText, %$listener%, , %$max%

	;sleep, 50
	Control, EditPaste, % "macros.run ""_Epoly-EpolySelection"" """ $macro_name """", %$listener%, %$max%

	;sleep, 300
	;ControlSetText, %$listener%, , %$max%
	ControlSend, %$listener%, {NumpadEnter 2}, %$max%
	;ControlSend, %$listener%, {Enter 5}, %$max%

} 



#^WheelUp::
	sendMacro( "epolyselection_select_ring_down" )
	return

#^WheelDown::
	sendMacro( "epolyselection_select_ring_up" )
	return
	
#!WheelUp::
	sendMacro( "epolyselection_deselect_ring_down" )
	return

#!WheelDown::
	sendMacro( "epolyselection_deselect_ring_up" )
	return


^WheelUp::
	sendMacro( "epolyselection_select_loop_up" )
	;send, ^#^{WheelUp}
	return

^WheelDown::
	sendMacro( "epolyselection_select_loop_down" )
	;send, ^#^{WheelDown}
	return

!WheelUp::
	sendMacro( "epolyselection_select_loop_down" )
	;send, #!{WheelUp}
	return


!WheelDown::
	sendMacro( "epolyselection_deselect_loop_down" )
	;send, #!{WheelDown}
	return
	
	