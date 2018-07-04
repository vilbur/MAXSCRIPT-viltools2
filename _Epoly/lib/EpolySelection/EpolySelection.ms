/** EpolySelection
  *
  *
 */
struct EpolySelection_v
(
	_selection,
	_mod,

	/** Get current subobejct selection
	  *
	 */
	function getSelection =
	(		
		this._setCurrentMod()
		
		sub_selection	= if( classOf _mod == Editable_Poly ) then this._getEditablePolySelection() else this._getEditPolySelection()
		
		print ( "sub_selection = " + sub_selection as string )
	),
	
	
	/*---------------------------------------
		PRIVATE
	-----------------------------------------*/
	/** Get editable poly selection of subobjects
	  * @return	bitArray	
	 */
	function _getEditablePolySelection =
	(
		_mod.GetSelection #Face
	),
	/** Get edit poly selection of subobjects 
	  * @return	[bitArray]	array of bitArrays, bitArray for each selected object
	 */
	function _getEditPolySelection =
	(
		for o in selection collect (_mod.GetSelection #Face node:o)
	),
	/** Set current mod
	 */
	function _setCurrentMod =
	(
		max modify mode
		
		_mod = modPanel.getCurrentObject()
	),

	function test =
	(
		messagebox "EditPoly.test()"
	)
)

