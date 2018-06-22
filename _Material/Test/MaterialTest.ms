
filein ( getFilenamePath(getSourceFileName()) + "/../../includes.ms" )

clearListener()

_material 	= (Material_v()).createMaterial()

selection.material = _material

setMeditMaterial 1 _material
actionMan.executeAction 0 "50048"  -- Tools: Material Editor Togglez