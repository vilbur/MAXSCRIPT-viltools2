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
