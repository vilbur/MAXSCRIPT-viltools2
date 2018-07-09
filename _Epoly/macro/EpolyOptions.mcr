macroscript	epoly_constrain
category:	"_Epoly-Options"  
buttonText:	"Constrain"
tooltip:	"Constrain Toggle 'Edge' & 'None'"
(
	Epoly = Epoly_v()
	
	new_state	= if( Epoly.constrain state:#get == 1 ) then 0 else 1 
	
	Epoly.constrain state:new_state
	
	onSelectionChangengeCallback()
)


macroscript	epoly_ignoreBackfacing_toggle
category:	"_Epoly-Options"  
buttonText:	"IgnoreBackfacing"
tooltip:	"IgnoreBackfacing Toggle"
(
	(Epoly_v()).ignoreBackfacing()
	
	onSelectionChangengeCallback()
)

macroscript	epoly_selectByAngle
category:	"_Epoly-Options"  
buttonText:	"selectByAngle"
tooltip:	"selectByAngle Toggle"
(
	(Epoly_v()).selectByAngle angle:15

	onSelectionChangengeCallback()
)