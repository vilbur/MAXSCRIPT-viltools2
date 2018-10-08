macroscript	camera_autoset_background
category:	"_Camera"
buttontext:	"Auto Bg"
--toolTip:	"Set background to camera view\nmaxFilePath + \"\\camera_background\\\" + (camera_name) + \".jpg\""
--icon:	"#(path, index)"
(
	clearListener()

	try( callbacks.removeScripts #viewportChange	id:#camera_match_change )catch()
	try( callbacks.addScript     #viewportChange "onCameraMatchChange()" id:#camera_match_change )catch()

)