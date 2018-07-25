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
		
		this._setEdgeSelection()
		this._setLoops()
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
	function _setLoops =
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
			--print ( "edge_selection = " + edge_selection as string )
			if( EditPolyLoop.loop != undefined ) then
			(
				append	_Loops EditPolyLoop
				
				join	loops_processed ( EditPolyLoop.loop as BitArray )
			)
			
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
				if( select_mode == #select ) then
					this._selectNextRing()
				
				else if( select_mode == #deselect ) then
					this._deselectRing()
					
				else
					this._moveRing()
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
	function _selectNextRing =
	(
		this._selectEdgesInLoops()
		
		mod.RingSelect 2 false true 
		
		_selection_difference	= ( mod.GetSelection #Edge ) - edge_selection -- only new ring loops
		_Loops_new	= this._getLoops _selection_difference
		--print ( "_Loops_new = " + _Loops_new as string )
		_Loop_new	= if( direction == #forward ) then _Loops_new[1] else _Loops_new[2] 
		
		this._addOrRemoveLoop	_Loop_new

	),
	/** Deselect ring
	 */
	function _deselectRing =
	(
		remove_index	= if( direction == #forward )then 1 else Loops.count 

		Loops = deleteItem Loops remove_index
	),
	/** _move ring
	 */
	function _moveRing =
	(
		this._selectNextRing()
		
		direction = if( direction == #forward )then #reverse else #forward 

		this._deselectRing()
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
	/*------------------------------------------------------------------------------
		EditPolyLoop_v
	--------------------------------------------------------------------------------*/
	/** Append or prepend new Loop in Loops
	 */
	function _addOrRemoveLoop Loop =
	(
		if( direction == #forward ) then
			Loops = join #(Loop) Loops
		else
			Loops = join Loops #(Loop)
	),
	
	function test =
	(
		messagebox "EditPolyRingLoop.test()"
	)
)
