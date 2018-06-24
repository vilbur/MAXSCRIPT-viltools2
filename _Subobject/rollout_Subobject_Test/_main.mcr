macroscript enter_subobject_vertex
category:"_Subobject"  
buttonText:"Enter vertex"
(
	--messagebox "epoly_test" beep:false
	clearListener()
	Subobject	= Subobject_v()
	subobjects	=  Subobject.subobjects()
	print ( "subobjects=" + subobjects as string )
	if( subobjects!=undefined ) then
	(
		for _subobject in subobjects  do
		(
			Subobject.enter _subobject
			sleep 1
		)
	)
	
	
)
