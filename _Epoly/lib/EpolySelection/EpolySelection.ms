/** Manage subobejct selections for Editable_Poly & Edit_Poly
  *
  *
 */
struct EpolySelection_v
(
	EpolyMod	= EpolyMod_v(),
	EpolySelection, -- store EditablePolySelection_v or EditPolySelection_v
	_objects,
	_mod,
	
	_subobjects	= #(#vertex, #edge, #border, #face, #element),

	/** Init
	 */
	function _init =
	(
		this._setObjects()
		this._setMod()
	),
	
	/** Convert current subobject to given subobject
	  * 1) If not subobject active then enter to subobject
	  * 2) If object is not Editable_Poly or Edit_Poly then Edit_Poly is added
	  * 
	  * @param	name	to_sub_obj E.g.: #vertex
	  */
	function convertSelection to_sub_obj =
	(
		this._init()

		if( subObjectLevel > 0 ) then
			_mod.convertSelection (_subobjects[ subObjectLevel ]) to_sub_obj
		
		(Subobject_v()).enterForced (this._getSubobjectIndex to_sub_obj)
	),
	/** Get selected or all faces
	 */
	function getSelectedOrAllFaces =
	(
		(this.epoly()).getSelectedOrAllFaces() --return
	),
	/** All faces
	 */
	function allFaces =
	(
		(this.epoly())._allFaces() --return
	),
	/** Get current subobejct selection
	  * @param	name	sub_obj
	  * @return	bitArray|[bitArray]	bitArray of selected elements or array of bitArrays for each object if Edit_Poly
	  */
	function getSel sub_obj =
	(		
		(this.epoly()).getSel sub_obj --return
	),
	/** Get current subobejct selection
	  * @param	name	sub_obj
	  * @param	bitArray|[bitArray]	_selection	bitArray of elements to select, for Edit_Poly can be array of bitArrays for each object
	 */
	function setSel sub_obj _selection =
	(		
		(this.epoly()).setSel sub_obj _selection --return
	),

	/**  
	 *	
	 */
	function getAusingB modOrObj bInVar aType:#currentLevel bType:#currentLevel =
	(
		print ("GetAUsingB" + " bInVar: " + bInVar as string + " aType: " + aType as string + " bType: " + bType as string)
		bBitArray = #{}
		--returnBitArray = #{}
		--class conversion
		case classOf bInVar of
		(
			Integer:	bBitArray = #{bInVar}
			BitArray:	bBitArray = bInVar
			Array:	bBitArray = bInVar as BitArray
			default:	(print "invalid inVar class"; return())
		)
		--currentLvl conversion
		if aType == #currentLevel do (aType = modOrObj.GetMeshSelLevel() )
		if bType == #currentLevel do (bType = modOrObj.GetMeshSelLevel() )
		--if both a and b are of the same type return b
		
		if aType == bType do ( return bBitArray )
		
		returnBitArray = (this.epoly()).getAusingB aType bType bBitArray

		returnBitArray --return
	),
	/** Ring loop edges
	 */
	function ringLoopEdges = ((struct _
	(
		forward	= #{}, reverse	= #{}, filter	= #{}
	);)()),
	/**  
	 *	
	 */
	function GetNextRingLoop oEdge_selection modOrObj:(Filters.GetModOrObj()) =
	(
		print ( "oEdge_selection = " + oEdge_selection as string )
		_loop_edges = this.ringLoopEdges()
		_ring_edges = this.ringLoopEdges()
		
		case classof oEdge_selection of
		(
			--BitArray:	if oEdge.numberset > 1 then oEdge = #{(oEdge as array)[1]}
			BitArray:	oEdge = #{ ( oEdge_selection as Array )[(oEdge_selection as Array ).count]  }
			Integer:	oEdge	= #{oEdge_selection}
			Array:	oEdge	= #{oEdge_selection[1]}
			default:	(print "unhandled oEdge variable"; return #{})
		)

		edgeVerts = this.getAusingB modOrObj oEdge aType:#Vertex bType:#Edge --edgeVerts should always be 2
	
		if edgeVerts.numberSet == 2 then
		(	
			reverseLoopVert = (edgeVerts as array)[1]
			forwardLoopVert = (edgeVerts as array)[2]
			print ("edgeVerts:	" + edgeVerts as string)
			
			_loop_edges.reverse = this.getAusingB modOrObj reverseLoopVert aType:#Edge bType:#Vertex
			_loop_edges.forward = this.getAusingB modOrObj forwardLoopVert aType:#Edge bType:#Vertex
			
			_ring_edges.filter = (_loop_edges.forward + _loop_edges.reverse) --union and store these for later
		) else
			return #{} --should be an impossible abortcondition unless passed something other than an Edge
		
		edgeFaces = this.getAusingB modOrObj oEdge aType:#Face bType:#Edge --edgeFaces can be either 2 or 1(for border oEdge)
	
		if (numFaces = edgeFaces.numBerset) > 0 then
		(
			_ring_edges.reverse = this.getAusingB modOrObj (edgeFaces as array)[1] aType:#Edge bType:#Face
			
			if numFaces == 2 then
				_ring_edges.forward = this.getAusingB modOrObj (edgeFaces as array)[2] aType:#Edge bType:#Face
			
			else
				print "is border Edge"
			
			_loop_edges.filter = (_ring_edges.forward + _ring_edges.reverse)  --union and store these for later
		) else
			return #{}--should also be an impossible abortcondition unless passed something other than an oEdge
		
		--do subtraction ops to get rid of most of the junk
		_loop_edges.forward -= _loop_edges.filter
		_loop_edges.reverse -= _loop_edges.filter
		_ring_edges.forward -= _ring_edges.filter
		_ring_edges.reverse -= _ring_edges.filter
		
		print "selecting the new edges just for testing"
		--modOrObj.SetSelection #Edge (_loop_edges.forward + _loop_edges.reverse + _ring_edges.forward + _ring_edges.reverse)
		--***From here on the code is incomplete***
		--print ( "oEdge = " + oEdge as string )
		print "-------------------"
		print ( "oEdge = " + oEdge as string )
		print ( "_loop_edges.forward = " + _loop_edges.forward as string )
		print ( "Edge + _loop_edges.forward = " + (oEdge + _loop_edges.forward) as string )
		print ( "_ringLoopEdges = " + _ringLoopEdges as string )
		--modOrObj.SetSelection #Edge ( _loop_edges.forward )
		--modOrObj.SetSelection #Edge ( oEdge )
		modOrObj.SetSelection #Edge ( oEdge_selection + _loop_edges.forward )
	),

	/**  
	 *	
	 */
	function select_loop switch_loop mode =
	(
		this._init()
	  
	  print "select loop"
		if( EpolyMod.isEditablePoly() ) then
		(
			obj = $
			if subobjectLevel == 2 then
				obj.setLoopShift switch_loop false mode
		)
		else if( EpolyMod.isEditPoly() ) then
		(
		
			if subobjectLevel == 2 then (
				--if mode == true then
				--(
					_mod.LoopSelect switch_loop false mode
				--
				--	--macros.run "PolyTools" "GrowLoop"
				--	
				--)
				--
				--else
				--(
				--	--macros.run "PolyTools" "ShrinkLoop"
				--	
				--)
			
	--selectedEdges = theObject.GetSelection #edge as array
	--selEdgeCount = selectedEdges.count
			)
		)
	),
	/**  
	 *	
	 */
	function select_ring switch_loop mode =
	(
		this._init()
	  
		if( EpolyMod.isEditablePoly() ) then
		(
			obj = $
			if subobjectLevel == 2 then
				obj.setRingShift switch_loop false mode
		)
		else if( EpolyMod.isEditPoly() ) then
		(
		
			if subobjectLevel == 2 then (
				_mod.RingSelect switch_loop false mode

				--if mode == true then 
				--	macros.run "PolyTools" "GrowRing"
				--
				--else
				--	macros.run "PolyTools" "ShrinkRing"
			
	--selectedEdges = theObject.GetSelection #edge as array
	--selEdgeCount = selectedEdges.count
			)
		)
	),
	/*------------------------------------------------------------------------------
		PRIVATE
	--------------------------------------------------------------------------------*/
	/** Epoly
	 */
	function epoly =
	(
		this._init()
		
		EpolyMod.getEpoly() --return 
	),
	/** Get subobject index
	  * @param	name	sub_obj
	 */
	function _getSubobjectIndex sub_obj =
	(
		findItem _subobjects sub_obj --return
	),
	
	/*---------------------------------------
		INIT METHODS
	-----------------------------------------*/
	
	/** Set object
	 */
	function _setObjects =
	(
		if( _objects == undefined ) then
			_objects = (Selection_v()).get()
	),
	/** Set current mod
	 */
	function _setMod =
	(
		--max modify mode
		if( _mod == undefined ) then
			_mod = EpolyMod.mod()
	),

	function test =
	(
		--messagebox "EpolySelection_v.test()"
		(Epoly_v()).EpolyEdges.test()

	)
)

