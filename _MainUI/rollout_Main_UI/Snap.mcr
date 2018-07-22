macroscript	snap_snap_disable_all
category:	"_MainUI"
buttontext:	"Snap disable all"
toolTip:	"Snap disable all"
--icon:	"#(path, index)"
(
	--(Snap_v()).getAll()
	(Snap_v()).disableAll()
)
