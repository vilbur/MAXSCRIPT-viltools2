macroscript	epoly_select_hard_edges
category:	"_Epoly-Edges"
buttonText:	"Select hard Edges"
tooltip:	"Select HARD edges on all objects"
(
	_selection = (Selection_v()).get()
	--print ( "_selection=" + _selection[1] as string )
	--print ( "_selection=" + _selection.count as string )
	
	for i=1 to _selection.count do
		(Epoly_v()).selectHardEdges _selection[i]
	
	select _selection
	subObjectLevel = 2

)

macroscript	epoly_split_by_hard_edges
category:	"_Epoly-Edges"  
buttonText:	"Split hard Edges"
tooltip:	"Split HARD edges on all objects"
(
	_selection = (Selection_v()).get()
	
	for i=1 to _selection.count do
		((Epoly_v()).selectHardEdges _selection[i]).splitEdges()
	
	select _selection
	subObjectLevel = 2
	
)

macroscript	epoly_select_corner_edges
category:	"_Epoly-Edges"  
buttonText:	"Corner Edges"
tooltip:	"Select Corner Edges, edges where meets 3 polygons"
(
	
	Epoly 	= (Epoly_v())
	--(Epoly_v()).selectCornerEdges()
	verts = Epoly.getAWhereB #vertex #edge "==" 3
	--print ( "verts = " + verts as string )
	subObjectLevel = 1
	Epoly.setSel #Vertex verts
	Epoly.convertSelection #edge
	
)
