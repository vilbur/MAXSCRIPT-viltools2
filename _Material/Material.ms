/** Material
 */
struct Material_v
(
	/** Explode by material id
	 */
	function explodeByMaterialId =
	(

		all_ids = #()
		detID = #()
		selo = #()
		finalSel = #()
		
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
				appendIfunique all_ids matID
			)
			poly_selections = #();
			--		id = 1
			for id in all_ids do
				--for f=1 to polyop.getNumFaces obj where polyop.getFaceMatID obj f == id collect f  -- for every id collect faces
				append poly_selections ((for f=1 to polyop.getNumFaces obj where polyop.getFaceMatID obj f == id collect f) as bitarray)

			
			EditPoly 	= EditPoly_v obj:obj
			final_sel	= EditPoly.explode poly_selections
			
			delete obj
			
			
			select final_sel
		)
	),
	function test =
	(
		messagebox "Material.test()"
	)
)
