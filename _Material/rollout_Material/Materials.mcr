--macroscript	material_TEST
--category:	"_Material"  
--buttonText:	"TEST"
--(
--	clearListener()
--	--Material = Material_v()
--
--	--Material.createMaterial()
--)
macroscript	material_assign_idmat
category:	"_Material"  
buttonText:	"ID Mat"
tooltip:	"Create edit multi material with different ID"  
(
	Material = Material_v()
	
	selection.material = Material.getIdMaterial()
)

macroscript	material_assign_modeling
category:	"_Material"  
buttonText:	"Modeling"
tooltip:	"Shade material for modeling"  
(
	mat = StandardMaterial glossiness:0 specularLevel:0
	
	mat.diffuse = color 169 191 203
		
	mat.name	= "Modeling"

	selection.material = mat
	
)

macroscript	material_assign_rock_3dsmax
category:	"_Material"
buttontext:	"Rock Mat"
toolTip:	"Rock"
--icon:	"#(path, index)"
(
	--mat		= this.getMat mat_name 
	--if( mat == fasle ) then
	--(
		mat = StandardMaterial glossiness:50 specularLevel:50
		
		--mat.diffuse = color 66 92 105
		mat.diffuse = color 97 119 130
		
	--
	mat.name	= ( dotNetObject "System.Text.RegularExpressions.Regex" @"[_-]\d+$" ).Replace (getFilenameFile maxFileName) "_rock"
	--)

	selection.material = mat
)

macroscript	material_assign_grass_3dsmax
category:	"_Material"
buttontext:	"Grass Mat"
toolTip:	"Grass"
--icon:	"#(path, index)"
(
	--mat		= this.getMat mat_name 
	--if( mat == fasle ) then
	--(
		mat = StandardMaterial glossiness:50 specularLevel:50
		
		--mat.diffuse = color 105 116 73
		mat.diffuse = color 108 120 84
	--)
	mat.name	= ( dotNetObject "System.Text.RegularExpressions.Regex" @"[_-]\d+$" ).Replace (getFilenameFile maxFileName) "_grass"

	selection.material = mat
)


macroscript	material_assign_tree_crown
category:	"_Material"  
buttonText:	"Tree crown"
tooltip:	"Tree crown"  
(
	mat = StandardMaterial glossiness:50 specularLevel:50
	
	mat.diffuse = color 95 99 64
		
	mat.name	= "Tree_crown"

	selection.material = mat
	
)

macroscript	material_assign_tree_trunk
category:	"_Material"  
buttonText:	"Tree trunk"
tooltip:	"Tree trunk"  
(
	mat = StandardMaterial glossiness:50 specularLevel:50
	
	mat.diffuse = color 105 75 55
		
	mat.name	= "Tree_trunk"

	selection.material = mat
	
)
