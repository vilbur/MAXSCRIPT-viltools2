--******************************************************************************************************
-- Created: 		29-10-2015
-- Last Updated:29-10-2015
-- Version:			1.00
--
-- Author :  Kostadin Kotev / miau_u@yahoo.com / http://miauumaxscript.blogspot.com/
-- Version:  3ds max 2009 (10) (should work in older versions too!)
--
-- Discription: Connect the last selected vert to prevoiusly selected.
-- Usage: RUN IT
--
-- Wishlist:
--
--******************************************************************************************************
-- MODIFY THIS AT YOUR OWN RISK

macroScript miauu_ConnectToLastSelVertAlt
category:"miauu"
toolTip:"Connect to last vertex"
buttonText:"Connect To Last vertex"
(
		if selection.count == 1 then
		(
			local curO = if (classof (modPanel.getCurrentObject())) == Edit_Poly then
				(
					modPanel.getCurrentObject()
				)
				else
				(
					selection[1]
				)
			--		
			case classof curO of
			(
				Editable_Poly:
				(
					with redraw off	
					(
						if subobjectlevel == 1 then
						( 	
							if (selVertsBA = (polyop.getVertSelection curO)).numberset != 0 then
							(
								max undo
								allVertsBA = polyop.getVertSelection curO
								vertsToConnectToArr = allVertsBA as array
								lastSelVert = ((selVertsBA - allVertsBA) as array)[1]
								for i = 1 to vertsToConnectToArr.count do
								(
									polyop.setVertSelection curO #{lastSelVert, vertsToConnectToArr[i]}
									curO.buttonOp #ConnectVertices
								)	
							)
							else
							(
								messagebox "Select some verts!" title:""
							)
						)
						else
						(
							messagebox "Activate Vertex sub-object level" title:""
						)
					)
				)
				Edit_Poly:
				(
					with redraw off	
					(
						if subobjectlevel == 1 then
						( 
							if (selVertsBA = (curO.GetSelection #Vertex)).numberset != 0 then
							(
								max undo
								allVertsBA = curO.GetSelection #Vertex
								vertsToConnectToArr = allVertsBA as array
								lastSelVert = ((selVertsBA - allVertsBA) as array)[1]
								for i = 1 to vertsToConnectToArr.count do
								(
									curO.SetSelection #Vertex #{}
									curO.Select #Vertex #{lastSelVert, vertsToConnectToArr[i]}
									curO.buttonOp #ConnectVertices
								)
								curO.Commit()								
							)
							else
							(
								messagebox "Select some verts!" title:""
							) 
						)
						else
						(
							messagebox "Activate Vertex sub-object level" title:""
						)
					)
				)
			)
		)
		else
			messagebox "Work woth single object" title:"Invalid Selection"
)