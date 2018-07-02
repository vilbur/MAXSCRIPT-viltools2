macroscript enter_subobject_test
category:	"_Subobject_Test" 
buttonText:	"Enter Subobject"
tooltip:	"Loop all elements of current modifier\n-Result in MAXScript Listener"
(
	clearListener()
	actionMan.executeAction 0 "40472"  -- MAX Script: MAXScript Listener

	
	Subobject	= Subobject_v()
	current_modifier	= Subobject.getCurrentModifier()
	subobjects	= Subobject.subobjects current_modifier
	_objects	= for o in selection where superClassOf o == GeometryClass collect o
	
	if( _objects.count > 0 ) then 
		for s = 1 to subobjects.count do
		(
			Subobject.enter subobjects[s]
			print ( "Macro=enter_subobject_test() Modifier="+current_modifier as string +" Subobject="+subobjects[s] as string +" 		Test: " + (s == subObjectLevel) as string )
		)
	else
		messagebox "Macro:enter_subobject_test:\n\nNOTHING IS SELECTED"

	
)