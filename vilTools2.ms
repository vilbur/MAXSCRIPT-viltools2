clearListener()

/** DEFINE FLOATER  */

Floater	= (Floater_v()).new "VilTools2"

Floater.Ini.ini ( dotnetObject "System.Text.RegularExpressions.Regex" @"(ms|mscr)$" ).Replace (getSourceFileName()) "ini"

/*---------------------------------------
	CONTENT
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
	CREATE DIALOG
-----------------------------------------*/

--loadContent()
--Floater.create()
Floater.create height:1280
--Floater.dock "right"



/*---------------------------------------
	CALLBACKS
-----------------------------------------*/
(EpolyCallbacks_v()).add()


/*---------------------------------------
	STARTUP
-----------------------------------------*/
ShellLaunch ( getFilenamePath(getSourceFileName()) + "/_Epoly/lib/EpolySelection/selectLoopOrRingOnMouseWheel.ahk" ) ""
macros.run "_MainUI" "mainui_mini_transform_type_in"

--clearListener()
--format "Cleared in vilTools2.ms\n"
AddSelectExportNodeCallback()




