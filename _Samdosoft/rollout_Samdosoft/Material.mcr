macroscript	material_assign_rock
category:	"_Samdosoft"
buttontext:	"Rock Mat"
toolTip:	"Rock"
--icon:	"#(path, index)"
(
	mat_name = "rock_3dsmax"
	--mat		= this.getMat mat_name 

	--if( mat == fasle ) then
	--(
		mat = StandardMaterial name:mat_name glossiness:50 specularLevel:50
		
		mat.diffuse = color 97 119 130
	--	
	--)

	selection.material = mat
)
