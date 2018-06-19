macroscript TEST
category:"_EditPoly"  
buttonText:"TEST"
(
	clearListener()
	EditPoly = EditPoly_v obj: selection[1]

	EditPoly.getElements()
)

macroscript attachSelection
category:"_EditPoly"  
buttonText:"Attach Selected"
(
	EditPoly = EditPoly_v()

	EditPoly.attachSelection true
)


macroscript explodeByElement
category:"_EditPoly"  
buttonText:"Explode elements"
(
	_selection = (Selection_v()).get()
	print ( "_selection=" + _selection.count as string )
	
	for i=1 to _selection.count do
		(EditPoly_v obj:_selection[i]).explode()
 
)

macroscript ExplodeByMaterial
	category:	"_Materials"
	buttontext:	"Explode by mat"
	toolTip:	"Explode By mat"
(
	_selection = (Selection_v()).get()
	print ( "_selection=" + _selection.count as string )
	
	for i=1 to _selection.count do
		selectmore ((EditPoly_v obj:_selection[i]).explodeByMaterialId())
		
	delete _selection
)