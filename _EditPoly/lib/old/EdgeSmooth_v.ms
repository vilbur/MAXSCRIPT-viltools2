fn EdgeSmooth_v mode =
(
/*
mode= true
mode= false	
	
EdgeSmooth_v true
EdgeSmooth_v false
	
*/
		curMode = modpanel.getCurrentObject ()
		subObj = subobjectLevel

		if classof curMode != Editable_Poly then 
		(			
			maxOps.CollapseNode $ off
			subobjectLevel = subObj
		)		
		if subobjectLevel != 0 and selection.count > 0 then
		(
		
			if subobjectLevel != 2 then
			(
				
				case subobjectLevel of
				(
					1:$.EditablePoly.ConvertSelection #Vertex #Edge
					3:$.EditablePoly.ConvertSelection #Border #Edge
					4:$.EditablePoly.ConvertSelection #Face #Edge
					5:$.EditablePoly.ConvertSelection #Element #Edge
					
				)				
			)

			
			
		)
		else if subobjectLevel == 0 then		
		(
			subobjectLevel = 2
			$.EditablePoly.SetSelection #Edge #{1..polyop.getNumEdges $}

		)
		
		if subobjectLevel != 2 then subobjectLevel = 2
		EdgeSmooth.Apply mode	
		subobjectLevel = subObj
)