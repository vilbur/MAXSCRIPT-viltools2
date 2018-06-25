macroscript enter_subobject_vertex
category:"_Subobject"  
buttonText:"vertex"
(
	--messagebox "epoly_test" beep:false
	clearListener()
	Subobject	= Subobject_v()
	subobjects	= Subobject.subobjects()
	print ( "subobjects=" + subobjects as string )
	if( subobjects==undefined ) then
	(
		(Modifiers_v()).addEditPoly()
		subobjects	=  Subobject.subobjects()
	)
	
	Subobject.enter #vertex

	
)
macroscript enter_subobject_edge
category:"_Subobject"  
buttonText:"edge"
(
	--messagebox "epoly_test" beep:false
	clearListener()
	Subobject	= Subobject_v()
	subobjects	= Subobject.subobjects()
	print ( "subobjects=" + subobjects as string )
	if( subobjects==undefined ) then
	(
		(Modifiers_v()).addEditPoly()
		subobjects	=  Subobject.subobjects()
	)
	
	Subobject.enter #edge

	
)
macroscript enter_subobject_polygon
category:"_Subobject"  
buttonText:"polygon"
(
	--messagebox "epoly_test" beep:false
	clearListener()
	Subobject	= Subobject_v()
	subobjects	= Subobject.subobjects()
	print ( "subobjects=" + subobjects as string )
	if( subobjects==undefined ) then
	(
		(Modifiers_v()).addEditPoly()
		subobjects	=  Subobject.subobjects()
	)
	
	Subobject.enter #polygon

	
)
macroscript enter_subobject_element
category:"_Subobject"  
buttonText:"element"
(
	--messagebox "epoly_test" beep:false
	clearListener()
	Subobject	= Subobject_v()
	subobjects	= Subobject.subobjects()
	print ( "subobjects=" + subobjects as string )
	if( subobjects==undefined ) then
	(
		(Modifiers_v()).addEditPoly()
		subobjects	=  Subobject.subobjects()
	)
	
	Subobject.enter #element

	
)