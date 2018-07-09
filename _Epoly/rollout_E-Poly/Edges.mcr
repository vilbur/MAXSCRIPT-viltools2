macroscript	epoly_selectHardEdges
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

macroscript	epoly_splitByHardEdges
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
