macroscript	explodeByElement
category:	"_EditPoly-Explode"  
buttonText:	"Elements"
toolTip:	"Explode by Elements"
(
	--clearListener()
	undo "explodeByElement" on
	(
		(Epoly_v()).explodeByElement()
	)
	--macros.run "_Material" "materialByObject"
)

macroscript	ExplodeByMaterial
category:	"_EditPoly-Explode"
buttontext:	"Material"
toolTip:	"Explode by Material"
(
	undo "explodeByMaterialId" on
	(
		(Epoly_v()).explodeByMaterialId()
	)
)

macroscript	explodeBySG
category:	"_EditPoly-Explode"  
buttonText:	"Smooth Groups"
toolTip:	"Explode by SmoothGroups"
(
	undo "explodeBySG" on
	(
		(Epoly_v()).explodeBySG()
	)
)

macroscript	explodeByHardErge
category:	"_EditPoly-Explode"
buttontext:	"HARD edges"
toolTip:	"Explode by  HARD edges"
(
	undo "explodeByHardEdges" on
	(
		(Epoly_v()).explodeByHardEdges()
	)
)