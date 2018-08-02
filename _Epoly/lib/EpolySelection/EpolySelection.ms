/** Manage subobejct selections for Editable_Poly & Edit_Poly
  *
  *
 */
struct EpolySelection_v
(
	Epoly,

	_EPselection,	-- NOTE !!! temp name of property, SHOULD BE COSEN BETTER THEN "_EPselection"
	EditablePolySelection	= EditablePolySelection_v	Epoly:Epoly,
	EditPolySelection	= EditPolySelection_v	Epoly:Epoly,

	_subobjects	= #(#vertex, #edge, #border, #face, #element),

	/** Get subobject selection
	  * @param	name	sub_obj
	  * @return	bitArray|[bitArray]	bitArray of selected elements or array of bitArrays for each object if Edit_Poly
	  */
	function getSel sub_obj =
	(		
		this._setEPselection()

		if( _EPselection != undefined ) then 
			_EPselection.getSelection sub_obj
	),
	/** Set selection of subobjects 
	  * @param	name	sub_obj
	  * @param	BitArrray	facelist_array
	 */
	function setSel sub_obj facelist_array =
	(
		this._setEPselection()

		if( _EPselection != undefined ) then 
			_EPselection.setSelection sub_obj facelist_array
	),	
	/** _get selection
	 */
	function _setEPselection =
	(
		prop_name = (Epoly.Mod.class camel_case:true) + "Selection"
		print ( "prop_name = " + prop_name as string )
		
		if not( hasProperty this prop_name ) then
			return undefined

		_EPselection = getProperty this prop_name
		
		_EPselection.setMod (Epoly.Mod.get())
	),
	
	/**  
	 *	
	 */
	function getAusingB subo_A subo_B _subobjects =
	(
		print ("EpolySelection_v.getAUsingB" + " subobjects: " + subobjects as string + " subo_A: " + subo_A as string + " subo_B: " + subo_B as string)
		--bBitArray = #{}
		--elements_B = #{}
		--class conversion
		case classOf _subobjects of
		(
			Integer:	subobjects = #{_subobjects}
			BitArray:	subobjects = _subobjects
			Array:	subobjects = _subobjects as BitArray
			default:	(print "invalid inVar class"; return())
		)
		--currentLvl conversion
		--if subo_A == #currentLevel do (subo_A = _mod.GetMeshSelLevel() )
		--if subo_B == #currentLevel do (subo_B = _mod.GetMeshSelLevel() )
		--if both a and b are of the same type return b

		if subo_A == subo_B do ( return subobjects )

		this._setEPselection()

		if( _EPselection != undefined ) then 
			elements_B = _EPselection.getAusingB subo_A subo_B subobjects
		
		elements_B --return
	),
	
	/** Get shared elemetns using another element
	  *
	  * @example getSharedAwithB #face #vertex #{1..7} -- get shared #faces for #vertices 1-7
	  *
	  * @return	BitArray	
	  */
	function getSharedAwithB subo_A subo_B _subobjects =
	(
		subobjects_B_all	= this.getAusingB subo_A subo_B _subobjects
		
		subobjects_B	= for item in _subobjects collect this.getAusingB subo_A subo_B #{item}
		
		for _subobjects_B in subobjects_B do
			subobjects_B_all = subobjects_B_all * _subobjects_B
		
		subobjects_B_all --return
	),
	
	/** Convert current subobject to given subobject
	  * 1) If not subobject active then enter to subobject
	  * 2) If object is not Editable_Poly or Edit_Poly then Edit_Poly is added
	  * 
	  * Convert FACE selection to BORDER will select outline edges of faces selection
	  * 
	  * @param	name	to_sub_obj E.g.: #vertex
	  */
	function convertSelection to_sub_obj =
	(
		--_mod	= Epoly.Mod.get()
		
		sub_obj	= subObjectLevel
		
		if( sub_obj == 0 ) then
			return false
			
		if( sub_obj == 4 and to_sub_obj == #border ) then
		(
			this.selectOutlineEdgesOfFaces()
			to_sub_obj = #edge
		)
		else
			(Epoly.Mod.get()).convertSelection (_subobjects[sub_obj]) to_sub_obj
		
		(Subobject_v()).enterForced (this._getSubobjectIndex to_sub_obj)
	),
	/** Get outline edges of faces
	 */
	function selectOutlineEdgesOfFaces =
	(
		faces	= this.getSel #face
		print ( "faces = " + faces as string )
		edges_of_faces	= this.getAusingB #Edge #Face faces
		edges_of_faces_inverted	= this.getAusingB #Edge #Face (-faces)
		
		this.setSel #edge (edges_of_faces*edges_of_faces_inverted) --return
	),
	
	/*------------------------------------------------------------------------------
		PRIVATE
	--------------------------------------------------------------------------------*/
	/** Get subobject index
	  * @param	name	sub_obj
	 */
	function _getSubobjectIndex sub_obj =
	(
		findItem _subobjects sub_obj --return
	),
	
	/** _objects
	 */
	function _objects =
	(
		Epoly._objects --return
	),
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/*------------------------------------------------------------------------------
		OLD
	--------------------------------------------------------------------------------*/
	
	EpolyMod	= EpolyMod_v(),
	--EpolySelection, -- store EditablePolySelection_v or EditPolySelection_v
	--_objects,
	_mod,


	/** Init
	 */
	function _init =
	(
		this._setObjects()
		this._setMod()
	),


	
	
	/** Get selected or all faces
	 */
	function getSelectedOrAllFaces =
	(
		(this.getEpoly()).getSelectedOrAllFaces() --return
	),
	/** All faces
	 */
	function allFaces =
	(
		(this.getEpoly())._allFaces() --return
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

		edge_verts = this.getAusingB oEdge #Vertex #Edge  --edge_verts should always be 2

		if edge_verts.numberSet == 2 then
		(	
			reverse_loop_vert = (edge_verts as array)[1]
			forward_loop_vert = (edge_verts as array)[2]
			print ("edge_verts:	" + edge_verts as string)

			_edges.loop.reverse = this.getAusingB reverse_loop_vert #Edge #Vertex 
			_edges.loop.forward = this.getAusingB forward_loop_vert #Edge #Vertex 

			_edges.ring.filter = (_edges.loop.forward + _edges.loop.reverse) --union and store these for later
		) else
			return #{} --should be an impossible abortcondition unless passed something other than an Edge

		edge_faces = this.getAusingB oEdge #Face #Edge  --edge_faces can be either 2 or 1(for border oEdge)

		if (num_faces = edge_faces.numBerset) > 0 then
		(
			_edges.ring.reverse = this.getAusingB (edge_faces as array)[1] #Edge #Face

			if num_faces == 2 then
				_edges.ring.forward = this.getAusingB (edge_faces as array)[2] #Edge #Face

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
	function getEpoly =
	(
		this._init()

		EpolyMod.getEpoly() --return 
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

