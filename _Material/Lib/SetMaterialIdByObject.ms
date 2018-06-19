subObj = subObjectLevel

sel = for obj in selection where classof obj.baseobject == Editable_Poly collect obj


for i=1 to sel.count do
(

	obj	= sel[i]
	MatID	= i
	select obj 
	max modify mode	
	local EditPolyMode
	curMod = modPanel.getcurrentObject ()	

	if classof curMod != Editable_Poly then   -----try find edit poly mdifier
	(
		EditPolyMode = (for m in obj.modifiers where  classof m == Edit_Poly collect m)[1]
		
		if EditPolyMode != undefined then
		(		

		if curMod != EditPolyMode then modPanel.setcurrentObject EditPolyMode
			
			if subObj == 0 then 
			(
				
				subobjectLevel = 4
				EditPolyMode.Select #Face #{1..(polyop.getNumFaces obj) } node:obj
			)
			if subobjectLevel == 4 or  subobjectLevel == 5 then 
			(
				EditPolyMode.SetOperation #SetMaterial
				EditPolyMode.materialIDToSet = MatID-1
				EditPolyMode.Commit ()
			)
		)
	)
	
	if classof curMod == Editable_Poly then  --- edit editabe poly if edit poly mdifiers is not on object
	(		
-- 					max modify mode	
-- 					modPanel.setCurrentObject obj.baseObject	
-- 					modPanel.getCurrentObject ()
		
		
		curMod = obj.baseObject
		
		if subObj == 0 then 
		(
			print ("DEBOG obj" + obj.name)
-- 					obj = sel[1]
			subobjectLevel = 4
			curMod.SetSelection #Face #{1..(polyop.getNumFaces obj) }
		)
		
		if subobjectLevel == 4 or  subobjectLevel == 5 then 
		(
			facelist = (curMod.GetSelection #Face) as array
			polyop.setFaceMatID obj facelist MatID
		)
	)
	
	if subObj != undefined then subobjectLevel = subObj
	select sel
)