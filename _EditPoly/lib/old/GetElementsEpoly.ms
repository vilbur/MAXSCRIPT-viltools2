
fn GetElementsEpoly objArray =
(
	
	/*local*/ AllElements = #()
-- 	objArray = selection as array
	
	for obj in objArray where classof obj == Editable_Poly or classof obj == PolyMeshObject  do
	(
	
            /*local*/ faces = #{}
            /*local*/ objFaces = obj.faces as bitArray
            /*local*/ objFaces_arr = objFaces as array
            /*local*/ objFaces_count = objFaces_arr.count
            /*local*/ CurObj = polyop

            /*local*/ getElement = CurObj.getElementsUsingFace
--             /*local*/ step = 100./spnPercentage.value

            /*local*/ elements = for i in objFaces where objFaces[i] == true collect
            (
                /*local*/ element = getElement obj i
                objFaces -= element
                element
            )
			
			append AllElements elements
			
	)	
	AllElements		

)