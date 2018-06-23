
filein ( getFilenamePath(getSourceFileName()) + "/../../includes.ms" )
clearListener()


/** Create id material
 */
function createIdMaterialTest =
(
	_material 	= (Material_v()).getIdMaterial()
	
	selection.material = _material
	
	redrawViews()
)

createIdMaterialTest()