macroscript	explodeByElement
category:	"_EditPoly-Explode"  
buttonText:	"Elements"
toolTip:	"Explode by Elements"
(
	(Epoly_v()).explode "explodeByElement"
	
	--macros.run "_Material" "materialByObject"
)

macroscript	ExplodeByMaterial
category:	"_EditPoly-Explode"
buttontext:	"Material"
toolTip:	"Explode by Material"
(
	(Epoly_v()).explode "explodeByMaterialId"
)
	
macroscript	explodeBySG
category:	"_EditPoly-Explode"  
buttonText:	"Smooth Groups"
toolTip:	"Explode by SmoothGroups"
(
	(Epoly_v()).explode "explodeBySG"
)

macroscript	explodeByHardErge
category:	"_EditPoly-Explode"
buttontext:	"HARD edges"
toolTip:	"Explode by  HARD edges"
(
	(Epoly_v()).explode "explodeByHardEdges"
)