
fn Connect_Options_v  = 	
(
	curObj = modPanel.getCurrentObject()
	subObj = SubObjectLevel
	
--	if subObj == 0 do	(SubObjectLevel = 2)
		
		
	
	undo "Connect_v" on
	(
		
		if classof curObj == Editable_Poly or classof curObj == Edit_Poly  then
		(
			if subObj == 2 then 
			(
			curObj.PopupDialog #ConnectEdges	
			)					
		)
		
	)

)

/*
			(curObj.PopupDialog #ConnectEdges)
			(curObj.PopupDialog #ConnectEdges)



*/