--******************************************************************************************************
-- Created: 		04-05-2011
-- Last Updated:	04-05-2011
-- Version:			1.0
--
-- Author :  Kostadin Kotev / miau_u@yahoo.com /
-- Version:  3ds max 2009 (should work in older versions too!)
--******************************************************************************************************
-- MODIFY THIS AT YOUR OWN RISK

macroScript Merge_Faces_v10
category:"miauu"
toolTip:"Merge Faces"
buttonText:"Merge Faces"
(
	local curObj = selection[1]
	if classof curObj == Editable_Poly then
	(
		if subobjectlevel == 4 or subobjectlevel == 5 then
		(
			local faceSel01 = polyop.getFaceSelection curObj
			if faceSel01.numberSet > 2 then
			(
				local edgesOfFace = polyop.getEdgesUsingFace curobj faceSel01
				curObj.EditablePoly.ConvertSelectionToBorder #Face #Edge
				local outerEdges = polyop.getEdgeSelection curObj
				local innerEdges = edgesOfFace-outerEdges
				polyop.setEdgeSelection curObj innerEdges
				curObj.EditablePoly.Remove selLevel:#Edge
			)
			else
				messagebox "Select 2 or more polygons" title:"Merge Faces Error!!!"
		)
		else
			messagebox "Go to Polygon/Element suboject level" title:"Merge Faces Error!!!"
	)
	else
		messagebox "Select Editable poly object!" title:"Merge Faces Error!!!"		
)