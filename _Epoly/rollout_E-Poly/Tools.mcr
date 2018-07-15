macroscript	epoly_relax
category:	"_Epoly-Tools"  
buttonText:	"Relax brush"
tooltip:	"Relax brush"
(
	if( subObjectLevel != 1 ) then
		(Epoly_v()).convertSelection #vertex
		
	current_mod	= modPanel.getCurrentObject()
	current_mod.SetOperation 81
	current_mod.paintDeformSize = 100
	--macros.run "Ribbon - Modeling" "RelaxSelection"

	
)

macroscript	epoly_relax_selection
category:	"_Epoly-Tools"  
buttonText:	"Relax selection"
tooltip:	"Relax selection"
(
	if( subObjectLevel != 1 ) then
		(Epoly_v()).convertSelection #vertex

	macros.run "Ribbon - Modeling" "RelaxSelection"
)
