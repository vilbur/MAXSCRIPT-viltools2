/** Edit poly
 */
struct EditPolyExplode_v
(
	obj,
	final_sel = #(),

	/** Explode
	  * @param	[bitArray]	poly_selections	Array of bitarrays to detach
	  * @return	selection	
	  *
	 */
	function explode poly_selections =
	(
		print ( "explode() poly_selections=" + poly_selections as string )
		final_sel = #()

		for poly_selection in poly_selections do
			this.detach poly_selection
			
		--print ( "final_sel=" + final_sel as string )
		final_sel --return
		--append final_sel detObj
	),
	/** Explode all elements
	 */
	function explodeByElement =
	(	
		this.explode ( this.getElements() ) --return
	),
	/**  Explode all smoothgroups
	 */
	function explodeBySG =
	(
		print ( "----explodeBySG" )
		this.explode ( _getSmoothGroups() ) --return
	),
	
	/** Explode by material id
	 */
	function explodeByMaterialId =
	(
		this.explode ( this._getMaterialElements() ) --return
	),
	/**  
	 */
	function explodeByHardEdges =
	(
		--print "explodeByHardEdges()"
		this.selectHardEdges()

		this.splitEdges()

		this.explodeByElement() --return

		--#(obj)
		--undefined --return
	),
	/** Get elements
	 */
	function getElements =
	(
		faces	= #{}
		obj_faces	= this._allFaces()
		CurObj	= polyop

		getElement = CurObj.getElementsUsingFace

		elements = for i in obj_faces where obj_faces[i] == true collect
		(
			element = getElement obj i
			obj_faces -= element
			element
		)

		elements --return		
	),

	/** Get material elements
	  * @return	[bitArray]	Array of faces by material
	 */
	function _getMaterialElements =
	(
		all_ids	= #()
		material_faces	= #();

		--print "_getMaterialElements"
		for f=1 to polyop.getNumFaces obj do
			appendIfUnique all_ids ( polyop.getFaceMatID obj f)
		
				id = 1
		for id in all_ids do
			append material_faces ((for f=1 to polyop.getNumFaces obj where polyop.getFaceMatID obj f == id collect f) as bitarray)

		material_faces --return
	),
	/** Get smooth groups
	 */
	function _getSmoothGroups =
	(
		smooth_groups = #()
		maxops.CollapseNode obj off
		--smGroupsArray = polyop.getFaceSmoothGroup obj firstFace;
		face_num = polyop.getNumFaces obj
		
		for sg_id = 1 to 32 do
		(
			smooth_group_face = #()

			for f=1 to face_num do
			--(
				if (( polyop.getFaceSmoothGroup obj f) == sg_id) then
					append smooth_group_face f
			--)
			--smooth_group_face = smooth_group_face as bitArray
			
			print ( "smooth_group_face=" + smooth_group_face as string )
			if  (  smooth_group_face.count > 0 and ( (smooth_group_face as array)[1] == 1 and smooth_group_face.count == face_num)==false ) then
				append smooth_groups smooth_group_face
		)
		smooth_groups --return
	),


	/** _all faces
	 */
	function _allFaces =
	(
		#{1..( polyop.getNumFaces obj)} --return
	),

	function test =
	(
		messagebox "EditPoly.test()"
	)
)
