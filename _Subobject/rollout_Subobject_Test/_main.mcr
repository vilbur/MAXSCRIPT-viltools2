macroscript enter_subobject_vertex
category:"_Subobject"  
buttonText:"Subobjects Loop"
(
	--messagebox "epoly_test" beep:false
	clearListener()
	Subobject	= Subobject_v()
	subobjects	=  Subobject.subobjects()
	print ( "subobjects=" + subobjects as string )
	if( subobjects==undefined ) then
	(
		(Modifiers_v()).addEditPoly()
		subobjects	=  Subobject.subobjects()
	)
		for _subobject in subobjects  do
		(
			Subobject.enter _subobject
			sleep 1
		)
	
	
)
