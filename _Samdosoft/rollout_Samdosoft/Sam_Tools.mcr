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
tooltip:	"Chamfer rock"
(

	if( selection[1].modifiers[#Chamfer_rock] == undefined  ) then
	(
		_objects	= for o in selection where superClassOf o == GeometryClass collect o
		
		for _obj in _objects do
		(
			select _obj
			macros.run "_Epoly" "selectHardEdges"
			
			_Chamfer = (Modifier_v type:#Chamfer name:"Chamfer-rock").add()
				
			_Chamfer.amount	= 12
			_Chamfer.chamfertype	= 1
			_Chamfer.limiteffect	= on
			
			redrawViews()
		)
		select _objects
	)
	else
		deleteModifier $ (selection[1].modifiers[#Chamfer_rock])
)
macroscript samdosoft_chamfer_remove
category:"_Samdosoft"  
buttonText:"Chamfer Rock"
tooltip:"Chamfer rock REMOVE"
(
	_objects	= for o in selection where superClassOf o == GeometryClass collect o

	for _obj in _objects do
		deleteModifier _obj _obj.modifiers[#Chamfer_rock]

)

