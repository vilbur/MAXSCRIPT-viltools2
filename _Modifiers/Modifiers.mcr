macroscript ModifiersTEST
category:"_Modifiers"  
buttonText:"TEST"
tooltip:""
(
	clearListener()
	Modifiers = Modifiers_v()

	Modifiers.createMaterial()
)

macroscript addEditPoly
category:"_Modifiers"  
buttonText:"Edit Poly"
tooltip:"Add EditPoly"
(
	clearListener()
	Modifiers = Modifiers_v()

	(Modifiers_v()).addEditPoly()
)