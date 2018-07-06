macroscript	epoly_convert_selection_test
category:	"_Epoly_Test"  
buttonText:	"Convert to face"
tooltip:	"Convert to face"
(
	clearListener()

	(Epoly_v()).convertSelection #face
)

macroscript	epoly_setSmoothGroup_test
category:	"_Epoly_Test"  
buttonText:	"SetSmoothGroup"
tooltip:	"SetSmoothGroup"
(
	(Epoly_v()).setSmoothGroup 1
)


macroscript	epoly_remove_test
category:	"_Epoly_Test"  
buttonText:	"Remove"
tooltip:	"Remove"
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









