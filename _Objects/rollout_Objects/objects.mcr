
macroscript objects_reset
	category:	"_Objects"
	buttontext:	"Reset"
	toolTip:	""
	icon:	"#(path, index)"
(
	--for o in selection where superClassOf o == GeometryClass collect o
	(Objects_v()).test()
	
)
