macroscript	autosmooth_30
category:	"_Epoly"
buttontext:	"Autosmooth"
toolTip:	"Autosmooth 30"
--icon:	"#(path, index)"
(
	(Epoly_v()).autosmooth 30
)

macroscript	autosmooth_65
category:	"_Epoly"
buttontext:	"Autosmooth"
toolTip:	"Autosmooth 65"
--icon:	"#(path, index)"
(
	(Epoly_v()).autosmooth 65
)

macroscript	clearSmoothGroups
category:	"_Epoly"
buttontext:	"Clear"
toolTip:	"Clear smooth groups"
--icon:	"#(path, index)"
(
	(Epoly_v()).clearSmoothGroups()
)

macroscript	smoothGroupByObject
category:	"_EditPoly-SmoothGroups"  
buttonText:	"By object"
tooltip:	"Set one smooth group for ach selected object"
( 
	EditPoly = EditPoly_v_old()
	_selection = (Selection_v()).get()
	
	for i=1 to _selection.count do
		(EditPoly_v_old obj:_selection[i]).setSmoothGroup  i
)

macroscript	repairSmoothGroupsByMaterial
category:	"_EditPoly-SmoothGroups"  
buttonText:	"By Mat"
tooltip:	"Set Smooth Groups By Material"
( 
	
	
	macros.run "_EditPoly" "attachSelection"
	macros.run "_EditPoly-Explode" "ExplodeByMaterial"
	--macros.run "_Material" "materialByObject"
	macros.run "_EditPoly-SmoothGroups" "smoothGroupByObject"
	macros.run "_EditPoly" "attachSelection"
	--macros.run "EditPoly-SmoothGroups" "smoothGroupByObject"
		
)
