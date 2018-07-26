macroscript	layers_rename_current_layer
category:	"_Layer"
buttontext:	"Rename"
toolTip:	"Rename current layer"
--icon:	"#(path, index)"
(
	current_layer	= LayerManager.getLayer 1
	dialog	= dotNetObject "MaxCustomControls.RenameInstanceDialog" current_layer.name
	dialog.text	= "Rename layer"
	modeal	= dialog.Showmodal()
	
	result = dialog.InstanceName
	
	current_layer.setName result
	
)


macroScript layers_delete_empty_layers
category:	"_Layer" 
buttontext:	"Delete"
toolTip:	"Delete empty layers"

(
	default_layer	= LayerManager.getLayer 0
	default_layer.current	= true

	try
	(	
		_layercount	= for i = 1 to (LayerManager.count - 1) collect i
		_revlayers	= #()
		
		for i in _layercount.count to 1 by -1 do append _revlayers _layercount[i]
	
		for j in _revlayers do
		(
			_getlayer = LayerManager.getlayer j
			LayerManager.deleteLayerByName _getlayer.name
		)		
	)
	catch()
)

macroscript	layer_turn_on_all_layers
category:	"_Layer"
buttontext:	"Turn on all layers"
toolTip:	"Turn on all layers"
--icon:	"#(path, index)"
(
	(Layer_v()).turnOnAllLayers()
)
