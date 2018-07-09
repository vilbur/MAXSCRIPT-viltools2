macroscript	epoly_remove
category:	"_Epoly-Edit"  
buttonText:	"Remove"
tooltip:	"Remove subobject"
(
	undo "Remove subobject" on
	(
		(Epoly_v()).remove()
	)
)


macroscript epoly_attachSelection
category:"_Epoly"  
buttonText:"Attach Selected"
tooltip:"Attach Selected"
(
	Epoly = Epoly_v()
	
	--macros.run "_Material" "materialByObject"
	
	Epoly.attachSelection true
		
)

macroscript epoly_bakeObjects
category:"_Epoly"  
buttonText:"Bake objects"
tooltip:"Bake objects\nSet one smoothgroup\nSet one material id"
(
	--clearListener()
	
	macros.run "_Epoly" "epoly_attachSelection"
	macros.run "_Epoly-SmoothGroups" "smoothGroupByObject"
	macros.run "_Material" "materialByObject"
	--macros.run "_Samdosoft" "samdosoft_planar"

)



macroscript	epoly_target_weld
category:	"_Epoly-Edit"  
buttonText:	"targetWeld"
tooltip:	"Target Weld"
(
	Epoly = Epoly_v()

	if( subObjectLevel != 1  ) then
		subObjectLevel = 1
		
	Epoly.targetWeld()
	
)

macroscript	epoly_connect
category:	"_Epoly-Edit"  
buttonText:	"Connect"
tooltip:	"Connect"
(
	undo "Connect subobject" on
	(
		(Epoly_v()).connect()
	)
)