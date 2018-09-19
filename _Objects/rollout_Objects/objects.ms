


rollout_objects	= __GLOBAL__v.Floater.roll "" "rollout_objects" 
_controls_1	= rollout_objects.controls groupbox:"Test"

_Checkbox_A = _controls_1.checkbox "Checkbox A" id:#checkbox_a_test
--(_controls_1.button "button_foo").pressed ( "messagebox ("+_Checkbox_A.prop ("state") #get +" as string) ")
