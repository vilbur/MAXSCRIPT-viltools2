/** Manage text in viewport
 */
struct ViewportText_v
(
	id,
	--text,
	color	= yellow,
	position	= [40, 40, 0],
	
	/** Show
	 */
	function show text =
	(
		cmd  = "global "+id
		cmd += "\n unregisterRedrawViewsCallback "+id
		cmd += "\n fn "+id+" ="
		cmd += "\n ("
		cmd += "\n 		gw.htext "+this._getPosition()+" \""+text+"\" color:"+color as string
		cmd += "\n 		gw.updateScreen()"
		cmd += "\n )"
		cmd += "\n registerRedrawViewsCallback "+id

		execute cmd 
	),
	
	/** Hide
	 */
	function hide =
	(
		execute (" unregisterRedrawViewsCallback "+id)
	),
	
	
	/*------------------------------------------------------------------------------
		PRIVATE
	--------------------------------------------------------------------------------*/
	/** _get position
	 */
	function _getPosition =
	(
		position as string --return
	),
	
	function test =
	(
		messagebox "ViewportText.test()"
	)
	
)
