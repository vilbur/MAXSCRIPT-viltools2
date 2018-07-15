/** Get EditablePoly_v or EditPoly_v class
 *
 */
struct EpolyMod_v
(
	--EditablePoly	= EditablePoly_v(),
	--EditPoly	= EditPoly_v(),

	Epoly,	-- store EditablePoly_v or EditPoly_v
	
	/** Set EditablePoly_v or EditPoly_v to Epoly property
	 */
	function getEpoly =
	(
		this._setEpoly()
		--if( this.isEditablePoly() ) then
			--EditablePoly --return
--			
		--else if( this.isEditPoly() ) then
			--EditPoly --return
			--print ( "=============== getEpoly " + Epoly as string )
		Epoly --return
	),
	/** Set EditablePoly_v or EditPoly_v to Epoly property
	 */
	function _setEpoly =
	(
		--messageBox "setEpoly"
		if( this.isEditablePoly()==false ) then
			this._initSubClass Edit_Poly
			
	),
	/** Get Editable_Poly or Edit_Poly modifier from EditablePoly_v & EditPoly_v 
	 */
	function mod =
	(
		this._setEpoly()
		--Epoly = this.getEpoly()
		--print ( "Epoly = " + Epoly as string )
		if( Epoly != undefined ) then
			Epoly.mod --return
	),
	/** Test if current modifier is editable poly
	 */
	function isEditablePoly =
	(
		if( Epoly == undefined ) then
			this._initSubClass Editable_Poly --return
		--else
		this._isType Editable_Poly --return
	),
	/** Test if current modifier is edit poly
	 */
	function isEditPoly =
	(
		if( Epoly == undefined ) then
			this._initSubClass Edit_Poly --return
			
		this._isType Edit_Poly --return
	),
	/** _is type
	 */
	function _isType _type =
	(
		if( Epoly != undefined ) then
			classOf Epoly.mod == _type --return
		else
			false --return
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
			Epoly = if( epoly_type == Editable_Poly ) then
						(EditablePoly_v()).init()
					else if( epoly_type == Edit_Poly ) then
						(EditPoly_v()).init()
		)
		else
			false --return
	),
	
	function test =
	(
		messagebox "Epoly_v.test()"
	)
	
)

