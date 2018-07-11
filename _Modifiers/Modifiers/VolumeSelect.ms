/** Edit poly_ modifier
 */
struct VolumeSelect_Modifier_v
(
	/** Get
	 */
	function get =
	(
		--$.modifiers[#Vol__Select].volume = 3
		--Edit_Poly()
		Vol__Select  level:2 volume:3
	),
	
	
	function test =
	(
		messagebox "EditPoly_Modifier.test()"
	)
)
