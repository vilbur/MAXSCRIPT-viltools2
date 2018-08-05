/** Subobject
 */
struct Subobject_v
(
	/** Enter toggle to subject, if subject is aftive thrn exit suobject
	 */
	function enterToogle sub_obj =
	(
		if not ( this.modifierHasSubobjects() ) then
			return false
		
		if( subObjectLevel == sub_obj ) then
			subObjectLevel = 0
		
		else
			this.enter sub_obj
	),
	
	/** Enter to subobject if Editable_Poly or modifier with subobjects
	  * @param	integer	sub_obj	Index of subobject
	 */
	function enter sub_obj =
	(		
		if not ( this.modifierHasSubobjects() ) then
			return false
		
		this.setActiveSubobject (this._testMaxSubObjectLevels sub_obj)
	),
	/** Enter toggle to last used subject
	 */
	function enterToogleLast =
	(
		this.enterToogle (this._lastUsedSubobject())
	),
	/** Circle
	 */
	function circle subobjects =
	(
		if not ( this.modifierHasSubobjects() ) then
			return false
			
		print ( "circle = " + subobjects as string )
		next_subobject	= this.findNextSubobject subobjects subObjectLevel
		print ( "next_subobject = " + next_subobject as string )

		this.enter next_subobject
	),
	/** Test if sub_obj is not higher then available subjects
	  *	@return	integer	
	 */
	function _testMaxSubObjectLevels sub_obj =
	(
		if( sub_obj > numSubObjectLevels ) then
			sub_obj = numSubObjectLevels
		
		sub_obj_new	= if( subObjectLevel == sub_obj )then 0 else sub_obj 
	),

	
	
	--/** This method will enter to subobject in anyway
	--  *
	--  * 1) Enter to subobject of current modifier
	--  * 2) If current modifier has not subobjects then search for first modifier with subobjects
	--  * 3) If modifier with subobjects is not found, then try select base object Editable_Poly
	--  * 3) If base object is not Editable_Poly, then add Edit_Poly modifier 
	-- */
	--function enterForced sub_obj =
	--(
	--	if( this.enter sub_obj == undefined ) then
	--	(
	--		current_modifier	= modPanel.getCurrentObject()
	--
	--		if( classOf current_modifier != Edit_Poly ) then
	--			(Modifier_v type:#Edit_Poly ).add()
	--		
	--		--obj	= selection[1]
	--		--subobject_modifiers	= this._getModifiersWithSubobjects obj
	--		--
	--		--if( subobject_modifiers.count > 0 ) then -- find modifier with subobjects
	--		--	modPanel.setCurrentObject obj.modifiers[subobject_modifiers[1]]
	--		--
	--		----else if( this._isEditablePolyObject obj ) then -- find Editable_Poly base obejct
	--		--	--modPanel.setCurrentObject obj.baseObject
	--		--
	--		--else -- add Edit_Poly
	--		--	(Modifier_v type:#Edit_Poly ).add()
	--		--
	--		this.enter sub_obj
	--	)
	--),



	/*------------------------------------------------------------------------------
		PRIVATE
	--------------------------------------------------------------------------------*/
	/** Set active subobject
	 */
	function setActiveSubobject sub_obj =
	(
		subObjectLevel = sub_obj
		
		if( last_used_subobject == undefined ) then
		(
			global last_used_subobject
			last_used_subobject = 1
		)
			
		if( sub_obj > 0 ) then
			last_used_subobject = sub_obj
			--sub_obj = last_used_subobject
			
		--print ( "last_used_subobject = " + sub_obj as string )
	),
	/** _set last subobject global variable
	 */
	function _lastUsedSubobject =
	(
		if( last_used_subobject == undefined ) then
		(
			global last_used_subobject
			last_used_subobject = 1
		)
		last_used_subobject --return
	),
	/** Find next element in array
	 */
	function findNextSubobject subobjects current_subobject =
	(
		current_index	= findItem subobjects current_subobject
		next_index	= current_index + 1
		
		if( current_index == undefined or subobjects[current_index] == undefined  or current_index ==  subobjects.count  ) then 
			subobjects[1] --return
		else
			subobjects[next_index] --return
	),
	
	
	/** Is subobject modifier
	 */
	function modifierHasSubobjects =
	(
		max modify mode

		numSubObjectLevels != 0
	),
	--/** Get edit poly modifiers
	-- */
	--function _getModifiersWithSubobjects obj =
	--(
	--	modifiers	= obj.modifiers
	--	subobject_modifiers	= #()
	--	--print ( "modifiers=" + modifiers as string )
	--
	--	for m=1 to modifiers.count where this._isModifiersWithSubobjects (modifiers[m]) do
	--		append subobject_modifiers m
	--	
	--	subobject_modifiers --return
	--),
	--/** Find if object is editabl epoly without modifiers
	-- */
	--function _isEditablePolyObject obj =
	--(
	--	classOf(obj.baseObject)==Editable_Poly --return 
	--),
	/** _get Current modifier
	 */
	--function _getCurrentModifier =
	--(
		--max modify mode
		
		--modPanel.getCurrentObject()
	--),

	
	function test =
	(
		messagebox "Subobject.test()"
	)
)
