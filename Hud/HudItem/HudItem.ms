/** Manage text in viewport
 */
struct HudItem_v
(
	id,
	text,
	state	= false,
	color	= yellow,
	position	= [0, 0, 0],
	
	--/** Instance
	-- */
	--function instance _id =
	--(
	--	this.setId _id
	--	
	--	if( global_vievporttext == undefined ) then
	--		execute ( "global global_vievporttext; global_vievporttext = " + List_v() as string ) --return
	--	
	--	_instance = 	global_vievporttext.getVal _id
	--	
	--	if( _instance == undefined ) then
	--	(
	--		_instance = 	this
	--		global_vievporttext.setVal _id _instance
	--		global_vievporttext.getVal _id
	--	)
	--	
	--	else
	--	_instance --return 
	--),
	/** Set state
	 */
	function setState _state =
	(
		state =  _state == true or _state == 1
		print ( "setState = " + state as string )
	),
	/** Set props
	 */
	function setProps props =
	(
		
	),
	/** Set prop of viewport text
	  * @param	#(key, value)	key_value
	  *
	  */
	function setProp key_value =
	(
		--key	= key_value[1]
		
		if( hasProperty this key_value[1] ) then
			setProperty  this key_value[1] key_value[2]
			
		--print ( "setProp = " + key_value as string )
	),
	
	/** Show
	 */
	function show text =
	(
		--print ( "HudItem_v.show() " + text as string )
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
		--print ( "hide() = " + id as string )
		--print ("unregisterRedrawViewsCallback "+id)
		execute ("unregisterRedrawViewsCallback "+id)
		--unregisterRedrawViewsCallback id
		--unregisterRedrawViewsCallback Info_ignoreBackfacing
		gw.updateScreen()
		CompleteRedraw()
	),
	/** Update
	 */
	function update =
	(
		--print ( "UPDATE = " + this as string )
		if( state==true ) then
			this.show text
		else
			this.hide()
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
		messagebox "Hud.test()"
	)
	
)
