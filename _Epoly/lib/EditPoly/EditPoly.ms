/** Edit poly
 */
struct EditPoly_v
(
	EditPoly,
	
	/** Init
	  * @return	boolean 	
	 */
	function init =
	(
		--print "EditPoly_v.init()"
		this._setEditPoly()
		
		true --return
	),
	/** Convert selection
	 */
	function convertSelection _from _to =
	(
		EditPoly.ConvertSelection _from _to
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
		EditPoly.smoothingGroupsToSet = 0
		EditPoly.smoothingGroupsToClear = -1
	),
	/*---------------------------------------
		PRIVATE 
	-----------------------------------------*/
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
