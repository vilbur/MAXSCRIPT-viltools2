
filein ( getFilenamePath(getSourceFileName()) + "/../Library/_UI/UI.ms" )
filein ( getFilenamePath(getSourceFileName()) + "/includes.ms" )
clearListener();

/* HOTFIX - Floater should be closed regularry */
try(cui.UnRegisterDialogBar rollout_test_floater)catch() --try to unregister if already registered
try(DestroyDialog rollout_test_floater)catch()	

/** DEFINE FLOATER  */
Floater	= (Floater_v()).new "Test Floater"


/* Get content from tree */
Content	= (Content_v dir:(getFilenamePath(getSourceFileName())+"/*") match:"rollout_(.*)(?<!_test)$").load()
Content_test_rollouts	= (Content_v dir:(getFilenamePath(getSourceFileName())+"/*") match:"rollout_(.*_test)$").load()

/* Set content to ui */
Content.setControlsToUI Floater
--Content_test_rollouts.setControlsToUI Floater

/*---------------------------------------
	RUN TEST
-----------------------------------------*/

--loadContent()
Floater.create()
Floater.dock "right"