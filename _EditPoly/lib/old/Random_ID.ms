fn Random_ID = 
(
	sel = for o in selection where superclassof o == GeometryClass collect o
	curObj = modPanel.getCurrentObject ()

	if  curObj == undefined do ( Max Modify Mode)
	if classof curObj != Editable_Poly and classof curObj != Edit_Poly then	
	(
		modPanel.addModToSelection (Edit_Poly ()) ui:on
		curObj = modPanel.getCurrentObject ()
	)
	
	if classof curMod == editable_poly then
	(
			for f= 1 to polyop.getNumFaces sel[1] do (polyop.setFaceMatID sel[1]  f (random 1 32 ))
	)
	else if classof curMod == edit_poly then
	(
		for o in sel do
		(
			for f= 1 to polyop.getNumFaces o do (polyop.setFaceMatID o f (random 1 32 ))
			
		)
	)
	mMat = multimaterial name:"RandomID" numsubs:32	
	
	
	for m = 1 to 32 do mMat[m].diffuse = (color (random 100 255) (random 100 255) (random 100 255))		
	
	for o in sel do o.material = mMat
	
)