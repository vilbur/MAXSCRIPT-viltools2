fn QuickSlice_v = 	
(		
	undo "QuickSlice_v" on
	(
		curObj = modPanel.getCurrentObject()	

		if curObj == undefined do max modify mode
			
		if classof curObj != Editable_Poly and classof curObj != Edit_Poly  do EditPoly_Add_v()
		
		
		
		
		if classof curObj == Editable_Poly then
		(
		curObj.toggleCommandMode  #QuickSlice 
		)
		else if classof curObj == Edit_Poly then
		(	
			curObj.EnterCommandMode #QuickSlice 
		)
	)
	
)