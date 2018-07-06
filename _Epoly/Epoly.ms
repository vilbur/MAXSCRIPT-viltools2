/** Epoly
 *
 */
struct Epoly_v
(
	--EditablePoly	= EditablePoly_v(),
	--EditPoly	= EditPoly_v(),
	
	EpolyMod	= EpolyMod_v(),
	EpolyOptions	= EpolyOptions_v(),
	EpolySmoothGroups	= EpolySmoothGroups_v(),
	
	--Epoly,
	
	_subobjects	= #(#vertex, #edge, #border, #face, #element),
	
	
	/*---------------------------------------
		EXTENDS
	-----------------------------------------*/
	
	/*------ EpolyOptions ------*/
	ignoreBackfacing	= EpolyOptions.ignoreBackfacing,
	constrain	= EpolyOptions.constrain,
	preserveUvs	= EpolyOptions.preserveUvs,
	selectByAngle	= EpolyOptions.selectByAngle,
	--EpolyOptionsTest	= EpolyOptions.test,
	
	/*------ EpolySmoothGroups ------*/
	setSmoothGroup	= EpolySmoothGroups.setSmoothGroup,
	autoSmooth	= EpolySmoothGroups.autoSmooth,
	clearSmoothGroups	= EpolySmoothGroups.clearSmoothGroups,
	
	
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
		PRIVATE
	-----------------------------------------*/

	/** _all faces
	 */
	function _allFaces =
	(
		#{1..( polyop.getNumFaces selection[1] )} --return
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

