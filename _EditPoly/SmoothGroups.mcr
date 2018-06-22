


macroscript smoothGroupByObject
category:"_EditPoly-SmoothGroups"  
buttonText:"SG by object"
( 
	EditPoly = EditPoly_v()
	_selection = (Selection_v()).get()
	--print ( "_selection=" + _selection as string )
	
	for i=1 to _selection.count do
		(EditPoly_v obj:_selection[i]).setSmoothGroup  i
		
)
macroscript repairSmoothGroupsByMaterial
category:"_EditPoly-SmoothGroups"  
buttonText:"SG by Mat"
tooltip:"Repair Smooth Groups By Material"
( 
	
	
	macros.run "_EditPoly" "attachSelection"
	macros.run "_EditPoly-Explode" "ExplodeByMaterial"
	--macros.run "_Material" "materialByObject"
	macros.run "_EditPoly-SmoothGroups" "smoothGroupByObject"
	macros.run "_EditPoly" "attachSelection"
	--macros.run "EditPoly-SmoothGroups" "smoothGroupByObject"
		
)
