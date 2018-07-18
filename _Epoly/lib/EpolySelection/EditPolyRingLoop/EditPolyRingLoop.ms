/** Edit poly selection
 */
struct EditPolyRingLoop_v
(
	mod,
	obj,
	Loops	= #(),
	
	function selectLoopRing loop_or_ring direction select_mode =
	(
		print ( "direction = " + direction as string )

		mod	= modPanel.getCurrentObject()
		
		this.setLoops ( mod.GetSelection #Edge )
		this.selectLoopRingInLoops direction select_mode
		this.selectEdgesInLoops()
		
		--messageBox "message"
	),
	/** Select loop ring in loops
	 */
	function selectLoopRingInLoops direction select_mode =
	(
		for Loop in Loops do
			Loop.selectLoopRing direction select_mode
		
		print "---------"
		--for i=1 to Loops.count do print ( i as string +": 	" + Loops[i]._selection as string )
		for i=1 to Loops.count do print ( i as string +": 	" + Loops[i] as string )
	),

	/** Sort given edges to bitArrays per loop 
	 *	@param	BitArray	edges	Edges for sorting
	 *	@return	[BitArray]	Sorted edges to BitArrays by looop
	 */
	function setLoops edges =
	(
		obj	= selection[1]
		edges_processed	= #{}
		
		for _edge in edges where findItem edges_processed _edge == 0 do
		(
			EditPolyLoop 	= EditPolyLoop_v mod:mod
			EditPolyLoop.getLoopForEdge _edge
			EditPolyLoop.filterSelectionEdges edges
			
			append	Loops EditPolyLoop

			join	edges_processed ( EditPolyLoop.loop as BitArray )
		)
		for i=1 to Loops.count do print ( i as string +": 	" + Loops[i] as string )
	),
	
	/*------------------------------------------------------------------------------
		PRIVATE
	--------------------------------------------------------------------------------*/
	/** Select edges in loops
	 */
	function selectEdgesInLoops =
	(
		edge_selection = #{}
		
		for Loop in Loops do
			--print ( (Loop._selection as BitArray ) as string )
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
