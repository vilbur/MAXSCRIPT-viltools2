/** Subobject
 */
struct Subobject_v
(
	sub_objects,
	_editable_modifiers	= #( Editable_Poly, Edit_Poly, FFD_2x2x2, FFD_3x3x3, FFD_4x4x4, FFDBox, Unwrap_UVW, line, SplineShape, Edit_Spline, ProBoolean, Casement ),
	_modfier_elements = #(
		#(#vertex, #edge, #border, #polygon, #element),	-- EPoly
		#(#vertex, #edge, #volume),	-- FFD
		#(#vertex, #edge, #polygon)	-- Unwrap_UVW
	),
	
	/** Enter
	  * @param	#property	sub_obj	Item from _modfier_elements
	 */
	function enter sub_obj =
	(
		_subobjects	= this.subobjects()
		print ( "Subobject_v.enter() =" + sub_obj as string )
		
		if( this._modifierHasSubObject()==true ) then
			subObjectLevel =  (findItem _subobjects sub_obj)
	),
	
	function _modifierHasSubObject =  --start
	(				  
		max modify mode

		current_modifier = modPanel.getCurrentObject()
		
		if( current_modifier!=undefined ) then
			(findItem _editable_modifiers ( classof current_modifier )) > 0 -- return
	),

	/** Get subobjects available for modifier
	  * @return	array	
	 */
	function subobjects =
	(
		current_modifier = modPanel.getCurrentObject()
		--subobjectLevel = 4
	
		if( current_modifier!=undefined ) then
		print ( "classOf current_modifier=" + classOf current_modifier as string )
			case classOf current_modifier of
			(
				Editable_Poly:	_modfier_elements[1]
				Edit_Poly:	_modfier_elements[1]
				FFDBox:	_modfier_elements[2]
				FFD_2x2x2:	_modfier_elements[2]
				FFD_3x3x3:	_modfier_elements[2]
				FFD_3x3x3:	_modfier_elements[2]
				FFD_4x4x4:	_modfier_elements[2]
				Unwrap_UVW:	_modfier_elements[3]
				--line:	line
				--SplineShape:	SplineShape
				--Edit_Spline:	Edit_Spline
				--ProBoolean:	ProBoolean
				--Casement:	Casement
				default:	undefined
				--"MODIFIER IS NOT SUPPORTED IN Subobject_v.subobjects() modifier " + (classOf current_modifier)	
			)
	),
	
	function test =
	(
		messagebox "Subobject.test()"
	)
)
