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
	/** Extrude
	 */
	function extrude options:true =
	(
		--(EpolyMod.mod()) = modPanel.getCurrentObject ()
	
		case subObjectLevel of
		(	
			1:(to_extrude = #ExtrudeVertex)
			2:(to_extrude = #ExtrudeEdge)
			3:(to_extrude = #ExtrudeEdge)
			4:(to_extrude = #ExtrudeFace)
			5:(to_extrude = #ExtrudeFace	)				
		)
		
		if( to_extrude != undefined ) then
			(EpolyMod.getEpoly()).extrude to_extrude options:options
	),
	--/** Extrude
	-- */
	--function extrude =
	--(
	--	(EpolyMod.getEpoly()).extrude()
	--),
	function test =
	(
		messagebox "EditPoly.test()"
	)
)
