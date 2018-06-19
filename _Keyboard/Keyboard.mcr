
macroScript _KeyboardTest
	category:	"_Keyboard"
	buttontext:	"_KeyboardTest"
	toolTip:	"_Keyboard Test Tooltip"
(
	
	ctrl = keyboard.controlPressed; alt = keyboard.altPressed; shift = keyboard.shiftPressed
	if ctrl == true  and alt == true and shift == true then
		print "Control and Alt and Shift"
	else if ctrl == true  and alt then
		print "Control and Alt"
	else if ctrl == true  and shift == true  then
		print "Control and Shift"
	else if ctrl == true then
		print "Control"
	else if alt == true  then
		print "Alt"
	else if shift == true  then
		print "Shift"
	else
		print "Nothing"
		
	
)

