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

macroscript	material_assign_rock_3dsmax
category:	"_Material"
buttontext:	"Rock Mat"
toolTip:	"Rock"
--icon:	"#(path, index)"
(
	mat_name = "rock_3dsmax"
	--mat		= this.getMat mat_name 

	--if( mat == fasle ) then
	--(
		mat = StandardMaterial name:mat_name glossiness:50 specularLevel:50
		
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
	mat_name = "grass_3dsmax"
	--mat		= this.getMat mat_name 

	--if( mat == fasle ) then
	--(
		mat = StandardMaterial name:mat_name glossiness:50 specularLevel:50
		
		--mat.diffuse = color 105 116 73
		mat.diffuse = color 108 120 84
	--)
	mat.name	= ( dotNetObject "System.Text.RegularExpressions.Regex" @"[_-]\d+$" ).Replace (getFilenameFile maxFileName) "_grass"

	selection.material = mat
)
