/** Manage subobejct selections for Editable_Poly & Edit_Poly
  *
  *
 */
struct EpolySelection_v
(
	EpolyMod	= EpolyMod_v(),
	--EpolySelection, -- store EditablePolySelection_v or EditPolySelection_v
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

	--/** Get all edges in loop for edge
	--  * @param	integer	_edge	Index of edge
	--  * @return	BitArray 	
	-- */
	--function getLoopForEdge _edge node =
	--(
	--	polyop.setEdgeSelection node #{_edge}
	--	
	--	node.SelectEdgeLoop()
	--	
	--	polyop.getEdgeSelection node
	--),

	--/** Loop ring blocker
	-- */
	--function loopRingBlocker = ((struct _
	--(
	--	forward,
	--	reverse,
	--	
	--	/** Set
	--	 */
	--	function setEdge property value =
	--	(
	--		setProperty this property value
	--
	--	)
	--	
	--);)()),
	
	/** Get new edge
	 */
	function getNewEdge edges_new direction =
	(
		if( loop_ring_blocker == undefined ) then
			global loop_ring_blocker = loopRingBlocker forward:edges_new[1] reverse:edges_new[2]

		blocked_edge	= loop_ring_blocker.getEdge direction 
		
		if( blocked_edge != undefined ) then
		(
			unblocked_index	= if( (findItem edges_new blocked_edge) == 1 ) then 2 else 1
			
			unblocked_edge	= edges_new[unblocked_index]
		)
		else
		(
			unblocked_edge	= loop_ring_blocker.getEdge direction opposite:true
			
			deleteItem edges_new (findItem edges_new unblocked_edge)
			
			blocked_edge	= edges_new[1]
		)
		
		loop_ring_blocker.setEdge direction	blocked_edge
		loop_ring_blocker.setEdge direction	undefined opposite:true
		print ( "loop_ring_blocker = " + loop_ring_blocker as string )
		print ( "unblocked_edge = " + unblocked_edge as string )
		
		unblocked_edge --return unblocked edge
	),
	
	/**  
	 *	
	 */
	function selectLoopRing loop_or_ring direction select_mode =
	(
		--print ( "direction = " + direction as string )

		print "-----------------------------------"
		modOrObj	= Filters.GetModOrObj()
		subObjectLevel	= 2
		edge_selection	= modOrObj.GetSelection #Edge

		
		if( classof modOrObj == Editable_Poly ) then
		(
			
			_direction	= if( direction == #forward  ) then 1 else -1  
			_select_or_move	= ( select_mode == #move )
			_select_mode	= ( select_mode == #select )
			
			if ( select_mode == #deselect ) then -- flip direction on #deselect, make direction of deselecting consist with EditPolyRingLoop_v.selectLoopRing()
				_direction = _direction * -1
			
			if( loop_or_ring == #loop ) then 
				modOrObj.setLoopShift _direction _select_or_move _select_mode
				
			else
				modOrObj.setRingShift _direction _select_or_move _select_mode
			
		)else
		(
			(EditPolyRingLoop_v mod:modOrObj).selectLoopRing loop_or_ring direction select_mode

		-- 	if( loop_or_ring == #loop ) then
		--	(
		--		modOrObj.LoopSelect 2 select_or_move select_mode
		--		
		--		edge_selection_new	= modOrObj.GetSelection #Edge
		--		
		--		new_edge = this.getNewEdge ((edge_selection_new - edge_selection) as Array ) direction
		--		
		--		
		--		edge_selection_one_way = append edge_selection new_edge
		--		
		--		--print ( "edge_selection_one_way = " + edge_selection_one_way as string )
		--		
		--		modOrObj.SetSelection #Edge edge_selection_one_way
		--		
		--		
		--		last_loop_ring_selection = edge_selection_one_way
		--	)
		--	else
		--	(
		--		modOrObj.RingSelect 2 select_or_move select_mode
		--		--modOrObj.RingSelect _direction select_or_move select_mode
		--	)
		)
	),

	--/** Select loop ring
	-- */
	--function selectLoopRing_old loop_or_ring direction select_or_deselect =
	--(
	--	clearListener()
	--	print ( "loop_or_ring = " + loop_or_ring as string )
	--	print ( "select_or_deselect = " + select_or_deselect as string )
	--	--final_selection = #{}
	--	
	--	if ( GetCommandPanelTaskMode() != #modify) then
	--		SetCommandPanelTaskMode #modify
	--
	--	modOrObj = Filters.GetModOrObj()
	--
	--	subObjectLevel	= 2
	--
	--	edge_selection = modOrObj.GetSelection #Edge
	--	--print ( "edge_selection = " + edge_selection as string )
	--	final_selection = edge_selection
	--
	--	
	--	if edge_selection.numberset > 0 then
	--	(
	--		--modOrObj.SetSelection #Edge (this.selectLoopRingSingleEdge modOrObj edge_selection loop_or_ring direction select_or_deselect )
	--
	--		all_loops = this.gedLoops selection[1] edge_selection
	--		--print ( "all_loops = " + all_loops as string )
	--		--
	--		for loop_edges in all_loops do
	--		(
	--			next_edges = this.selectLoopRingSingleEdge modOrObj loop_edges direction loop_or_ring
	--			print ( "next_edges = " + next_edges as string )
	--			--print ( "next_edges.forward[1] = " + next_edges.forward[1] as string )
	--			
	--			case select_or_deselect of
	--			(
	--				#select:	final_selection += (getProperty next_edges direction)
	--				--#select:	final_selection += next_edges.reverse + next_edges.forward
	--				--#deselect:	append final_selection (getProperty next_edges direction)
	--				#move:	final_selection = (getProperty next_edges direction)
	--
	--			)
	--			
	--			
	--			--modOrObj.SetSelection #Edge (getProperty next_edges direction )
	--			
	--		)
	--	
	--		
	--		modOrObj.SetSelection #Edge final_selection
	--	)
	--	else
	--		print "nothing selected"
	--
	--	redrawViews()
	--),
	--/** Select loop ring single edge
	-- */
	--function selectLoopRingSingleEdge modOrObj loop_edges direction loop_or_ring =
	--(		
	--	print ( "loop_edges = " + loop_edges as string )
	--	edge_selection_first_or_last	= if (direction==#forward) then #{ ( loop_edges as Array )[(loop_edges as Array).count] } else #{ ( loop_edges as Array )[1] }
	--	--edge_selection_first_or_last	= #{ ( loop_edges as Array )[(loop_edges as Array).count] }
	--	
	--	next_edges = this.getNextRingLoop edge_selection_first_or_last modOrObj:modOrObj
	--	
	--	print ( "next_edges = " + next_edges as string )
	--	
	--	--next_edge = getProperty (getProperty next_edges loop_or_ring) direction
	--	--next_edge = getProperty next_edges loop_or_ring
	--	--print ( "next_edge = " + next_edge as string )
	--	--print ( "next_edge = " + next_edge.forward as string +" " +next_edge.reverse as string  )
	--	
	--	--case of
	--	--(
	--	--	(select_or_deselect == #select):	final_selection	= loop_edges + next_edge.forward + next_edge.reverse
	--	--	--(select_or_deselect == #select):	final_selection	= loop_edges + next_edge.forward 
	--	--	(select_or_deselect == #deselect):	final_selection	= loop_edges - edge_selection_first_or_last
	--	--	 
	--	--	default:	final_selection = loop_edges
	--	--)
	--	--
	--	--final_selection --return
	--	getProperty next_edges loop_or_ring --return
	--),

	/**  
	 *	
	 */
	function getNextRingLoop edge_selection modOrObj:(Filters.GetModOrObj()) =
	(
		print ( "edge_selection = " + edge_selection as string )
		
		_edges = ((struct _(
			loop, ring
		);)())
		
		_edges.loop = this.ringLoopEdges()
		_edges.ring = this.ringLoopEdges()
		
		case classof edge_selection of
		(
			--BitArray:	if oEdge.numberset > 1 then oEdge = #{(oEdge as array)[1]}
			--BitArray:	oEdge = #{ ( edge_selection as Array )[(edge_selection as Array ).count]  }
			BitArray:	oEdge = #{ ( edge_selection as Array )[1] }
			Integer:	oEdge	= #{edge_selection}
			Array:	oEdge	= #{edge_selection[1]}
			default:	(print "unhandled oEdge variable"; return #{})
		)

		edge_verts = this.getAusingB modOrObj oEdge aType:#Vertex bType:#Edge --edge_verts should always be 2

		if edge_verts.numberSet == 2 then
		(	
			reverse_loop_vert = (edge_verts as array)[1]
			forward_loop_vert = (edge_verts as array)[2]
			print ("edge_verts:	" + edge_verts as string)

			_edges.loop.reverse = this.getAusingB modOrObj reverse_loop_vert aType:#Edge bType:#Vertex
			_edges.loop.forward = this.getAusingB modOrObj forward_loop_vert aType:#Edge bType:#Vertex

			_edges.ring.filter = (_edges.loop.forward + _edges.loop.reverse) --union and store these for later
		) else
			return #{} --should be an impossible abortcondition unless passed something other than an Edge

		edge_faces = this.getAusingB modOrObj oEdge aType:#Face bType:#Edge --edge_faces can be either 2 or 1(for border oEdge)

		if (num_faces = edge_faces.numBerset) > 0 then
		(
			_edges.ring.reverse = this.getAusingB modOrObj (edge_faces as array)[1] aType:#Edge bType:#Face

			if num_faces == 2 then
				_edges.ring.forward = this.getAusingB modOrObj (edge_faces as array)[2] aType:#Edge bType:#Face

			else
				print "is border Edge"

			_edges.loop.filter = (_edges.ring.forward + _edges.ring.reverse)  --union and store these for later
		) else
			return #{}--should also be an impossible abortcondition unless passed something other than an oEdge

		_edges.loop.filterEdges()
		_edges.ring.filterEdges()

		--print "selecting the new edges just for testing"
		--modOrObj.SetSelection #Edge (_edges.loop.forward + _edges.loop.reverse + _edges.ring.forward + _edges.ring.reverse)
		--***From here on the code is incomplete***
		print "--------------------------------------------------------"
		print ( "_edges = " + _edges as string )
		
		_edges --return
	),
	/** Ring loop edges
	 */
	function ringLoopEdges = ((struct _
	(
		forward	= #{}, reverse	= #{}, filter	= #{},

		/** Remove filter edges
		 */
		function filterEdges =
		(
			forward_edge	= ( (forward	- filter) as Array )[1]
			reverse_edge	= ( (reverse	- filter) as Array )[1]
			
			forward	= #{ if forward_edge > reverse_edge then forward_edge else reverse_edge }
			reverse	= #{ if forward_edge < reverse_edge then forward_edge else reverse_edge }
			

		)

	);)()),
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

