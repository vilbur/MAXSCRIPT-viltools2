--macroscript samdosoft_rock
--category:"_Samdosoft"  
--buttonText:"Rock"
--tooltip:"Create Rock"
--(
--	modPanel.addModToSelection (Mesh_Select ()) ui:on
--
--	_Edit_Poly	= (Modifiers_v()).addEditPoly()
--	_Edit_Poly.name	= #Extrude
--	
--	select selection
--	
--	redrawViews()
--)

macroscript samdosoft_chamfer_material_borders
category:"_Samdosoft"  
buttonText:"Chamfer Mat"
tooltip:	"Chamfer edges on material ID borders"
(

	if( selection[1].modifiers[#Chamfer_mat] == undefined  ) then
	(
		_objects	= for o in selection where superClassOf o == GeometryClass collect o
		
		for _obj in _objects do
		(
			select _obj

			/*------ CHAMFER ------*/
			_Chamfer	= (Modifier_v type:#Chamfer name:"Chamfer-mat").add()
			_Chamfer.amount	= 10
			_Chamfer.chamfertype	= 1
			_Chamfer.selectionoption	= 5
			_Chamfer.useminangle	= false
			_Chamfer.materialoption	= 1
			_Chamfer.SetMaterial	= on
			_Chamfer.materialID	= 999

			--/*------ SEELCT CHAMFER ------*/
			_Chamfer_Select	= (Modifier_v type:#Edit_Poly name:"Select-Chamfer").add()
			Epoly	= (Epoly_v())
			faces_id	= Epoly.Material.getFacesByMatId 999 
			print ( "faces_id = " + faces_id as string )
			subObjectLevel = 4
			Epoly.Sel.setSel #face faces_id[1]
			
			/*------ NOISE ------*/
			_Noise	= (Modifier_v type:#Noise name:"Noise-Chamfer").add()
			--_Noise.strength	= [5, 5, 5]
			--_Noise.scale	= 5
			_Noise.strength	= [15, 15, 15]
			_Noise.scale	= 20
			_Noise.fractal	= false

			redrawViews()
		)
		select _objects
	)
	--else
		--deleteModifier $ (selection[1].modifiers[#Chamfer_mat])
)

macroscript samdosoft_chamfer_material_borders_remove
category:"_Samdosoft"  
buttonText:"Chamfer Mat"
tooltip:"Remove chamfer modifiers"
(
	_objects	= for o in selection where superClassOf o == GeometryClass collect o

	for _obj in _objects do
	(
		deleteModifier _obj _obj.modifiers[#Chamfer_mat]
		deleteModifier _obj _obj.modifiers[#Select_Chamfer]
		deleteModifier _obj _obj.modifiers[#Noise_Chamfer]
		
	)

)




