macroscript convert_to_subobject_1
category:"_Epoly"  
buttonText:"Convert to vertex"
tooltip:	"Convert subobject to vertex"
(
	(Epoly_v()).convertSelection #vertex
)

macroscript convert_to_subobject_edge
category:"_Epoly"  
buttonText:"Convert to edge"
tooltip:	"Convert subobject to edge"
(
	(Epoly_v()).convertSelection #edge
)

macroscript convert_to_subobject_border
category:"_Epoly"  
buttonText:"Convert to border"
tooltip:	"Convert subobject to border"
(
	(Epoly_v()).convertSelection #border
)

macroscript convert_to_subobject_face
category:"_Epoly"  
buttonText:"Convert to face"
tooltip:	"Convert subobject to face"
(
	(Epoly_v()).convertSelection #face
)


macroscript convert_to_subobject_element
category:"_Epoly"  
buttonText:"Convert to element"
tooltip:	"Convert subobject to element"
(
	(Epoly_v()).convertSelection #element
)