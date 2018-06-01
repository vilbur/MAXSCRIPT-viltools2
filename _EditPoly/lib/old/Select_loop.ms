



fn Select_loop switchLoop mode =
(
   theObject = modPanel.GetCurrentObject()
	/*
	switchLoop = -1
	*/
	
	if theObject != undefined then
	(
		
		undo "Select_Loop" on
		(	
			Enter_Subobject_CallBackKill()
			
			case classof theObject of
		   (
			Editable_Poly: (
							obj = $
							if subobjectLevel == 2 do (
								obj.setLoopShift switchLoop false mode
							)


				
						)
				Edit_Poly:  (
						

					
								if subobjectLevel == 2 do (
									
									if mode == true then (
										macros.run "PolyTools" "GrowLoop"
									
									)else(
										macros.run "PolyTools" "ShrinkLoop"

									)

									
					
															
-- 									selectedEdges = theObject.GetSelection #edge as array
-- 									selEdgeCount = selectedEdges.count

								)
							)
		   )
		   
		   
		   

		   
		   
	    )
	   
	   
   )
)

