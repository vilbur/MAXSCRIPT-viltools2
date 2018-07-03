/** Subobject
 */
struct Subobject_v
(
	Subobjects 	= SubobjectModifiers_v(),
	
	/** Enter to subobject if Editable_Poly or modifier with subobjects
	  * @param	integer	sub_obj	Index of subobject
	 */
	function enter sub_obj =
	(
		--current_modifier	= this._getCurrentModifier()
		subobjects_of_modifier	= Subobjects.get (this._getCurrentModifier())
		
		
		if( subobjects_of_modifier != undefined and sub_obj <= subobjects_of_modifier.count ) then
		(
			--index	= (findItem subobjects_of_modifier sub_obj)
			
			if( subObjectLevel == sub_obj ) then 
				subObjectLevel =  0
			else
				subObjectLevel =  sub_obj
		)
	),
	/** This method will enter to subobject in anyway
	  *
	  * 1) Enter to subobject of current modifier
	  * 2) If current modifier has not subobjects then search for first modifier with subobjects
	  * 3) If modifier with subobjects is not found, then try select base object Editable_Poly
	  * 3) If base object is not Editable_Poly, then add Edit_Poly modifier 
	 */
	function enterForced sub_obj =
	(
		if( this.enter sub_obj == undefined ) then
		(
			obj	= selection[1]
			subobject_modifiers	= this._getModifiersWithSubobjects obj
			
			if( subobject_modifiers.count > 0 ) then -- find modifier with subobjects
				modPanel.setCurrentObject obj.modifiers[subobject_modifiers[1]]

			else if( this._isEditablePolyObject obj ) then -- find Editable_Poly base obejct
				modPanel.setCurrentObject obj.baseObject
			
			else -- add Edit_Poly
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
	function _getCurrentModifier =
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
