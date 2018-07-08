/** Interface for
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
	EpolyEdit 	= EpolyEdit_v(),

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
	getSel	= EpolySelection.getSel,
	setSel	= EpolySelection.setSel,
	convertSelection	= EpolySelection.convertSelection,
	allFaces	= EpolySelection.allFaces,
	getSelectedOrAllFaces	= EpolySelection.getSelectedOrAllFaces,
	
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
	setMatIdToObject 	= EditPolyMaterial.setMatIdToObject,
	
	/*------ EpolyEdit ------*/
	quickslice 	= EpolyEdit.quickslice,

	
	
	/** Get epoly info
	  !!!! MOVE THIS TO OWN FILE
	 */
	function getEpolyInfo =
	(
		backafing	= this.ignoreBackfacing	state:#get
		constrain	= this.constrain	state:#get get:#name
		preserveuv	= this.preserveUvs	state:#get
		by_angle	= this.selectByAngle	state:#get
		
		epoly_infos = #(
			#("Info_ignoreBackfacing", (if(backafing==true)then "BACKFACING" else backafing),                                        ( color 114 255 0) ),
			#("Info_constrain",        (if(constrain!=false)then ( "      "+( toUpper (constrain as string ))+"      ") else false), ( color 255 120 0) ),
			#("Info_by_angle",         (if(by_angle[1]==true)then "   ANGLE   " +by_angle[2] as string else false),                  ( color 255 235 0) ),
			#("Info_preserveuv",       (if(preserveuv==true)then "        UV        " else preserveuv),                              ( color 255 0 0) )
		)
		
		for epoly_info in epoly_infos where classOf  epoly_info[2] == String do
			epoly_info[2] = "■■■   "+epoly_info[2]+"   ■■■"
			
		print ( "epoly_infos = " + epoly_infos as string )
		epoly_infos --return
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

