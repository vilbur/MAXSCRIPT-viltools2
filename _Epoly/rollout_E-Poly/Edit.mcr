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

macroscript	epoly_connect_test
category:	"_Epoly_Test"  
buttonText:	"Connect"
tooltip:	"Connect"
(
	undo "Connect subobject" on
	(
		(Epoly_v()).connect()
	)
)

macroscript attachSelection
category:"_EditPoly"  
buttonText:"Attach Selected"
(
	EditPoly = EditPoly_v_old()
	
	--macros.run "_Material" "materialByObject"
	
	EditPoly.attachSelection true
)

macroscript bakeObjects
category:"_EditPoly"  
buttonText:"Bake objects"
tooltip:"Attach objects\nSet one smoothgroup\nSet one material id"
(
	clearListener()
	
	macros.run "_EditPoly" "attachSelection"
	macros.run "EditPoly-SmoothGroups" "smoothGroupByObject"
	macros.run "_Material" "materialByObject"
)
