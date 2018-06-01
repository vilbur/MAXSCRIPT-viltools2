
fn Connect_v  = 	
(
	curObj = modPanel.getCurrentObject()
	subObj = SubObjectLevel
	
--	if subObj == 0 do	(SubObjectLevel = 2)
		
		
	
	undo "Connect_v" on
	(
		
		if classof curObj == Editable_Poly then
		(
			if subObj == 4 then ($.EditablePoly.ConvertSelection #face #vertex ; SubObjectLevel = 1; curObj.ConnectVertices () )
				else if subObj == 1 then
			curObj.ConnectVertices () 
				else if subObj == 2 then	
			curObj.ConnectEdges ()						
		)
		else if classof curObj == Edit_Poly then
		(	
			if subObj == 4 or subObj == 5 then (curObj.ConvertSelection #face #vertex ; SubObjectLevel = 1; curObj.ButtonOp #ConnectVertices )
				else if subObj == 1 then
			curObj.ButtonOp #ConnectVertices 
				else if subObj == 2 then	
			curObj.ButtonOp #ConnectEdges
		)
	)

)

