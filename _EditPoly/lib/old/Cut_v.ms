fn Cut_v = 	
(		
	undo "Cut_v" on
	(
		curObj = modPanel.getCurrentObject()	

		if curObj == undefined do max modify mode
			
		if classof curObj != Editable_Poly and classof curObj != Edit_Poly  do EditPoly_Add_v()
		
		
		
		
		if classof curObj == Editable_Poly then
		(
			case subobjectLevel of
				(	
					1:(SubObjVar = #CutVertex)
					2:(SubObjVar = #CutEdge )
					3:(SubObjVar = #CutFace )
					4:(SubObjVar = #CutFace )
					5:(SubObjVar = #CutFace )
				)
		curObj.toggleCommandMode SubObjVar 
		)
		else if classof curObj == Edit_Poly then
		(	
			curObj.EnterCommandMode #Cut  
		)
	)
	
)