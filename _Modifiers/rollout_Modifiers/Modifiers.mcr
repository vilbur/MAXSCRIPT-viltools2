macroscript modifier_chamfer
category:"_Modifiers"  
buttonText:"Chamfer"
tooltip:""
(
	--clearListener()
	Modifiers = Modifiers_v()
	Modifiers.addChamfer()
	
)

macroscript addEditPoly
category:"_Modifiers"  
buttonText:"Edit Poly"
tooltip:"Add EditPoly"
(
	--clearListener()
	Modifiers = Modifiers_v()

	(Modifiers_v()).addEditPoly()
)