macroscript	mainui_mini_transform_type_in
category:	"_MainUI"
buttontext:	"Mini Type In"
toolTip:	"Open Mini Transform Type In"
--icon:	"#(path, index)"
(
	miniTransformTypeInStart()
	--filein ( getFilenamePath(getSourceFileName()) + "/../Mini-Transform-Type-In/Mini-Transform-Type-In-Start.ms" )
	--filein ( getFilenamePath(getSourceFileName()) + "/../Mini-Transform-Type-In/Mini-Transform-Type-In-Start.ms" ) -- HOT FIX: run twice to remove extra border after move by ahk
)

macroscript	mainui_mini_transform_type_in_close
category:	"_MainUI"
buttontext:	"Mini Type In"
toolTip:	"Close Mini Transform Type In"
--icon:	"#(path, index)"
(
	miniTransformTypeInClose()
	--messageBox "close" beep:false
	--ShellLaunch ( getFilenamePath(getSourceFileName()) + "/../Mini-Transform-Type-In/Mini-Transform-Type-In-Close.ahk" ) ""
)

macroscript	dialogs_face_id_dialogs
category:	"_MainUI"
buttontext:	"Face IDs"
toolTip:	"Open Mat & Smooth group dialogs"
--icon:	"#(path, index)"
(
	macros.run "Ribbon - Modeling" "MaterialIDDialog"
	macros.run "Ribbon - Modeling" "SmoothingGroupsDialog"
	
	ShellLaunch ( "$userscripts/vilTools2/_MainUI/Ahk/SetLastDialogPosition.ahk" ) ""

)
