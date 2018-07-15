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
		mod = EpolyMod.mod()
	
		case subObjectLevel of
		(	
			1:(to_extrude = #ExtrudeVertex)
			2:(to_extrude = #ExtrudeEdge)
			3:(to_extrude = #ExtrudeEdge)
			4:(to_extrude = #ExtrudeFace)
			5:(to_extrude = #ExtrudeFace	)				
		)
		
		height = if( to_extrude == #ExtrudeEdge ) then -20 else 20
		
		if( to_extrude != undefined ) then
			(EpolyMod.getEpoly()).extrude to_extrude options:options height:height
		
		--if options == true then
		--(
		--	mod.PopupDialog to_extrude
		--	mod.extrudeEdgeWidth	= 20
		--	mod.extrudeEdgeHeight	= height
		--)
		--else
		--	mod.EnterCommandMode to_extrude
			
	),
	/** Target weld
	 */
	function targetWeld =
	(
		(EpolyMod.getEpoly()).targetWeld()
	),
	/** Make planar
	 */
	function makePlanar axis =
	(
		(EpolyMod.getEpoly()).makePlanar axis
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
