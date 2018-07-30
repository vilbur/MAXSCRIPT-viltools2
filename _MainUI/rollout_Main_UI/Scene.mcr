/** Set viewport setting for modeling 
 *	
 */
macroscript	scene_light_toggle
category:	"_MainUI-Ligtning"
buttontext:	"Ligtning"
toolTip:	"Scene light setup toggle"
--icon:	"#(path, index)"
(
	macro_name = if( ambientColor == ( color 10	10	10 ) ) then "scene_light_modeling" else "scene_light_unity"
	print ( "macro_name = " + macro_name as string )
	macros.run "_MainUI-Ligtning" macro_name
)
