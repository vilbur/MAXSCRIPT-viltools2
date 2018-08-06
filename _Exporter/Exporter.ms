global export_nodes_in_scene = #()

/** Exporter
 */
struct Exporter_v
(
	--export_nodes_in_scene = #(),	-- all export nodes in scene
	export_node,	-- used node for export
	objects_export,
	
	export_path,
	
	function exportNode _export_node deleteObjects:true =
	(
		(EpolyCallbacks_v()).remove()
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
		
		--objects_for_export = this._getExportObjects()
		--print ( "objects_for_export = " + objects_for_export as string )
		
		--ObjectCleaner = ObjectCleaner_v()
		objects_export = (ObjectCleaner_v()).prepareForExport export_node
		
		print ( "objects_export = " + objects_export as string )
		select objects_export
		
		--exportFile export_path #noPrompt selectedOnly:true using:FBXEXP
		
		if( deleteObjects ) then
		(
			export_layer	= LayerManager.getLayerFromName "Export-Unity-Objects"
			export_layer_objects	= for obj in objects where obj.layer.name == export_layer.name do delete obj
			
		)
			--delete objects_export
		
		(EpolyCallbacks_v()).add()
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
