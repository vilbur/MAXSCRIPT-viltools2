/** Set viewport setting for modeling 
 *	
 */
macroscript	scene_light_toggle
category:	"_MainUI-Ligtning"
buttontext:	"Ligtning"
toolTip:	"Scene light setup toggle"
--icon:	"#(path, index)"
(
	macro_name = if( (NitrousGraphicsManager.GetActiveViewportSetting()).VisualStyleMode == #Facets ) then "scene_light_modeling" else "scene_light_unity"
	print ( "macro_name = " + macro_name as string )
	macros.run "_MainUI-Ligtning" macro_name
)
/** Set viewport setting for modeling 
 *	
 */
macroscript	scene_preview_toggle
category:	"_MainUI-Ligtning"
buttontext:	"Preview"
toolTip:	"Preview scene in Unity like setup"
--icon:	"#(path, index)"
(
	--macro_name = if( (NitrousGraphicsManager.GetActiveViewportSetting()).VisualStyleMode == #Facets ) then "scene_light_modeling" else "scene_light_unity"
	--print ( "macro_name = " + macro_name as string )
	--macros.run "_MainUI-Ligtning" macro_name
	sub_obj	= subObjectLevel
	if( sub_obj != 0 ) then 
		subObjectLevel = 0
	--print ( "sub_obj = " + sub_obj as string )
	macro_name	= if( (NitrousGraphicsManager.GetActiveViewportSetting()).VisualStyleMode == #Facets ) then "scene_light_modeling" else "scene_light_unity"
	mat_name	= if( macro_name == "scene_light_modeling" )then "modeling" else "rock_3dsmax" 
	
	macros.run "_MainUI-Ligtning"	macro_name
	macros.run "_Material"	("material_assign_" +mat_name)
	
	
)
