/** EditPolyLoop represent edge loop in Edit_Poly
 */
struct EditPolyLoop_v
(
	obj,
	mod,
	loop,
	_selection	= #(), -- selected edges in loop

	/** Get all edges in loop for edge
	  * @param	integer	_edge	Index of edge
	  * @return	BitArray 	
	 */
	function getLoopForEdge _edge =
	(
		mod.SetSelection	#Edge #{}
		mod.Select	#Edge #{_edge}
		mod.ButtonOp	#SelectEdgeLoop

		loop = this._getEdgesInLoop()
	),

	/** Append to selection
	 */
	function filterSelectionEdges selection_edges =
	(
		for edge_in_loop in loop where this._isEdgeInSelection selection_edges edge_in_loop do
			append _selection edge_in_loop
	),
	/** Select loop ring
	 */
	function addOrRemoveEdgeInLoop direction select_mode =
	(
		first_or_last_edge = this._getFirstOrLastEdge direction

		case select_mode of
		(
			(#select):	this._addNextOrPrevEdgeToSelection 	first_or_last_edge direction
			(#deselect):	this._removeEdgeFromSelection	first_or_last_edge
		)

	),
	/*------------------------------------------------------------------------------
		PRIVATE
	--------------------------------------------------------------------------------*/

	/** Is edge in selection
	 */
	function _isEdgeInSelection selection_edges _edge =
	(
		(findItem selection_edges _edge) != 0 --return
	),

	/** Get edge loop
	 */
	function _getEdgesInLoop =
	(
		--obj	= selection[1]
		edges_selected	= mod.GetSelection #Edge

		edge_verts	= polyop.GetVertsUsingEdge obj edges_selected
		one_edge_verts	= for v in edge_verts where ( (edges_selected * (polyop.getEdgesUsingVert obj v)).numberset	== 1) collect v
		vL1	= #{one_edge_verts[1]}
		this_edge_loop	= #()
		e0	= #{}

		for vv in edge_verts do
		(
			e1 = (edges_selected * ( polyop.getEdgesUsingVert obj vL1)) - e0
			if not e1.isEmpty then
			(
				for i in e1 do appendIfUnique this_edge_loop i
				vL1 = (polyop.getVertsUsingEdge obj e1) - vL1
				e0 = e1
			)	
		)	
		this_edge_loop --return
	),

	/** Get first or last edge of selection in loop
	  * @param	#forward|#reverse	direction If #forward then return last edge, if #reverse then return first edge in selection 
	  * @return	integer	
	 */
	function _getFirstOrLastEdge direction =
	(
		if( direction == #forward ) then
			_selection[_selection.count] --return

		else
			_selection[1] --return
	),

	/** Set next or previous edge in loop selection for edge
	  * @param	integer	_edge
	 */
	function _addNextOrPrevEdgeToSelection _edge direction =
	(
		index_in_loop	= findItem loop _edge
		next_prev_index	= if( direction == #forward )then index_in_loop+1 else index_in_loop-1

		if(  loop[next_prev_index] != undefined ) then
		(
			if( direction == #forward ) then
				append _selection loop[next_prev_index] --return

			else
				_selection = join #(loop[next_prev_index]) _selection
		)

	),
	/** Remove first or last edge from selection
	  * @param	integer	_edge
	 */
	function _removeEdgeFromSelection _edge =
	(
		deleteItem _selection (findItem _selection _edge)
	),

	function test =
	(
		messagebox "EditPolyRingLoop.test()"
	)
)
