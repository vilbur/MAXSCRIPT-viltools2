macroscript EditPolyTestMacro
category:"_EditPoly"  
buttonText:"edit_poly_test"

(
	--messagebox "_EditPoly.mcr"
	
	EditPoly 	= (EditPoly_v()).test()
)
macroscript explodeBySG
category:"_EditPoly"  
buttonText:"Explode By SG"

(
	--messagebox "_EditPoly.mcr"
	--_selection = (Selection_v()).get()
	--print ( "_selection=" + _selection as string )
	for obj in ((Selection_v()).get()) do
		EditPoly 	= (EditPoly_v obj:obj).explodeBySG()
		
)
