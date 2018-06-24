/** Subobject
 */
struct Subobject_v
(
	
	/** Enter
	 */
	function enter sub_obj =
	(
		editable = this._modifierHasSubObject()
		print ( "editable=" + editable as string )
	),
	
	function _modifierHasSubObject =  --start
	(				  
		max modify mode

		current_modifier = modPanel.getCurrentObject()
		
		if( current_modifier!=undefined ) then
		(
			editable_modifiers	= #( Editable_Poly, Edit_Poly, FFD_2x2x2, FFD_3x3x3, FFD_4x4x4, FFDBox, Unwrap_UVW, line, SplineShape, Edit_Spline, ProBoolean, Casement )
			index	= findItem editable_modifiers ( classof ( modPanel.getCurrentObject()) )

			if( index>0 ) then
				true --return
			else
				false --return 
		)
	
	),
	
	function test =
	(
		messagebox "Subobject.test()"
	)
)
