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
		subobjects_of_modifier	= Subobjects.get (this._getCurrentModifier())
		
		if( sub_obj == 0 ) then
			this.enterToogle()
		
		else if( subobjects_of_modifier != undefined and sub_obj <= subobjects_of_modifier.count ) then
		(
			if( subObjectLevel == sub_obj ) then 
				sub_obj_new =  0
			else
				sub_obj_new =  sub_obj
			
			this.setActiveSubobject sub_obj_new
			
			subObjectLevel =  sub_obj_new

		)
	),
	/** Enter toogle
	 */
	function enterToogle =
	(
		subo = this.setActiveSubobject undefined
		
		if( subObjectLevel == 0 ) then
			subObjectLevel = subo
		else
			subObjectLevel = 0
		
	),
	/** Circle
	 */
	function circle subobjects =
	(
		--print ( "subobjects = " + subobjects as string )
		next_index	= this.findNextIndex subobjects subObjectLevel
		--actionMan.executeAction 0 "40472"  -- MAX Script: MAXScript Listener
		sub_obj_new	= subobjects[next_index]
		
		this.setActiveSubobject sub_obj_new

		this.enter sub_obj_new
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
			current_modifier	= modPanel.getCurrentObject()

			if( classOf current_modifier != Edit_Poly ) then
				(Modifier_v type:#Edit_Poly ).add()
			
			--obj	= selection[1]
			--subobject_modifiers	= this._getModifiersWithSubobjects obj
			--
			--if( subobject_modifiers.count > 0 ) then -- find modifier with subobjects
			--	modPanel.setCurrentObject obj.modifiers[subobject_modifiers[1]]
			--
			----else if( this._isEditablePolyObject obj ) then -- find Editable_Poly base obejct
			--	--modPanel.setCurrentObject obj.baseObject
			--
			--else -- add Edit_Poly
			--	(Modifier_v type:#Edit_Poly ).add()
			--
			this.enter sub_obj
		)
	),

	/*------------------------------------------------------------------------------
		PRIVATE
	--------------------------------------------------------------------------------*/
	/** Set active subobject
	 */
	function setActiveSubobject sub_obj =
	(
			
		if( enter_subobject_last_subobject == undefined ) then
		(
			global enter_subobject_last_subobject
			enter_subobject_last_subobject = 1
		)
			
		if( sub_obj == undefined) then
			sub_obj = enter_subobject_last_subobject
		print ( "enter_subobject_last_subobject = " + sub_obj as string )
		enter_subobject_last_subobject = sub_obj
	),
	/** Find next index
	 */
	function findNextIndex array current_index =
	(
		next_index	= current_index + 1
		--print ( "current_index = " + current_index as string )
		--print ( "next_index = " + next_index as string )
		if( next_index<=array.count or next_index <= 0 ) then next_index else 1 --return
	),
	/** Get edit poly modifiers
	 */
	function _getModifiersWithSubobjects obj =
	(
		modifiers	= obj.modifiers
		subobject_modifiers	= #()
		--print ( "modifiers=" + modifiers as string )

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
