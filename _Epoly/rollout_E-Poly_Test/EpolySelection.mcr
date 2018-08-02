
macroscript	epoly_selection_getselselection_test
category:	"_Epoly-Test"  
buttonText:	"Get\Set Selection"
tooltip:	"Get current subobejct Selection test"
(
	actionMan.executeAction 0 "40472"  -- MAX Script: MAXScript Listener
	clearListener()
	global sub_selection_test
	sub_selection_test = (Epoly_v()).Sel.getSel subObjectLevel
	--sub_selection_test = (Epoly_v()).EpolySelection.getSel subObjectLevel
	
	print ( "Subobjects selected = " + sub_selection_test as string ) 
)

macroscript	epoly_selection_setselselection_test
category:	"_Epoly-Test"  
buttonText:	"Get\Set Selection"
tooltip:	"Set current subobejct Selection test"
(
	actionMan.executeAction 0 "40472"  -- MAX Script: MAXScript Listener
	clearListener()
	
	(Epoly_v()).Sel.setSel subObjectLevel sub_selection_test
)



macroscript	epoly_convert_selection_test
category:	"_Epoly-Test"  
buttonText:	"Convert to face"
tooltip:	"Convert to face test"
(
	(Epoly_v()).convertSelection #face
)

macroscript	epoly_selection_empty_test
category:	"_Epoly-Test"
buttontext:	"Test"
tooltip:	"X test"
--icon:	"#(path, index)"
(
	--(EpolySelection_v()).select_loop 1 false
	(Epoly_v()).EpolySelection.test()
)

macroscript	epoly_selection_getAusingB_test
category:	"_Epoly-Test"
buttontext:	"Get A using B"
tooltip:	"Get A using B test"
--icon:	"#(path, index)"
(
	clearListener()

	--modOrObj = Filters.GetModOrObj()
	subObjectLevel	= 4
	
	sub_selection = ( modPanel.getCurrentObject() ).GetSelection #Face
	
	print ( "sub_selection = " + sub_selection as string )
	
	b_get =  (Epoly_v()).Sel.getAusingB #Face #Vertex sub_selection
	
	print ( "b_get = " + b_get as string )
	--(EpolySelection_v()).select_loop 1 false   
)

macroscript	epoly_selection_GetNextRingLoop_test
category:	"_Epoly-Test"
buttontext:	"GetNextRingLoop"
tooltip:	"GetNextRingLoop test"
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

macroscript	epolyselection_get_ring_loop_edges_test
category:	"_Epoly-Test"
buttontext:	"Get ring loop edges"
tooltip:	"Get ring loop edges test"
--icon:	"#(path, index)"
(
	all_loops = (Epoly_v()).EpolySelection.getRingLoopEdges selection[1] (( modPanel.getCurrentObject() ).GetSelection #Edge)
	print ( "all_loops = " + all_loops as string )

)






