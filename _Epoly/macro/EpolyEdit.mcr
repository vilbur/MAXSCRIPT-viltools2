
macroscript	epoly_quickslice
category:	"_Epoly-Edit"  
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

macroscript	epoly_extrude
category:	"_Epoly-Edit"  
buttonText:	"Extrude"
tooltip:	"Extrude"
(
	Epoly = Epoly_v()
	
	--if( subObjectLevel == 0 ) then
	--	_selection = Epoly.allFaces()
	--else
	--	_selection = Epoly.getSelectedOrAllFaces()
	--
	--subObjectLevel = 4
	--Epoly.setSel #Face _selection
	Epoly.extrude()
)

macroscript	epoly_create
category:	"_Epoly-Edit"  
buttonText:	"Create Polygon"
tooltip:	"Create Polygon"
(
	Epoly = Epoly_v()

	Epoly.create()
)

