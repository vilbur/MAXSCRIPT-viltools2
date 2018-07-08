macroscript	_Transform_X
category:	"_Transform"
buttontext:	"Circle Single"
toolTip:	"Circle x\y axis"
--icon:	"#(path, index)"
(
	(Gizmo_v()).circle #single #x
)

macroscript	_Transform_Z
category:	"_Transform"
buttontext:	"Circle Single"
toolTip:	"Circle x\y axis"
--icon:	"#(path, index)"
(
	(Gizmo_v()).circle #single #z
)
macroscript	_Transform_XY
category:	"_Transform"
buttontext:	"Circle Double"
toolTip:	"Circle x\y axis"
--icon:	"#(path, index)"
(
	(Gizmo_v()).circle #double #xy
)

macroscript	_Transform_YZ
category:	"_Transform"
buttontext:	"Circle Double"
toolTip:	"Circle y\z axis"
--icon:	"#(path, index)"
(
	(Gizmo_v()).circle #double #yz
)
