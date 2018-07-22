/** Transform
 */
struct Transform_v
(
	
	/** Rotate selection
	 */
	function rotateSelection _angle =
	(
		tramsform	= #( 0, 0, 0 )
		axises	= #( "x", "y", "z" )
		axis_active	= toLower ( toolMode.axisconstraints as string)[1]
		--print ( "axis_active = " + axis_active as string )
		axis_i	= findItem axises axis_active
	
		tramsform[axis_i]	= 1
		tramsform_p3	= [tramsform[1], tramsform[2], tramsform[3]]
		
		rotate $ (angleaxis _angle tramsform_p3)
	),
	/*------------------------------------------------------------------------------
		PRIVATE
	--------------------------------------------------------------------------------*/
	
	function test =
	(
		messagebox "Transform.test()"
	)
)
