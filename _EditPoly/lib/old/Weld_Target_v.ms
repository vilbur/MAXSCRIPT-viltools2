fn Weld_Target_v = --start	
(
	undo "Weld_Target_v" on
	(
			
		curObj = modPanel.getCurrentObject ()
		subObj = SubObjectLevel
		sel = for o in selection where superclassof o == GeometryClass collect o
		
		if  curObj == undefined do ( Max Modify Mode)
		if classof curObj != Editable_Poly and classof curObj != Edit_Poly then	
		(
			modPanel.addModToSelection (Edit_Poly ()) ui:on
			curObj = modPanel.getCurrentObject ()
		)

		
		case (classof curObj) of
		(
				Editable_Poly:	(
									obj = sel[1]
									vertSel = polyop.getVertSelection obj as array
									LastvertPos = polyop.getVert obj vertSel[vertSel.count]
									deleteitem vertSel vertSel.count
									curObj.collapse #Vertex 
									curObj.collapse #Vertex 
									
									(polyop.setVert obj ( polyop.getVertSelection obj) vertPos) 

					
								)
				Edit_Poly:		(
									selCount = ((curObj.GetSelection #Vertex) as array).count
									if selCount == 0 then 
									(actionMan.executeAction 0 "40021"  -- Selection: Select All
									SubObjectLevel = 1)
									oldTres = curObj.weldVertexThreshold
									curObj.weldVertexThreshold  = treshold
									curObj.ButtonOp #WeldVertex
									curObj.weldVertexThreshold = oldTres
									if selCount == 0 then curObj.SetSelection #Vertex #{}
								)
		)
		
	)
)