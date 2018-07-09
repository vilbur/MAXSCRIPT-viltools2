macroscript	autosmooth_30
category:	"_Epoly-SmoothGroups"
buttontext:	"Autosmooth 30"
toolTip:	"Autosmooth 30"
--icon:	"#(path, index)"
(
	(Epoly_v()).autosmooth 30
)

macroscript	autosmooth_65
category:	"_Epoly-SmoothGroups"
buttontext:	"Autosmooth 65"
toolTip:	"Autosmooth 65"
--icon:	"#(path, index)"
(
	(Epoly_v()).autosmooth 65
)

macroscript	clearSmoothGroups
category:	"_Epoly-SmoothGroups"
buttontext:	"Clear"
toolTip:	"Clear smooth groups"
--icon:	"#(path, index)"
(
	(Epoly_v()).clearSmoothGroups()
)

macroscript	smoothGroupByObject
category:	"_Epoly-SmoothGroups"  
buttonText:	"By object"
tooltip:	"Set one smooth group for ach selected object"
(
	/* HOTFIX */
		--current_modifier	= modPanel.getCurrentObject()
		--
		--if( classOf current_modifier != Edit_Poly ) then
		--	(Modifier_v type:#Edit_Poly ).add()
	/*  */
 
	Epoly = Epoly_v()
	_selection = (Selection_v()).get()
	
	for i=1 to _selection.count do
	(
		select _selection[i]
		--Epoly.clearSmoothGroups()
		(Epoly_v()).setSmoothGroup i
		
	)
	select _selection

)

macroscript	repairSmoothGroupsByMaterial
category:	"_Epoly-SmoothGroups"  
buttonText:	"Smooth Groups By Material"
tooltip:	"Set Smooth Groups By Material"
( 
	
	--messageBox "message" beep:false
	macros.run "_Epoly" "epoly_attachSelection"
	macros.run "_Epoly-Explode" "ExplodeByMaterial"

	macros.run "_Epoly-SmoothGroups" "smoothGroupByObject"
	macros.run "_Epoly" "epoly_attachSelection"

	macros.run "_Epoly" "selectHardEdges"

		
)
