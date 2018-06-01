fn Attach_Selected_v weld =
(	
	--		i=$
	if selection.count > 1 do
	(	
		
		undo "Attach_Selected_v" on
		(
		
			for o=1 to (selection.count - 1 ) where superclassof selection[o] == geometryclass do 
				(
				
						AddModifier selection[o] (Edit_Poly())
						maxOps.CollapseNode selection[o] off
						
				)
				
				maxOps.CollapseNodeTo  selection[selection.count] 1 off


						
				while selection.count > 1 do
				(
					selcount = selection.count
					for i = selcount to 2 by -2 do
					(
						polyop.attach selection[i] selection[i-1]
					)
				)
				update selection[1]
				
			if weld == 1 do (polyop.weldVertsByThreshold selection[1] #{1..(polyop.getNumVerts selection[1])}) --weld vetices
				--subobjectLevel = 1
			
				wText "" "Selection Attached" "" ""
				
			)	
			
	)	

)
