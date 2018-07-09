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


macroscript	epoly_ignore_backfacing_toggle
category:	"_Epoly-Options"  
buttonText:	"Ignore Backfacing"
tooltip:	"Ignore Backfacing Toggle"
(
	(Epoly_v()).ignoreBackfacing()
	
	onSelectionChangengeCallback()
)

macroscript	epoly_select_by_angle
category:	"_Epoly-Options"  
buttonText:	"Select By Angle"
tooltip:	"Select By Angle Toggle"
(
	(Epoly_v()).selectByAngle angle:15

	onSelectionChangengeCallback()
)