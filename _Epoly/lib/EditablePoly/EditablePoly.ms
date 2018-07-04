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
		--print "EditablePoly_v.init()"
		this._setObj()
		this._setEditablePoly()
		
		true --return
	),
	/** Convert selection
	 */
	function convertSelection _from _to =
	(
		--print "EditablePoly_v.convertSelection()"
		--print ( "_from = " + _from as string )
		--print ( "_to = " + _to as string )
		EditablePoly.ConvertSelection _from _to
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
		facelist = polyop.getnumfaces obj
	
		for i = 1 to facelist do
			polyop.setFaceSmoothGroup obj i 0
	),
	/*---------------------------------------
		PRIVATE 
	-----------------------------------------*/
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
