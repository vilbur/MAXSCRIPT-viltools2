/** Edit poly
 */
struct EditablePoly_v
(
	EditablePoly,
	
	/** Init
	 */
	function init =
	(
		--print "EditablePoly_v.init()"
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
