/** Methods for Editable_Poly baseobject
 */
struct EditablePoly_v
(
	mod,
	obj,
	
	/** Init
	  * @return	boolean 	
	 */
	function init =
	(
		if( obj == undefined ) then
		(
			this._setObj()
			this._setMod()
		)
		true --return
	),
	/** Connect subobject
	 */
	function connect =
	(
		--sub_obj = subObjectLevel
		
		if subObjectLevel == 4 then
		(
			mod.ConvertSelection #face #vertex
			subObjectLevel = 1
			mod.ConnectVertices ()
		)
		else if subObjectLevel == 1 then
			mod.ConnectVertices () 

		else if subObjectLevel == 2 then
			mod.ConnectEdges ()	
	),
	/** Remove edge with vertices
	  */
	function remove =
	(
		--sub_obj = subObjectLevel
		if subObjectLevel == 4 then
		(
			mod.ConvertSelection #Face #Vertex
			subObjectLevel = 1	
		)
		
		if subObjectLevel != 2 then
			mod.Remove selLevel:#CurrentLevel
			
		else
		(
			edges = polyop.getEdgeSelection obj
			
			if edges.numberset!=0 do
			(
				vertices = #()
				
				for edge in edges do ( join vertices (( polyop.getVertsUsingEdge obj edge ) as Array ) )
				
				theVertsToRemove = vertices as BitArray
				
				for v in theVertsToRemove do ( deleteItem vertices (findItem vertices v) )
				
				mod.Remove selLevel:#Edge
				polyop.setVertSelection obj ( vertices as BitArray )
				mod.Remove selLevel:#Vertex
				
			)
		)
	),

	/** Face count
	 */
	function faceCount =
	(		
		polyop.getNumFaces obj --return 
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
		if( facelist==undefined ) then
			facelist = this._allFaces()
			
		polyop.setFaceSmoothGroup obj facelist smooth_group
	),
	/** Auto smooth
	  * @param	integer	_angle
	 */
	function autoSmooth _angle =
	(
		mod.autoSmoothThreshold = _angle
		mod.autosmooth()
	),
	/** Clear smooth groups
	 */
	function clearSmoothGroups =
	(
		--obj = obj.baseObject
		facelist = polyop.getNumFaces obj
	
		for i = 1 to facelist do
			polyop.setFaceSmoothGroup obj i 0
	),
	/*---------------------------------------
		PRIVATE 
	-----------------------------------------*/
	/** _all faces
	 */
	function _allFaces =
	(
		#{1..( this.faceCount() )} --return
	),
	
	/** _set obj
	 */
	function _setObj =
	(
		obj = selection[1]
	),
	/** Set current modifier
	 */
	function _setMod =
	(
		mod = modPanel.getCurrentObject()
	),
	function test =
	(
		messagebox "EditablePoly_v.test()"
	)
)
