

/** On selection change callback
 */
function onUnityExportNodeSelected =
(
	ExportNode = selection[1]
	
	if( classOf ExportNode == text and getUserProp ExportNode "unity-export-node" != undefined ) then 
	(
		----_mode = toolmode.commandmode 
		--print ("Export node selected " + ExportNode.name)
		startObjectCreation unity_exporter_v
		----toolmode.commandmode = _mode
	)
	
)

/** Create and manage export node 
 *	
 */
plugin helper unity_exporter_v
name:"Export"
--extends:dummy
--replaceUI:true
category:"Unity"
(
	local ExportNode = UnityExportNode_v()
	
	tool create
	(
		--on mousePoint click do
		--(
		--	try( callbacks.removeScripts #selectionSetChanged	                           id:#onUnityExportNodeSelected )catch()
		--	try( callbacks.addScript     #selectionSetChanged "onUnityExportNodeSelected()" id:#onUnityExportNodeSelected )catch()
		--	
		--	--ExportNode = UnityExportNode_v()
		--	#stop
		--)
	)
	parameters main rollout:params
	(
		export_filename type:#string 
	)
	
	rollout create_roll "Create"
	(
		button create_export_node "Create Node"
		on create_export_node pressed do (
			ExportNode.create()
		)
	)
	
	rollout params "Parameters"
	(
	 
		edittext export_filename "Name" text:ExportNode.name
		
		button btn_browse "Path" toolTip:ExportNode.path 

		edittext export_path "" text:ExportNode.path 
		
		on btn_browse pressed do (
			local dir = getSavePath caption:"Browse export dir" initialDir:ExportNode.path 
			if (dir != undefined) do
			(
				export_path.text	= dir
				btn_browse.tooltip	= dir
				
				ExportNode.setExportDir dir
			)
		)

	)


	
)

