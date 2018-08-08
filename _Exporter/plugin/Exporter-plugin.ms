/** On selection change callback
 */
function onUnityExportNodeSelected =
(
	ExportNode = selection[1]

	if( classOf ExportNode == text and getUserProp ExportNode "unity-export-node" != undefined ) then 
	(
		print "\n\nEXPORT NODE SELECTED"
		--max create mode
		--startObjectCreation unity_exporter_v
	)else
		print "onUnityExportNodeSelected()\n\nEXPORT NODE NOT SELECTED"

)
/** Select export node callback remove
 */
function selectExportNodeCallbackRemove =
(
	try( callbacks.removeScripts #selectionSetChanged id:#onUnityExportNodeSelected )catch()
)
/** Select export node callback add
 */
function selectExportNodeCallbackAdd =
(
	print ( "==== selectExportNodeCallbackAdd()"  )
	selectExportNodeCallbackRemove()
	try( callbacks.addScript #selectionSetChanged "onUnityExportNodeSelected()" id:#onUnityExportNodeSelected )catch()
)

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
	local options_roll

	
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

		--this.removeCallbacks()

		--export_nodes_roll.choose_export_node_mlb.selection = (this.getSelectedNodesIndexes())

		--this.updateRotateCheckbox()

		--this.addCallbacks()

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
		multilistbox choose_export_node_mlb "Choose one" items:(this.exportNodeNames()) selection:(this.getSelectedNodesIndexes())
		--multilistbox choose_export_node_mlb "Choose one" items:(this.exportNodeNames()) selection:#(2)

		--on mlb selected val do format "selected: % - %\n" val mlb.selection[val]
		on choose_export_node_mlb selected  val do
		--on choose_export_node_mlb doubleclicked val do
		(
			--clearListener()
			--print ( "val = " + val as string )

			this.selectNodes #( val )

			--DestroyDialog choose_export_node
		)
		on choose_export_node_mlb selectionEnd do
		(
			 --format "selectionEnd: %\n" choose_export_node_mlb.selection
			this.selectNodes choose_export_node_mlb.selection
		)

		on choose_export_node_mlb doubleclicked val do
		(
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
		button export_button	"Export"
			--on deleteafterexport_cbx changed val do (
			--
			--																	print val
			--																	)

		on create_export_node		pressed do ( ExportNode.create() )

		on assign_to_export_node		pressed	do ( this.assignSelectionToNodes() )
		on clear_expor_objects_layer_btn 	pressed	do ( (ObjectCleaner_v()).deleteExportObjectsLayer() )
		on assign_to_export_node		rightClick	do ( this.assignSelectionToNodes remove:true )

		on export_layer_display_toggle changed val do
			this.exportLayerToggleShowHide()

		on export_button pressed do (

			clearListener()
			selectExportNodeCallbackRemove()
			export_nodes_selected = this.getNodesSelectedInListBox()

			for export_node_selected in export_nodes_selected do
				(Exporter_v()).exportNode export_node_selected deleteObjects:options_roll.delete_after_export_cbx.state rotate:( this.getProp export_node_selected "rotate-on-export" default:true )

			selectExportNodeCallbackAdd()
		)

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

	rollout options_roll "Options"
	(
		checkbox delete_after_export_cbx "Delete after export" checked:true
		checkbox rotate_in_export_cbx "Rotate in world"

		on rotate_in_export_cbx changed val do
		(
			selected_nodes = this.getSelectedNodes()

			for _node in selected_nodes do
				setUserProp _node "rotate-on-export" val
		)
			--this.updateRotateCheckbox value:val

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

	/** Add callbacks
	 */
	function addCallbacks =
	(
		this.removeCallbacks()
		try( callbacks.addScript #selectionSetChanged "onUnityExportNodeSelected()" id:#onUnityExportNodeSelected )catch()
	)
	/** Remove callbacks
	 */
	function removeCallbacks =
	(
		try( callbacks.removeScripts #selectionSetChanged id:#onUnityExportNodeSelected )catch()

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

		for export_node_in_scene in export_nodes_in_scene where findItem _selection export_node_in_scene > 0 collect export_node_in_scene

	)
	/** Get selected nodes
	 */
	function getSelectedNodesIndexes =
	(
		_selection = ( selection as Array )

		selected_nodes = for n=1 to export_nodes_in_scene.count where findItem _selection export_nodes_in_scene[n] > 0 collect n

		print ( "unity_exporter_v.getSelectedNodesIndexes() = " + (selected_nodes as BitArray) as string )

		selected_nodes as BitArray --return
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
		this.removeCallbacks()
		UnityExportNode = UnityExportNode_v()
		--print ( "export_nodes_in_scene = " + export_nodes_in_scene as string )
		--print ( "selected = " + export_nodes_in_scene[val] as string )
		--print ( "selected = " + choose_export_node_mlb.selection[val] as string )
		--select export_nodes_in_scene[val]
		--print ( "selectNodes() selected_indexes = " + (selected_indexes as Array ) as string )		
		--print ( "export_nodes_in_scene = " + export_nodes_in_scene as string )
		--clearSelection()

		this.deselectNodes()

		for n in selected_indexes do
			selectmore export_nodes_in_scene[n]
			--print ( "export_nodes_in_scene[n] = " + export_nodes_in_scene[n] as string )

		this.updateRotateCheckbox()

		this.addCallbacks()
	)

	/** Deselect nodes
	 */
	function deselectNodes =
	(
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
		indexes = export_nodes_roll.choose_export_node_mlb.selection

		for i in indexes collect export_nodes_in_scene[i] --return
	)

	/** Update rotate checkbox
	 */
	function updateRotateCheckbox value:#null =
	(
		print ( "\n\n====== updateRotateCheckbox() ======\n\n" )
		--clearListener()
		selected_nodes = this.getSelectedNodes()

		--if( value == #null ) then 
		value =  if (selected_nodes!=undefined and selected_nodes.count > 0) then this.getProp selected_nodes[1] "rotate-on-export" default:true else true

		--selected_nodes_index = this.getSelectedNodesIndexes()
		print ( "selected_nodes = " + selected_nodes as string )
		--print ( "selected_nodes_index = " + selected_nodes_index as string )
		print ( "value = " + value as string )
		print ( "classOf value = " + classOf value as string )

		--options_roll.rotate_in_export_cbx.state = value
		options_roll.rotate_in_export_cbx.checked = value

	)
	/** Get prop
	 */
	function getProp obj key default:#null =
	(
		print ( "getProp = " + obj as string )
		if( obj != undefined and classOf obj != BooleanClass  and getUserProp obj key != undefined ) then getUserProp obj key else default --return		
	)

)

