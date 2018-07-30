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
	
	/** GEt material ids of faces
	 */
	function getMatId facelist:undefined =
	(
		print ( "getMatId facelist = " + facelist as string )
		--print (  classOf facelist[1] == BitArray  as String )
			if( facelist != undefined and  classOf facelist[1] == BitArray ) then -- HORT FIX make working with wditable poly and one object
				facelist = facelist[1]
	
		print ( "facelist = " + facelist as string )
		
		Epoly 	=  EpolyMod.getEpoly()
		mat_ids	= #()
		count = Epoly.count 4
		
		if( classOf count == Array ) then -- HORT FIX make working with wditable poly and one object
			count = count[1]
		
		if( facelist == undefined ) then
			facelist	= #{1..count}

		for face in facelist as Array do
			--print ( "face = " + face as string )
			append mat_ids ( polyop.getFaceMatID selection[1] face )

		mat_ids --return
	),
	/** Get faces by mat id
	 */
	function getFacesByMatId mat_ids =
	(
		faces 	= #()
		all_ids	= this.getMatId()
		
		if( classOf mat_ids != Array ) then 
			mat_ids = #( mat_ids )
		
		--print ( "all_ids = " + all_ids as string )
		--face_count = Epoly.count 4
		for mat_id in mat_ids do
		(
			faces_ids = for i=1 to all_ids.count where all_ids[i] == mat_id collect i
				
			append faces (faces_ids as BitArray )
		)
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
