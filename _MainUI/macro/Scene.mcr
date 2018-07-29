/** Set viewport setting for modeling 
 *	
 */
macroscript	scene_light_modeling
category:	"_MainUI-Ligtning"
buttontext:	"Light modeling"
toolTip:	"Scene light setup - Modeling"
--icon:	"#(path, index)"
(
	/** http://help.autodesk.com/view/3DSMAX/2015/ENU/?guid=__files_GUID_34892DB6_E840_4F52_9175_30332799B7B1_htm
	 */
	lightTintColor	= color 140	140	140
	ambientColor	= color 50	50	50
	
	settings = NitrousGraphicsManager.GetActiveViewportSetting()
	
	settings.ShowHighlightEnabled = false
	settings.VisualStyleMode  = #Shaded
	settings.UseEnvironmentBackgroundColorEnabled = false

	redrawViews()
)

/** Set viewport rendering similar to Samodsoft`s Unity engine setup
 *	
 */
macroscript	scene_light_unity
category:	"_MainUI-Ligtning"
buttontext:	"Light Unity"
toolTip:	"Scene light setup - Unity"
--icon:	"#(path, index)"
(
	lightTintColor	= color 140	140	140
	ambientColor	= color 10	10	10
	backgroundColor	= color 136	173	201

	settings = NitrousGraphicsManager.GetActiveViewportSetting()
	
	settings.ShowHighlightEnabled = true
	settings.VisualStyleMode  = #Facets
	settings.UseEnvironmentBackgroundColorEnabled = true

	redrawViews()
)