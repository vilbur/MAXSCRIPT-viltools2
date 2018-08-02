macroscript	epoly_convert_subobject_to_1
category:"_Epoly-Selection"  
buttonText:"Convert to vertex"
tooltip:	"Convert subobject to vertex"
(
	(Epoly_v()).Sel.convertSelection #vertex
)

macroscript	epoly_convert_subobject_to_edge
category:"_Epoly-Selection"  
buttonText:"Convert to edge"
tooltip:	"Convert subobject to edge"
(
	(Epoly_v()).Sel.convertSelection #edge
)

macroscript	epoly_convert_subobject_to_border
category:"_Epoly-Selection"  
buttonText:"Convert to border"
tooltip:	"Convert subobject to border"
(
	(Epoly_v()).Sel.convertSelection #border
)

macroscript	epoly_convert_subobject_to_face
category:"_Epoly-Selection"  
buttonText:"Convert to face"
tooltip:	"Convert subobject to face"
(
	(Epoly_v()).Sel.convertSelection #face
)

macroscript	epoly_convert_subobject_to_element
category:"_Epoly-Selection"  
buttonText:"Convert to element"
tooltip:	"Convert subobject to element"
(
	(Epoly_v()).Sel.convertSelection #element
)