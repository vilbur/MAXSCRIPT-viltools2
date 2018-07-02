macroscript enter_subobject_test
category:	"_Subobject_Test" 
buttonText:	"Enter Subobject"
tooltip:	"Loop all elements of current modifier\n-Result in MAXScript Listener"
(
	actionMan.executeAction 0 "40472"  -- MAX Script: MAXScript Listener
	clearListener()

	
	Subobject	= Subobject_v()
	current_modifier	= Subobject.getCurrentModifier()
	subobjects	= Subobject.Subobjects.get  current_modifier
	_objects	= for o in selection where superClassOf o == GeometryClass collect o
	
	print ( "_objects = " + _objects as string )
	if( _objects.count > 0 and subobjects != undefined ) then 
		for s = 1 to subobjects.count do
		(
			Subobject.enter subobjects[s]
			print ( "Macro: enter_subobject_test() Modifier="+current_modifier as string +" Subobject="+subobjects[s] as string +" 		Test: " + (s == subObjectLevel) as string )
		)
	else if( _objects.count == 0 ) then 
		messagebox "Macro: enter_subobject_test:\n\nNOTHING IS SELECTED"
	
	else if( subobjects == undefined ) then 
		messagebox "Macro: enter_subobject_test:\n\nOBJECT IS NOT 'Editable_Poly' OR 'Edit_Poly'"

	--Subobject.enter #vertex
)

macroscript enter_subobject_or_add_modifier_test
category:	"_Subobject_Test" 
buttonText:	"Enter, find or add"
tooltip:	"Enter to subobject or find modifier with subobjects or add edit poly"
(
	actionMan.executeAction 0 "40472"  -- MAX Script: MAXScript Listener
	clearListener()
	
	Subobject	= Subobject_v()
	
	Subobject.enterOrFindModifierOrAddEditPoly #vertex
	
	--current_modifier	= Subobject.getCurrentModifier()
	--subobjects	= Subobject.subobjects current_modifier
	--_objects	= for o in selection where superClassOf o == GeometryClass collect o
	--
	--print ( "_objects = " + _objects as string )
	--if( _objects.count > 0 and subobjects != undefined ) then 
	--	for s = 1 to subobjects.count do
	--	(
	--		Subobject.enter subobjects[s]
	--		print ( "Macro=enter_subobject_test() Modifier="+current_modifier as string +" Subobject="+subobjects[s] as string +" 		Test: " + (s == subObjectLevel) as string )
	--	)
	--else if( _objects.count == 0 ) then 
	--	messagebox "Macro:enter_subobject_test:\n\nNOTHING IS SELECTED"
	--
	--else if( subobjects == undefined ) then 
	--	messagebox "Macro:enter_subobject_test:\n\nObject is not Editable_Poly or Edit_Poly"
	--
	----Subobject.enter #vertex
)