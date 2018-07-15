
macroscript	epoly_selection_getselselection_test
category:	"_Epoly-Test"  
buttonText:	"Get\Set Selection"
tooltip:	"Get current subobejct Selection"
(
	actionMan.executeAction 0 "40472"  -- MAX Script: MAXScript Listener
	clearListener()
	global sub_selection_test
	sub_selection_test = (EpolySelection_v()).getSel subObjectLevel
	--sub_selection_test = (Epoly_v()).EpolySelection.getSel subObjectLevel
	
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

macroscript	epoly_selection_empty
category:	"_Epoly-Test"
buttontext:	"Test"
toolTip:	"X"
--icon:	"#(path, index)"
(
	--(EpolySelection_v()).select_loop 1 false
	(Epoly_v()).EpolySelection.test()
)

macroscript	epoly_selection_getAusingB
category:	"_Epoly-Test"
buttontext:	"get A using B"
toolTip:	"get A using B"
--icon:	"#(path, index)"
(
	clearListener()

	modOrObj = Filters.GetModOrObj()
	
	subObjectLevel	= 2
	
	sub_selection = modOrObj.GetSelection #Face
	
	b_get =  (Epoly_v()).EpolySelection.getAusingB modOrObj sub_selection aType:#Face bType:#Vertex 
	
	print ( "b_get = " + b_get as string )
	--(EpolySelection_v()).select_loop 1 false   
)

macroscript	epoly_selection_GetNextRingLoop
category:	"_Epoly-Test"
buttontext:	"GetNextRingLoop"
toolTip:	"GetNextRingLoop"
--icon:	"#(path, index)"
(
	clearListener()

	if (getCommandPanelTaskMode() != #modify) then
		setCommandPanelTaskMode #modify
	
	
	modOrObj = Filters.GetModOrObj()
	
	subObjectLevel	= 2
	
	edgeBitArray = modOrObj.GetSelection #Edge
	
	if edgeBitArray.numberset > 0 then
	(
		print ("selected edges: " +  (edgeBitArray) as string )
		print ("selected edges FIRST: " + (edgeBitArray as Array)[1] as string )
		print ("selected edges LAST: " + (edgeBitArray as Array)[(edgeBitArray as Array).count] as string )
		(Epoly_v()).EpolySelection.GetNextRingLoop edgeBitArray modOrObj:modOrObj
	)
	else
	(
		print "nothing selected"
	)
		
	redrawViews()
)
