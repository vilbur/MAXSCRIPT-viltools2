macroscript samdosoft_export
category:"_Smadosoft"  
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

