macroscript	epoly_remove
category:	"_Epoly-Edit"  
buttonText:	"Remove"
tooltip:	"Remove subobject"
(
	undo "Remove subobject" on
	(
		(Epoly_v()).remove()
	)
)

macroscript	epoly_target_weld
category:	"_Epoly-Edit"  
buttonText:	"Target Weld"
tooltip:	"Target Weld"
(
	Epoly = Epoly_v()

	if( subObjectLevel != 1  ) then
		subObjectLevel = 1

	Epoly.targetWeld()
)

/** Collapse subobjects 
 *	If current subobject is #vertex, then connect vertices first
 *	
 */
macroscript	edit_collapse
category:	"_Epoly-Edit"
buttontext:	"Collapse"
toolTip:	"Collapse"
--icon:	"#(path, index)"
(
	if( subObjectLevel == 1 ) then
		macros.run "Editable Polygon Object" "EPoly_Connect"

	macros.run "Ribbon - Modeling" "GeometryCollapse"

)


macroscript epoly_planarize_faces
category:"_Epoly-Edit"  
buttonText:"Planarize"
tooltip:"Planarize Faces"
(

	if( subObjectLevel == 4 ) then
		macros.run "Ribbon - Modeling" "MakePlanar"

	else
		macros.run "_Epoly-Edit" "edit_planarize_object"

	/*------------------------------------------------------------------------------
		NOT WORKING FOR EDItABLE POLY
	--------------------------------------------------------------------------------*/

	--clearListener()
	----_objects	= for o in selection where superClassOf o == GeometryClass collect o
	--
	--_objects = #(selection[1])
	--	obj_copy	= selection[2]
	--for _obj in _objects do
	--(
	--	select _obj
	--	_mod	= modPanel.getCurrentObject()
	--	--print ( "polyop.getNumFaces _obj = " + polyop.getNumFaces _obj as string )
	--	--obj_copy	= #()
	--	--maxOps.cloneNodes _obj cloneType:#copy newNodes:&obj_copy offset:[50, 0, 0]
	--	--maxOps.cloneNodes _obj cloneType:#copy newNodes:&obj_copy 1
	--	--obj_copy = obj_copy[1]
	--	--
	--	--maxOps.CollapseNode obj_copy off
	--	
	--
	--	vert_pos_original = for v=1 to polyop.getNumVerts obj_copy collect  polyop.getVert _obj v
	--	
	--	--for x=1 to 20 do (for i=1 to polyop.getNumFaces obj_copy do ( polyop.makeFacesPlanar obj_copy #(i)) )
	--	
	--	vert_pos_flat = for v=1 to polyop.getNumVerts obj_copy collect  polyop.getVert obj_copy v
	--	--print ( "coords = " + coords as string )
	--	print ( "vert_pos_original = " + vert_pos_original as string )
	--	print ( "vert_pos_flat     = " + vert_pos_flat as string )
	--	
	--	 for v=1 to polyop.getNumVerts _obj do
	--	(
	--		--print ( "v = " + v as string )
	--		--print ( "transMatrix vert_pos_flat[v] = " + transMatrix vert_pos_flat[v] as string )
	--		
	--		_mod.SetSelection	#Vertex #{}
	--		_mod.Select	#Vertex #{v}
	--		
	--		new_pos = ( vert_pos_original[v] - vert_pos_flat[v] )
	--		--new_pos =  vert_pos_original[v]
	--		--new_pos =  [0,0,5]
	--		
	--		print ( "new_pos = " + new_pos as string )
	--		
	--		_mod.MoveSelection new_pos
	--		--_mod.MoveSelection  [ 0,0,5]
	--		--_mod.MoveSelection new_pos parent:_obj.transform localOrigin:true 
	--		--_mod.MoveSelection new_pos parent:(matrix3 [0,0,0] [0,0,0] [0,0,0] [0,0,0])
	--		--_mod.MoveSelection new_posnew_pos parent:(matrix3 [vert_pos_original[v].x,0,0] [0,vert_pos_original[v].y,0] [0,0,vert_pos_original[v].z] [0,0,0])
	--		--_mod.MoveSelection new_posnew_pos parent:(transMatrix vert_pos_original[v]) axis:(transMatrix vert_pos_original[v]) 
	--		--_mod.MoveSelection new_posnew_pos parent:(transMatrix vert_pos_original[v]) localOrigin:true 
	--		--_mod.MoveSelection new_posnew_pos parent:(transMatrix vert_pos_original[v]) 
	--		--_mod.MoveSelection new_posnew_pos
	--		----localOrigin:true 
	--		_mod.Commit ()
	--		
	--
	--		obj_copy.wirecolor = color 27 177 27
	--	)
	--		--print ( "v = " + v as string )
	--	
	--	--delete obj_copy
	--	
	--)

	redrawViews()
)

macroscript	edit_planarize_object
category:	"_Epoly-Edit"
buttontext:	"Planarize object"
toolTip:	"Planarize object"
--icon:	"#(path, index)"
(
	_objects  = for o in selection where superClassOf o == GeometryClass collect o

	for _obj in _objects do
	(
		maxOps.CollapseNode _obj off

		for x=1 to 20 do (for i=1 to ( polyop.getNumFaces _obj) do ( polyop.makeFacesPlanar _obj #(i)) )

		--addModifier _obj (Edit_Poly())

		--(Pivot_v()).centerToObject()
	)
)

macroscript	edit_chamfer
category:	"_Epoly-Edit"
buttontext:	"Chamfer"
toolTip:	"Chamfer"
--icon:	"#(path, index)"
(

	--On Execute Do (

		undo "Chamfer" on
		(
			Epoly	= Epoly_v()
			--connect_method	= #polyToolsConnect
			--
			--if not ( Epoly.Mod.setCurrent() or subObjectLevel ) then
			--	return false
			--
			if( subObjectLevel == 4 ) then
				Epoly.convertSelection #edge

			else if( subObjectLevel == 1 ) then
			(
				vertices	= Epoly.Sel.getSel 1
				print ( "vertices = " + vertices as string )
				_edges	= Epoly.Sel.getAusingB #edge #vertex vertices
				print ( "_edges = " + _edges as string )
				edge_lengths	= Epoly.Edges.getLength _edges
				print ( "edge_lengths = " + edge_lengths as string )
				print ( "amin  edge_lengths = " + amin  edge_lengths as string )

			--	if( ( shared_faces as array ).count == 1 ) then 
			--		connect_method	= #ConnectToLastSelVert -- connect to last vertex if all faces shared one face
			)
			--else if( subObjectLevel == 2 ) then
			--(
			--	_selection	= Epoly.Sel.getSel #edge
			--	
			--	if( ( _selection as array ).count == 1 ) then 
			--		(Epoly.Mod.get()).SelectEdgeRing()
			--		
			--	connect_method = #ConnectEdges
			--)
			--print ( "connect_method = " + connect_method as string )
			--case connect_method of
			--(
			--	(#polyToolsConnect):	macros.run "Editable Polygon Object"	"EPoly_Connect"
			--	(#ConnectToLastSelVert):	macros.run "miauu"	"miauu_ConnectToLastSelVertAlt"
			--	(#ConnectEdges):	macros.run "Ribbon - Modeling"	"ConnectEdges"
			--
			--)
		)
	--)

)

/**  
 *	If subobject:
 *		#vertex	- A) Connect to last selected vertex, if selected vertices are on one face
 *			  B) Connect all vertices if vertices does not share one face
 *		#edge	- Connect edges, if one selected then select ring
 *		#border	- Do nothing
 *		#face	- Convert to #vertex and connect vertices
 */
macroscript	epoly_connect
category:	"_Epoly-Edit"  
buttonText:	"Connect"
tooltip:	"Connect subobject"
(

	on execute do (

		undo "Connect subobjects" on
		(
			Epoly	= Epoly_v()
			connect_method	= #polyToolsConnect

			if not ( Epoly.Mod.setCurrent() or subObjectLevel ) then
				return false

			if( subObjectLevel == 4 ) then
				Epoly.convertSelection #vertex

			else if( subObjectLevel == 1 ) then
			(
				_selection	= Epoly.Sel.getSel #vertex
				shared_faces	= Epoly.Sel.getSharedAwithB #face #vertex _selection

				if( ( shared_faces as array ).count == 1 ) then 
					connect_method	= #ConnectToLastSelVert -- connect to last vertex if all faces shared one face
			)
			else if( subObjectLevel == 2 ) then
			(
				_selection	= Epoly.Sel.getSel #edge

				if( ( _selection as array ).count == 1 ) then 
					(Epoly.Mod.get()).SelectEdgeRing()

				connect_method = #ConnectEdges
			)
			print ( "connect_method = " + connect_method as string )
			case connect_method of
			(
				(#polyToolsConnect):	macros.run "Editable Polygon Object"	"EPoly_Connect"
				(#ConnectToLastSelVert):	macros.run "miauu"	"miauu_ConnectToLastSelVertAlt"
				(#ConnectEdges):	macros.run "Ribbon - Modeling"	"ConnectEdges"

			)
		)
	)

	/** Options menu item 
	 */
	on AltExecute type do (
		try (
			If SubObjectLevel == undefined then Max Modify Mode
			local A = Filters.GetModOrObj()
			A.popupDialog #ConnectEdges
		)
		catch()
	)

)