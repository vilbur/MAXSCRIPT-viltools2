/** Modifiers
 */
struct Modifiers_v
(
	/** Add edit poly
	 */
	function addEditPoly =
	(
		test = modPanel.addModToSelection (Edit_Poly ignoreBackfacing:on selectAngle:20 SelectByAngle:on ) ui:on
--print ( "test=" + test as string )
	

	),
	
	
	function test =
	(
		messagebox "Modifiers.test()"
	)
)
