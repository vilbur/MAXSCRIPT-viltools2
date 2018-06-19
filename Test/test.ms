

subObj = subObjectLevel

sel = for o in selection where classof o.baseobject == Editable_Poly collect o

for i=1 to sel.count do
(

	o	= sel[i]
	MatID	= i
	select o 
	max modify mode	
	local EditPolyMode
	curMod = modPanel.getcurrentObject ()	

	if classof curMod != Editable_Poly then   -----try find edit poly mdifier
	(
		EditPolyMode = (for m in o.modifiers where  classof m == Edit_Poly collect m)[1]
		
		if EditPolyMode != undefined then
		(		

		if curMod != EditPolyMode then modPanel.setcurrentObject EditPolyMode
			
			if subObj == 0 then 
			(
				
				subobjectLevel = 4
				EditPolyMode.Select #Face #{1..(polyop.getNumFaces o) } node:o
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
-- 					modPanel.setCurrentObject o.baseObject	
-- 					modPanel.getCurrentObject ()
		
		
		curMod = o.baseObject
		
		if subObj == 0 then 
		(
			print ("DEBOG o" + o.name)
-- 					o = sel[1]
			subobjectLevel = 4
			curMod.SetSelection #Face #{1..(polyop.getNumFaces o) }
		)
		
		if subobjectLevel == 4 or  subobjectLevel == 5 then 
		(
			facelist = (curMod.GetSelection #Face) as array
			polyop.setFaceMatID o facelist MatID
		)
	)
	
	if subObj != undefined then subobjectLevel = subObj
	select sel
)