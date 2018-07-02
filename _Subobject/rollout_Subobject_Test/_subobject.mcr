macroscript enter_subobject_test
category:	"_Subobject_Test" 
buttonText:	"Enter Subobject"
tooltip:	"Loop all edit poly elements"
(
	--messagebox "epoly_test" beep:false
	clearListener()
	Subobject	= Subobject_v()
	subobjects	= #(#vertex, #edge, #border, #polygon, #element)
	
	for s = 1 to subobjects.count do
	(
		Subobject.enter subobjects[s]

		print ( "enter_subobject_test suboboject "+subobjects[s] as string +"	=	" + (s == subObjectLevel) as string )
		
	)
		
	
	--subobjects	= Subobject.subobjects()
	--print ( "subobjects=" + subobjects as string )
	--if( subobjects==undefined ) then
	--(
	--	(Modifiers_v()).addEditPoly()
	--	subobjects	=  Subobject.subobjects()
	--)
	--	for _subobject in subobjects  do
	--	(
	--		Subobject.enter _subobject
	--		sleep 1
	--	)
	
	
)


--macroscript enter_subobject_loop_test
--category:"_Subobject_Test"  
--buttonText:"Subobjects Loop"
--(
--	--messagebox "epoly_test" beep:false
--	clearListener()
--	Subobject	= Subobject_v()
--	subobjects	= Subobject.subobjects()
--	print ( "subobjects=" + subobjects as string )
--	if( subobjects==undefined ) then
--	(
--		(Modifiers_v()).addEditPoly()
--		subobjects	=  Subobject.subobjects()
--	)
--		for _subobject in subobjects  do
--		(
--			Subobject.enter _subobject
--			sleep 1
--		)
--	
--	
--)
