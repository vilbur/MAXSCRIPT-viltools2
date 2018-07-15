/** Editable poly selection
 */
struct EditablePolySelection_v
(
	_mod,
	
	
	function getAUsingB modOrObj bInVar aType:#currentLevel bType:#currentLevel =
	(
		case aType of
		(
			#vertex: case bType of
			(
				
			)
			#edge: case bType of
			(
				
			)
			#face: case bType of
			(
				
			)
			default:(print "invalid aType")

		)
	),
	/*------------------------------------------------------------------------------
		PRIVATE
	--------------------------------------------------------------------------------*/
	
	function test =
	(
		messagebox "EditablePolySelection.test()"
	)
)
