/**  
 *	1) Run .ms script "Mini Transform Type-In"
 *	2) Run ahk script "Set-Transform-Type-In-Position.ahk"
 *
 */


/** Mini transform type in
 */
function miniTransformTypeInStart =
(
	--messageBox "miniTransformTypeInStart" beep:false
	actionMan.executeAction 0 "40093"  -- Edit: Transform Type-In Dialog OPen	
	
	--sleep 1
	filein	( getFilenamePath(getSourceFileName()) + "/Mini-Transform-Type-In.ms" )
	--sleep 1
	ShellLaunch ( getFilenamePath(getSourceFileName()) + "/Mini-Transform-Type-In-Set-Position.ahk" ) ""
	
)

/** Mini transform type lose
 */
function miniTransformTypeInClose =
(
	--messageBox "miniTransformTypeClose" beep:false
	ShellLaunch ( getFilenamePath(getSourceFileName()) + "/Mini-Transform-Type-In-Close.ahk" ) ""
)
