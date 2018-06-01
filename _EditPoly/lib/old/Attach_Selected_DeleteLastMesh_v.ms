fn Attach_Selected_DeleteLastMesh_v =
(	
	--		i=$
	if selection.count > 1 do
	(			
		undo "Attach_Selected_DeleteLastMesh" on
		(
			objArray = for o in selection where superclassof o == geometryclass collect o 
			lastSel = objArray[objArray.count]
			
			if isgroupmember lastSel and  not isOpenGroupMember lastSel then
			(
			
					
					TheGroup = lastsel.parent 
					
					setGroupOpen TheGroup true
					wText  "  Group" " OPENED" "" "Try again"
				
-- 					selectmore lastSel
					deselect TheGroup
					for ch  in TheGroup.children where ch.isHidden  do deselect ch

					
				
				
			)
			else
			(
				
				if superclassof lastSel == geometryclass and classof lastSel != Editable_Poly  then 
				(
					AddModifier lastSel (Edit_Poly())
					maxOps.CollapseNodeTo lastSel 1 off
				)
				
				
				
					polyop.deleteVerts lastSel #{1..(lastSel.NumVerts)}
					Attach_Selected_v 0
				
			)
		)	
	)	

)
