/** Object cleaner
 */
struct ObjectCleaner_v
(
	export_layer = "Export",
	export_node,
	export_objects,
	obj,
	_export_layer_name="Export-Unity-Objects",
	/** Prepare objects for export
	 */
	function prepareForExport _export_node deleteObjects:true rotate:true =
	(
		this.deleteExportObjectsLayer()
		
		export_node = _export_node
		--print ( "prepareForExport() __objects = " + __objects as string )
		
		
		this.cloneObjects (this._getSourceObjectsForExport())
		this.attachObjectsByMaterial()
		
		if ( rotate==true ) then 
			this.rotateInWorld()
		
		for obj in export_objects do
			this.prepareObject obj
		
		export_objects --return	
	),

	/** Delete export objects layer
	 */
	function deleteExportObjectsLayer =
	(
		export_layer	= LayerManager.getLayerFromName "Export-Unity-Objects"
		for obj in objects where isValidNode obj and obj.layer == export_layer do delete obj
	),
	/** Set objects
	 */
	function cloneObjects objects_for_export =
	(
		--print ( "cloneObjects() __objects = " +  __objects as string )
		cloned_nodes	= #()
		
		maxOps.cloneNodes (objects_for_export as array) cloneType:#copy newNodes:&cloned_nodes #nodialog

		
		export_objects = cloned_nodes
		
		for o=1 to export_objects.count where objects_for_export[o].material != undefined  do export_objects[o].material = objects_for_export[o].material
		
		
		print ( "cloneObjects() export_objects = " +  export_objects as string )
		
		this.addToExportLayer()
		--_objects	= for obj in selection where superClassOf obj == GeometryClass and obj.layer.name == export_layer collect obj
		--
		--if( _objects.count == 0 ) then 
		--	_objects	= this.getObjectsInExportLayer()
	),
	/** Add to expor l;ayer
	 */
	function addToExportLayer =
	(

		_export_layer	= LayerManager.getLayerFromName _export_layer_name
		
		if( _export_layer == undefined ) then
			_export_layer	= LayerManager.newLayerFromName _export_layer_name
		
		for obj in export_objects do
			_export_layer.addNode obj

	),
	fn clearDeadNodes array = 
	(
		if array.count != 0 do (for i = array.count to 1 by -1 where not isValidNode array[i] do deleteItem array i)
		array
	),
	--/** Get objects in export layer
	--  * @return	collection of geometry objects in layer "Export"	
	-- */
	--function getObjectsInExportLayer =
	--(
	--	for obj in objects where superClassOf obj == GeometryClass and obj.layer.name == export_layer collect obj
	--),
	/** Rotate in world aroun Z axis
	  * Rotate Z axis, Front view in Max and Unity and thumbnail match correctly
	 */
	function rotateInWorld =
	(
		in coordsys (matrix3 [1,0,0] [0,1,0] [0,0,1] [0,0,0]) about coordsys rotate export_objects -90 z_axis
	),
	/** Prepare object
	 */
	function prepareObject _obj =
	(
		print ( "prepareObject() _obj = " + _obj as string )
		obj = _obj
		select obj
		
		this._polySelectAll()
		this.fixMirroredObjectNormals()
		
		this._resetXformUnity()
		this.resetSmooth()
		this.resetPivot()
		
		this.convertToEditablePoly()
		
		this.planarizeFaces()
		this.renameObject()
		
		--this.setOneSideFaces()
		
	),
	/** Attach objects by material
	 */
	function attachObjectsByMaterial =
	(
		merged_objects = #()
		_materials	= makeUniqueArray (for obj in export_objects where obj.material != undefined collect obj.material)
		print ( "_materials = " + _materials as string )
		print ( "_materials.count = " + _materials.count as string )
	
		_objects_per_mats = #()
		for mat in _materials do
			append _objects_per_mats (for obj in export_objects where  obj.material == mat collect obj)

		print ( "_objects_per_mats.count = " + _objects_per_mats.count as string )
		for _objects_per_mat in _objects_per_mats do 
		(
			print ( "_objects_per_mat = " + _objects_per_mat as string ) 
			for obj in _objects_per_mat do
				ConvertTo obj Editable_Poly
			
			clearSelection()
			select _objects_per_mat
			--print ( "_objects_per_mat = " + _objects_per_mat as string )
			--while _objects_per_mat.count > 1 do
			--(
			--	selcount = _objects_per_mat.count
			--	for i = selcount to 2 by -2 do
			--	(
			--		if( isValidNode _objects_per_mat[i] and isValidNode array[i-1] ) then 
			--			polyop.attach _objects_per_mat[i] _objects_per_mat[i-1]
			--		--deleteItem _objects_per_mat (findItem _objects_per_mat _objects_per_mat[i-1] )
			--	)
			--		--polyop.attach selection[i] selection[i-1]
			--)
			while selection.count > 1 do
			(
				selcount = selection.count
				for i = selcount to 2 by -2 do
					polyop.attach selection[i] selection[i-1]
			)
			update selection[1]
				
			--print ( "_objects_per_mat = " + _objects_per_mat as string )

			--print ( "selection = " + (selection as Array ) as string )
			for obj in selection where isValidNode obj do
			--for obj in this.clearDeadNodes selection  do
				append merged_objects obj
			
		)
		export_objects = merged_objects
	),
	
	/** Convert to editable poly
	 */
	function convertToEditablePoly =
	(
		ConvertTo obj Editable_Poly
	),
	/** _poly select all
	 */
	function _polySelectAll =
	(
		modPanel.addModToSelection (Poly_Select ()) ui:on
		subObjectLevel = 4
		actionMan.executeAction 0 "40021"  -- Selection: Select All
		subObjectLevel = 0
	),
	/** Fix mirrored object normals
	 */
	function fixMirroredObjectNormals =
	(
		print ( " this._isObjectMirrored() = " +  this._isObjectMirrored() as string )
	
		if not ( this._isObjectMirrored() ) then
			return false
		
		--print ( "obj = " + obj as string )	
			
		--_Poly_Select = Poly_Select()
		--print ( "selection = " + selection as string )
		--for obj in selection where superClassOf obj == GeometryClass do print obj.name
		--addModifier obj _Poly_Select

		normal_mod = this.addNormalModifier()
		normal_mod.flip	= on
		normal_mod.unify	= on
	),
	/** Add normal modifier
	 */
	function addNormalModifier =
	(
		normal_mod	= Normalmodifier unify:on
		
		addModifier obj normal_mod
		
		normal_mod --return
	),
	/** Reset xform for Unity engine
	  *
	  * Rotate Y axis
	  * Rotate Z axis, Front view in Max and Unity and thumbnail match correctly
	 */
	function _resetXformUnity =
	(
		rot = eulerToQuat( EulerAngles 90 0 0)
		--Rotate obj (angleaxis -90 [0,0,1]) -- rotate Z axis, match sides of views

		--rot = eulerToQuat( EulerAngles 90 0 90) -- -- rotate only Y with ( EulerAngles 90 -90 0)
		this.convertToEditablePoly()

		ResetXForm obj
		modPanel.addModToSelection (XForm ()) ui:on
		--addModifier obj (XForm ())
		obj.modifiers[#XForm].gizmo.rotation += rot as Quat
		Rotate obj ( Inverse rot as Quat )

	),

	/** Planarize faces
	 */
	function planarizeFaces =
	(
		for x=1 to 20 do (for i=1 to ( polyop.getNumFaces obj) do ( polyop.makeFacesPlanar obj #(i)) )
	),
	/** Reset smooth
	 */
	function resetSmooth =
	(
		addModifier obj (smooth()) 
	),
	/** Center pivot to object and 0 on Z axis
	  * Exclude objects centered to world
	 */
	function resetPivot =
	(
		if( obj.pivot == [0, 0, 0] ) then
			return false
		print ( "ObjectCleaner_v.resetPivot() obj = " + obj as string )
		CenterPivot obj
		
		obj.pivot.z = 0
	),
	/** Rename object if name is not matching scene name
	 */
	function renameObject =
	(
		--if( this._isNameMatchingNodeName() or obj.material == undefined ) then 
		if( obj.material == undefined ) then 
			return false
		
		--_name	= ( dotNetObject "System.Text.RegularExpressions.Regex" @"[_-]\d+$" ).Replace (getFilenameFile export_node.name) ""
		
		obj.name	= obj.material.name
		
		print ( "obj.name = " + obj.name as string )
		
	),
	/** 
	 */
	function setOneSideFaces =
	(
		obj.backfacecull = on
	),
	/*------------------------------------------------------------------------------
		PRIVATE
	--------------------------------------------------------------------------------*/
	/** Get export objects
	 */
	function _getSourceObjectsForExport =
	(
		(SelectionSets_v()).objects export_node.name filter:#(export_node) --return
	),
	/** Is object mirrored
	 */
	function _isObjectMirrored =
	(
		(obj.scale.x < 0.0 or obj.scale.y < 0.0  or obj.scale.z < 0.0) --return
	),
	/** Is name matching scene name
	  * @example obj.name = "scene_name_foo_bar" // return true  if scene name is "scene_name" 
	  * @example obj.name = "bar_x_obj_59"       // return false if scene name is "scene_name"
	  * @return	boolean	
	 */
	function _isNameMatchingNodeName =
	(
		matchPattern obj.name pattern:("*"+export_node.name+"_*")
	),
	function test =
	(
		messagebox "ObjectCleaner.test()"
	)
)
