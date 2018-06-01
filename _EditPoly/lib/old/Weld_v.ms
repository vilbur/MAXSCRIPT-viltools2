fn Weld_v withOptions treshold = --start	
(
	undo "Weld_v" on
	(
	
		/*
		withOptions=0
		treshold=0.5
		Weld_v 0 0.5

		*/		
		curObj = modPanel.getCurrentObject ()
		subObj = SubObjectLevel
		sel = for o in selection where superclassof o  == GeometryClass collect o
		
		if  curObj == undefined do ( Max Modify Mode)
		if classof curObj != Editable_Poly and classof curObj != Edit_Poly then	
		(
			modPanel.addModToSelection (Edit_Poly ()) ui:on
			curObj = modPanel.getCurrentObject ()
		)
			
		case subObj of
		(
			
			2:(curObj.ConvertSelection #Edge #Vertex)
			3:(curObj.ConvertSelection #Border #Vertex)
			4:(curObj.ConvertSelection #Face #Vertex)
			5:(curObj.ConvertSelection #Element #Vertex)				
		)
		
		SubObjectLevel = 1
	
		if withOptions == 0 then
		(
			case (classof curObj) of
			(
					Editable_Poly:	(	
										startVertCount = polyop.getNumVerts $

										selCount = ((curObj.GetSelection #Vertex) as array).count
										if subObj == 0 or selCount == 0 then 
										(
-- 											SubObjectLevel = 1
-- 											actionMan.executeAction 0 "40021"  -- Selection: Select All
											max select all
										)
										oldTres = curObj.weldThreshold
										curObj.weldThreshold = treshold
										polyop.weldVertsByThreshold $ (curObj.GetSelection #Vertex)
										curObj.weldThreshold = oldTres
										if selCount == 0 then curObj.SetSelection #Vertex #{}
										EndVertCount = polyop.getNumVerts $
-- 										SubObjectLevel =  subObj
	

									)
					Edit_Poly:		(
						
										startVertCount = 0 
										EndVertCount = 0
						
										for o in sel do startVertCount += polyop.getNumVerts o
											
						
										selCount = ((curObj.GetSelection #Vertex) as array).count
										if subObj == 0 or selCount == 0  then 
										(
-- 											SubObjectLevel = 1
											max select all
										)
										oldTres = curObj.weldVertexThreshold
										curObj.weldVertexThreshold  = treshold
										curObj.ButtonOp #WeldVertex
										curObj.weldVertexThreshold = oldTres
										if selCount == 0 then curObj.SetSelection #Vertex #{}
											
										for o in sel do EndVertCount += polyop.getNumVerts o

-- 										SubObjectLevel =  subObj
									)

			)
			
			SubObjectLevel = subObj
			if startVertCount == EndVertCount then wText "   Weld" ("Treshold: " + treshold as string)  "Nothing Welded" "" 
			else
			(
				global wTC1 = Red
				global wTC2 = Red
				global wTC3 = Red
				global wTC4 = Red
				wText "   Weld" ("Treshold: " + treshold as string) ("Before: " + startVertCount as string + " verts") ("After:  " + EndVertCount as string + " verts")
			)
		)
		else
		(
			case classof curObj of
			(
				Editable_Poly:	(	curObj.PopupDialog #WeldSelected	)
				Edit_Poly:		(	curObj.PopupDialog #WeldVertex	)
			)
			SubObjectLevel = subObj

		)

	)
)