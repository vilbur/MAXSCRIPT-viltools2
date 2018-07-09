macroscript	enter_subobject_test
category:	"_Subobject-Test" 
buttonText:	"Enter Subobjects"
tooltip:	"Loop all elements of current modifier\n-Result in MAXScript Listener"
(
	actionMan.executeAction 0 "40472"  -- MAX Script: MAXScript Listener
	clearListener()

	Subobject	= Subobject_v()
	current_modifier	= Subobject._getCurrentModifier()
	subobjects	= Subobject.Subobjects.get  current_modifier
	_objects	= for o in selection where superClassOf o == GeometryClass collect o
	
	--print ( "_objects = " + _objects as string )
	if( _objects.count > 0 and subobjects != undefined ) then 
		for s = 1 to subobjects.count do
		(
			Subobject.enter s
			print ( "Macro: enter_subobject_test() Modifier="+current_modifier as string +" Subobject="+subobjects[s] as string +" 		Test: " + (s == subObjectLevel) as string )
		)
		
	else if( _objects.count == 0 ) then 
		messagebox "Macro: enter_subobject_test:\n\nNOTHING IS SELECTED"
	
	else if( subobjects == undefined ) then 
		messagebox "Macro: enter_subobject_test:\n\nOBJECT IS NOT 'Editable_Poly' OR 'Edit_Poly'"
		
)

macroscript	enter_subobject_forced_test
category:	"_Subobject-Test" 
buttonText:	"Enter forced"
tooltip:	"Enter to subobject or find modifier with subobjects or add edit poly"
(
	actionMan.executeAction 0 "40472"  -- MAX Script: MAXScript Listener
	clearListener()
	
	Subobject	= Subobject_v()
	
	Subobject.enterForced 1
)