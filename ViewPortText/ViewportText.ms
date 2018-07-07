/** Manage text in viewport
 */
struct ViewportText_v
(
	id,
	--text,
	color	= yellow,
	position	= [40, 40, 0],
	
	/** Instance
	 */
	function instance _id =
	(
		this.setId _id
		
		if( global_vievporttext == undefined ) then
			execute ( "global global_vievporttext = " + List_v() as string ) --return
		
		_instance = 	global_vievporttext.getVal _id
		
		if( _instance == undefined ) then
		(
			_instance = 	this
			global_vievporttext.setVal _id _instance
		)
		_instance --return 
	),
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
	/** Set id
	 */
	function setId _id =
	(
		id = "gw_"+_id
	),
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
