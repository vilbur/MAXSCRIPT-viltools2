macroscript epoly_spinEdge
category:	"_Epoly"
tooltip:	"Spin Edge"
buttontext:	"Spin Edge"
(
	--SpinEdge 
	--Version 1.0
	--Started: 2004/12/06
	--Edited:  2004/12/06
	--Code by Borislav "Bobo" Petrov 
	--Copyright (c) 2004
	
	--Make sure exactly one object is selected, it is in Edge SO mode and it is either EditablePoly base object or Edit_Poly modifier.
	on isEnabled return 
		selection.count == 1 and subObjectLevel == 2 and ( classof (modPanel.getCurrentObject()) == Editable_Poly or classof (modPanel.getCurrentObject()) == Edit_Poly )
		
	--when executed, do the magic:	
	on execute do
	(
		theObject = modPanel.getCurrentObject() --get the object from the modifier stack
		if classof theObject == Edit_Poly then theMode = 1 else theMode = 0 --see what class it is to decide which code to use
		
		--get the selected edges using the corresponding syntax for Epoly or Edit_Poly:
		if theMode == 0 then
			theEdges = ((polyOp.getEdgeSelection theObject ) as array)  
		else
			theEdges = (theObject.GetSelection #Edge node:selection[1]) as array
			
		if theEdges.count == 1 then --check to make sure only one edge is selected
		(
			theEdge = theEdges[1]  --if only one, get its index!
			if theMode == 0 then  --if EditablePoly is selected in Modifier panel, then
			(
				theFaces = (polyOp.getFacesUsingEdge theObject theEdge) as array --grab the faces sharing the selected edge as array
				if theFaces.count == 2 then
				(
					theEdgeVerts = (polyOp.getVertsUsingEdge theObject theEdge)  --grab the vertices on both sides of the edge as bitArray
					thePolyEdges1 = (polyOp.getEdgesUsingFace theObject theFaces[1]) - #{theEdge} --grab all edges of the first face except the selected one
					thePolyEdges2 = (polyOp.getEdgesUsingFace theObject theFaces[2]) - #{theEdge} --grab all edges of the second face except the selected one
					
					--get all edges using the first vertex of the selected edge except the selected edge itself.
					--then take the intersection with the edges of the first polygon, convert to array and grab the first edge
					theNeighbourEdge1 = ((( (polyOp.getEdgesUsingVert theObject (theEdgeVerts as array)[1]) - #{theEdge} ) * thePolyEdges1 ) as array)[1]
					--repeat for the second polygon.
					--This gives us knowledge which edges are part of the one or the other polygon AND share a vertex with the selected edge
					--(which is the only one that belongs to both polygons)
					theNeighbourEdge2 = ((( (polyOp.getEdgesUsingVert theObject (theEdgeVerts as array)[2]) - #{theEdge} ) * thePolyEdges2 ) as array)[1]
					
					--Create an array of the first vertex of both edges collected above.
					--Then sort the array to keep the vertices in ascending order.
					newVerts = sort #( 
								(((polyOp.getVertsUsingEdge theObject theNeighbourEdge1) -  theEdgeVerts) as array)[1],
								(((polyOp.getVertsUsingEdge theObject theNeighbourEdge2) -  theEdgeVerts) as array)[1] 
							)
			
					theObject.remove selLevel:#edge --remove the currently selected edge, turning both polygons into one.
					
					if keyboard.shiftPressed then --depending on the state of the SHIFT key when pressing the script's button, create edge in the one or the other direction
						theObject.createEdge newVerts[2] newVerts[1] select:true
					else	
						theObject.createEdge newVerts[1] newVerts[2] select:true
				)
				else --if the edge does not have two polygons, let the user know!
					pushPrompt "Cannot Spin an OPEN Edge!"		
			)	
			else	--if the object in Modifier Stack is Edit_Poly, work here instead...
			(
				theFaces = #()  --init. an array to collect the faces of the selected edge
				theFace1 = theObject.getEdgeFace theEdge 1 --grab the first one
				theFace2 = theObject.getEdgeFace theEdge 2 --and the second one
				if theFace1 > 0 do append theFaces theFace1 --if it is valid, add it to the array
				if theFace2 > 0 do append theFaces theFace2 --same with the second one
				
				if theFaces.count == 2 then --if two faces collected, continue...
				(
					theEdgeVerts = #{ (theObject.getEdgeVertex theEdge 1), (theObject.getEdgeVertex theEdge 2) } --collect the two vertices of the selected edge
					
					--collect the edges of the first polygon except the selected one
					thePolyEdges1 = ((for i = 1 to (theObject.GetFaceDegree theFaces[1]) collect (theObject.getFaceEdge theFaces[1] i) ) as bitArray) - #{theEdge}
					--collect the edges of the second polygon except the selected one
					thePolyEdges2 = ((for i = 1 to (theObject.GetFaceDegree theFaces[2]) collect (theObject.getFaceEdge theFaces[2] i) ) as bitArray) - #{theEdge}
					
					--collect the edges that share the first vertex of the selected edge and are used by the first polygon, take the first one
					theNeighbourEdge1 = ((((( for i = 1 to (theObject.GetVertexEdgeCount (theEdgeVerts as array)[1]) collect theObject.getVertexEdge (theEdgeVerts as array)[1] i) as bitArray) - #{theEdge} ) * thePolyEdges1 ) as array)[1]
					--collect the edges that share the second vertex of the selected edge and are used by the second polygon, take the first one
					theNeighbourEdge2 = ((((( for i = 1 to (theObject.GetVertexEdgeCount (theEdgeVerts as array)[2]) collect theObject.getVertexEdge (theEdgeVerts as array)[2] i) as bitArray) - #{theEdge} ) * thePolyEdges2 ) as array)[1]
					
					--grab the vertices of the neighbour edge determined above, remove the vertices of the selected edge and take the remaining one
					newVert1 = ((#{theObject.getEdgeVertex theNeighbourEdge1 1, theObject.getEdgeVertex theNeighbourEdge1 2} - theEdgeVerts ) as array)[1]
					newVert2 = ((#{theObject.getEdgeVertex theNeighbourEdge2 1, theObject.getEdgeVertex theNeighbourEdge2 2} - theEdgeVerts ) as array)[1]
					
					--sort the two vertices in ascending order
					newVerts = sort #( newVert1, newVert2)
					
					--remove the selected edge to turn the two polys into one...
					theObject.ButtonOp #RemoveEdge 
					
					--depending on the state of the SHIFT key, connect the vertices in descending or ascending order
					if keyboard.shiftPressed then		
						theObject.CreateEdge newVerts[2] newVerts[1] node:selection[1]
					else	
						theObject.CreateEdge newVerts[1] newVerts[2] node:selection[1]
					theObject.Commit() --commit the change to create two polys again.
				)	
				else --open edge is a no-no
					pushPrompt "Cannot Spin an OPEN Edge!"					
			)--end Edit_Poly code
		)--end if one edge	
		else --let the user know he did not select a single edge!
			pushPrompt "Select EXACTLY Only Edge to Spin!"
	)--end execute
)--end macro