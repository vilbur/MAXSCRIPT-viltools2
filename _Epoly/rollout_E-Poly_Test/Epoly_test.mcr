macroscript epoly_test
category:"_Epoly_Test"  
buttonText:"Epoly test"
(
	--messagebox "epoly_test" beep:false
	(Epoly_v()).test()
)

macroscript convert_selection_test
category:"_Epoly_Test"  
buttonText:"Convert edge to face"
(
	clearListener()
	--messagebox "epoly_test" beep:false
	(Epoly_v()).convertSelection #edge #face
)