/** Coord mode
 */
struct CoordMode_v
(
	/** Circle
	 */
	function circle =
	(
			--	if viewport.IsPerspView() 
		cordSys = getRefCoordSys ()
		
		if viewport.IsPerspView()  then
		(
			if cordSys != #world then
				tMode =  #world
			else
				tMode =  #local
		)
		else
		(
			if cordSys == #hybrid then
				tMode =  #local
			else if cordSys == #local then
				tMode =  #screen
			else
				tMode =  #view
		)
		
		
		toolMode.coordsys tMode
		
		--wText "" "" "" (toUpper (tMode as string))
	),
	
	/*------------------------------------------------------------------------------
		PRIVATE
	--------------------------------------------------------------------------------*/
	
	function test =
	(
		messagebox "CoordMode.test()"
	)
)
