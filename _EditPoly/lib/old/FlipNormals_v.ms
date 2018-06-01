
function FlipNormals_v =  --start
(
	curmod = modPanel.getCurrentObject ()

	if subobjectLevel == 4 or subobjectLevel == 5 then 

	(
		case classof curmod of
		(
		Editable_Poly: (curmod.flipNormals 1) 	
		Edit_Poly: (curmod.ButtonOp #FlipFace) 
		)
	)
	else 
	(
	FlipNormal = Normalmodifier ()
	addModifier $ FlipNormal
	FlipNormal.flip = on
	)


)--end