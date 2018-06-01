
fn InsertVertex_v  = 	
(
	curObj = modPanel.getCurrentObject()
	--	curObj = modPanel.getCurrentObject ()
	--ModClass = classof curObj

	if  curObj == undefined do ( Max Modify Mode; curObj = modPanel.getCurrentObject ())
--	if  curObj == undefined do 	modPanel.addModToSelection (Edit_Poly ()) ui:on
--	if subObj == 0 do	(SubObjectLevel = 2)
		
	subObj = SubObjectLevel
		
		
		if classof curObj == Editable_Poly or  classof curObj == Edit_Poly  then
		(	
			if SubObjectLevel != 2 then SubObjectLevel = 2
			macros.run "Editable Polygon Object" "EPoly_InsertVertex"
		
		)

	
)

