macroscript	mainui_mini_transform_type_in
category:	"_MainUI-Mini-Transform-Type-In"
buttontext:	"Mini Type In"
toolTip:	"Open Mini Transform Type In"
--icon:	"#(path, index)"
(
	filein ( getFilenamePath(getSourceFileName()) + "/../Mini-Transform-Type-In/Mini-Transform-Type-In-Start.ms" )
	filein ( getFilenamePath(getSourceFileName()) + "/../Mini-Transform-Type-In/Mini-Transform-Type-In-Start.ms" ) -- HOT FIX: run twice to remove extra border after move by ahk
)
