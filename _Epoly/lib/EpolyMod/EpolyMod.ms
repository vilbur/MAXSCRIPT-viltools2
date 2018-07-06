/** Get EditablePoly_v or EditPoly_v class
 *
 */
struct EpolyMod_v
(
	EditablePoly	= EditablePoly_v(),
	EditPoly	= EditPoly_v(),

	Epoly,	-- store EditablePoly_v or EditPoly_v
	
	/** Set EditablePoly_v or EditPoly_v to Epoly property
	 */
	function getEpoly =
	(
		if( this.isEditablePoly() ) then
			EditablePoly --return
			
		else if( this.isEditPoly() ) then
			EditPoly --return
	),
	/** Get Editable_Poly or Edit_Poly modifier from EditablePoly_v & EditPoly_v 
	 */
	function mod =
	(
		Epoly = this.getEpoly()
		
		if( Epoly != undefined ) then
			Epoly.mod --return
	),
	/** Test if current modifier is editable poly
	 */
	function isEditablePoly =
	(
		this._initSubClass Editable_Poly --return
	),
	/** Test if current modifier is edit poly
	 */
	function isEditPoly =
	(
		this._initSubClass Edit_Poly --return
	),
	/** Init EditPoly_v or EditablePoly_v
	 * @param	Editable_Poly|Edit_Poly	epoly_type
	 * @return	boolean
	 */
	function _initSubClass epoly_type =
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
	
	function test =
	(
		messagebox "Epoly_v.test()"
	)
	
)

