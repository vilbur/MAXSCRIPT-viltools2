

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
	local ExportNode	= UnityExportNode_v()
	local export_nodes_in_scene	= #()
	
	tool create
	(
		--on mousePoint click do
		--(
		--	try( callbacks.removeScripts #selectionSetChanged	                           	id:#onUnityExportNodeSelected )catch()
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
	
	rollout export_nodes_roll "Export nodes"
	(
		multilistbox choose_export_node_mlb "Choose one" items:(this.exportNodeNames()) selection:(this.getSelectedNodes())
		--multilistbox choose_export_node_mlb "Choose one" items:(this.exportNodeNames()) selection:#(2) 
		
		--on mlb selected val do format "selected: % - %\n" val mlb.selection[val]
		on choose_export_node_mlb selected  val do
		--on choose_export_node_mlb doubleclicked val do
		(
			clearListener()
			print ( "val = " + val as string )
			this.selectNodes #( val )
			--DestroyDialog choose_export_node
		)
		on choose_export_node_mlb selectionEnd do
		(
			 format "selectionEnd: %\n" choose_export_node_mlb.selection
			this.selectNodes choose_export_node_mlb.selection
		)
	)
	
	rollout manage_roll "Manage node"
	(
		button create_export_node		"Create"
		button assign_to_export_node	"Assign"


		on create_export_node		pressed do ( ExportNode.create() )
		on assign_to_export_node	pressed do ( this.pluginFunctionTest() )
		--on assign_to_export_node	pressed do ( ExportNode.assign() )
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
	
	/** Plugin function test
	 */
	function exportNodeNames =
	(
		this.findExportNodes()
		
		for _node in export_nodes_in_scene collect _node.name
	)
	/** Find export node
	 */
	function findExportNodes =
	(
		print "findExportNodes()"
		export_nodes_in_scene = for _shape in objects where getUserProp _shape "unity-export-node" != undefined collect _shape		
	)
	/** Get selected nodes
	 */
	function getSelectedNodes =
	(
		_selection = ( selection as Array )
		
		selected_nodes = for n=1 to export_nodes_in_scene.count where findItem _selection export_nodes_in_scene[n] > 0 collect n
		
		print ( "unity_exporter_v.selected_nodes = " + (selected_nodes as BitArray) as string )
		
		selected_nodes as BitArray --return
	)
	/** Select nodes
	 */
	function selectNodes selected_indexes =
	(
		UnityExportNode = UnityExportNode_v()
		UnityExportNode.removeCallback()
		--print ( "export_nodes_in_scene = " + export_nodes_in_scene as string )
		--print ( "selected = " + export_nodes_in_scene[val] as string )
		--print ( "selected = " + choose_export_node_mlb.selection[val] as string )
		--select export_nodes_in_scene[val]
		print ( "selectNodes() selected_indexes = " + (selected_indexes as Array ) as string )		
		print ( "export_nodes_in_scene = " + export_nodes_in_scene as string )
		clearSelection()
		
		for n in selected_indexes do
			selectmore export_nodes_in_scene[n]
			--print ( "export_nodes_in_scene[n] = " + export_nodes_in_scene[n] as string )
		
		UnityExportNode.addCallback()
	)
)

