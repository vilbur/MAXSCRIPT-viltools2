macroscript explodeByElement
category:"_EditPoly-Explode"  
buttonText:"Elements"
toolTip:	"Explode by Elements"

(
	(EditPolyObjects_v()).explode "explodeByElement"
	
	--macros.run "_Material" "materialByObject"
)

macroscript ExplodeByMaterial
category:	"_EditPoly-Explode"
buttontext:	"Material"
toolTip:	"Explode by Material"
(
	(EditPolyObjects_v()).explode "explodeByMaterialId"
)
	
macroscript explodeBySG
category:"_EditPoly-Explode"  
buttonText:"Smooth Groups"
toolTip:	"Explode by SmoothGroups"

(
	(EditPolyObjects_v()).explode "explodeBySG"
	--macros.run "_Material" "materialByObject"
)
macroscript explodeByHardErge
	category:	"_EditPoly-Explode"
	buttontext:	"HARD edges"
	toolTip:	"Explode by  HARD edges"
(
	--(EditPolyObjects_v()).explode "explodeByMaterialId"
	--macros.run "_EditPoly" "selectHardEdges"
	(EditPolyObjects_v()).explode "explodeByHardEdges"
	
	
)