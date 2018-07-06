/** Manage subobejct selections for Editable_Poly & Edit_Poly
  *
  *
 */
struct EpolySelection_v
(
	EpolyMod	= EpolyMod_v(),

	_objects,
	--_mod,
	
	_subobjects	= #(#vertex, #edge, #border, #face, #element),

	/** Init
	 */
	function _init =
	(
		this._setObjects()
		this._setCurrentMod()
	),
	
	/** Convert current subobject to given subobject
	  * 1) If not subobject active then enter to subobject
	  * 2) If object is not Editable_Poly or Edit_Poly then Edit_Poly is added
	  * 
	  * @param	name	to_sub_obj E.g.: #vertex
	  */
	function convertSelection to_sub_obj =
	(
		if( subObjectLevel > 0 ) then
			(EpolyMod.mod()).convertSelection (_subobjects[ subObjectLevel ]) to_sub_obj
		
		(Subobject_v()).enterForced (this._getSubobjectIndex to_sub_obj)
	),
	
	/** Get current subobejct selection
	  * @return	bitArray|[bitArray]	bitArray of selected elements or array of bitArrays for each object if Edit_Poly
	  */
	function getSelection sub_obj =
	(		
		this._init()
		
		sub_selection	= if( classOf _mod == Editable_Poly ) then this._getEditablePolySelection sub_obj else this._getEditPolySelection sub_obj
		
		print ( "sub_selection = " + sub_selection as string )
	),
	/** Get current subobejct selection
	  * @param	bitArray|[bitArray]	_selection	bitArray of elements to select, for Edit_Poly can be array of bitArrays for each object
	 */
	function setSelection sub_obj _selection =
	(		
		this._init()
		
		if( classOf _mod == Editable_Poly ) then this._setEditablePolySelection sub_obj _selection else this._setEditPolySelection sub_obj _selection
	),

	/*------------------------------------------------------------------------------
		PRIVATE
	--------------------------------------------------------------------------------*/
	
	/** Get subobject index
	  * @param	name	sub_obj
	 */
	function _getSubobjectIndex sub_obj =
	(
		findItem _subobjects sub_obj --return
	),
	
	/* ========= GET SELECTION ========= */
	
	/** Get editable poly selection of subobjects
	  * @return	bitArray	
	 */
	function _getEditablePolySelection sub_obj =
	(
		_mod.GetSelection sub_obj 
	),
	/** Get edit poly selection of subobjects 
	  * @return	[bitArray]	array of bitArrays, bitArray for each selected object
	 */
	function _getEditPolySelection sub_obj _selection =
	(
		for o in _objects collect (_mod.GetSelection sub_obj node:o)
	),
	
	/* ========= SET SELECTION ========= */
	
	/** Set editable poly selection of subobjects
	 */
	function _setEditablePolySelection sub_obj _selection =
	(
		_mod.SetSelection sub_obj _selection
	),
	/** Set edit poly selection of subobjects 
	 */
	function _setEditPolySelection sub_obj _selection =
	(
		print "_setEditPolySelection()"

		for o=1 to _objects.count do
		(
			sub_selection	= if( classOf _selection == Array )then _selection[o] else _selection
			_mod.SetSelection	sub_obj #{}	node: _objects[o]
			_mod.Select	sub_obj sub_selection	node: _objects[o]
		)
	),
	
	/*---------------------------------------
		INIT METHODS
	-----------------------------------------*/
	
	/** Set object
	 */
	function _setObjects =
	(
		_objects = (Selection_v()).get()
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
		messagebox "EpolySelection_v.test()"
	)
)

