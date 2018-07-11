
macroscript	epoly_attach_selection
category:	"_Epoly"  
buttonText:	"Attach Selected"
tooltip:	"Attach Selected"
(
	with redraw off

	(
		undo "repair smooth groups by mat" on
		(
			Epoly = Epoly_v()
		
			--macros.run "_Material" "materialByObject"
		
			Epoly.attachSelection true
	)	)
)

macroscript	epoly_bakeObjects
category:	"_Epoly"  
buttonText:	"Bake objects"
tooltip:	"Bake objects\nSet one smoothgroup\nSet one material id"
(
	--clearListener()
	undo "Bake objects" on
	(
		macros.run "_Epoly" "epoly_attach_selection"
		macros.run "_Epoly-SmoothGroups" "epoly_smooth_group_by_object"
		macros.run "_Material" "material_material_by_object"
		--macros.run "_Samdosoft" "samdosoft_planar"
	)
)
