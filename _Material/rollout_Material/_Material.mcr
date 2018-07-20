--macroscript	material_TEST
--category:	"_Material"  
--buttonText:	"TEST"
--(
--	clearListener()
--	--Material = Material_v()
--
--	--Material.createMaterial()
--)
macroscript	material_create_id_material
category:	"_Material"  
buttonText:	"ID Mat"
tooltip:	"Create edit multi material with different ID"  
(
	Material = Material_v()
	selection.material = Material.getIdMaterial()
)

macroscript	material_material_by_object
category:	"_Material"  
buttonText:	"Mat By Object"
tooltip:	"Set different material ID for each object"
(
	--EditPoly = Epoly_v()
	_selection = (Selection_v()).get()
	print ( "_selection=" + _selection.count as string )
	
	for i=1 to _selection.count do
	(
		select _selection[i]
		(Epoly_v()).setMatIdToObject i
	)
 
	select _selection
	completeRedraw() 
)
macroscript	material_select_faces_by_material_id
category:	"_Material"
buttontext:	"Sel Faces by Mat"
toolTip:	"Select faces by material id"
--icon:	"#(path, index)"
(
	Epoly 	=  Epoly_v()
	EditPolyMaterial 	=  EditPolyMaterial_v()

	faces_ids_merged	= #{}
	face_count	= Epoly.count 4
	mat_ids	= EditPolyMaterial.getMatId facelist:( Epoly.getSel #Face )

	faces_ids	= EditPolyMaterial.getFacesByMatId ( makeUniqueArray  mat_ids )
	for faces_id in faces_ids do
		join faces_ids_merged faces_id
	
	Epoly.setSel #Face faces_ids_merged
)


macroscript	material_random_material
category:	"_Material"  
buttonText:	"Random"
tooltip:	"Set random material id for selection"
(
	--EditPoly = Epoly_v()
	_selection = (Selection_v()).get()
	print ( "_selection=" + _selection.count as string )
	mat_id	= random 1 32
	
	for i=1 to _selection.count do
	(
		select _selection[i]
		(Epoly_v()).setMatId mat_id
	)
 
	select _selection

	completeRedraw() 
)

macroscript	material_select_objs_by_material
category:	"_Material"  
buttonText:	"Select By Mat"
tooltip:	"Select Objects By Material"

(
	-- <array>SelectObjectByMaterial - returns array of objects a material is assigned to
	fn SelectObjectByMaterial reqMatEditOpen materialIndex = (
		objarr = #()
		
		-- Select ALL objects with this material
		if MatEditor.isOpen() or (reqMatEditOpen == false) then (
			if materialIndex > 0 and materialIndex < 25 then (	-- start index check
				objarr = for o in objects where o.material == meditMaterials[materialIndex] collect o
				-- Check if the obj is part of a group
				for obj in objarr where isGroupMember obj AND (NOT isOpenGroupMember obj) do
				(
				  	par = obj.parent
				  	while par != undefined do
				  	(
				  		if isGroupHead par then 
				  		(
				  			setGroupOpen par true
				  			par = undefined
				  		)
				  		else par = par.parent
					)
				)				
			) -- end index check
		) else	-- Material Editor isn't open
			messageBox "Material Editor is not open" beep:false
			
		objarr
	)
	
	on execute do (
		clearSelection()
		max create mode
		if (objs = SelectObjectByMaterial true (medit.getActiveMtlSlot())) != undefined then
			select objs	
	)
	
	on altexecute type do (
		clearSelection()
		max create mode
		if (objs = SelectObjectByMaterial true (medit.getActiveMtlSlot())) != undefined then
			select objs	
			
		for o in objs where not(o.layer.on) do o.layer.on = true
		for o in objs where o.layer.isFrozen do o.layer.isFrozen = false
		for o in objs where o.isHidden do o.isHidden = false
		for o in objs where o.isFrozen do o.isFrozen = false
		
		select objs
	)
)