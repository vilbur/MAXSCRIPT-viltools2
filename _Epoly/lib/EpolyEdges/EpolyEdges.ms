/** EpolyEdges
 */
struct EpolyEdges_v
(
	obj,
	EpolyMod	= EpolyMod_v(),
	
	/** Select hard edges
	 */
	function selectHardEdges obj =
	(
	----	--select obj
	----	--setCommandPanelTaskMode #modify
	----	max modify mode
	----
	----	subObjectLevel = 2   
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

	function test =
	(
		messagebox "EditPoly.test()"
	)
)
