/** Object cleaner
 */
struct ObjectCleaner_v
(
	export_layer = "Export",
	
	_objects,
	obj,
	
	/** Prepare objects for export
	 */
	function prepareObjectsForExport =
	(
		this.setObjects()
		--print ( "_objects = " + _objects as string )
		for obj in _objects do
			this.prepareObject obj
	),
	/** Set objects
	 */
	function setObjects =
	(
		_objects	= for obj in selection where superClassOf obj == GeometryClass and obj.layer.name == export_layer collect obj
		--print ( "selection = " + _objects as string )
		if( _objects.count == 0 ) then 
			_objects	= this.getObjectsInExportLayer()
	),
	/** Get objects in export layer
	  * @return	collection of geometry objects in layer "Export"	
	 */
	function getObjectsInExportLayer =
	(
		for obj in objects where superClassOf obj == GeometryClass and obj.layer.name == export_layer collect obj
	),

	/** Prepare object
	 */
	function prepareObject _obj =
	(
		print "prepareObject"
		obj = _obj
		
		this.fixMirroredObjectNormals()
		
		this._resetXformUnity()
		this.resetSmooth()
		this.resetPivot()
		
		this.convertToEditablePoly()
		
		this.planarizeFaces()
		this.renameObject()
		
		this.setOneSideFaces()
	),
	
	/** Convert to editable poly
	 */
	function convertToEditablePoly =
	(
		ConvertTo obj Editable_Poly
	),
	/** Fix mirrored object normals
	 */
	function fixMirroredObjectNormals =
	(
		if not ( this._isObjectMirrored() ) then
			return false
			
		normal_mod = this.addNormalModifier()
		normal_mod.flip = on
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
		Rotate obj (angleaxis -90 [0,0,1]) -- rotate Z axis, match sides of views

		--rot = eulerToQuat( EulerAngles 90 0 90) -- -- rotate only Y with ( EulerAngles 90 -90 0)
		
		ResetXForm obj
		modPanel.addModToSelection (XForm ()) ui:on
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
		if( this._isNameMatchingSceneName() ) then 
			return false
		
		_name	= ( dotNetObject "System.Text.RegularExpressions.Regex" @"[_-]\d+$" ).Replace (getFilenameFile maxFileName) "" 

		obj.name	= _name
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
	function _isNameMatchingSceneName =
	(
		matchPattern obj.name pattern:("*"+getFilenameFile maxFileName +"_*")
		
	),
	function test =
	(
		messagebox "ObjectCleaner.test()"
	)
)
