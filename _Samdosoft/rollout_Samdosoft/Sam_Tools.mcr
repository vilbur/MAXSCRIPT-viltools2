macroscript samdosoft_chamfer
category:"_Samdosoft"  
buttonText:"Stairs"
tooltip:"Create stairs from selected objects"
(
	for o=1 to selection.count do
	(
		obj = selection[o]	
		
		obj.pos.z = o * 30 as float  
		obj.pos.x = o * 100 as float  
	)
)

macroscript samdosoft_rock
category:"_Samdosoft"  
buttonText:"Rock"
tooltip:"Create Rock"
(
	modPanel.addModToSelection (Mesh_Select ()) ui:on

	_Edit_Poly	= (Modifiers_v()).addEditPoly()
	_Edit_Poly.name	= #Extrude
	
	select selection
	
	redrawViews()
)

