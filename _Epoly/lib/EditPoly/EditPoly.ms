/** Edit poly
 */
struct EditPoly_v
(
	mod,
	_objects,

	/** Init
	  * @return	boolean 	
	 */
	function init =
	(
		--print "EditPoly_v.init()"
		this._setObjects()
		this._setMod()

		true --return
	),
	/** Remove
	 */
	function remove =
	(
		for obj in _objects do
		(
			case subobjectLevel of
			(
				1:( for_remove = #RemoveVertex )
				2:( for_remove = #RemoveEdgeRemoveVertices )
				3:( for_remove = #RemoveEdgeRemoveVertices )
				4:( mod.ConvertSelection #Face #Vertex; for_remove = #DeleteFace )
				5:( mod.ConvertSelection #Face #Vertex; for_remove = #DeleteFace )
			)
			
			mod.ButtonOp for_remove
		)
	),
	
	/** Face count
	 */
	function faceCount =
	(		
		face_counts = #()
		
		for obj in _objects do
			append face_counts ( polyop.getNumFaces obj )
		
		face_counts --return	
	),
	
	/*---------------------------------------
		SMOOTH GROUPS
	-----------------------------------------*/
	/** Set smooth group
	  * @param	integer	smooth_group	
	  * @param	bitArray	facelists 	All faces used if facelist==undefined
	 */
	function setSmoothGroup smooth_group facelist:undefined =
	(
		mod.SetOperation #SetSmooth
		mod.smoothingGroupsToSet = smooth_group
	),
	/** Auto smooth
	  * @param	integer	_angle
	 */
	function autoSmooth _angle =
	(
		mod.autoSmoothThreshold = _angle
		mod.ButtonOp #Autosmooth
	),
	/** Clear smooth groups
	 */
	function clearSmoothGroups =
	(
		mod.SetOperation #SetSmooth
		mod.smoothingGroupsToSet	= 0
		mod.smoothingGroupsToClear	= -1
	),
	/*---------------------------------------
		PRIVATE 
	-----------------------------------------*/
	/** Set object
	 */
	function _setObjects =
	(
		_objects = (Selection_v()).get()
	),
	/** Set current modifier
	 */
	function _setMod =
	(
		mod = modPanel.getCurrentObject()
	),
	function test =
	(
		messagebox "EditPoly_v.test()"
	)
)
