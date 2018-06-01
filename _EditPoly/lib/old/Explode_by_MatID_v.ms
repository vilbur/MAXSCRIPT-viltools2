function Explode_by_MatID_v  =
(
	/*
	obj = selection[1]
	
	*/
	local allIDs = #()
	local detID = #()
	local selo = #()
	global finalSel = #()
	
	selo = for o in selection collect o
	
	for obj in selo do
	(
		---    obj = selo[2]
		print ( "Detaching: " + obj.name as string)
		
		if (classOf obj != Editable_Poly) do
		(
			convertTo obj Editable_Poly
			polyop.deleteIsoVerts obj
		)
		
		try ( maxops.CollapseNodeTo obj 1 off) catch ()
		-- get mat ids to array
		for f=1 to polyop.getNumFaces obj do
		(
			matID = polyop.getFaceMatID obj f
			appendIfunique allIDs matID
		)
		
		--		id = 1
		for id in allIDs do
		(
			detID = for f=1 to polyop.getNumFaces obj where polyop.getFaceMatID obj f == id collect f -- for every id collect faces
			detID = detID as bitarray
			polyop.detachFaces obj detID delete:true asNode:true name: "TempDet"
			detObj = getnodebyname "TempDet" 
			detObj.name = (uniquename (obj.name + "_ID" + id as string))
			detOBj.wirecolor =  color (random 0 255) (random 0 255) (random 0 255)
			append finalSel detObj
		)		
		delete obj
	)
	select finalSel
)
