macroscript selectHardEdges
category:"_EditPoly"  
buttonText:"Select"
tooltip:"Select HARD edges on all objects"
(
	_selection = (Selection_v()).get()
	--print ( "_selection=" + _selection[1] as string )
	--print ( "_selection=" + _selection.count as string )
	
	for i=1 to _selection.count do
		(EditPoly_v_old obj: _selection[i]).selectHardEdges()
	
	select _selection
	subobjectLevel = 2   

)

macroscript splitByHardEdges
category:"_EditPoly"  
buttonText:"Split"
tooltip:"Split HARD edges on all objects"
(
	_selection = (Selection_v()).get()
	--print ( "_selection=" + _selection[1] as string )
	--print ( "_selection=" + _selection.count as string )
	
	for i=1 to _selection.count do
		((EditPoly_v_old obj: _selection[i]).selectHardEdges()).splitEdges()
	
	select _selection
	subobjectLevel = 2   

)

macroscript chamfer_hard_edges
category:"_EditPoly"  
buttonText:"Chmafer HARD"
tooltip:	"Chmafer HARD edges"
(
	
	clearListener()
	
	
	Modifiers = Modifiers_v()

	
	--modPanel.addModToSelection (Edit_Poly name:"select_hardedges" ignoreBackfacing:on selectAngle:20 SelectByAngle:on ) ui:on

-- 	macros.run "_EditPoly" "selectHardEdges"
	--
	Modifiers.addChamfer()
	
	
)

