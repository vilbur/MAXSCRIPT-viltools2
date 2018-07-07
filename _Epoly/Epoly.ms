/** Command bus for
 *		- EditablePoly_v
 *		- EditPoly_v
 *
 */
struct Epoly_v
(
	EpolyMod	= EpolyMod_v(),
	EpolyOptions	= EpolyOptions_v(),
	EpolySelection	= EpolySelection_v(),
	EpolySmoothGroups	= EpolySmoothGroups_v(),
	EpolyEdges	= EpolyEdges_v(),
	EditPolyExplode	= EditPolyExplode_v(),
	EditPolyMaterial 	= EditPolyMaterial_v(),

	/*---------------------------------------
		EXTENDS
	-----------------------------------------*/
	
	/*------ EpolyOptions ------*/
	ignoreBackfacing	= EpolyOptions.ignoreBackfacing,
	constrain	= EpolyOptions.constrain,
	preserveUvs	= EpolyOptions.preserveUvs,
	selectByAngle	= EpolyOptions.selectByAngle,
	
	/*------ EpolySmoothGroups ------*/
	setSmoothGroup	= EpolySmoothGroups.setSmoothGroup,
	autoSmooth	= EpolySmoothGroups.autoSmooth,
	clearSmoothGroups	= EpolySmoothGroups.clearSmoothGroups,
	
	/*------ EpolySelection ------*/
	convertSelection	= EpolySelection.convertSelection,
	
	/*------ EpolyEdges ------*/
	selectHardEdges	= EpolyEdges.selectHardEdges,
	splitEdges	= EpolyEdges.splitEdges,
	
	/*------ EditPolyExplode ------*/
	explodeByHardEdges	= EditPolyExplode.explodeByHardEdges,
	explodeByMaterialId	= EditPolyExplode.explodeByMaterialId,
	explodeBySG	= EditPolyExplode.explodeBySG,
	explodeByElement	= EditPolyExplode.explodeByElement,
	
	/*------ EditPolyMaterial ------*/
	setMatId 	= EditPolyMaterial.setMatId,
	
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

