

macroscript	epoly_ignoreBackfacing_on_test
category:	"_Epoly-Test"  
buttonText:	"IgnoreBackfacing"
tooltip:	"IgnoreBackfacing ON"
(
	(Epoly_v()).ignoreBackfacing state:true
)

macroscript	epoly_constrain_test
category:	"_Epoly-Test"  
buttonText:	"Constrain"
tooltip:	"Constrain Toggle 'Edge' & 'None'"
(
	Epoly = Epoly_v()
	
	new_state	= if( Epoly.constrain state:#get == 1 ) then 0 else 1 
	
	Epoly.constrain state:new_state
)

macroscript	epoly_preserveuvs_test
category:	"_Epoly-Test"  
buttonText:	"Preserve UVs"
tooltip:	"Preserve UVs Toggle"
(
	(Epoly_v()).preserveUvs()
)

macroscript	epoly_selectByAngle_test
category:	"_Epoly-Test"  
buttonText:	"selectByAngle"
tooltip:	"selectByAngle Toggle"
(
	(Epoly_v()).selectByAngle()
)