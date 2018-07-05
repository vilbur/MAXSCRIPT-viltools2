macroscript	epoly_test
category:	"_Epoly_Test"  
buttonText:	"Epoly test"
(
	--messagebox "epoly_test" beep:	false
	(Epoly_v()).test()
)

macroscript	convert_selection_test
category:	"_Epoly_Test"  
buttonText:	"Convert to face"
tooltip:	"Convert to face"
(
	clearListener()
	--messagebox "epoly_test" beep:	false
	(Epoly_v()).convertSelection #face
)

macroscript	setSmoothGroup_test
category:	"_Epoly_Test"  
buttonText:	"SetSmoothGroup"
tooltip:	"SetSmoothGroup"
(
	(Epoly_v()).setSmoothGroup 1
)

macroscript	ignoreBackfacing_toggle_test
category:	"_Epoly_Test"  
buttonText:	"IgnoreBackfacing"
tooltip:	"IgnoreBackfacing Toggle"
(
	(Epoly_v()).ignoreBackfacing()
)

macroscript	ignoreBackfacing_on_test
category:	"_Epoly_Test"  
buttonText:	"IgnoreBackfacing"
tooltip:	"IgnoreBackfacing ON"
(
	(Epoly_v()).ignoreBackfacing state:true
)

macroscript	constrain_test
category:	"_Epoly_Test"  
buttonText:	"Constrain"
tooltip:	"Constrain Toggle 'Edge' & 'None'"
(
	Epoly = Epoly_v()
	
	new_state	= if( Epoly.constrain state:#get == 1 ) then 0 else 1 
	
	Epoly.constrain state:new_state
)

macroscript	preserveuvs_test
category:	"_Epoly_Test"  
buttonText:	"Preserve UVs"
tooltip:	"Preserve UVs Toggle"
(
	(Epoly_v()).preserveUvs()
)

macroscript	selectByAngle_test
category:	"_Epoly_Test"  
buttonText:	"selectByAngle"
tooltip:	"selectByAngle Toggle"
(
	(Epoly_v()).selectByAngle()
)








