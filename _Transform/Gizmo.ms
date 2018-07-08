/** Gizmo
 */
struct Gizmo_v
(
	
	/** Activate axis
	 */
	function activateAxis axis =
	(
		toolmode.axisConstraints = axis
		global saved_axis = axis
	),
	/** Circle
	 */
	function circle mode axis =
	(
		--axis	= "x"	
		--mode	= #single
		active_axis	= toolMode.axisConstraints
	
	-- 	if active_axis != #z  and active_axis != #xy  and active_axis != #yz and active_axis != #zx then (global saved_axis = active_axis) else (global saved_axis = #x) 
	
		case mode of				
		(
			#single:(
				case axis of
				(
					#x: if (active_axis ==  #x) then
							this.activateAxis #y
						else 
							this.activateAxis #x
						
					#z: if active_axis !=  #z then
							this.activateAxis #z
						else 
						(
							this.activateAxis saved_axis
							--if saved_axis = #x then global wTC4 = red else global wTC4 = Green
						)
				)
			)
			#double:(
				if (toolmode.axisConstraints == #xy) then 
				toolmode.axisConstraints = #zx
				
				else if (toolmode.axisConstraints == #zx) then
				toolmode.axisConstraints = #yz
				else
				toolmode.axisConstraints = #xy
			)		
						
		)
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