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
		mat = StandardMaterial name:mat_name glossiness:50 specularLevel:80
		
		mat.diffuse = color 97 119 130
	--	
	--)

	selection.material = mat
)
