
fn Chamfer_v OptionsVar = 	
(
	curObj = modPanel.getCurrentObject()
	subObj = SubObjectLevel
	
--	if subObj == 0 do	(SubObjectLevel = 2)
		
	if OptionsVar == 1 then 
		(
		
			if classof curObj == Editable_Poly then
			(
				if subObj == 4 do ($.EditablePoly.ConvertSelection #Face #Edge ; SubObjectLevel = 2)
				(curObj.PopupDialog #Chamfer)
			)
			else if classof curObj == Edit_Poly then
			(	
				if subObj == 4 or subObj == 5 do (curObj.ConvertSelection #Face #Edge ; SubObjectLevel = 2)
				case subobjectLevel of
					(	
						1:(SubObjVar = #ChamferVertex)
						2:(SubObjVar = #ChamferEdge)
						3:(SubObjVar = #ChamferEdge)
					)
				
				(curObj.PopupDialog SubObjVar)
			)
		)
		else
		(
			
			If SubObjectLevel == undefined then Max Modify Mode
			 A = modPanel.getCurrentObject()
			-- default to Edge level:
			if subobjectLevel > 3 then subobjectLevel = 2
			if subobjectLevel == 0 then subobjectLevel = 2
			if subobjectLevel == 1 then (A.toggleCommandMode #ChamferVertex)
			else (A.toggleCommandMode #ChamferEdge)	
			
		)
		
	

	
)

/*
			curObj.ButtonOp #ChamferEdge


*/