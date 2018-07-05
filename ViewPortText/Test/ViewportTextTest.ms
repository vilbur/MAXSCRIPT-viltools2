clearListener()


/** Declare just once, otherwise hide() doesn't work 
 */
function declareViewportText =
(
	if( _ViewportText==undefined ) then
	(
		filein ( getFilenamePath(getSourceFileName()) + "/../../includes.ms" )
		
		global _ViewportText
		
		_ViewportText = ViewportText_v id: "ViewportTexTest"
	)
)


/** Show text test
 */
function showTextTest =
(
	_ViewportText.show "Lorem ipsum"
)
/** Hide text test
 */
function hideTextTest =
(
	_ViewportText.hide() 
)


/*---------------------------------------
	RUN TESTS
-----------------------------------------*/

declareViewportText()
--showTextTest()
hideTextTest()
 