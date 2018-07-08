clearListener()


/** Declare just once, otherwise hide() doesn't work 
 */
function declareHud =
(
	if( _Hud==undefined ) then
	(
		filein ( getFilenamePath(getSourceFileName()) + "/../../includes.ms" )
		
		global _Hud
		
		_Hud = Hud_v id: "Hudest"
	)
)


/** Show text test
 */
function showTextTest =
(
	_Hud.show "Lorem ipsum"
)

/** Hide text test
 */
function hideTextTest =
(
	_Hud.hide() 
)


/*---------------------------------------
	RUN TESTS
-----------------------------------------*/

declareHud()
--showTextTest()
hideTextTest()
 