--macroscript	TEST
--category:	"_Material"  
--buttonText:	"TEST"
--(
--	clearListener()
--	--Material = Material_v()
--
--	--Material.createMaterial()
--)
macroscript	createIdMaterial
category:	"_Material"  
buttonText:	"ID Mat"
tooltip:	"Create edit multi material with different ID"  
(
	Material = Material_v()
	selection.material = Material.getIdMaterial()
)

macroscript	materialByObject
category:	"_Material"  
buttonText:	"By Object"
tooltip:	"Set different material ID for each object"
(
	--EditPoly = Epoly_v()
	_selection = (Selection_v()).get()
	print ( "_selection=" + _selection.count as string )
	
	for i=1 to _selection.count do
		(Epoly_v obj:_selection[i]).setMatId i
 
	--select _selection
	completeRedraw() 
)

macroscript	randomMaterial
category:	"_Material"  
buttonText:	"Random"
tooltip:	"Set random material id for selection"
(
	--EditPoly = Epoly_v()
	_selection = (Selection_v()).get()
	print ( "_selection=" + _selection.count as string )
	mat_id	= random 1 32
	
	_selection = (Selection_v()).get()
	print ( "_selection=" + _selection.count as string )
	
	for i=1 to _selection.count do
		(Epoly_v obj:_selection[i]).setMatId mat_id
 
	--select _selection
	completeRedraw() 
)

macroscript	SelectObjsByMaterial
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