fn Bridge_preFN_v = 	
(
		global OrigFcount = #()
		global edgeSel =  #()
		global selObj = for o in selection  collect o
		
		curObj = modpanel.getcurrentobject ()

		for i= 1 to selObj.count do 
		(
			o = selObj[i]
			append OrigFcount (polyop.getNumFaces o)

			if classof curObj == Editable_Poly then 
			(
				append edgeSel (polyop.getEdgeSelection o)
			) 
			else if classof curObj == Edit_Poly then 
			(
				append edgeSel (o.modifiers[#Edit_Poly].getSelection #Edge node:o)
			)
					
		)		
)
/*
brigSeg = 1
Bridge_v 1
o = selObj[1]
o = selObj[2]
*/
	--global brigSeg

fn Bridge_v brigSeg = 	
(

	if brigSeg == undefined or brigSeg == 0 do global brigSeg = 1
	undo "Bridge_V" on
	(
		curObj = modpanel.getcurrentobject ()
		
		if classof curObj == Editable_Poly then
		(
			$.bridgeSegments = brigSeg
			$.bridge selLevel: #edge 
		)
		else if classof curObj == Edit_Poly then
		(
			selection[1].modifiers[#Edit_Poly].bridgeSegments = brigSeg
			selection[1].modifiers[#Edit_Poly].ButtonOp #BridgeEdge 			
		)
	)
)
/*
BridgeSeg_v 1
BridgeSeg_v -1
Bridge_preFN_v()
Bridge_v 1
BridgeSeg_v 1
BridgeSeg_v -1
BridgeSeg_v 0
coef = 0
coef = 1
*/
fn BridgeSeg_v coef = 
(	

	if  brigSeg != 0 do
	(
		curObj = modpanel.getcurrentobject ()
		if brigSeg == undefined do global brigSeg = 1

		if classof curObj == Edit_Poly then
		(
			for i=1 to selObj.count do
			(
				
				obj = selObj[i]	
				delFaces = #{1..polyop.getNumFaces obj}	- #{1..OrigFcount[i]}		
				obj.Edit_Poly.Select #Face (#{1..polyop.getNumFaces obj} - #{1..OrigFcount[i]}) node:obj -- select new faces by new face count minus old facecount
				selObj[i].Edit_Poly.ButtonOp #DeleteFace 
				obj.Edit_Poly.Select #Edge edgeSel[i] node:obj
			)
		)
		else if classof curObj == Editable_Poly then
		(	
			obj = selObj[1]	
			obj.EditablePoly.SetSelection #Face  (#{1..polyop.getNumFaces obj} - #{1..OrigFcount[1]}) 
			obj.EditablePoly.delete #Face	
			obj.EditablePoly.SetSelection #Edge  edgeSel[1]
		)
		
		
		if coef != 0 do
		(
			brigSeg = (brigSeg + coef )
			if brigSeg >= 1 then
			(Bridge_v brigSeg)
			else
			(brigSeg = 1 ; Bridge_v brigSeg)
			
			Bridge_v brigSeg -- run bridge again
		)

		


		--	edgeSel = 	polyop.getEdgeSelection $  --edit poly
	)
)
/*
(	
	 theObject = modPanel.GetCurrentObject()
--	if (classof theObject == Editable_Poly or classof theObject == Edit_Poly) AND (subObjectLevel == 2 or subObjectLevel == 3 ) do
	
		case classof theObject of
		 (
			 Editable_Poly: if subObjectLevel == 2 or subObjectLevel == 3 do ( selection[1].EditablePoly.Bridge ()) 

			 Edit_Poly: if subObjectLevel == 2 then ( selection[1].modifiers[#Edit_Poly].ButtonOp #BridgeEdge ) 
							else if subObjectLevel == 3 do selection[1].modifiers[#Edit_Poly].ButtonOp #BridgeBorder

)
 )
 */