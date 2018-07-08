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
		this --return
	),
	/** Get facelist or all faces
	 */
	function getSelectedOrAllFaces  =
	(
		_selection = (EpolySelection_v()).getSel #Face --return

		if( _selection.isEmpty ) then
			this._allFaces() --return
		else
			_selection --return
	),
	/** Quickslice
	 */
	function quickslice =
	(
		mod.toggleCommandMode  #QuickSlice 
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
	
	/** Set mat id
	 */
	function setMatId facelist id =
	(
		--print ( "setMatId = " + facelist as string )
		--print ( "classOf facelist = " + (classOf facelist as BitArray ) as string )
		--print ( "obj = " + obj as string )
		--print ( "id = " + id as string )
		polyop.setFaceMatID obj facelist id
		--polyop.setFaceMatID obj ( facelist as BitArray ) id
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
		polyop.setFaceSmoothGroup obj (this._getFacelist facelist) smooth_group
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
	function clearSmoothGroups facelist:undefined =
	(
		--obj = obj.baseObject
		--facelist = polyop.getNumFaces obj
	
		for i = 1 to (this._getFacelist facelist) do
			polyop.setFaceSmoothGroup obj i 0
	),
	/*---------------------------------------
		PRIVATE 
	-----------------------------------------*/
	/** _all faces
	 */
	function _allFaces =
	(
		#{ 1..( this.faceCount() ) } --return
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
