/** Edit poly selection
 */
struct EditPolyRingLoop_v
(
	mod,
	obj,
	edge_selection,
	Loops	= #(),
	
	
	/*------ Parameters ------*/
	loop_or_ring,
	direction,
	select_mode,
		
	function selectLoopRing loop_or_ring direction select_mode =
	(
		this.setParameters loop_or_ring direction select_mode
		
		mod	= modPanel.getCurrentObject()
		
		this._setEdgeSelection	()
		this._setLoops	edge_selection
		this._selectOrMoveEdges()
		this._selectEdgesInLoops()
	),

	/*------------------------------------------------------------------------------
		PRIVATE
	--------------------------------------------------------------------------------*/
	/** Set parameters
	 */
	function setParameters _loop_or_ring _direction _select_mode =
	(
		loop_or_ring	= _loop_or_ring
		direction	= _direction
		select_mode	= _select_mode
	),
	/** _get loops
	 */
	function _setLoops _getLoops =
	(
		Loops = this._getLoops edge_selection
	),
	/** Get loops for selected edges
	 *	@param	BitArray	edge_selection	Edges for loops
	 *	@return	[BitArray]	Sorted edge_selection to BitArrays by looop
	 */
	function _getLoops edge_selection =
	(
	    obj  = selection[1]
		_Loops	= #()
		loops_processed	= #{}

		for _edge in edge_selection where findItem loops_processed _edge == 0 do
		(
			EditPolyLoop 	= EditPolyLoop_v obj:obj mod:mod
			EditPolyLoop.getLoopForEdge _edge
			EditPolyLoop.filterSelectionEdges edge_selection
			
			append	_Loops EditPolyLoop

			join	loops_processed ( EditPolyLoop.loop as BitArray )
		)
		for i=1 to _Loops.count do print ( i as string +": 	" + _Loops[i] as string )
		
		_Loops --return
	),
	/** Select or move
	 */
	function _selectOrMoveEdges =
	(
		--print ( "select_mode = " + select_mode as string )
		case loop_or_ring of
		(
			(#loop):
				if( select_mode != #move ) then
					this._addOrRemoveEdgeInLoop()
				
				else
					this._moveEdgesInLoops()
			
			(#ring):
				this.selectNextRing()
		)
		
	
		
	),
	/*------------------------------------------------------------------------------
		LOOP
	--------------------------------------------------------------------------------*/
	/** Select loop ring in loops
	 */
	function _addOrRemoveEdgeInLoop =
	(
		for Loop in Loops do
			Loop.addOrRemoveEdgeInLoop direction select_mode
	),
	/** _move edges in loops
	 */
	function _moveEdgesInLoops =
	(
		direction_opposite	= if( direction == #forward )then #reverse else #forward 
		
		for Loop in Loops do
		(
			Loop.addOrRemoveEdgeInLoop direction	#select
			Loop.addOrRemoveEdgeInLoop direction_opposite 	#deselect
		)
	),
	/*------------------------------------------------------------------------------
		RING
	--------------------------------------------------------------------------------*/
	/** Select next ring
	 */
	function selectNextRing =
	(
		this._selectEdgesInLoops()
		
		mod.RingSelect 2 false true 
		
		_selection_difference	= ( mod.GetSelection #Edge ) - edge_selection -- only new ring loops
		_Loops_new	= this._getLoops _selection_difference
		--print ( "_Loops_new = " + _Loops_new as string )
		--for i=1 to _Loops_new.count do print ( i as string +" new: 	" + _Loops_new[i]._selection as string )
		
		_new_ring	= if( direction == #forward )then _Loops_new[1] else _Loops_new[2] 
				
		Loops = join Loops #(_new_ring)
	),
	/*------------------------------------------------------------------------------
		EDGES
	--------------------------------------------------------------------------------*/
	/** Set edge selection
	 */
	function _setEdgeSelection =
	(
		edge_selection = mod.GetSelection #Edge
	),
	/** Select edges in loops
	 */
	function _selectEdgesInLoops =
	(
		edge_selection = #{}
		
		for Loop in Loops do
			join edge_selection (Loop._selection as BitArray)
		
		print ( "edge_selection = " + edge_selection as string )
		mod.SetSelection	#Edge #{}
		mod.Select	#Edge edge_selection
	),

	function test =
	(
		messagebox "EditPolyRingLoop.test()"
	)
)
