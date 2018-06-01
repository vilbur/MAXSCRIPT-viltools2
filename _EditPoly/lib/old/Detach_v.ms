/*
Detach_v true true 	-- editable poly -- detach
Detach_v false true	-- editable poly -- detach COPY
Detach_v true false 	-- editable poly -- detach to element
Detach_v false false   -- editable poly -- detach to element COPY

DontCopy = true
DontCopy = false --copy

toElement =true
toElement =false

*/
fn Detach_v DontCopy toElement  =
(
   theObject = modPanel.GetCurrentObject()
	
	if theObject != undefined then
	(
		
		undo "Detach_v" on
		(	
			case classof theObject of
		   (
			Editable_Poly: (
							obj = $
							FaceCount = (polyop.getNumFaces obj)+1
							objName = obj.name
							faces = polyop.getFaceSelection obj as bitarray
							polyop.detachFaces obj faces delete:DontCopy asNode:toElement name:(objName +"_TMPdetached")
				
							if  toElement == true then
							(
								detachedObj = getnodebyname (objName +"_TMPdetached")
								detachedObj.name =  (uniquename objName )
							)
		
							if toElement == false and DontCopy == false then  polyop.setFaceSelection obj #{FaceCount..(polyop.getNumFaces $)}
							if toElement == true then select detachedObj
						)
				Edit_Poly:  (
								--detach copy
			-- 									obj = $
								subObj = subobjectLevel

								for obj in selection do
								(											
									objLayer = obj.layer.name			
									addLayer = LayerManager.getLayerFromName objLayer -- get layer of old object
									
									curObj = modpanel.GetCurrentObject ()

									objName = obj.name
									faces = (curObj.getSelection #Face) as bitArray  		
									invFaces = -(curObj.getSelection #Face) as bitarray
-- 									copy obj name:"tmp_copy"
									maxOps.cloneNodes obj cloneType:#copy newNodes:&nnl
									tmpDet = nnl[1]
									if DontCopy == true then curObj.ButtonOp #DeleteFace 
-- 									tmpDet = getnodebyname "tmp_copy"						
									maxOps.CollapseNode tmpDet off
									tmpDet.EditablePoly.SetSelection #Face invFaces
									tmpDet.EditablePoly.delete #Face
									--move tmpDet [-80,0,0]
				-- 					select tmpDet
				-- 					tmpDet.Edit_Poly.setSelection #Face invFaces
				-- 					tmpDet.Edit_Poly.ButtonOp #DeleteFace 
									tmpDet.name =  (objName +"_TMPdetached")
				-- 					maxOps.CollapseNode tmpDet off
									tmpDet.name =  (objName +"_detached")				
									addLayer.addnode tmpDet --add box to layer

-- 									select obj
									if toElement == false then
									(
										curObj.SetSelection #Face #{}
										
										tmpDet.EditablePoly.SetSelection #Face #{1..(tmpDet.numfaces)}
										curObj.attach tmpDet  editPolyNode:obj

									)
									
									
									
									
									if toElement == true then select tmpDet
									
								)	
								
								subobjectLevel = subObj

								
							)
		   )
		   
		   
		   
			If DontCopy  	and toElement  then		wText "" "Detach" "" "" 					   -- editable poly -- detach
			If not DontCopy and toElement  then		wText "" "Detach" "Copy" "" 			-- editable poly -- detach COPY
			If DontCopy  	and not toElement then 	wText "" "Detach" "Elemet" "" 				-- editable poly -- detach to element
			If not DontCopy and not toElement then 	wText "" "Detach" "Elemet" "Copy"		  -- editable poly -- detach to element COPY
		   
		    		
		   
		   
	    )
	   
	   
   )
)

