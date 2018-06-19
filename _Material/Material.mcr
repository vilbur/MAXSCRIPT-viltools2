
macroScript SetMaterialIdByObject
	category:	"_Materials"
	buttontext:	"Set Material by Object"
	toolTip:	""
(
	
	--messagebox "Test"
	
)

macroScript ExplodeByMaterial
	category:	"_Materials"
	buttontext:	"Explode"
	toolTip:	"Explode By Material"
(
	Material_v 	= (Material_v()).explodeByMaterialId()
	
)

