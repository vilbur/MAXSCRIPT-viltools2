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
		--print "EditPoly_v.convertSelection()"
		--print ( "_from = " + _from as string )
		--print ( "_to = " + _to as string )
		EditPoly.ConvertSelection _from _to
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
