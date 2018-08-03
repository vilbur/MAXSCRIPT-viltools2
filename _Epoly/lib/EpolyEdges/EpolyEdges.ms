/** EpolyEdges
 */
struct EpolyEdges_v
(
	Epoly,

	obj,
	EpolyMod	= EpolyMod_v(),
	
	/** Select hard edges
	 */
	function selectHardEdges obj =
	(
	    max modify mode
	
		subObjectLevel = 2   
	
		macros.run "PolyTools" "SharpEdges"

		this --return
	),
	
	/** Split edges
	 */
	function splitEdges =
	(
		_EpolyMod = EpolyMod.mod()

		if( classOf _EpolyMod == Editable_Poly ) then
			_EpolyMod.splitEdges()

		else if( classOf _EpolyMod == Edit_Poly ) then
			_EpolyMod.ButtonOp #SplitEdges
	),
	/** Get edge length
	  * @return	array
	 */
	function getLength _edges  =
	(
		--for _edge in _edges collect this._getEdgeLength _edge --return
		for _edge in _edges collect print _edge --return
	),
	
	/*------------------------------------------------------------------------------
		PRIVATE 
	--------------------------------------------------------------------------------*/
	/** Get edge length
	 */
	function _getEdgeLength _edge  =
	(
		obj	= Epoly.obj()
		-- get vertexes defining the edge into an Array
		edge_verts = Epoly.Sel.getAusingB #vertex #edge #{_edge}
		
		-- get vertexes positions into an Array
		vert_position = for iVert in edge_verts collect
		polyop.getVert obj iVert
		
		-- return the distance between vertexes
		return (distance vert_position[1] vert_position[2])
	),
	
	function test =
	(
		(EpolyMod.getEpoly()).test() 
		messageBox "EpolyEdges.test()"
	)
)
