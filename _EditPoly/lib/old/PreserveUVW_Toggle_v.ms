fn PreserveUVW_Toggle_v = 
(
	if selection.count > 0 then
	(
		obj = selection[1]		
		curObj = modPanel.getCurrentObject()

		if	(classof curObj == Editable_Poly) Then
		(
			if obj.preserveUVs == off then obj.preserveUVs = on else obj.preserveUVs = off 
		) --condition not valid
		else
		(
			if(classof curObj == Edit_Poly) then
				(
					(
						if obj.modifiers[#Edit_Poly].preserveUVs == off then obj.modifiers[#Edit_Poly].preserveUVs = on else obj.modifiers[#Edit_Poly].preserveUVs = off 		
					)

				)
		)
		

		global wTC2 = red
		wText "PreserveUVs" ("     " + obj.preserveUVs as string) "" ""
	)
 ) --ScriptEnd
	
	