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
	 */
	function constrain state:undefined =
	(
		this._toggleState "constrainType" state:state --return
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
		--mod	= this._mod()
		
		this._toggleState "SelectByAngle" state:state --return
		
		--#( state, angle) --return
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
