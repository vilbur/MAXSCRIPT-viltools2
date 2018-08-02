/** EpolyEdit
 */
struct EpolyEdit_v
(
	Epoly,
	
	
	/** Connect
	 */
	function connect =
	(
		sub_obj = subObjectLevel

		messageBox "message" beep:false
		--case sub_obj of
		--(
		--	(1):	this.connectToLastVert()
		--	(2):	(this.EpolyMod.getEpoly()).connectEdges sub_obj
		--	(4):	this.connectPolygon()
		--
		--	--default:	
		--)
		----(this.EpolyMod.getEpoly()).connect()
	),
	

	/*------------------------------------------------------------------------------
		OLD
	--------------------------------------------------------------------------------*/
	
	
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
	function extrude height width:20 options:true =
	(
		mod = EpolyMod.mod()

		case subObjectLevel of
		(	
			1:(to_extrude = #ExtrudeVertex)
			2:(to_extrude = #ExtrudeEdge)
			3:(to_extrude = #ExtrudeEdge)
			4:(to_extrude = #ExtrudeFace)
			5:(to_extrude = #ExtrudeFace)				
		)
		
		if( to_extrude != undefined ) then
			(EpolyMod.getEpoly()).extrude to_extrude options:options width:width height:height

	),

	/** Connect to last vert
	 */
	function connectPolygon =
	(
		(Epoly_v()).convertSelection #vertex
		--this.connectToLastVert()
	),
	--/** Connect to last vert
	-- */
	--function connectToLastVert =
	--(
	--	macros.run "miauu" "miauu_ConnectToLastSelVertAlt"
	--),
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
