macroscript autoSmooth
category:"_EditPoly"  
buttonText:"autoSmooth"
tooltip:	"Click Autosmooth\nCtrl+Alt+Shift+Click Clear smooth groups\nCtr+Click Atuosmooth 30"
(
	
	ctrl = keyboard.controlPressed; alt = keyboard.altPressed; shift = keyboard.shiftPressed
	if ctrl == true  and alt == true and shift == true then
		(EditPolyObjects_v()).method "clearSmoothGroups" 

	--	print "Control and Alt and Shift"
	--else if ctrl == true  and alt then
	--	print "Control and Alt"
	else if ctrl == true  and shift == true  then
		(EditPolyObjects_v()).method "autoSmooth" param1:50
	else
	if ctrl == true then
		(EditPolyObjects_v()).method "autoSmooth" param1:30

	else
		(EditPolyObjects_v()).method "autoSmooth" param1:45
	
	
)

macroscript attachSelection
category:"_EditPoly"  
buttonText:"Attach Selected"
(
	EditPoly = EditPoly_v_old()
	
	--macros.run "_Material" "materialByObject"
	
	EditPoly.attachSelection true
)

macroscript bakeObjects
category:"_EditPoly"  
buttonText:"Bake objects"
tooltip:"Attach objects\nSet one smoothgroup\nSet one material id"
(
	clearListener()
	
	macros.run "_EditPoly" "attachSelection"
	macros.run "EditPoly-SmoothGroups" "smoothGroupByObject"
	macros.run "_Material" "materialByObject"
)
