
filein ( getFilenamePath(getSourceFileName()) + "/../Library/_UI/UI.ms" )
filein ( getFilenamePath(getSourceFileName()) + "/includes.ms" )
clearListener();

/* HOTFIX - Floater should be closed regularry */
try(cui.UnRegisterDialogBar rollout_test_floater)catch() --try to unregister if already registered
try(DestroyDialog rollout_test_floater)catch()	

/** DEFINE FLOATER  */
Floater	= (Floater_v()).new "Test Floater"


/** Load content from hierarchy
 */
function loadContentTest =
(
	Content = Content_v dir:(getFilenamePath(getSourceFileName())+"/") subdirs:"_*"
	--Content = Content_v dir:(getFilenamePath(getSourceFileName())+"/../") subdirs:"_EditPoly"
	--Content_2 = Content_v dir:(getFilenamePath(getSourceFileName())+"/../") subdirs:"_Selection"
	
	Content.loadTree()
	--Content_2.loadTree()

	Content.setControlsToUI Floater
	--addRolloutByCodeTest "Rollout by code 1"
	--Content_2.setControlsToUI Floater

)



/*---------------------------------------
	RUN TEST
-----------------------------------------*/

loadContentTest()
Floater.create()

Floater.dock "right"


--sleep 1
--try(cui.UnRegisterDialogBar test_floater)catch() --try to unregister if already registered
--try(DestroyDialog test_floater)catch()
	--_selection.selection_test.text == "test"



