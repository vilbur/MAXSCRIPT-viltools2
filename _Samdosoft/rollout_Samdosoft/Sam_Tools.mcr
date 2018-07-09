--macroscript samdosoft_chamfer
--category:"_Samdosoft"  
--buttonText:"Stairs"
--tooltip:"Create stairs from selected objects"
--(
--	for o=1 to selection.count do
--	(
--		obj = selection[o]	
--		
--		obj.pos.z = o * 30 as float  
--		obj.pos.x = o * 100 as float  
--	)
--)

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


macroscript samdosoft_chamfer
category:"_Samdosoft"  
buttonText:"Chamfer Rock"
tooltip:"Chamfer rock"
(
	
	
	if( selection[1].modifiers[#Chamfer_rock] == undefined  ) then
	(
		macros.run "_Epoly" "selectHardEdges"
		
		_Chamfer = (Modifier_v type:#Chamfer name:"Chamfer-rock").add()
			
		_Chamfer.amount	= 15
		_Chamfer.chamfertype	= 1
		_Chamfer.limiteffect	= on
		
		redrawViews()
	)
	else
		deleteModifier $ (selection[1].modifiers[#Chamfer_rock])
)

