global export_nodes_in_scene = #()

/** Exporter
 */
struct Exporter_v
(
	--export_nodes_in_scene = #(),	-- all export nodes in scene
	export_node,	-- used node for export
	export_objects,
	
	export_path,
	
	function exportNode _export_node =
	(
		export_node = _export_node 
		print ( "exportNode = " + export_node as string )
		this._setExportPath()
		
		--individualFBXs = #()
		--if $herp != undefined then append individualFBXs $herp
		--if $derp != undefined then append individualFBXs $derp
		--if $slurp != undefined then append individualFBXs $slurp
		
		--lol, herp derp did make me chuckle ;)
		
		--No need to put this in a loop.
		
		--Geometry------------------------------------------------------------------------
		FBXExporterSetParam "SmoothingGroups"	false
		FBXExporterSetParam "NormalsPerPoly"	false
		FBXExporterSetParam "TangentSpaceExport"	false -- NEED TO TEST
		FBXExporterSetParam "SmoothMeshExport"	false
		FBXExporterSetParam "Preserveinstances"	false
		FBXExporterSetParam "SelectionSetExport"	false
		FBXExporterSetParam "GeomAsBone"	false
		--FBXExporterSetParam "ColladaTriangulate"	true
		FBXExporterSetParam "PreserveEdgeOrientation"	true
		--Animation------------------------------------------------------------------------
		FBXExporterSetParam "Animation"	false
		--Cameras------------------------------------------------------------------------
		FBXExporterSetParam "Cameras"	false
		--Lights------------------------------------------------------------------------
		FBXExporterSetParam "Lights"	false
		--Embed Media--------------------------------------------------------------------
		FBXExporterSetParam "EmbedTextures"	false
		--Units----------------------------------------------------------------------------
		--Axis Conversion-----------------------------------------------------------------
		FBXExporterSetParam "AxisConversionMethod" "Non	"
		FBXExporterSetParam "UpAxis" "Y" 
		--UI----------------------------------------------------------------
		FBXExporterSetParam "ShowWarnings"	true
		FBXExporterSetParam "GenerateLog"	false
		--FBX File Format----------------------------------------------------------------
		FBXExporterSetParam "ASCII"	true
		FBXExporterSetParam "FileVersion" "FBX20120	"
		
		--select export_node.children
		
		_objects = (SelectionSets_v()).objects export_node.name filter:#(export_node)
		print ( "_objects = " + _objects as string )
		--exportFile export_path #noPrompt selectedOnly:true using:FBXEXP 
	),

	
	
	/** Find export node
	 */
	function findExportNode =
	(
		export_nodes_in_scene = for _shape in objects where getUserProp _shape "unity-export-node" != undefined collect _shape
	),
	/** Choose node dialog
	 */
	function chooseNodeDialog =
	(
		this.findExportNode()
		
		rollout choose_export_node "Export node"
		(
			multilistbox choose_export_node_mlb "Choose one" items:(this.exportNodeNames())
			--selection:#(1,3)
			
			--on mlb selected val do format "selected: % - %\n" val mlb.selection[val]
			on choose_export_node_mlb doubleclicked val do
			(
				select export_nodes_in_scene[val]

				DestroyDialog choose_export_node
			)
		)
		
		CreateDialog choose_export_node
	),
	
	/*------------------------------------------------------------------------------
		PRIVATE
	--------------------------------------------------------------------------------*/
	
	/** Set export path
	  * Combine Export dir path defined in user properties of node and node name
	 */
	function _setExportPath =
	(
		export_dir = getUserProp export_node "export-dir"
		
		export_path = export_dir + "\\" + export_node.name + ".fbx"
	),
	/** Export node names
	 */
	function exportNodeNames =
	(
		
		for _node in export_nodes_in_scene collect _node.name
	),
	
	function test =
	(
		messagebox "Exporter.test()"
	)
)
