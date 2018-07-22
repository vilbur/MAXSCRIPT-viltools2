macroscript	rotate_toos_rotate
category:	"_Transform"
buttontext:	"Rotate"
toolTip:	"Rotate about active axis\nDefault 	90\nCtrl	180"
--icon:	"#(path, index)"
(
	_angle = 90
	
	ctrl = keyboard.controlPressed; alt = keyboard.altPressed; shift = keyboard.shiftPressed
	
	--if ctrl == true  and alt == true and shift == true then
	--	print "Control and Alt and Shift"
	--else if ctrl == true  and alt then
	--	print "Control and Alt"
	--else if ctrl == true  and shift == true  then
	--	print "Control and Shift"
	--else
	if ctrl == true then
		_angle = 180 
	--else if alt == true then
	--	print "Alt"
	--else if shift == true  then
	--	print "Shift"
	--else
	--	print "Nothing"
	--print ( "tramsform = " + (tramsform as Point3) as string )
	
	(Transform_v()).rotateSelection _angle
)
macroscript	rotate_toos_rotate_back
category:	"_Transform"
buttontext:	"Rotate"
toolTip:	"Rotate about active axis\nDefault	-90\nCtrl	-180"
--icon:	"#(path, index)"
(
	_angle = -90
	
	ctrl = keyboard.controlPressed; alt = keyboard.altPressed; shift = keyboard.shiftPressed
	
	--if ctrl == true  and alt == true and shift == true then
	--	print "Control and Alt and Shift"
	--else if ctrl == true  and alt then
	--	print "Control and Alt"
	--else if ctrl == true  and shift == true  then
	--	print "Control and Shift"
	--else
	if ctrl == true then
		_angle = -180 
	--else if alt == true then
	--	print "Alt"
	--else if shift == true  then
	--	print "Shift"
	--else
	--	print "Nothing"
	--print ( "tramsform = " + (tramsform as Point3) as string )
	
	(Transform_v()).rotateSelection _angle
)
