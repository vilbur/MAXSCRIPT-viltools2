
/** Get edge loop
 */
function getEdgeLoopEditPoly =
(
	obj	= selection[1]
	mod	= modPanel.getCurrentObject()
	edges_selected	= if( classOf ( modPanel.getCurrentObject() ) == Editable_Poly ) then polyop.getEdgeSelection obj else mod.GetSelection #Edge
	edge_verts	= polyop.GetVertsUsingEdge obj edges_selected
	one_edge_verts	= for v in edge_verts where ( (edges_selected * (polyop.getEdgesUsingVert obj v)).numberset	== 1) collect v
	vL1	= #{one_edge_verts[1]}
	this_edge_loop	= #()
	e0	= #{}

	--print ( "edges_selected = " + edges_selected as string )
	--print ( "edge_verts = " + edge_verts as string )
	--print ( "returnBitArray = " + returnBitArray as string )
	--print ( "one_edge_verts = " + one_edge_verts as string )
	
	for vv in edge_verts do
	(
		e1 = (edges_selected * ( polyop.getEdgesUsingVert obj vL1)) - e0
		if not e1.isEmpty then
		(
			for i in e1 do appendIfUnique this_edge_loop i
			vL1 = (polyop.getVertsUsingEdge obj e1) - vL1
			e0 = e1
		)	
	)	
	format "Edge order: % \n" this_edge_loop
	
)

getEdgeLoopEditPoly()


