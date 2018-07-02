/** Edit poly
  *
  * Selection types
  * 1) Single base object
  * 2) Single editable poly object
  * 3) Single edit poly object
  *		a) edit poly modifier is selected
  *		b) edit poly modifier is not selected
  * 
  *
 */
struct EpolySelection_v
(
	_selection,
	
	/** Get current Editable_Poly or Edit_Poly modifier 
	  *
	  * @return	modifier "Editable_Poly|Edit_Poly|Undefined" Type of active modifier, undefined if Editable_poly & Edit_Poly is not active
	 */
	function getCurrentEpoly =
	(		
		_selection = (Selection_v()).get()
		
		if( _selection.count > 0 ) then
		(
			current_epoly	= this._getCurrentEpoly()

			if( current_epoly != undefined ) then
				current_epoly --return
				
			else
				undefined --return
		)
	),
	/** 1) Find and select Edit_Poly modifier,
	  * 2) If Edit_Poly does not exist, then select Editable_Poly
	  * 3) If object is not Editable_Poly then return undefined
	 */
	function findEpoly =
	(
		current_epoly = this.getCurrentEpoly()

		if( current_epoly == undefined ) then
		(
			obj	= _selection[1]
			edit_poly_index	= this.searchEditPolyModifier obj
			
			if( edit_poly_index != undefined ) then 
				this._selectModifierByIndex obj edit_poly_index -- set Edit_Poly
				
			else if ( this._isEditablePolyObject obj ) then
				this._selectBaseObject obj -- set Editable_Poly
		)
		
	),
	/** Search for first edit poly modifier from top
	 */
	function searchEditPolyModifier obj =
	(
		edit_poly_mods	= this._getEditPolyModifiers obj
	
		if( edit_poly_mods.count > 0 ) then
			edit_poly_mods[1] --return
		--print ( "edit_poly_mods=" + edit_poly_mods as string )
	),
	/** Get edit poly modifiers
	 */
	function _getEditPolyModifiers obj =
	(
		modifiers	= obj.modifiers
		edit_poly_mods	= #()
		print ( "modifiers=" + modifiers as string )

		for m=1 to modifiers.count where  classOf modifiers[m] == Edit_Poly do
			append edit_poly_mods m
		
		edit_poly_mods --return
	),	
	/** Get current Editable_Poly or Edit_Poly
	  * @return	Editable_Poly|Edit_Poly|undefined	Return undefined if Editable_Poly or Edit_Poly is not active
	 */
	function _getCurrentEpoly =
	(
		max modify mode

		current_modifier	=  modPanel.getCurrentObject()
		current_modifier_class	= classOf current_modifier
		
		if( current_modifier_class == Edit_Poly or current_modifier_class == Editable_Poly  ) then
			current_modifier --return
		else
			undefined --return
	),
	/** Select modifier by index
	 */
	function _selectModifierByIndex obj index =
	(
		modPanel.setCurrentObject obj.modifiers[index] -- set Edit_Poly
	),
	/** Select modifier by index
	 */
	function _selectBaseObject obj =
	(
		modPanel.setCurrentObject obj.baseObject -- set Edit_Poly
	),
	/** Find if object is editabl epoly without modifiers
	 */
	function _isEditablePolyObject obj =
	(
		classOf(obj.baseObject)==Editable_Poly --return 
	),

	
	function test =
	(
		messagebox "EditPoly.test()"
	)
)

