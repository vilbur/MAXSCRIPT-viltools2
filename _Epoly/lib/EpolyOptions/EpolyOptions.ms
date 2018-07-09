/** Edit poly objects
 */
struct EpolyOptions_v
(
	
	/** Ignore backfacing
	  * @param	boolean|undefined|#get	state	1) Toggle state if undefined 2) Get current state if #get 3) Set state if boolean
	  * @return	boolean		State of ignoreBackfacing
	  */
	function ignoreBackfacing state:undefined =
	(
		this._toggleState "ignoreBackfacing" state:state --return
	),
	/** Set constrain type
	  * @param	integer	state	0-None|1-Edge|2-Face|3-Normal
	  * @param	mixed	get	If not undefined, then return state as name E.G.: #Face
	  * @return	integer|name
	 */
	function constrain state:undefined get:undefined =
	(
		current_state = this._toggleState "constrainType" state:state
		
		if( get != undefined ) then
			case current_state of
			(
				0:	false	--return
				1:	#Edge	--return	
				2:	#Face	--return	
				3:	#Normal	--return	
			)
		else
			current_state --return	
	),
	/** Preserve UVs
	  * @param	boolean|undefined|#get	state	1) Toggle state if undefined 2) Get current state if #get 3) Set state if boolean
	  * @return	boolean		State of ignoreBackfacing
	 */
	function preserveUvs state:undefined =
	(
		this._toggleState "preserveUVs" state:state --return
	),
	/** Select by angle
	 */
	function selectByAngle state:undefined angle:45 =
	(
		--mod.selectAngle = angle
		_mod	= modPanel.getCurrentObject()
		current_state	= this._toggleState "SelectByAngle" state:state

		if( state == #get ) then
			angle = _mod.selectAngle
			
		else
			_mod.selectAngle = angle

		#( current_state, angle ) --return
	),
	/*---------------------------------------
		PRIVATE
	-----------------------------------------*/
	/** Toggle state
	 */
	function _toggleState method state:undefined =
	(
		--mod	= modPanel.getCurrentObject()
		if( mod != undefined ) then
		(
			if( state == undefined ) then
				state = execute ( "(modPanel.getCurrentObject())."+method+" != true" )
			
			if( state == #get ) then
				state = execute ( "(modPanel.getCurrentObject())."+method )
			
			else
				execute ( "(modPanel.getCurrentObject())."+method+" = "+state as string )
			
			state --return
		)
	),
	
	function test =
	(
		messageBox "EpolyOptions_v.test()"
	)
)
