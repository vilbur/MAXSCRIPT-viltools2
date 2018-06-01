
fn SelectTopFaces_v objArray TheMode = --start	
(
-- 	o=$
		max modify mode
-- 	/*local*/ objArray = for o in selection where classof o.baseobject == editable_poly or classof o.baseobject == PolyMeshObject  collect o
-- 		objArray = vilTools_InstanceTest objArray
		curMod = modPanel.getcurrentObject ()	
		
		if curMod == undefined then 
		(
			addModifier objArray (Edit_Poly ()) 
			max create mode
			max modify mode
			curMod = modPanel.getcurrentObject ()			
		)	
-- 		obj = objArray[1]
-- 	 	obj = selection[2]
-- 		TheMode= true
-- 		TheMode= false
		subobjectlevel = 4
		max select none
-- 		if  classof curMod == edit_poly then  for obj in objArray do  curMod.SetSelection #Face #{} node:obj else curMod.Select #Face #{} node:obj		

		for obj in objArray do 
		(						
			FinalFaces = #{}

			for f=1 to polyop.getNumFaces obj do
			(
		-- 		polyop.getFaceNormal obj 124		node:obj
	-- 		polyop.setFaceSelection obj f			
				faceNormal = polyop.getFaceNormal obj f node:obj	
-- 				faceNormal = polyop.getFaceNormal obj 4 node:obj	

				if TheMode then 
				(
					if faceNormal.z > 0.666 then append FinalFaces f
				)
				else 
				(
					if faceNormal.z < 0.666 then append FinalFaces f
				)
			)
			
			
	
			
			
	-- 				polyop.setFaceSelection selection[1] #{255}
	-- 		polyop.setFaceSelection selection[2]  #{255}]
			if  classof curMod == editable_poly then 
			(
				curMod.SetSelection #Face #{}
				curMod.SetSelection #Face FinalFaces
				)
			else 
				(
				curMod.Select #Face #{} node:obj
				curMod.Select #Face FinalFaces node:obj
				)
				
				
		)
	
	
	
-- 	polyop.setFaceSelection obj FinalFaces	

		redrawviews()
	
	
)

