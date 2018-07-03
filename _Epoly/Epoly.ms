/** Epoly
 *
 */
struct Epoly_v
(
	--current_modifier,
	EditablePoly	= EditablePoly_v(),
	EditPoly	= EditPoly_v(),
	
	_subobjects	= #(#vertex, #edge, #border, #face, #element),
	
	/** Convert subobject 
	 */
	function convertSelection _to =
	(
		if( subobjectLevel > 0 ) then
		(
			_from = _subobjects[subobjectLevel]
			
			if( this.isEditablePoly() ) then
				EditablePoly.convertSelection _from _to
				
			else if( this.isEditPoly() ) then
				EditPoly.convertSelection _from _to
		)
		
		this.enterSubobject _to
	),
	/** Test if current modifier is editable poly
	 */
	function isEditablePoly =
	(
		this.initSubClass Editable_Poly --return
	),
	/** Test if current modifier is edit poly
	 */
	function isEditPoly =
	(
		this.initSubClass Edit_Poly --return
	),
	/** Init sub class
	 */
	function initSubClass epoly_type =
	(
		max modify mode
		
		if( epoly_type == classof ( modPanel.getCurrentObject()) ) then
		(
			if( epoly_type == Editable_Poly ) then
				EditablePoly.init() --return
				
			else if( epoly_type == Edit_Poly ) then
				EditPoly.init() --return
		)
		else
			false --return
	),
	/** Enter to subobject
	  * @param	name	sub_obj
	 */
	function enterSubobject sub_obj =
	(
		--print ( "subobjectLevel = " + ( findItem _subobjects sub_obj ) as string )
		subobjectLevel = ( findItem _subobjects sub_obj )
	),
	
	function test =
	(
		this._setCurrentModifier()
		--messagebox "Epoly_v.test()"

	)
	
)

