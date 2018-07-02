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
	/** 1) Enter to subobject of current modifier
	  * 2) If current modifier has not subobjects then search for first modifier with subobjects
	  * 3) If modifier with subobjects is not found, then add Edit_Poly modifier 
	 */
	function enterOrFindModifierOrAddEditPoly sub_obj =
	(
		--if( this.enter sub_obj == undefined ) then
			
	),
	
	/** _get Current modifier
	 */
	function getCurrentModifier =
	(
		max modify mode
		
		modPanel.getCurrentObject()
	),
	
	
	--function _modifierHasSubObject _modifier =  --start
	--(				  		
	--	if( _modifier!=undefined ) then
	--		(findItem _editable_modifiers ( classof _modifier )) > 0 -- return
	--),
	
	
	function test =
	(
		messagebox "Subobject.test()"
	)
	

)
