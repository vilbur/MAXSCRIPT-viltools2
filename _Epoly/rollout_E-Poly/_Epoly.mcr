
macroscript	epoly_attachSelection
category:	"_Epoly"  
buttonText:	"Attach Selected"
tooltip:	"Attach Selected"
(
	Epoly = Epoly_v()

	--macros.run "_Material" "materialByObject"

	Epoly.attachSelection true

)

macroscript	epoly_bakeObjects
category:	"_Epoly"  
buttonText:	"Bake objects"
tooltip:	"Bake objects\nSet one smoothgroup\nSet one material id"
(
	--clearListener()
	undo "Bake objects" on
	(
		macros.run "_Epoly" "epoly_attachSelection"
		macros.run "_Epoly-SmoothGroups" "smoothGroupByObject"
		macros.run "_Material" "materialByObject"
		--macros.run "_Samdosoft" "samdosoft_planar"
	)
)
