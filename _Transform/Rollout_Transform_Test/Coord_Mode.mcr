macroscript	_Transform_coordMode_circle_world_local
category:	"_Transform"
buttontext:	"CoordMode"
toolTip:	"Circle #world, #local"
--icon:	"#(path, index)"
(
	(CoordMode_v()).circle #( #world, #local )
)

macroscript	_Transform_coordMode_circle_all
category:	"_Transform"
buttontext:	"CoordMode"
toolTip:	"Circle #world, #local, #screen"
--icon:	"#(path, index)"
(
	(CoordMode_v()).circle #( #world, #local, #screen )
)
