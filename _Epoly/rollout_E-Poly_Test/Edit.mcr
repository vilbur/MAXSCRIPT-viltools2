
macroscript	epoly_quickslice_test
category:	"_Epoly_Test"  
buttonText:	"Quickslice"
tooltip:	"Quickslice"
(
	Epoly = Epoly_v()
	
	if( subObjectLevel == 0 ) then
		_selection = Epoly.allFaces()
	else
		_selection = Epoly.getSelectedOrAllFaces()
	
	subObjectLevel = 4
	Epoly.setSel #Face _selection
	
	
	Epoly.quickslice()
)

macroscript	epoly_extrude_test
category:	"_Epoly_Test"  
buttonText:	"Extrude"
tooltip:	"Extrude"
(
	Epoly = Epoly_v()

	Epoly.extrude()
)
