
macroscript modifier_add_test
category:"_Modifiers"  
buttonText:"Add Test"
tooltip:"Modifier get"
(
	clearListener()

	--(Modifier_v type:#Edit_Poly name:"Edit Poly Test").add()
	--(Modifier_v type:#Chamfer name:"Chamfer Test").add()
	--(Modifier_v type:#xForm name:"Xform Test").add()
	
	redrawViews()
)

macroscript modifier_add_editpoly
category:"_Modifiers"  
buttonText:"Add EditPoly"
tooltip:"Add EditPoly"
(
	--clearListener()

	_Edit_Poly = (Modifier_v type:#Edit_Poly ).add()

	--Xform.resetObject()
	
	redrawViews()
)
macroscript modifier_add_normal
category:"_Modifiers"  
buttonText:"Add Normal"
tooltip:"Add Normal"
(
	--clearListener()

	_Normal = (Modifier_v type:#Normal ).add()

	--Xform.resetObject()
	
	redrawViews()
)

macroscript modifier_resetXform
category:"_Modifiers"  
buttonText:"Reset Xform"
tooltip:"Xform"
(
	--clearListener()
	Xform = (XForm_Modifier_v())

	Xform.resetObject()
)
