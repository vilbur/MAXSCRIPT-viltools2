format "*** vilTools2-import-scripts\n"

/** Import UI 
 *	
 */
filein ( getFilenamePath(getSourceFileName()) + "/../Library/_UI/UI.ms" )

/** Import VilTools2
 */
--filein ( getFilenamePath(getSourceFileName()) + "/includes.ms" )	-- PRODUCTION path
filein "c:\\MaxScripts\\vilTools2\\includes.ms"	-- DEV path, use hardlink for shorten path to file, easy for debbuging

/** Load macros 
 *	
 */
(MacroAutoLoader_v()).importScripts()
