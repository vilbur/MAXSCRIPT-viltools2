macroscript samdosoft_export
category:"_Samdosoft"  
buttonText:"Export"
tooltip:"Export"
(
	
	Xform = (XForm_Modifier_v())

	Xform.resetObject()
	
	modPanel.addModToSelection (smooth ()) ui:on
	modPanel.addModToSelection (Materialmodifier ()) ui:on
	
	(Selection_v()).collapse()
	
	(Selection_v()).name "file"

	
)


macroscript samdosoft_planar
category:"_Samdosoft"  
buttonText:"Planar"
tooltip:"Planarize Faces"
(
	for x=1 to 20 do (for i=1 to (polyop.getNumFaces $) do ( polyop.makeFacesPlanar $ #(i)) )
	
	redrawViews()
)

