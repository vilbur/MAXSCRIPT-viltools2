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
		forward	= #{}, reverse	= #{}, filter	= #{},

		/** Remove filter edges
		 */
		function filterEdges =
		(
			forward -= filter
			reverse -= filter
		)

	);)()),

	/** Select loop ring
	 */
	function selectLoopRing loop_or_ring direciton select_or_deselect =
	(
		clearListener()

		if (getCommandPanelTaskMode() != #modify) then
			setCommandPanelTaskMode #modify

		modOrObj = Filters.GetModOrObj()

		subObjectLevel	= 2

		edge_selection = modOrObj.GetSelection #Edge

		if edge_selection.numberset > 0 then
		(

			--edge_selection_first_or_last	= #{ ( edge_selection as Array )[(edge_selection as Array).count] }
			
			edge_selection_first_or_last	= if (direciton==#forward) then #{ ( edge_selection as Array )[(edge_selection as Array).count] } else #{ ( edge_selection as Array )[1] }

			_edges = this.getNextRingLoop edge_selection_first_or_last modOrObj:modOrObj

			next_edges = getProperty (getProperty _edges loop_or_ring) direciton
			
			print ( "next_edges = " + next_edges as string )
			
			modOrObj.SetSelection #Edge ( edge_selection + next_edges )
		)
		else
		(
			print "nothing selected"
		)
		redrawViews()
	),

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

		print "selecting the new edges just for testing"
		--modOrObj.SetSelection #Edge (_edges.loop.forward + _edges.loop.reverse + _edges.ring.forward + _edges.ring.reverse)
		--***From here on the code is incomplete***
		--print ( "oEdge = " + oEdge as string )
		print "--------------------------------------------------------"
		
		_edges --return
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

