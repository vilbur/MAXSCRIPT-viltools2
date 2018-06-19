macroscript TEST
category:"_Material"  
buttonText:"TEST"
(
	clearListener()
	Material = Material_v

	Material.test()
)

macroscript materialByObject
category:"_Material"  
buttonText:"Material by Object"
(
	--EditPoly = EditPoly_v()
	_selection = (Selection_v()).get()
	print ( "_selection=" + _selection.count as string )
	
	for i=1 to _selection.count do
		(EditPoly_v obj:_selection[i]).setMatId i
 
	--select _selection
	completeRedraw() 
)