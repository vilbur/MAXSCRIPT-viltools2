/** Gizmo
 */
struct Gizmo_v
(
	
	/** Circle axis modes axises in array
	  * @param	#( #x, #y, #z, #xy, #zx, #yz )	axises	 
	 */
	function circle axises  =
	(
		
		active_axis	= toolMode.axisConstraints
		
		next_index	= (findItem axises active_axis) + 1
		
		next_axis = if( next_index<=axises.count ) then axises[next_index] else axises[1]
		
		toolMode.axisConstraints = next_axis

	),
	
	/*------------------------------------------------------------------------------
		PRIVATE
	--------------------------------------------------------------------------------*/
	
	function test =
	(
		messagebox "Gizmo.test()"
	)
)


--fn Axis_Circle_v mode axis =
--(
--	/*
--	axis = "x"	
--	mode=#single
--	*/
--	active_axis = toolMode.axisConstraints
--
---- 	if active_axis != #z  and active_axis != #xy  and active_axis != #yz and active_axis != #zx then (global saved_axis = active_axis) else (global saved_axis = #x) 
--	case mode of				
--	(
--		"AxisSingle":(
--						case axis of
--						(
--							"x": if (active_axis ==  #x) then 
--														(
--															toolmode.axisConstraints = #y
--															global saved_axis = #y
--															global wTC4 = Green
--															printText = "Y"
--														) 
--														else 
--														( 
--															toolmode.axisConstraints =  #x
--															global saved_axis = #x
--															global wTC4 = red
--															printText = "X"
--														)
--							
--							"z": if active_axis !=  #z then
--														(
--															toolmode.axisConstraints = #z
--															printText = "Z"
--															global wTC4 = Blue
--														)
--														else 
--														(
--															toolmode.axisConstraints =  saved_axis
--															printText = (toUpper  (saved_axis as string))
--															if saved_axis = #x then global wTC4 = red else global wTC4 = Green
--														)
--						)
--					)
--		#double:(
--						if toolmode.axisConstraints == #xy then 
--						(toolmode.axisConstraints = #zx; printText = "ZX")
--						else if toolmode.axisConstraints == #zx then
--						(toolmode.axisConstraints = #yz; printText = "YZ")
--						else (toolmode.axisConstraints = #xy; printText = "XY")
--					)		
--					
--	)
--	
--	wText "" "" "" printText
--
--)
--
--Axis_Circle_v #double "x"