macroscript	epoly_relax
category:	"_Epoly-Tools"  
buttonText:	"Relax brush"
tooltip:	"Relax brush"
(
	if( subObjectLevel != 1 ) then
		(Epoly_v()).convertSelection #vertex
		
	current_mod	= modPanel.getCurrentObject()
	current_mod.SetOperation 81
	current_mod.paintDeformSize = 100
	--macros.run "Ribbon - Modeling" "RelaxSelection"

	
)

macroscript	epoly_relax_selection
category:	"_Epoly-Tools"  
buttonText:	"Relax selection"
tooltip:	"Relax selection"
(
	if( subObjectLevel != 1 ) then
		(Epoly_v()).convertSelection #vertex

	macros.run "Ribbon - Modeling" "RelaxSelection"
)

macroscript	tools_ridge_ring
category:	"_Epoly-Tools"
buttontext:	"Ridge ring"
toolTip:	"Make Ridge in edge ring selection"
--icon:	"#(path, index)"
(
	undo "Ridge" on
	(
		Epoly   = Epoly_v() 
		--subobjectLevel = 4 
		 
		EpolyMod  = EpolyMod_v() 
		_mod  = EpolyMod.mod() 
		 
		_selection  = Epoly.getSel #edge 
		 
		print ( "_selection = " + _selection as string ) 
		print ( "_mod = " + _mod as string ) 
		_mod.ConvertSelection #Edge #Face 
		subobjectLevel = 4 
		----$.bevelOutline = -59.6235 
		----$.bevelType = 1 
		----$.bevelOutline = 25.7864 
		----$.EditablePoly.buttonOp #Bevel 
		 
		_mod.SetOperation #Bevel 
		_mod.bevelHeight = -106.222 
		_mod.bevelOutline = -56.235 
		_mod.bevelType = 1
		_mod.Commit () 
		 
		_faces  = Epoly.getSel #face 
		_edges  = Epoly.getAusingB _mod _faces[1] aType:#Edge bType:#Face 
		 
		subobjectLevel = 2 
		 
		_mod.ButtonOp #SelectEdgeRing 
		 
		_ring  = (Epoly.getSel #Edge)[1] 
		 
		 
		 
		print ( "_faces = " + _faces as string ) 
		print ( "_edges = " + _edges as string ) 
		print ( "_ring = " + _ring as string ) 
		edges_collapse = (_ring - (_ring - _edges)) 
		 
		Epoly.setSel #edge edges_collapse 
		 
		_mod.ConvertSelection #Edge #Vertex 
	   
		macros.run "Editable Polygon Object" "EPoly_Collapse" 
		
	)
	
)

macroscript	tools_ridge_loop
category:	"_Epoly-Tools"
buttontext:	"Ridge loop"
toolTip:	"Make Ridge in edge loop selection"
--icon:	"#(path, index)"
(
	undo "Ridge" on
	(
		Epoly   = Epoly_v() 
		
		Epoly.extrude -20 options:false 
		--Epoly.extrude -20
		subObjectLevel = 2
		macros.run "_Epoly-EpolySelection" "epolyselection_select_loop_up"
		macros.run "_Epoly-EpolySelection" "epolyselection_select_loop_down"
		
	)
	
)
