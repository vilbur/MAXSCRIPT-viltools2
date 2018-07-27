
macroscript pivot_center_to_object
category:	"_Pivot"
buttontext:	"Center"
toolTip:	"Center pivot to objects"
--icon:	"#(path, index)"
(
	(Pivot_v()).centerToObject()
)

macroscript pivot_reset_to_word
category:	"_Pivot"
buttontext:	"Center"
toolTip:	"Reset pivot to world"
--icon:	"#(path, index)"
(
	(Pivot_v()).resetToWord()
)

macroscript pivot_free_mode
category:	"_Pivot"
buttontext:	"Free"
toolTip:	"Affect pivot only mode"
--icon:	"#(path, index)"
(
	--for o in selection where superClassOf o == GeometryClass collect o
	(Pivot_v()).freePivot()
)
	