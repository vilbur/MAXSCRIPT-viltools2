
macroscript	layer_turn_on_layer_edit
category:	"_Layer"
buttontext:	"Edit"
toolTip:	"Turn on 'edit' layer"
--icon:	"#(path, index)"
(
	with redraw off
	(
		Layer 	= (Layer_v())
		Layer.turnOnAllLayers()
		Layer.hideAllLayers excludes:#("Edit")
		Layer.activate "Edit"
	)
	
)

macroscript	layer_turn_on_layer_export
category:	"_Layer"
buttontext:	"Export"
toolTip:	"Turn on 'edit' layer"
--icon:	"#(path, index)"
(
	with redraw off
	(
		Layer 	= (Layer_v())
		Layer.turnOnAllLayers()
		Layer.hideAllLayers excludes:#("Export")
		Layer.activate "Export"
	)
	
	
)