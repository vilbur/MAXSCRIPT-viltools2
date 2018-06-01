
fn InsetPoly_v  = 	
(
	curObj = modPanel.getCurrentObject()
	subObj = SubObjectLevel
	
--	if subObj == 0 do	(SubObjectLevel = 2)
		
		
	
	undo "InsetPoly_v" on
	(
		
		if classof curObj == Editable_Poly then
		(
			if subObj == 4 do 
			(curObj.PopupDialog #inset)
		)
		else if classof curObj == Edit_Poly then
		(	
			if subObj == 4 do
			(curObj.PopupDialog #inset)
		)
	)
	
)

