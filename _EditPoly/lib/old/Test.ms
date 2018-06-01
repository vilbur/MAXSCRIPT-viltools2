

/* 

	obj = $BoxTest1
	EpolyMod = (Edit_Poly ())
	addModifier obj EpolyMod 

		

		
		

		subobjectLevel = 5
		
		EpolyMod.SetSelection #Face #{}
		EpolyMod.Select #Face #{1..6}
		EpolyMod.ButtonOp #CloneFace
		EpolyMod.SetOperation #Transform
		EpolyMod.MoveSelection  [-1804.27,0,0] 
		EpolyMod.Commit ()

		
		EpolyMod.getNumFaces ()
	 	EpolyMod.ButtonOp #DeleteFace
	
		
		
	polyop.deleteFaces EpolyMod #{2} delIsoVerts:true





 */