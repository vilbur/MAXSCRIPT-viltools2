/** Edit poly objects
 */
struct EditPolyObjects_v
(
	/** Do for objects
	 */
	function doForObjects method =
	(
		clearListener()
		_selection = (Selection_v()).get()
		print ( "_selection=" + _selection.count as string )
		
		for i=1 to _selection.count do
		(
			print ( "doForObjects=" + i as string )
			
			EditPoly = EditPoly_v obj: _selection[i]

			if( method=="explodeByElement" ) then
				final_sel = EditPoly.explodeByElement()
				
			else if( method=="explodeByMaterialId" ) then
				final_sel = EditPoly.explodeByMaterialId()
				
			else if( method=="explodeBySG" ) then
				final_sel = EditPoly.explodeBySG()
				
			print ( "final_sel=" + final_sel as string )
			
			if( final_sel!=undefined ) then
				for o in final_sel do selectmore o 
				
		)
		
		delete _selection
		
		--sleep 1
		--if( final_sel!=undefined ) then
			--for o in final_sel do selectmore o 

			--select final_sel[1] --return
	),
	
	
	function test =
	(
		messagebox "EditPolyObjects.test()"
	)
)
