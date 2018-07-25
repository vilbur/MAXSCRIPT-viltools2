macroscript	layers_rename_current_layer
category:	"_Layers"
buttontext:	"Rename"
toolTip:	"Rename current layer"
--icon:	"#(path, index)"
(
	current_layer	= LayerManager.getLayer 1
	dialog	= dotNetObject "MaxCustomControls.RenameInstanceDialog" current_layer.name
	dialog.text	= "Rename layer"
	modeal	= dialog.Showmodal()
	
	result = dialog.InstanceName
		--print ( "result = " + result as string )
	
	
	current_layer.setName result
	
)
