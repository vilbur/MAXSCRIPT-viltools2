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
	_objects	= for o in selection where superClassOf o == GeometryClass collect o
	
	for _obj in _objects do
		for x=1 to 20 do (for i=1 to ( polyop.getNumFaces _obj) do ( polyop.makeFacesPlanar _obj #(i)) )
	
	redrawViews()
)

