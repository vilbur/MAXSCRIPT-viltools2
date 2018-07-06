macroscript	epolyselection_getselselection_test
category:	"_Epoly_Test"  
buttonText:	"Get Selection"
tooltip:	"Get current subobejct Selection"
(
	actionMan.executeAction 0 "40472"  -- MAX Script: MAXScript Listener
	
	(EpolySelection_v()).getSelection subObjectLevel
)

macroscript	epoly_convert_selection_test
category:	"_Epoly_Test"  
buttonText:	"Convert to face"
tooltip:	"Convert to face"
(
	(Epoly_v()).convertSelection #face
)

