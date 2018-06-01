macroScript Select_loop_up
	category:"_EditPoly"
	buttontext:"Select_loop_up"
(
	include "$userScripts\\_EditPoly\\Select_loop.ms"
	
	Select_loop -1 true

)

macroScript Select_loop_down
	category:"_EditPoly"
	buttontext:"Select_loop_up"
(
	include "$userScripts\\_EditPoly\\Select_loop.ms"
	Select_loop 1 true

)

macroScript Deselect_loop_up
	category:"_EditPoly"
	buttontext:"Select_loop_up"
(
	include "$userScripts\\_EditPoly\\Select_loop.ms"
	Select_loop -1 false

)

macroScript Deselect_loop_down
	category:"_EditPoly"
	buttontext:"Select_loop_up"
(
	include "$userScripts\\_EditPoly\\Select_loop.ms"
	Select_loop 1 false

)