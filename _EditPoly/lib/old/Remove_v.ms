
fn Remove_v = 
(

	undo "Remove_v" on
	(
		
		sel = for o in selection where superclassof o == GeometryClass collect o
	
		if subobjectLevel != 0 then
		(
			curObj = modPanel.getCurrentObject ()
			if classof curObj == editable_poly then
			(
	-- 			$.EditablePoly.Remove ()
				if subobjectLevel != 2 then curObj.Remove selLevel:#CurrentLevel 
				else			----------Remove edge with vertices
				(
			
					macros.run "PolyTools" "RemoveLoop"

						
				)
				
				
				
			)
			else if classof curObj == edit_poly then
			(
				for o in sel do
				(
					curObj = modPanel.getCurrentObject ()
					
				case subobjectLevel of
					(
							
						1:(comonentToRemove = #RemoveVertex)
						2:(comonentToRemove = #RemoveEdgeRemoveVertices)
						3:(comonentToRemove = #RemoveEdgeRemoveVertices)
						4:(curObj.ConvertSelection #Face #Vertex;comonentToRemove = #DeleteFace )
						5:(curObj.ConvertSelection #Face #Vertex;comonentToRemove = #DeleteFace )
					)
					
					curObj.ButtonOp comonentToRemove

					
				)
			)
		)
		else
		(
			curObj = modPanel.getCurrentObject ()
			if curObj != undefined and superclassof curObj == modifier then deletemodifier sel curObj
			
		)
	)
)
