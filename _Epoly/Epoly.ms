/** Epoly
 *
 */
struct Epoly_v
(
	EpolyMod	= EpolyMod_v(),
	EpolyOptions	= EpolyOptions_v(),
	EpolySelection	= EpolySelection_v(),
	EpolySmoothGroups	= EpolySmoothGroups_v(),
	
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
	
	/*------ EpolySelection ------*/
	convertSelection	= EpolySelection.convertSelection,
	
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

	--/** _all faces
	-- */
	--function _allFaces =
	--(
	--	#{1..( polyop.getNumFaces selection[1] )} --return
	--),


	
	function test =
	(
		--this._setCurrentModifier()
		messagebox "Epoly_v.test()"

	)
	
)

