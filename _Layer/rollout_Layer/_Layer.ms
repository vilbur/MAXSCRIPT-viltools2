
/** Checkbutton test
 */
function checkbuttonTest =
(
	messageBox "checkbuttonTest"	
	checkbutton_test.text = "XXX"
)


rollout_objects	= __GLOBAL__v.Floater.roll "" "rollout_layer" 
_controls_1	= rollout_objects.controls groupbox:"Test"


(_controls_1.checkbutton "checkbutton test").changed "(Layer_v()).toggle #export #edit"


--(_controls_1.button "button_foo").pressed ( "messagebox ("+_Checkbox_A.prop ("state") +" as string) ")
