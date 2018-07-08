/** Coord mode
 */
struct CoordMode_v
(
	/** Circle given coord modes
	  * @param	array	modes	 #( #world, #local, #screen, #hybrid )
	 */
	function circle modes =
	(
		print ( "CoordMode_v = " + modes as string )
		current_coord = GetRefCoordSys()
		
		next_index	= (findItem modes current_coord) + 1
		
		next_mode = if( next_index<=modes.count ) then modes[next_index] else modes[1] 
		--if viewport.IsPerspView()  then
		--(
		--	if current_coord != #world then
		--		tMode =  #world
		--	else
		--		tMode =  #local
		--)
		--else
		--(
		--	if current_coord == #hybrid then
		--		tMode =  #local
		--	else if current_coord == #local then
		--		tMode =  #screen
		--	else
		--		tMode =  #view
		--)
		
		toolMode.coordsys next_mode
		
	),
	
	/*------------------------------------------------------------------------------
		PRIVATE
	--------------------------------------------------------------------------------*/
	
	function test =
	(
		messagebox "CoordMode.test()"
	)
)
