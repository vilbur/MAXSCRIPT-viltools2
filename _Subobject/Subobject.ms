/** Subobject
 */
struct Subobject_v
(
	Subobjects 	= SubobjectModifiers_v(),
	
	/** Enter to subobject if Editable_Poly or modifier with subobjects
	  * @param	#property	sub_obj	Item from _modfier_elements
	 */
	function enter sub_obj =
	(
		--current_modifier	= this.getCurrentModifier()
		subobjects_of_modifier	= Subobjects.get (this.getCurrentModifier())
		
		if( subobjects_of_modifier != undefined ) then
		(
			index	= (findItem subobjects_of_modifier sub_obj)
			
			if( subObjectLevel == index ) then 
				subObjectLevel =  0
			else
				subObjectLevel =  index
		)
	),
	/** This method will enter to subobject in anyway
	  *
	  * 1) Enter to subobject of current modifier
	  * 2) If current modifier has not subobjects then search for first modifier with subobjects
	  * 3) If modifier with subobjects is not found, then try select base object Editable_Poly
	  * 3) If base object is not Editable_Poly, then add Edit_Poly modifier 
	 */
	function enterOrFindModifierOrAddEditPoly sub_obj =
	(
		if( this.enter sub_obj == undefined ) then
		(
			obj	= selection[1]
			subobject_modifiers	= this._getModifiersWithSubobjects obj
			
			if( subobject_modifiers.count > 0 ) then
				modPanel.setCurrentObject obj.modifiers[subobject_modifiers[1]]

			else if( this._isEditablePolyObject obj ) then
				modPanel.setCurrentObject obj.baseObject
			
			else
				(Modifier_v type:#Edit_Poly ).add()
			
			this.enter sub_obj
		)

	),

	/** Get edit poly modifiers
	 */
	function _getModifiersWithSubobjects obj =
	(
		modifiers	= obj.modifiers
		subobject_modifiers	= #()
		print ( "modifiers=" + modifiers as string )

		for m=1 to modifiers.count where this._isModifiersWithSubobjects (modifiers[m]) do
			append subobject_modifiers m
		
		subobject_modifiers --return
	),
	/** Find if object is editabl epoly without modifiers
	 */
	function _isEditablePolyObject obj =
	(
		classOf(obj.baseObject)==Editable_Poly --return 
	),
	/** _get Current modifier
	 */
	function getCurrentModifier =
	(
		max modify mode
		
		modPanel.getCurrentObject()
	),
	/** Is subobject modifier
	 */
	function _isModifiersWithSubobjects _modifier =
	(
		--classOf modifiers[m] == Edit_Poly
		subobjects_of_modifier	= Subobjects.get _modifier
		
		subobjects_of_modifier != undefined --return

	),
	
	function test =
	(
		messagebox "Subobject.test()"
	)
	

)
