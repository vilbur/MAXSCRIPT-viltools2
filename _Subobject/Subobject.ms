/** Subobject
 */
struct Subobject_v
(
	sub_objects,
	_editable_modifiers	= #( Editable_Poly, Edit_Poly, FFD_2x2x2, FFD_3x3x3, FFD_4x4x4, FFDBox, Unwrap_UVW, line, SplineShape, Edit_Spline, ProBoolean, Casement ),
	
	
	_modfier_elements = #(                              -- Available types of subobjects for modifier per type
		#(#vertex, #edge, #border, #polygon, #element), -- EPoly
		#(#vertex, #edge, #volume),                     -- FFD
		#(#vertex, #edge, #polygon)                     -- Unwrap_UVW
	),
	
	/** Enter
	  * @param	#property	sub_obj	Item from _modfier_elements
	 */
	function enter sub_obj =
	(
		current_modifier	= this.getCurrentModifier()
		_subobjects	= this.subobjects ( current_modifier )
		--print ( "Subobject_v.enter() =" + sub_obj as string )
		--print ( "current_modifier.name = " + current_modifier.name as string )
		
		if( this._modifierHasSubObject current_modifier ) then
		(
			index = (findItem _subobjects sub_obj)
			
			if( subObjectLevel == index ) then 
				subObjectLevel =  0
			else
				subObjectLevel =  index
		)
	),

	/** Get subobjects available for modifier
	  * @return	array	
	 */
	function subobjects _modifier =
	(
		if( _modifier!=undefined ) then
		--print ( "classOf _modifier=" + classOf _modifier as string )
			case classOf _modifier of
			(
				Editable_Poly:	_modfier_elements[1]
				Edit_Poly:	_modfier_elements[1]
				FFDBox:	_modfier_elements[2]
				FFD_2x2x2:	_modfier_elements[2]
				FFD_3x3x3:	_modfier_elements[2]
				FFD_3x3x3:	_modfier_elements[2]
				FFD_4x4x4:	_modfier_elements[2]
				Unwrap_UVW:	_modfier_elements[3]
				----line:	line
				----SplineShape:	SplineShape
				----Edit_Spline:	Edit_Spline
				----ProBoolean:	ProBoolean
				----Casement:	Casement
				default:	undefined
				----"MODIFIER IS NOT SUPPORTED IN Subobject_v.subobjects() modifier " + (classOf _modifier)	
			)
	),
	
	/** _get Current modifier
	 */
	function getCurrentModifier =
	(
		max modify mode
		
		modPanel.getCurrentObject()
	),
	
	function _modifierHasSubObject _modifier =  --start
	(				  		
		if( _modifier!=undefined ) then
			(findItem _editable_modifiers ( classof _modifier )) > 0 -- return
	),
	
	
	function test =
	(
		messagebox "Subobject.test()"
	)
)
