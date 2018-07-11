/** Tool mode
 */
struct ToolMode_v
(
	tool_modes	= #( #SELECT, #MOVE, #ROTATE, #NUSCALE, #USCALE, #SQUASH ),

	/** Set tool or change axis
	 */
	function setToolOrChangeAxis tool_mode axises =
	(
		if not ( this._setTool tool_mode ) then 
			this.circle axises
		
	),
	/** Set tool or change selection type
	 */
	function setToolOrChangeSelectionType tool_mode selection_types =
	(
		if not ( this._setTool tool_mode ) then 
			this.circleSelectionTypes selection_types
		
	),
	/** Circle axis modes axises in array
	  * @param	#( #x, #y, #z, #xy, #zx, #yz )	axises	 
	 */
	function circle axises  =
	(		
		next_axis	= this.findNextIndex axises (findItem axises (this.activeAxis()))

		toolMode.axisConstraints = axises[next_axis]
	),
	/** Selection types
	  * @param	array	selection_types	Customized #( #Rectangle, #Circle, #Fence, #Lasso, #Paint )
	 */
	function circleSelectionTypes selection_types =
	(
		if( current_selection_type == undefined ) then
			global current_selection_type
		
		next_index	= this.findNextIndex selection_types (findItem selection_types current_selection_type)
		current_selection_type	= selection_types[next_index]
		
		case current_selection_type of
		(
			#Circle:	actionMan.executeAction 0 "59233" -- Selection: Circular Selection Region
			#Fence:	actionMan.executeAction 0 "59234" -- Selection: Fence Selection Region
			#Lasso:	actionMan.executeAction 0 "59235" -- Selection: Lasso Selection Region
			#Paint:	actionMan.executeAction 0 "59236" -- Selection: Paint Selection Region
			default:	actionMan.executeAction 0 "59232" -- Selection: Rectangular Selection Region
		)
	),
	/** Active mode
	 */
	function activeMode =
	(
		toolMode.commandmode	 --return
	),
	/** Active axis
	 */
	function activeAxis =
	(
		toolMode.axisConstraints	 --return
	),	

	/*------------------------------------------------------------------------------
		PRIVATE
	--------------------------------------------------------------------------------*/
	/** Find next index
	 */
	function findNextIndex array current_index =
	(
		next_index	= current_index + 1

		if( next_index<=array.count or next_index <= 0 ) then next_index else 1 --return
	),
	
	/** Set tool
	 */
	function _setTool tool_mode =
	(
		if( this.activeMode() != tool_mode ) then
		(
			toolMode.commandmode = tool_mode
			true --return
		) else
			false --return	

	),
	function test =
	(
		messagebox "ToolMode.test()"
	)
)
