/** Edit poly objects
 */
struct EditPolyObjects_v
(
	/** Do for objects
	 */
	function explode method =
	(
		clearListener()
		_selection = (Selection_v()).get()
		print ( "_selection=" + _selection[1] as string )
		--print ( "_selection=" + _selection.count as string )
		
		for i=1 to _selection.count do
		(
			EditPoly = EditPoly_v_old obj: _selection[i]

			if( method=="explodeByElement" ) then
				final_sel = EditPoly.explodeByElement()
				
			else if( method=="explodeByMaterialId" ) then
				final_sel = EditPoly.explodeByMaterialId()
				
			else if( method=="explodeBySG" ) then
				final_sel = EditPoly.explodeBySG()
				
			else if( method=="explodeByHardEdges" ) then
				final_sel = EditPoly.explodeByHardEdges()
								
			print ( "final_sel=" + final_sel as string )
			
			if( final_sel!=undefined ) then
				for o in final_sel do selectmore o 
				
		)
		
		print ( "EXPLODE=" + final_sel as string )
		
		delete _selection

	),
	/** Do for objects
	 */
	function method method param1:undefined =
	(
		clearListener()
		_selection = (Selection_v()).get()
		
		for i=1 to _selection.count do
		(
			EditPoly = EditPoly_v_old obj: _selection[i]

			if( method=="autoSmooth" ) then
				EditPoly.autoSmooth param1
				
			else if( method=="clearSmoothGroups" ) then
				EditPoly.clearSmoothGroups()
		)
	),
	
	
	function test =
	(
		messagebox "EditPolyObjects.test()"
	)
)
