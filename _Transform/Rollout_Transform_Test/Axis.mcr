macroscript	_Transform_axis_XY
category:	"_Transform"
buttontext:	"Circle Single"
toolTip:	"Circle x\y axis"
--icon:	"#(path, index)"
(
	(Gizmo_v()).circle #( #x, #y )
)

macroscript	_Transform_axis_XYZ
category:	"_Transform"
buttontext:	"Circle Single"
toolTip:	"Circle x\y\z axis"
--icon:	"#(path, index)"
(
	(Gizmo_v()).circle #( #x, #y, #z )
)
macroscript	_Transform_axis_XyZx
category:	"_Transform"
buttontext:	"Circle Double"
toolTip:	"Circle xy\zx axis"
--icon:	"#(path, index)"
(
	(Gizmo_v()).circle #( #xy, #zx )
)

macroscript	_Transform_axis_XyZxYz
category:	"_Transform"
buttontext:	"Circle Double"
toolTip:	"Circle  xy\zx\yz axis"
--icon:	"#(path, index)"
(
	(Gizmo_v()).circle #( #xy, #zx, #yz )
)
