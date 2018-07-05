macroscript	epoly_ignoreBackfacing_toggle
category:	"_Epoly"  
buttonText:	"ignoreBackfacing"
tooltip:	"ignoreBackfacing Toggle"
(
	(Epoly_v()).ignoreBackfacing()
)

macroscript	epoly_constrain_toggle_edge_none
category:	"_Epoly"  
buttonText:	"Constrain Toggle"
tooltip:	"Constrain Toggle 'Edge' & 'None'"
(
	Epoly = Epoly_v()
	
	new_state	= if( Epoly.constrain state:#get == 1 ) then 0 else 1 
	
	Epoly.constrain state:new_state
)

macroscript	epoly_preserveuvs_toggle
category:	"_Epoly"  
buttonText:	"Preserve UVs Toggle"
tooltip:	"Preserve UVs Toggle"
(
	(Epoly_v()).preserveUvs()
)

macroscript	epoly_remove
category:	"_Epoly"  
buttonText:	"Remove"
tooltip:	"Remove subobject"
(
	undo "Remove subobject" on
	(
		(Epoly_v()).remove()
	)
)