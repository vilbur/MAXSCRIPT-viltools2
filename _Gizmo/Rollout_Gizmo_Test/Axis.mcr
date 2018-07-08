macroscript	_Gizmo_X
category:	"_Gizmo"
buttontext:	"Circle Single"
toolTip:	"Circle x\y axis"
--icon:	"#(path, index)"
(
	(Gizmo_v()).circle #single #x
)

macroscript	_Gizmo_Z
category:	"_Gizmo"
buttontext:	"Circle Single"
toolTip:	"Circle x\y axis"
--icon:	"#(path, index)"
(
	(Gizmo_v()).circle #single #z
)
macroscript	_Gizmo_XY
category:	"_Gizmo"
buttontext:	"Circle Double"
toolTip:	"Circle x\y axis"
--icon:	"#(path, index)"
(
	(Gizmo_v()).circle #double #xy
)

macroscript	_Gizmo_YZ
category:	"_Gizmo"
buttontext:	"Circle Double"
toolTip:	"Circle y\z axis"
--icon:	"#(path, index)"
(
	(Gizmo_v()).circle #double #yz
)
