macroscript samdosoft_planar
category:"_Samdosoft"  
buttonText:"Planar"
tooltip:"Planarize Faces"
(
	
	_objects  = for o in selection where superClassOf o == GeometryClass collect o 

	for _obj in _objects do
	(
		maxOps.CollapseNode _obj off
		
		for x=1 to 20 do (for i=1 to ( polyop.getNumFaces _obj) do ( polyop.makeFacesPlanar _obj #(i)) )
		
		addModifier _obj (Edit_Poly())
		
		(Pivot_v()).centerToObject()
	)
	
	
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

