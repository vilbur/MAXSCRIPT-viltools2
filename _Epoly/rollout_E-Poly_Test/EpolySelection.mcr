macroscript epolyselection_getselselection_test
category:"_Epoly_Test"  
buttonText:"Get Selection"
tooltip:	"Get current subobejct Selection"
(
	actionMan.executeAction 0 "40472"  -- MAX Script: MAXScript Listener
	
	(EpolySelection_v()).getSelection subObjectLevel
)


