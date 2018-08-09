/** On selection change callback
 */
function onUnityExportNodeSelected =
(
	
	export_nodes_selected = for _shape in selection where classOf _shape == text and getUserProp _shape "unity-export-node" != undefined collect _shape		

	print "\n"
	print ( "selection.count = " + (selection.count > 0) as string )
	print ( "export_nodes_selected.count = " + (export_nodes_selected.count > 0 ) as string )
	print ( "isCreatingObject unity_exporter_v = " + (isCreatingObject unity_exporter_v == false) as string )
	
	if ( selection.count > 0 and export_nodes_selected.count > 0 and isCreatingObject unity_exporter_v == false ) then 
	(
		print "\n\nEXPORT NODE SELECTED"
		max create mode
		startObjectCreation unity_exporter_v
	) else
		print "onUnityExportNodeSelected()\n\nEXPORT NODE NOT SELECTED !!!"

)
/** Select export node callback remove
 */
function RemoveSelectExportNodeCallback =
(
	print ( "==== RemoveSelectExportNodeCallback()"  )
	try( callbacks.removeScripts #selectionSetChanged id:#onUnityExportNodeSelected )catch()
)
/** Select export node callback add
 */
function AddSelectExportNodeCallback =
(
	RemoveSelectExportNodeCallback()
	print ( "==== AddSelectExportNodeCallback()"  )
	try( callbacks.addScript #selectionSetChanged "onUnityExportNodeSelected()" id:#onUnityExportNodeSelected )catch()
)




global lisbox_last_selected_export_node

/** Create and manage export node 
 *	
 */
plugin helper unity_exporter_v
name:"Exporter"
--extends:dummy
--replaceUI:true
category:"Unity"
(
	local ExportNode	= UnityExportNode_v()
	local export_nodes_in_scene	= #()
	local _export_layer_name	= "Export-Unity"
	local export_nodes_roll
	local node_options_roll

	local node_options = #("delete-after-export", "rotate-on-export")
	
	/*------------------------------------------------------------------------------
	
		EVENTS
		
	--------------------------------------------------------------------------------*/
	
	tool create
	(
		--on mousePoint click do
		--(
		----	try( callbacks.removeScripts #selectionSetChanged	                           	id:#onUnityExportNodeSelected )catch()
		----	try( callbacks.addScript     #selectionSetChanged "onUnityExportNodeSelected()" id:#onUnityExportNodeSelected )catch()
		----	
		----	--ExportNode = UnityExportNode_v()
		--	#stop
		--)
	)
	on create do 
	(
		print ( "unity_exporter_v.create() = "  as string )

		--RemoveSelectExportNodeCallback()
		--print ( "this.getSelectedSceneNodesIndexes() = " + this.getSelectedSceneNodesIndexes() as string )
		
		print ( "\n====== create() ======" )
		--this.updateNodeOptions()
		
		
		this.updateListBox()

		--AddSelectExportNodeCallback()

	)
	on update do 
	(
		print ( "unity_exporter_v.update() = "  as string )

	)

	
	/*------------------------------------------------------------------------------
	
		ROLLOUTS
		
	--------------------------------------------------------------------------------*/

	parameters main rollout:export_path_roll
	(
		export_filename type:#string 
	)

	rollout export_nodes_roll "Export nodes"
	(
		multilistbox export_nodes_lbox "Choose one" items:(this.exportNodeNames()) selection:(this.getSelectedSceneNodesIndexes())
		--multilistbox export_nodes_lbox "Choose one" items:(this.exportNodeNames()) selection:#(2)

		--on mlb selected val do format "selected: % - %\n" val mlb.selection[val]
		on export_nodes_lbox selected  val do
		--on export_nodes_lbox doubleclicked val do
		(
			print ( "\n====== export_nodes_lbox.selected() ====== " + val as string )
			print ( "lisbox_last_selected_export_node ==undefined " + (lisbox_last_selected_export_node ==  undefined) as string )
			print ( "lisbox_last_selected_export_node != val = " + (lisbox_last_selected_export_node != val) as string )
			
			if( lisbox_last_selected_export_node != val  ) then 
				this.selectNodes #( val )
			
			lisbox_last_selected_export_node = val
			
			--this.updateNodeOptions()

			--DestroyDialog choose_export_node
		)
		on export_nodes_lbox selectionEnd do
		(
			print ( "\n====== export_nodes_lbox.selectionEnd() ======"  + export_nodes_lbox.selection as string )
			 --format "selectionEnd: %\n" export_nodes_lbox.selection
			--this.selectNodes export_nodes_lbox.selection
			
		)

		on export_nodes_lbox doubleclicked val do
		(
			print ( "\n====== export_nodes_lbox.doubleclicked() ======" )
			--clearListener()
			export_objects = this.getObejctsForNodes (this.getNodesSelectedInListBox())

			selection_test = for obj in export_objects where findItem (selection as Array) obj > 0 collect obj

			--print ( "export_objects.count = " + export_objects.count as string )
			--print ( "selection_test.count = " + selection_test.count as string )
			--print ( "selection = " + (selection as Array )as string )

			IsolateSelection.ExitIsolateSelectionMode()

			select export_objects;

			if( selection_test.count == export_objects.count ) then
			(
				IsolateSelection.EnterIsolateSelectionMode()
			)
			selectmore (this.getNodesSelectedInListBox())

		)

	)

	rollout manage_roll "Manage"
	(
		button create_export_node		"Create"
		button assign_to_export_node	"Assign\Remove"
		checkbutton export_layer_display_toggle	"Show\Hide"
		button select_btn	"Isolate"
		button clear_expor_objects_layer_btn	"Clear Layer"

		on create_export_node		pressed do ( ExportNode.create() )

		on assign_to_export_node		pressed	do ( this.assignSelectionToNodes() )
		on clear_expor_objects_layer_btn 	pressed	do ( (ObjectCleaner_v()).deleteExportObjectsLayer() )
		on assign_to_export_node		rightClick	do ( this.assignSelectionToNodes remove:true )

		on export_layer_display_toggle changed val do
			this.exportLayerToggleShowHide()

		on select_btn pressed do
		(
			clearSelection()
			this.getObejctsForNodes (this.getNodesSelectedInListBox())
		)

		on select_btn pressed do
		(
			clearSelection()
			IsolateSelection.ExitIsolateSelectionMode()

			this.getObejctsForNodes (this.getNodesSelectedInListBox())

			IsolateSelection.EnterIsolateSelectionMode()
		)
		--on assign_to_export_node	pressed do ( ExportNode.assign() )
	)

	rollout export_roll "Export"
	(

		button export_button	"Export"

		on export_button pressed do (

			clearListener()
			RemoveSelectExportNodeCallback()
			export_nodes_selected = this.getNodesSelectedInListBox()

			for export_node_selected in export_nodes_selected do
				(Exporter_v()).exportNode export_node_selected deleteObjects:node_options_roll.delete_after_export_cbx.state rotate:( this.getProp export_node_selected "rotate-on-export" default:true )

			AddSelectExportNodeCallback()
		)

	)
	
	rollout export_path_roll "Export Path"
	(

		edittext export_filename "Name" text:ExportNode.name

		button btn_browse "Path" toolTip:ExportNode.path

		edittext export_path "" text:ExportNode.path

		on btn_browse pressed do
		(
			print ( "initialDir = " + export_path_roll.export_path.text  as string )
			--local dir = getSavePath caption:"Browse export dir" initialDir:ExportNode.path 
			local dir = getSavePath caption:"Browse export dir" initialDir:export_path_roll.export_path.text 
			if (dir != undefined) do
			(
				export_path.text	= dir
				btn_browse.tooltip	= dir

				ExportNode.setExportDir dir
			)
		)
	)
	

	--rollout export_options_roll "Export Options"
	--(
	--	checkbox rotate_in_export_cbx "Delete after export"
	--		on rotate_in_export_cbx changed val do
	--			for _node in this.getSelectedSceneNodes() do
	--				setUserProp _node "delete-after-export" val
	--)

	rollout node_options_roll "Node Options"
	(
		checkbox delete_after_export_cbx "Delete after export" checked:(this.getSelectedNodeProp node_options[1] )
			on delete_after_export_cbx changed val do
				for _node in this.getSelectedSceneNodes() do
					setUserProp _node "delete-after-export" val
		
		checkbox rotate_in_export_cbx "Rotate in world" checked:(this.getSelectedNodeProp node_options[2] )
			on rotate_in_export_cbx changed val do
			(
				print "\n\n************* CHECKBOX *************"	
				for _node in this.getSelectedSceneNodes() do
					setUserProp _node node_options[2] val
			)
			
	)

	/*------------------------------------------------------------------------------
	
		FUNCTIONS
		
	--------------------------------------------------------------------------------*/

	/** Select obejcts for nodes
	 */
	function getObejctsForNodes export_nodes =
	(
		_objects	= #()

		for export_node in export_nodes do
		--print ( "objects = " + (SelectionSets_v()).objects export_node_selected.name filter:#(export_node_selected) as string )
			for obj in ((SelectionSets_v()).objects export_node.name filter:#(export_node)) do
				append _objects obj	
		_objects --return
	)

	--/** Add callbacks
	-- */
	--function addCallbacks =
	--(
	--	RemoveSelectExportNodeCallback()
	--	try( callbacks.addScript #selectionSetChanged "onUnityExportNodeSelected()" id:#onUnityExportNodeSelected )catch()
	--)
	--/** Remove callbacks
	-- */
	--function removeCallbacks =
	--(
	--	try( callbacks.removeScripts #selectionSetChanged id:#onUnityExportNodeSelected )catch()
	--
	--)

	/** Plugin function test
	 */
	function exportNodeNames =
	(
		this.setExportNodesInScene()

		for _node in export_nodes_in_scene collect _node.name
	)
	/** Find export node
	 */
	function setExportNodesInScene =
	(
		print "setExportNodesInScene()"
		export_nodes_in_scene = for _shape in objects where getUserProp _shape "unity-export-node" != undefined collect _shape		
	)
	/** Get selected nodes
	 */
	function getSelectedSceneNodes =
	(
		for _shape in selection where classOf _shape == text and getUserProp _shape "unity-export-node" != undefined collect _shape		
	)
	/** Get selected nodes
	 */
	function getSelectedSceneNodesIndexes =
	(
		this.setExportNodesInScene()
		
		selected_nodes = this.getSelectedSceneNodes()
		
		indexes = for i = 1 to selected_nodes.count collect
			findItem export_nodes_in_scene selected_nodes[i] --return
		--print ( "unity_exporter_v.getSelectedSceneNodesIndexes() = " + ( selected_nodes as BitArray ) as string )

		indexes as BitArray --return
	)
	/** Fileter export nodes
	 */
	function fileterExportNodes _objects =
	(
		_objects_filtered_export_nodes = #()

		for obj in _objects where findItem export_nodes_in_scene obj == 0 do
			append _objects_filtered_export_nodes obj

		_objects_filtered_export_nodes --return
	)
	/** Select nodes
	 */
	function selectNodes selected_indexes =
	(
		print "***selectNodes()"
		
		RemoveSelectExportNodeCallback()
		
		UnityExportNode = UnityExportNode_v()

		this.deselectNodes()

		for n in selected_indexes do
			selectmore export_nodes_in_scene[n]

		AddSelectExportNodeCallback()
	)

	/** Deselect nodes
	 */
	function deselectNodes =
	(
		print "***deselectNodes()"
		
		for _node in export_nodes_in_scene do
			deselect _node
	)
	/** Export layer toggle show hide
	 */
	function exportLayerToggleShowHide =
	(
		Layer = LayerManager.getLayerFromName _export_layer_name
		Layer.on = Layer.on != true
		redrawViews()
	)
	/** Assign to nodes
	 */
	function assignSelectionToNodes remove:false =
	(
		print ( "assignSelectionToNodes() remove = " + remove as string )
		nodes	= this.getNodesSelectedInListBox()
		SelectionSets	= SelectionSets_v()

		for _node in nodes do
			SelectionSets.updateSelectionSet (this.fileterExportNodes selection) _node.name remove:remove
	)

	/** Get export nodes
	 */
	function getNodesSelectedInListBox  =
	(
		indexes = export_nodes_roll.export_nodes_lbox.selection

		for i in indexes collect export_nodes_in_scene[i] --return
	)
	/** Update list box
	 */
	function updateListBox =
	(
		print ( "this.getSelectedSceneNodesIndexes() = " + this.getSelectedSceneNodesIndexes() as string )
		try(
			export_nodes_roll.export_nodes_lbox.selection = (this.getSelectedSceneNodesIndexes())
		)catch()
	)

	/** Update rotate checkbox
	 */
	function updateNodeOptions value:#null =
	(
		print ( "\n\n====== updateNodeOptions() ======\n\n" )
		selected_nodes = this.getSelectedSceneNodes()
		print ( "selected_nodes = " + selected_nodes as string )
		
		if( selected_nodes.count == 0 ) then 
			return()
		
		--node_options_roll.delete_after_export_cbx.state	= (this.getProp selected_nodes[1] "delete-after-export"	default:true)
		--node_options_roll.rotate_in_export_cbx.state	= (this.getProp selected_nodes[1] "rotate-on-export"	default:true)
		

	)
	/** Get selected node prop
	 */
	function getSelectedNodeProp key =
	(
		selected_nodes = this.getSelectedSceneNodes()
		
		this.getProp selected_nodes[1] key	default:true --return
	)
	
	/** Get prop
	 */
	function getProp obj key default:#null =
	(
		--print ( "getProp = " + obj as string )
		--if( obj != undefined and classOf obj != BooleanClass  and getUserProp obj key != undefined ) then getUserProp obj key else default --return
		
		_value = if( obj != undefined and classOf obj != BooleanClass  and getUserProp obj key != undefined ) then getUserProp obj key else default --return
		print ( "getProp() "+key+"= " + _value as string )
		_value --return
	)

)

