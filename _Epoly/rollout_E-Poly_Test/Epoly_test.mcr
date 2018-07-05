macroscript	epoly_convert_selection_test
category:	"_Epoly_Test"  
buttonText:	"Convert to face"
tooltip:	"Convert to face"
(
	clearListener()

	(Epoly_v()).convertSelection #face
)

macroscript	epoly_setSmoothGroup_test
category:	"_Epoly_Test"  
buttonText:	"SetSmoothGroup"
tooltip:	"SetSmoothGroup"
(
	(Epoly_v()).setSmoothGroup 1
)

macroscript	epoly_ignoreBackfacing_toggle_test
category:	"_Epoly_Test"  
buttonText:	"IgnoreBackfacing"
tooltip:	"IgnoreBackfacing Toggle"
(
	(Epoly_v()).ignoreBackfacing()
)

macroscript	epoly_ignoreBackfacing_on_test
category:	"_Epoly_Test"  
buttonText:	"IgnoreBackfacing"
tooltip:	"IgnoreBackfacing ON"
(
	(Epoly_v()).ignoreBackfacing state:true
)

macroscript	epoly_constrain_test
category:	"_Epoly_Test"  
buttonText:	"Constrain"
tooltip:	"Constrain Toggle 'Edge' & 'None'"
(
	Epoly = Epoly_v()
	
	new_state	= if( Epoly.constrain state:#get == 1 ) then 0 else 1 
	
	Epoly.constrain state:new_state
)

macroscript	epoly_preserveuvs_test
category:	"_Epoly_Test"  
buttonText:	"Preserve UVs"
tooltip:	"Preserve UVs Toggle"
(
	(Epoly_v()).preserveUvs()
)

macroscript	epoly_selectByAngle_test
category:	"_Epoly_Test"  
buttonText:	"selectByAngle"
tooltip:	"selectByAngle Toggle"
(
	(Epoly_v()).selectByAngle()
)

macroscript	epoly_remove_test
category:	"_Epoly_Test"  
buttonText:	"Remove"
tooltip:	"Remove"
(
	(Epoly_v()).remove()
)








