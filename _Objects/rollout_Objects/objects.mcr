
macroscript	objects_reset
category:	"_Objects"
buttontext:	"Reset"
toolTip:	""
icon:	"#(path, index)"
(
	--for o in selection where superClassOf o == GeometryClass collect o
	(Objects_v()).test()
	
)
	
macroscript	objects_copy
category:	"_Objects"
buttontext:	"Copy\Paste"
toolTip:	"Copy selected object"
icon:	"#(path, index)"
(
	(Objects_v()).copy()
)

macroscript	objects_paste
category:	"_Objects"
buttontext:	"Copy\Paste"
toolTip:	"Paste selected object"
icon:	"#(path, index)"
(
	(Objects_v()).paste()
)
	


