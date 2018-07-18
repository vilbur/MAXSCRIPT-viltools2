/** Edit poly selection
 */
struct EditPolyRingLoop_v
(
	mod,
	obj,
	Loops	= #(),
	
	/*------ Parameters ------*/
	loop_or_ring,
	direction,
	select_mode,
		
	function selectLoopRing loop_or_ring direction select_mode =
	(
		this.setParameters loop_or_ring direction select_mode
		
		mod	= modPanel.getCurrentObject()
		
		this._setLoops	( mod.GetSelection #Edge )
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
	/** Sort given edges to bitArrays per loop 
	 *	@param	BitArray	edges	Edges for sorting
	 *	@return	[BitArray]	Sorted edges to BitArrays by looop
	 */
	function _setLoops edges =
	(
		obj	= selection[1]
		edges_processed	= #{}
		
		for _edge in edges where findItem edges_processed _edge == 0 do
		(
			EditPolyLoop 	= EditPolyLoop_v obj:obj mod:mod
			EditPolyLoop.getLoopForEdge _edge
			EditPolyLoop.filterSelectionEdges edges
			
			append	Loops EditPolyLoop

			join	edges_processed ( EditPolyLoop.loop as BitArray )
		)
		for i=1 to Loops.count do print ( i as string +": 	" + Loops[i] as string )
	),
	/** Select or move
	 */
	function _selectOrMoveEdges =
	(
		if( select_mode != #move ) then
			this._selectLoopRingInLoops()
		
		else
			this._moveEdgesInLoops()
	),
	/** Select loop ring in loops
	 */
	function _selectLoopRingInLoops =
	(
		for Loop in Loops do
			Loop.selectLoop direction select_mode
	),
	/** _move edges in loops
	 */
	function _moveEdgesInLoops =
	(
		direction_opposite	= if( direction == #forward )then #reverse else #forward 
		
		for Loop in Loops do
		(
			Loop.selectLoop direction	#select
			Loop.selectLoop direction_opposite 	#deselect
		)
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
