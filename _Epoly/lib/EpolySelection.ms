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
	
	/** Find if selection is editable poly or edit_poly
	  * Activate Edit_Poly modifier if is found in stack
	  *
	  * @return	string "Editable_Poly|Edit_Poly" or undefined  	
	 */
	function getEpoly =
	(
		print ( "this._isEditPolyActive()=" + this._isEditPolyActive() as string )
		
		_selection = (Selection_v()).get()
		if( _selection.count > 0 ) then 
		(
			if( this._isObjectEditablePoly _selection[1] and _selection.count == 1 ) then
				"Editable_Poly" --return
			
			else
			(
				edit_poly_active = this._isEditPolyActive()
				
				if( edit_poly_active == false and _selection.count == 1 ) then
				(
					edit_poly_index = this.searchEditPolyModifier _selection[1]
					modPanel.setCurrentObject _selection[1].modifiers[edit_poly_index]
					edit_poly_active = true
				)
				
				if( edit_poly_active ) then 
					"Edit_Poly" --return
			)
		)

	),
	/** Is edit poly active
	 */
	function _isEditPolyActive =
	(
		max modify mode

		classOf ( modPanel.getCurrentObject() ) == Edit_Poly  --return
	),
	/** Find if object is editabl epoly without modifiers
	 */
	function _isObjectEditablePoly obj =
	(
		classOf(obj.baseObject)==Editable_Poly and obj.modifiers.count==0
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
	
	function test =
	(
		messagebox "EditPoly.test()"
	)
)

