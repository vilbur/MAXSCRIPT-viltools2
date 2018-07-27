/** Object cleaner
 */
struct ObjectCleaner_v
(
	_objects,
	obj,
	
	/** Prepare objects for export
	 */
	function prepareObjectsForExport =
	(
		this.setObjectsInExportLayer()
		
		for obj in _objects do
			this.prepareObject obj
	),
	
	/** Set objects in export layer
	  * @return	collection of geometry objects in layer "Export"	
	 */
	function setObjectsInExportLayer =
	(
		_objects = for obj in objects where superClassOf obj == GeometryClass and obj.layer.name == "Export" collect obj
	),

	/** Prepare object
	 */
	function prepareObject _obj =
	(
		print "prepareObject"
		obj = _obj
		
		this.fixMirroredObjectNormals()
		
		this._resetXform()
		this.resetSmooth()
		this.resetPivot()
		
		this.convertToEditablePoly()
		
		this.planarizeFaces()
		this.renameObject()
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
	/** Reset xform
	 */
	function _resetXform =
	(
		print ( "_resetXform = " + obj as string )
		print ( "this._isObjectMirrored() = " + this._isObjectMirrored() as string )
		
		ResetXForm obj
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
	/** Rename object
	 */
	function renameObject =
	(
		_name	= ( dotNetObject "System.Text.RegularExpressions.Regex" @"[_-]\d+$" ).Replace (getFilenameFile maxFileName) "" 
		
		--obj.name	= uniqueName _name
		obj.name	= _name
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
	function test =
	(
		messagebox "ObjectCleaner.test()"
	)
)
