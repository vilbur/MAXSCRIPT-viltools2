macroscript	epoly_test
category:	"_Epoly_Test"  
buttonText:	"Epoly test"
(
	--messagebox "epoly_test" beep:	false
	(Epoly_v()).test()
)

macroscript	convert_selection_test
category:	"_Epoly_Test"  
buttonText:	"Convert to face"
tooltip:	"Convert to face"
(
	clearListener()
	--messagebox "epoly_test" beep:	false
	(Epoly_v()).convertSelection #face
)

macroscript	setSmoothGroup_test
category:	"_Epoly_Test"  
buttonText:	"setSmoothGroup"
tooltip:	"setSmoothGroup"
(
	(Epoly_v()).setSmoothGroup 1
)

macroscript	ignoreBackfacing_toggle_test
category:	"_Epoly_Test"  
buttonText:	"ignoreBackfacing"
tooltip:	"ignoreBackfacing Toggle"
(
	(Epoly_v()).ignoreBackfacing()
)

macroscript	ignoreBackfacing_on_test
category:	"_Epoly_Test"  
buttonText:	"ignoreBackfacing"
tooltip:	"ignoreBackfacing ON"
(
	(Epoly_v()).ignoreBackfacing state:true
)


macroscript	constrain_test
category:	"_Epoly_Test"  
buttonText:	"constrain"
tooltip:	"constrain"
(
	(Epoly_v()).constrain state:true
)