/** Epoly
 *
 */
struct Epoly_v
(
	EditablePoly	= EditablePoly_v(),
	EditPoly	= EditPoly_v(),
	
	EpolyOptions	= EpolyOptions_v(),
	
	Epoly,
	
	_subobjects	= #(#vertex, #edge, #border, #face, #element),
	
	
	/*---------------------------------------
		EXTENDS
	-----------------------------------------*/
	
	/*------ EpolyOptions ------*/
	ignoreBackfacing	= EpolyOptions.ignoreBackfacing,
	constrain	= EpolyOptions.constrain,
	preserveUvs	= EpolyOptions.preserveUvs,
	selectByAngle	= EpolyOptions.selectByAngle,
	EpolyOptionsTest	= EpolyOptions.test,
	
	
	/** Convert current subobject to given subobject
	  * 1) If not subobject active then enter to subobject
	  * 2) If object is not Editable_Poly or Edit_Poly then Edit_Poly is added
	  * 
	  * @param	name	to_sub_obj E.g.: #vertex
	  */
	function convertSelection to_sub_obj =
	(
		if( subobjectLevel > 0 ) then
			(this._mod()).convertSelection (_subobjects[subobjectLevel]) to_sub_obj
		
		(Subobject_v()).enterForced (this._getSubobjectIndex to_sub_obj)
	),
	
	/** Bevel
	 */
	function bevel =
	(
		messagebox "Epoly_v.bevel()" 	
	),
	/** Extrude
	 */
	function extrude =
	(
		messagebox "Epoly_v.extrude()" 	
	),
	/** Connect subobject
	 */
	function connect =
	(
		(this._setEpoly()).connect()
	),
	
	/** Remove subobject
	 */
	function remove =
	(
		(this._setEpoly()).remove()
	),

	/** Face count
	 */
	function faceCount =
	(		
		(this._setEpoly()).faceCount()
	),
	
	/*---------------------------------------
		SMOOTH GROUPS
	-----------------------------------------*/
	/** Set smooth group
	  * @param	integer	smooth_group	
	  * @param	bitArray	facelists 	All faces used if facelist==undefined
	 */
	function setSmoothGroup smooth_group facelist:undefined =
	(
		(this._setEpoly()).setSmoothGroup smooth_group facelist:facelist
	),
	
	/** Auto smooth
	  * @param	integer	_angle
	 */
	function autoSmooth _angle =
	(
		(this._setEpoly()).autoSmooth _angle
	),
	/** Clear smooth groups
	 */
	function clearSmoothGroups =
	(
		(this._setEpoly()).clearSmoothGroups()
	),
	/*---------------------------------------
		PRIVATE
	-----------------------------------------*/

	/** _all faces
	 */
	function _allFaces =
	(
		#{1..( polyop.getNumFaces selection[1] )} --return
	),
	
	/** Set EditablePoly or EditPoly to Epoly property
	 */
	function _setEpoly =
	(
		if( this.isEditablePoly() ) then
			Epoly = EditablePoly
			
		else if( this.isEditPoly() ) then
			Epoly = EditPoly
		
	),
	/** _mod
	 */
	function _mod =
	(
		Epoly = this._setEpoly()
		
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
	/** Get subobject index
	  * @param	name	sub_obj
	 */
	function _getSubobjectIndex sub_obj =
	(
		findItem _subobjects sub_obj --return
	),
	
	function test =
	(
		--this._setCurrentModifier()
		messagebox "Epoly_v.test()"

	)
	
)

