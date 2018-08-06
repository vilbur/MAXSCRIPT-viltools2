/** Object cleaner
 */
struct ObjectCleaner_v
(
	export_layer = "Export",
	export_node,
	export_objects,
	obj,
	
	/** Prepare objects for export
	 */
	function prepareForExport _export_node =
	(
		export_node = _export_node
		--print ( "prepareForExport() __objects = " + __objects as string )
		
		
		this.cloneObjects (this._getSourceObjectsForExport())

		this.rotateInWorld()
		
		for obj in export_objects do
			this.prepareObject obj
		
		export_objects --return	
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
		_export_layer	= LayerManager.getLayerFromName "Export-Unity"
		--print ( "_export_layer = " + _export_layer as string )
		
		for obj in export_objects do
			_export_layer.addNode obj

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
		
		--this.planarizeFaces()
		this.renameObject()
		
		--this.setOneSideFaces()
		
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
		
		CenterPivot obj
		
		obj.pivot.z = 0
	),
	/** Rename object if name is not matching scene name
	 */
	function renameObject =
	(
		if( this._isNameMatchingNodeName() or obj.material == undefined ) then 
			return false
		
		--_name	= ( dotNetObject "System.Text.RegularExpressions.Regex" @"[_-]\d+$" ).Replace (getFilenameFile export_node.name) ""
		
		obj.name	= obj.material.name
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
