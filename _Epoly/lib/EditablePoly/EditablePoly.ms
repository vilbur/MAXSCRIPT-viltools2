/** Edit poly
 */
struct EditablePoly_v
(
	obj,
	EditablePoly,
	
	/** Init
	  * @return	boolean 	
	 */
	function init =
	(
		if( obj == undefined ) then
		(
			this._setObj()
			this._setEditablePoly()
		)
		true --return
	),
	/** Convert selection
	 */
	function convertSelection _from _to =
	(
		EditablePoly.ConvertSelection _from _to
	),
	/** Ignore backfacing
	 */
	function ignoreBackfacing state:undefined =
	(
		if( state == undefined ) then
			state = EditablePoly.ignoreBackfacing != true

		EditablePoly.ignoreBackfacing  = state
	),
	
	/** Face count
	 */
	function faceCount =
	(		
		polyop.getNumFaces obj --return 
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
		if( facelist==undefined ) then
			facelist = this._allFaces()
			
		polyop.setFaceSmoothGroup obj facelist smooth_group
	),
	/** Auto smooth
	  * @param	integer	_angle
	 */
	function autoSmooth _angle =
	(
		EditablePoly.autoSmoothThreshold = _angle
		EditablePoly.autosmooth()
	),
	/** Clear smooth groups
	 */
	function clearSmoothGroups =
	(
		--obj = obj.baseObject
		facelist = polyop.getNumFaces obj
	
		for i = 1 to facelist do
			polyop.setFaceSmoothGroup obj i 0
	),
	/*---------------------------------------
		PRIVATE 
	-----------------------------------------*/
	/** _all faces
	 */
	function _allFaces =
	(
		#{1..( this.faceCount() )} --return
	),
	
	/** _set obj
	 */
	function _setObj =
	(
		obj = selection[1]
	),
	/** Set current modifier
	 */
	function _setEditablePoly =
	(
		EditablePoly = modPanel.getCurrentObject()
	),
	function test =
	(
		messagebox "EditablePoly_v.test()"
	)
)
