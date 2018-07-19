/**  
 *	1) Run .ms script "Mini Transform Type-In"
 *	2) Run ahk script "Set-Transform-Type-In-Position.ahk"
 *
 */

actionMan.executeAction 0 "40093"  -- Edit: Transform Type-In Dialog OPen	

filein	( getFilenamePath(getSourceFileName()) + "/Mini-Transform-Type-In.ms" )
ShellLaunch	( getFilenamePath(getSourceFileName()) + "/Set-Transform-Type-In-Position.ahk" ) ""