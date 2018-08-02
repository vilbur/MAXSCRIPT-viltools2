#SingleInstance force
;#NoTrayIcon

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


/*---------------------------------------
	LOOP
-----------------------------------------
*/

/*------ MOVE ------
*/
+WheelUp::
	sendMacro( "epolyselection_move_loop_up" )
	return

+WheelDown::
	sendMacro( "epolyselection_move_loop_down" )
	return
	
/*------ FORWARD ------
*/
^WheelUp::
	sendMacro( "epolyselection_select_loop_up" )
	return

^WheelDown::
	sendMacro( "epolyselection_deselect_loop_up" )
	return

/*------ REVERSE ------
*/	
!WheelDown::
	sendMacro( "epolyselection_select_loop_down" )
	return

!WheelUp::
	sendMacro( "epolyselection_deselect_loop_down" )
	return

	
	
/*---------------------------------------
	RING
-----------------------------------------
*/

/*------ MOVE ------
*/
#WheelUp::
	sendMacro( "epolyselection_move_ring_down" )
	return

#WheelDown::
	sendMacro( "epolyselection_move_ring_up" )
	return

/*------ FORWARD ------
*/
#^WheelUp::
	sendMacro( "epolyselection_select_ring_down" )
	return

#^WheelDown::
	sendMacro( "epolyselection_deselect_ring_down" )
	return

/*------ REVERSE ------
*/	
#!WheelUp::
	sendMacro( "epolyselection_deselect_ring_up" )
	return

#!WheelDown::
	sendMacro( "epolyselection_select_ring_up" )
	return
