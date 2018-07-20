/** Edit poly objects
 */
struct EditPolyMaterial_v
(
	EpolyMod	= EpolyMod_v(),

	/** Set mat id
	 */
	function setMatId id =
	(
		Epoly = EpolyMod.getEpoly()

		Epoly.setMatId (Epoly.getSelectedOrAllFaces()) id 
	),
	/** Set mat id
	 */
	function setMatIdToObject id =
	(
		Epoly = EpolyMod.getEpoly()

		Epoly.setMatId (Epoly._allFaces()) id 
	),
	
	/** Select material
	 */
	function getMatId facelist:undefined =
	(
		Epoly 	=  EpolyMod.getEpoly()
		mat_ids	= #()
		
		if( facelist == undefined ) then
			facelist	= #{1..Epoly.count 4}

		print ( "facelist = " + facelist as string )
		--print ( "_all_faces = " + _all_faces as string )
		--print ( "_selected_faces = " + _selected_faces as string )

		for face in facelist as Array do
			append mat_ids ( polyop.getFaceMatID selection[1] face )
			--print ( "_selected_face = " + _selected_face as string )
		mat_ids --return
	),
	/** Get faces by mat id
	 */
	function getFacesByMatId mat_ids =
	(
		faces 	= #()
		all_ids	= this.getMatId()
		print ( "all_ids = " + all_ids as string )
		--face_count = Epoly.count 4
		for mat_id in mat_ids do
		(
			faces_ids = for i=1 to all_ids.count where all_ids[i] == mat_id collect i
				
			append faces (faces_ids as BitArray )
		)
		
		--print ( "faces = " + faces as string )
		faces --return
	),
	
	
	--/** Unselect material
	-- */
	--function unselectMaterial id =
	--(
	--	
	--),
	
	function test =
	(
		messagebox "EditPolyObjects.test()"
	)
)
