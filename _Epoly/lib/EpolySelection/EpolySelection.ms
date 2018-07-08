/** Manage subobejct selections for Editable_Poly & Edit_Poly
  *
  *
 */
struct EpolySelection_v
(
	EpolyMod	= EpolyMod_v(),

	_objects,
	_mod,
	
	_subobjects	= #(#vertex, #edge, #border, #face, #element),

	/** Init
	 */
	function _init =
	(
		this._setObjects()
		this._setMod()
	),
	
	/** Convert current subobject to given subobject
	  * 1) If not subobject active then enter to subobject
	  * 2) If object is not Editable_Poly or Edit_Poly then Edit_Poly is added
	  * 
	  * @param	name	to_sub_obj E.g.: #vertex
	  */
	function convertSelection to_sub_obj =
	(
		this._init()

		if( subObjectLevel > 0 ) then
			_mod.convertSelection (_subobjects[ subObjectLevel ]) to_sub_obj
			--(EpolyMod.mod()).convertSelection (_subobjects[ subObjectLevel ]) to_sub_obj
		
		(Subobject_v()).enterForced (this._getSubobjectIndex to_sub_obj)
	),
	/** Get selected or all faces
	 */
	function getSelectedOrAllFaces =
	(
		this._init()

		--_selection = (EpolyMod.getEpoly()).getSelectedOrAllFaces()
		--print ( "_selection = " + _selection as string )
		--_selection --return
		(EpolyMod.getEpoly()).getSelectedOrAllFaces() --return
	),
	/** All faces
	 */
	function allFaces =
	(
		(EpolyMod.getEpoly())._allFaces() --return
	),
	/** Get current subobejct selection
	  * @param	name	sub_obj
	  * @return	bitArray|[bitArray]	bitArray of selected elements or array of bitArrays for each object if Edit_Poly
	  */
	function getSel sub_obj =
	(		
		this._init()
		
		sub_selection	= if( classOf _mod == Editable_Poly ) then this._getEditablePolySelection sub_obj else this._getEditPolySelection sub_obj
		
		--print ( "sub_selection = " + sub_selection as string )
		sub_selection --return
	),
	/** Get current subobejct selection
	  * @param	name	sub_obj
	  * @param	bitArray|[bitArray]	_selection	bitArray of elements to select, for Edit_Poly can be array of bitArrays for each object
	 */
	function setSel sub_obj _selection =
	(		
		this._init()
		print ( "setSel = " + _selection as string )
		
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
	  * @param	name	sub_obj
	  * @return	bitArray	
	 */
	function _getEditablePolySelection sub_obj =
	(
		_mod.GetSelection sub_obj  --return
	),
	/** Get edit poly selection of subobjects 
	  * @param	name	sub_obj
	  * @return	[bitArray]	array of bitArrays, bitArray for each selected object
	 */
	function _getEditPolySelection sub_obj =
	(
		print "***_getEditPolySelection()"
		for o in _objects collect (_mod.GetSelection sub_obj node:o)
	),
	
	/* ========= SET SELECTION ========= */
	
	/** Set editable poly selection of subobjects
	  * @param	name	sub_obj
	 */
	function _setEditablePolySelection sub_obj facelist =
	(
		_mod.SetSelection sub_obj facelist
	),
	/** Set edit poly selection of subobjects 
	  * @param	name	sub_obj
	 */
	function _setEditPolySelection sub_obj facelist_array =
	(
		--print "======= _setEditPolySelection()"

		for o=1 to _objects.count do
		(
			sub_selection	= if( classOf facelist_array == Array )then facelist_array[o] else facelist_array
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
	function _setMod =
	(
		--max modify mode
		
		--_mod = modPanel.getCurrentObject()
		_mod = EpolyMod.mod()
	),

	function test =
	(
		messagebox "EpolySelection_v.test()"
	)
)

