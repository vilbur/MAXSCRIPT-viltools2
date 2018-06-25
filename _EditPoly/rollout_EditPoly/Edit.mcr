macroscript chamfer_hard_edges
category:"_EditPoly"  
buttonText:"Chmafer HARD"
tooltip:	"Chmafer HARD edges"
(
	
	clearListener()
	
	
	Modifiers = Modifiers_v()

	
	--modPanel.addModToSelection (Edit_Poly name:"select_hardedges" ignoreBackfacing:on selectAngle:20 SelectByAngle:on ) ui:on

-- 	macros.run "_EditPoly" "selectHardEdges"
	--
	Modifiers.addChamfer()
	
	
)

