#SingleInstance force

/** Run sequence of macros for testing vilTools2
  *
  *
  *
 */
runMacro( "_vilTools2", "vilTools2" )
;
;runMacro( "_Epoly-Test", "epoly_selection_setselselection_test" )

;runMacro( "_Epoly-EpolySelection", "epolyselection_select_loop_up" )
;runMacro( "_Epoly-EpolySelection", "epolyselection_select_ring_up" )



/**  
 *	
 */
runMacro( $category, $name )
{
	$max	:= "ahk_class 3DSMAX"
	$listener	:= "MXS_Scintilla2"
	
	WinActivate, %$max%
	ControlSetText, %$listener%, , %$max%
	
	;MsgBox,262144,, % "macros.run """ $category  "" """ $name  """,2 
	;sleep, 50
	Control, EditPaste, % "macros.run """ $category  """ """ $name  """", %$listener%, %$max%
	ControlSend, %$listener%, {NumpadEnter 2}, %$max%
	
}