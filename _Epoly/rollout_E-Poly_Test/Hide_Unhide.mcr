
macroscript	epoly_hide_subobject_test
category:	"_Epoly-Test"  
buttonText:	"Hide\Unhide"
tooltip:	"Hide unselected subobjects"
(
	Epoly = Epoly_v()
	
	Epoly.hideObj "UnSelected" 1 0
)

macroscript	epoly_unhide_subobject_test
category:	"_Epoly-Test"  
buttonText:	"Hide\Unhide"
tooltip:	"Unhide subobjects"
(
	Epoly = Epoly_v()
	
	Epoly.hideObj "UnHide" 1 0
)


macroscript	epoly_hide_subobject_toggle_test
category:	"_Epoly-Test"  
buttonText:	"Hide\Unhide Toggle"
tooltip:	"Hide unselected\Unhhide subobjects toggle"
(
	if( global_hide_subobject_state == undefined ) then
		global global_hide_subobject_state
	
	global_hide_subobject_state = if( global_hide_subobject_state != "UnHide" ) then "UnHide" else "UnSelected"
	
	Epoly = Epoly_v()
	
	Epoly.hideObj global_hide_subobject_state 1 0
	
)
