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
