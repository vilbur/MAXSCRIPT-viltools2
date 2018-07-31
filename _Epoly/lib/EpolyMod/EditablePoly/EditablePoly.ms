/** Methods for Editable_Poly baseobject
 */
struct EditablePoly_v
(
	Epoly,
	
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
	function connectEdges =
	(
		--sub_obj = subObjectLevel
		--
		--if subObjectLevel == 4 then
		--(
		--	mod.ConvertSelection #face #vertex
		--	subObjectLevel = 1
		--	mod.ConnectVertices ()
		--)
		--else if subObjectLevel == 1 then
		--	mod.ConnectVertices () 
		--
		--else if subObjectLevel == 2 then
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

	/** Extrude
	 */
	function extrude to_extrude options:true width:20 height:20 =
	(

		mod.edgeExtrudeWidth	= width
		mod.edgeExtrudeHeight	= height
		
		if options == true then
			mod.PopupDialog #Extrude
		else		
			mod.buttonOp #Extrude
	),
	/** Target weld
	 */
	function targetWeld =
	(
		this.init()
		
		--obj	= sel[1]
		--vertSel	= polyop.getVertSelection obj as Array
		--LastvertPos	= polyop.getVert obj vertSel[vertSel.count]
		--deleteitem vertSel vertSel.count
		--mod.collapse #Vertex 
		--mod.collapse #Vertex 
		--
		--( polyop.setVert obj ( polyop.getVertSelection obj) vertPos) 
	),
	/** Face count
	 */
	function faceCount =
	(		
		polyop.getNumFaces obj --return 
	),
	/** Face count
	 */
	function count sub_obj =
	(		
		case sub_obj of
		(
			(1):	polyop.getNumVerts obj
			(2):	polyop.getNumEdges obj
			(4):	polyop.getNumFaces obj
		)
	),
	/** Set mat id
	 */
	function setMatId facelist id =
	(

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
		if( facelist == undefined ) then
			facelist = this._allFaces()
			
		--(EpolySelection_v()).setSel #Face facelist
		
		
		
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
	function clearSmoothGroups facelist:undefined =
	(
		--obj = obj.baseObject
		--facelist = polyop.getNumFaces obj
	
		for i = 1 to (this._allFaces()) do
			polyop.setFaceSmoothGroup obj i 0
	),
	/** Make planar
	 */
	function makePlanar axis =
	(
		if( axis != undefined ) then
			mod.EditablePoly.MakePlanarIn axis
		else
			mod.makePlanar #Face
		
	),
	/*---------------------------------------
		SELECTION
	-----------------------------------------*/
	/** Get current subobejct selection
	  * @param	name	sub_obj
	  * @return	bitArray|[bitArray]	bitArray of selected elements or array of bitArrays for each object if Edit_Poly
	  */
	function getSel sub_obj =
	(		
		this.init()
--print ( "getSel() = " + sub_obj as string )
--print ( "mod = " + mod as string )
		mod.GetSelection sub_obj --return

	),
	/** Set editable poly selection of subobjects
	  * @param	name	sub_obj
	 */
	function setSel sub_obj facelist =
	(
		mod.SetSelection sub_obj facelist
	),
	/** Get ausing b
	 */
	function getAusingB aType bType subobjects =
	(
		this.init()
		
		case of
		(
			( aType == #Vertex	and bType == #Edge	): polyop.getVertsUsingEdge obj subobjects
			( aType == #Vertex	and bType == #Face	): polyop.getVertsUsingFace obj subobjects
			( aType == #Edge	and bType == #Vertex	): polyop.getEdgesUsingVert obj subobjects
			( aType == #Edge	and bType == #Face	): polyop.getEdgesUsingFace obj subobjects
			( aType == #Face	and bType == #Vertex	): polyop.getFacesUsingVert obj subobjects
			( aType == #Face	and bType == #Edge	): polyop.getFacesUsingEdge obj subobjects
		)
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
		print ( "----------------------------------\n\tEditablePoly_v._setMod()\n----------------------------------" )
		mod = modPanel.getCurrentObject()
	),
	function test =
	(
		messagebox "EditablePoly_v.test()"
	)
)
