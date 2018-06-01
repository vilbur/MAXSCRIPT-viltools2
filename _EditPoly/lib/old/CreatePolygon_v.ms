
fn CreatePolygon_v  = --start	
(
	undo "CreatePolygon_v" on
	(
		selCount = 0
		curObj = modPanel.getCurrentObject ()
		subObj = SubObjectLevel
		sel = for o in selection where superclassof o == GeometryClass collect o
		
		if  curObj == undefined do ( Max Modify Mode)
		if classof curObj != Editable_Poly and classof curObj != Edit_Poly then	
		(
			modPanel.addModToSelection (Edit_Poly ()) ui:on
			curObj = modPanel.getCurrentObject ()
		)

		if subObj == 1 or subObj == 3 then
		(
			if classof curObj == Editable_Poly or selection.count == 1 then 
			(
-- 				macros.run "PolyTools" "CreatePolygon"
				curObj.capHoles #Edge
			)
			else 
			(
				for o in sel do
				(
					select o 
					SubObjectLevel = 1
					macros.run "PolyTools" "CreatePolygon"
				)
				select sel
			)
		)
		else if subObj == 2 then
		(	
			Bridge_v 1	
		)	
		else if subObj != 1 or subObj != 2 then
		(
			case  subObj of
			(
				0:(SubObjectLevel = 2)
				3:(curObj.ConvertSelection #Border #Edge)
				4:(curObj.ConvertSelection #Face #Edge)
			)
			
			SubObjectLevel = 2

			--	o =$
			for o in sel where (polyop.getEdgeSelection o).numberSet > 0 do 
			(
				selCount = 1
			)
				
			if classof curObj == Editable_Poly then 
			(
				curObj.SetSelection #Edge ((polyOp.getOpenEdges $) as bitarray)	

				curObj.capHoles #Edge 
				if selCount == 0 then curObj.SetSelection #Edge #{}
			)
			else if classof curObj == Edit_Poly then
			(
				if selCount == 0 then -- if nothing sected
				(
					for o in sel do
					(
						-- o = $
						select o
						SubObjectLevel = 2			
						curObj.SetSelection #Edge ((polyOp.getOpenEdges o) as bitarray)	
						curObj.ButtonOp #Cap
					)
					select sel					
				)
				else
				(
					curObj.ButtonOp #Cap
				)
			)
			
		)
		
		
		SubObjectLevel = subObj
	
--	if subObj == 0 do	(SubObjectLevel = 2)
		

	)
	
)

