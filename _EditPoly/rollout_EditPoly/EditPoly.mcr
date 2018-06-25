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
	EditPoly = EditPoly_v()
	
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

macroscript selectHardEdges
category:"_EditPoly"  
buttonText:"Select HARD"
tooltip:"Select HARD edges on all objects"
(
	_selection = (Selection_v()).get()
	--print ( "_selection=" + _selection[1] as string )
	--print ( "_selection=" + _selection.count as string )
	
	for i=1 to _selection.count do
		(EditPoly_v obj: _selection[i]).selectHardEdges()
	
	select _selection
	subobjectLevel = 2   

)
macroscript splitByHardEdges
category:"_EditPoly"  
buttonText:"Split HARD"
tooltip:"Split HARD edges on all objects"
(
	_selection = (Selection_v()).get()
	--print ( "_selection=" + _selection[1] as string )
	--print ( "_selection=" + _selection.count as string )
	
	for i=1 to _selection.count do
		((EditPoly_v obj: _selection[i]).selectHardEdges()).splitEdges()
	
	select _selection
	subobjectLevel = 2   

)