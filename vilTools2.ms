
filein ( getFilenamePath(getSourceFileName()) + "/../Library/_UI/UI.ms" )
filein ( getFilenamePath(getSourceFileName()) + "/includes.ms" )
clearListener();

/* HOTFIX - Floater should be closed regularry */
try(cui.UnRegisterDialogBar rollout_viltools2)catch() --try to unregister if already registered
try(DestroyDialog rollout_viltools2)catch()	

/** DEFINE FLOATER  */
ini	= ( dotnetObject "System.Text.RegularExpressions.Regex" @"(ms|mscr)$" ).Replace (getSourceFileName()) "ini"
Floater	= (Floater_v ini:ini).new "VilTools2"


/*---------------------------------------
	cotnent
-----------------------------------------*/

/* FINAL CONTENT */
--Content	= (Content_v dir:(getFilenamePath(getSourceFileName())+"/*") match:"rollout_(.*)(?<!_test)$").load()

/* TEST CONTETNT */
--Content	= (Content_v dir:(getFilenamePath(getSourceFileName())+"/*") match:"rollout_(.*_test)$").load()

/* ALL */
Content	= (Content_v dir:(getFilenamePath(getSourceFileName())+"/*") match:"rollout_(.*)$").load()


/* Set content to ui */
Content.setControlsToUI Floater

/*---------------------------------------
	RUN TEST
-----------------------------------------*/

--loadContent()
Floater.create()
Floater.dock "right"