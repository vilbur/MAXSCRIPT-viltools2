/** EpolyEdit
 */
struct EpolyEdit_v
(
	obj,
	EpolyMod	= EpolyMod_v(),
	
	
	/** Split edges
	 */
	function quickslice =
	(
		(EpolyMod.getEpoly()).quickslice()
	),

	function test =
	(
		messagebox "EditPoly.test()"
	)
)
