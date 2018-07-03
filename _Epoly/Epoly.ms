/** Epoly
 *
 */
struct Epoly_v
(
	--current_modifier,
	EditablePoly	= EditablePoly_v(),
	EditPoly	= EditPoly_v(),
	
	_subobjects	= #(#vertex, #edge, #border, #face, #element),
	
	/** Convert current subobject to given subobject
	  * 1) If not subobject active then enter to subobject
	  * 2) If object is not Editable_Poly or Edit_Poly then Edit_Poly is added
	  * 
	  * @param	name	sub_obj E.g.: #vertex
	  */
	function convertSelection sub_obj =
	(
		if( subobjectLevel > 0 ) then
		(
			_from = _subobjects[subobjectLevel]
			
			if( this.isEditablePoly() ) then
				EditablePoly.convertSelection _from sub_obj
				
			else if( this.isEditPoly() ) then
				EditPoly.convertSelection _from sub_obj
		)
		
		(Subobject_v()).enterForced (this._getSubobjectIndex sub_obj)
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
	/** Init EditPoly_v or EditablePoly_v
	  * @param	Editable_Poly|Edit_Poly	epoly_type
	  * @return	boolean
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
		subobjectLevel = this._getSubobjectIndex sub_obj
	),
	/** Get subobject index
	  * @param	name	sub_obj
	 */
	function _getSubobjectIndex sub_obj =
	(
		findItem _subobjects sub_obj --return
	),
	
	function test =
	(
		this._setCurrentModifier()
		--messagebox "Epoly_v.test()"

	)
	
)

