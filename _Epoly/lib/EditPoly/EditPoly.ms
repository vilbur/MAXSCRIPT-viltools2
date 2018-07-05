/** Edit poly
 */
struct EditPoly_v
(
	EditPoly,
	_objects,

	/** Init
	  * @return	boolean 	
	 */
	function init =
	(
		--print "EditPoly_v.init()"
		this._setObjects()
		this._setEditPoly()

		true --return
	),
	/** Convert selection
	 */
	function convertSelection _from _to =
	(
		EditPoly.ConvertSelection _from _to
	),
	/** Ignore backfacing
	  * @return	boolean	new state
	 */
	function ignoreBackfacing state:undefined =
	(
		if( state == undefined ) then
			state = EditPoly.ignoreBackfacing != true
		
		EditPoly.ignoreBackfacing  = state
		
		state --return
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
		EditPoly.SetOperation #SetSmooth
		EditPoly.smoothingGroupsToSet = smooth_group
	),
	/** Auto smooth
	  * @param	integer	_angle
	 */
	function autoSmooth _angle =
	(
		EditPoly.autoSmoothThreshold = _angle
		EditPoly.ButtonOp #Autosmooth
	),
	/** Clear smooth groups
	 */
	function clearSmoothGroups =
	(
		EditPoly.SetOperation #SetSmooth
		EditPoly.smoothingGroupsToSet	= 0
		EditPoly.smoothingGroupsToClear	= -1
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
	function _setEditPoly =
	(
		EditPoly = modPanel.getCurrentObject()
	),
	function test =
	(
		messagebox "EditPoly_v.test()"
	)
)
