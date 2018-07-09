macroscript	epoly_selection_getselselection_test
category:	"_Epoly-Test"  
buttonText:	"Get\Set Selection"
tooltip:	"Get current subobejct Selection"
(
	actionMan.executeAction 0 "40472"  -- MAX Script: MAXScript Listener
	clearListener()
	global sub_selection_test
	sub_selection_test = (EpolySelection_v()).getSel subObjectLevel
	
	print ( "Subobjects selected = " + sub_selection_test as string ) 
)

macroscript	epoly_selection_setselselection_test
category:	"_Epoly-Test"  
buttonText:	"Get\Set Selection"
tooltip:	"Set current subobejct Selection"
(
	actionMan.executeAction 0 "40472"  -- MAX Script: MAXScript Listener
	clearListener()
	
	(EpolySelection_v()).setSel subObjectLevel sub_selection_test
)

macroscript	epoly_convert_selection_test
category:	"_Epoly-Test"  
buttonText:	"Convert to face"
tooltip:	"Convert to face"
(
	(Epoly_v()).convertSelection #face
)

