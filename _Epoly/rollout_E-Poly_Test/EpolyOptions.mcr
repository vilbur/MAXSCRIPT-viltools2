
macroscript	epoly_ignoreBackfacing_toggle_test
category:	"_Epoly_Test"  
buttonText:	"IgnoreBackfacing"
tooltip:	"IgnoreBackfacing Toggle Test"
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