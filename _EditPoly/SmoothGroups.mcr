

macroscript explodeBySG
category:"EditPoly-SmoothGroups"  
buttonText:"Explode By SG"
(
	(EditPolyObjects_v()).doForObjects "explodeBySG"

	--messagebox "_EditPoly.mcr"
	--_selection = (Selection_v()).get()
	----print ( "_selection=" + _selection as string )
	--
	--for obj in _selection do
	--	selectmore ((EditPoly_v obj:obj).explodeBySG())
	--	
	--delete _selection
	--update selection
)

macroscript smoothGroupByObject
category:"EditPoly-SmoothGroups"  
buttonText:"SG by object"
( 
	EditPoly = EditPoly_v()
	_selection = (Selection_v()).get()
	--print ( "_selection=" + _selection as string )
	
	for i=1 to _selection.count do
		(EditPoly_v obj:_selection[i]).setSmoothGroup ( polyop.getNumFaces _selection[i] )  i
		
)
