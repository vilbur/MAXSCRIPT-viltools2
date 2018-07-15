
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

/*------------------------------------------------------------------------------
	MAKE PLANAR
--------------------------------------------------------------------------------*/

macroscript	epoly_make_planar_x
category:	"_Epoly-Edit"  
buttonText:	"Align X"
tooltip:	"Align face to X"
(
	(Epoly_v()).makePlanar #X
)

macroscript	epoly_make_planar_y
category:	"_Epoly-Edit"  
buttonText:	"Align Y"
tooltip:	"Align face to Y"
(
	(Epoly_v()).makePlanar #Y
)

macroscript	epoly_make_planar_z
category:	"_Epoly-Edit"  
buttonText:	"Align Z"
tooltip:	"Align face to Z"
(
	(Epoly_v()).makePlanar #Z
)


macroscript	epoly_make_planar
category:	"_Epoly-Edit"  
buttonText:	"Make Planar"
tooltip:	"Make Planar"
(
	(Epoly_v()).makePlanar undefined
)



















