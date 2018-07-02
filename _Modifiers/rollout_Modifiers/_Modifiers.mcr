
--macroscript modifier_add_test
--category:"_Modifiers"  
--buttonText:"Add Test"
--tooltip:"Modifier get"
--(
--	clearListener()
--
--	--(Modifier_v type:#Edit_Poly name:"Edit Poly Test").add()
--	--(Modifier_v type:#Chamfer name:"Chamfer Test").add()
--	--(Modifier_v type:#xForm name:"Xform Test").add()
--	
--	redrawViews()
--)

macroscript modifier_add_editpoly
category:"_Modifiers"  
buttonText:"EditPoly"
tooltip:"Add EditPoly"
(
	--clearListener()

	_Edit_Poly = (Modifier_v type:#Edit_Poly ).add()

	--Xform.resetObject()
	
	redrawViews()
)
macroscript modifier_add_normal
category:"_Modifiers"  
buttonText:"Normal"
tooltip:"Add Normal"
(
	_Normal = (Modifier_v type:#Normal ).add()

	redrawViews()
)
macroscript modifier_add_shell
category:"_Modifiers"  
buttonText:"Shell"
tooltip:"Add Shell"
(
	_Shell = (Modifier_v type:#Shell ).add()

	redrawViews()
)

macroscript modifier_resetXform
category:"_Modifiers"  
buttonText:"Xform"
tooltip:"Reset Xform"
(
	--clearListener()
	Xform = (XForm_Modifier_v())

	Xform.resetObject()
)

macroscript modifier_Relax
category:"_Modifiers"  
buttonText:"Relax"
tooltip:"Reset Relax"
(
	--clearListener()
	(Modifier_v type:#Relax).add()

)



