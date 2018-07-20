--******************************************************************************************************
-- Created: 		10-07-2011
-- Last Updated:	10-08-2011
-- Version:			1.0
--
-- Author :  Kostadin Kotev / miau_u@yahoo.com /
-- Version:  3ds max 9 
--
-- Discription: 
--	Select edges by its length or measure distance between verts, edges or objects
--
--******************************************************************************************************
-- MODIFY THIS AT YOUR OWN RISK
macroScript miauuMeasureAndSelect
category:"miauu"
tooltip:"Measure and Select"
buttonText:"Measure and Select"
(
	
	global DistanceTool
	try(destroydialog DistanceTool)catch()
	global DrawEdgeSegmLength
	global SelectObjectsMouseTool
	global ShowTapeLengthInViewport
	miauuTape1 = tape pos:[0,0,0] target:(targetObject pos:[10,0,0])
	miauuTape1.name = "miauuTape"

	when transform miauuTape1 changes do
	(
		DistanceTool.et_showDistance.text = DistanceTool.UserOrGenericUnits miauuTape1.targetDistance
	)	
	
	rollout DistanceTool "miauu Measure and Select"
	(
		local selSpline = undefined
		local edgeLengthArr = #()
		local textColor = green
		local linePoints = #([0,0,0], [0,0,0])
		local obj01pos = undefined
		local obj02pos = undefined
		local etToUse = undefined
		local objLength = undefined
		local objHeight = undefined
		local objWidth = undefined
		local backLeftBottom = undefined
		local frontLeftBottom = undefined
		local backLeftTop = undefined
		local backRightBottom = undefined
		local lineArr = #(undefined,undefined,undefined)
		local selObjArrPos = #()
		--
		local moGetFaceArea = meshop.getFaceArea
		local moGetNumFaces = meshOp.getNumFaces
		local moGetFaceCenter = meshop.getFaceCenter
		local meshGetFaceSel = getFaceSelection
		local moGetVertsUsingEdge = meshop.getVertsUsingEdge
		local moGetVert = meshop.getVert
		
		local poGetNumFaces = polyOp.getNumFaces
		local poGetFaceCenter = polyop.getFaceCenter
		local poGetFaceSel = polyOp.getFaceSelection
		local poGtEdgeVerts = polyOp.getEdgeVerts
		local poGetVertSel = polyOp.getVertSelection
		local poGetEdgeSel = polyOp.getEdgeSelection
		local poGetVert = polyOp.getVert
		local poGetFaceArea = polyOp.getFaceArea
		
		
		groupbox grpbox_SelectByLength "Select edges by length" pos:[2,2] width:197 height:58
			spinner spn_edgeLength "" pos:[3,18] fieldwidth:59 range:[0.0,1e9,0.0] scale:0.001 type:#float
			checkButton chkbtn_enableSpn2 "from..to" pos:[75,18] height:16 tooltip:"Select all edges with length between two spinners values!"
			spinner spn_edgeLengthM "" pos:[125,18] fieldwidth:59 range:[0.0,1e9,0.0] scale:0.001 type:#float enabled:off		
			checkbox chkbox_less "<" pos:[3,38] tooltip:"Select all edges with length less than the spinner value!"
			checkbox chkbox_equal "=" pos:[33,38] tooltip:"Select all edges with length equal to the spinner value!"
			checkbox chkbox_more ">" pos:[63,38] tooltip:"Select all edges with length grater than the spinner value!"
			button btn_Select "Select" pos:[95,35]		
		
		checkbox chkbox_showInVP "Show in viewport" pos:[10,65] checked:true tooltip:"Show length/distance on viewport"
		ImgTag it_Green bitmap:(bitmap 14 14 color:green) pos:[117,65]  width:14 height:14 tooltip:"Change text color to green!"
		ImgTag it_Red bitmap:(bitmap 14 14 color:red) pos:[132,65]  width:14 height:14 tooltip:"Change text color to red!"
		ImgTag it_Yellow bitmap:(bitmap 14 14 color:yellow) pos:[147,65]  width:14 height:14 tooltip:"Change text color to yellow!"
		ImgTag it_White bitmap:(bitmap 14 14 color:white) pos:[162,65]  width:14 height:14 tooltip:"Change text color to white!"
		ImgTag it_Blue bitmap:(bitmap 14 14 color:blue) pos:[177,65]  width:14 height:14 tooltip:"Change text color to blue!"
		label lbl_units "Units scale:" pos:[15,85]
		radiobuttons rb_userOrGeneric  pos:[73,85] labels:#("Generic", "User") default:1 columns:2
		
		groupbox grpbox_MeasureLength "Measure edges/segments length" pos:[2,105] width:197 height:37			
			button btn_showLength "Show Lenght>>" pos:[4,120] height:16
			edittext et_showLength "" fieldWidth:60 pos:[91,120] labelOnTop:false
			button btn_copyToClipboard "Copy" pos:[156,120] height:16 tooltip:"Copy to clipboard"
			
		groupbox grpbox_MeasureDistance "Measure distance" pos:[2,148] width:197 height:110
			radiobuttons rb_PivotOrCenter  pos:[2,165] labels:#("Pivot to Pivot","Center to Center") default:1 columns:2
			button btn_showDistance "Show Distance:" pos:[4,185] height:16
			edittext et_showDistance "" fieldWidth:60 pos:[91,185] labelOnTop:false
			button btn_copyToClipboardD "Copy" pos:[156,185] height:16 tooltip:"Copy to clipboard"
			checkButton chkbtn_ShowTape "Use Tape" pos:[5,205] highlightColor:red tooltip:"Show TAPE helper and use it to measure distance!"
			label lbl_selectTape "Select:" pos:[73,208]
			button btn_selTape "Tape" pos:[108,205] width:35
			button btn_selTarget "Target" pos:[149,205]
			button btn_pickObjects "Pick Objects" pos:[5,230] width:65 tooltip:"RMB - hide on-screen text."
			button btn_pickPoints "Pick Points" pos:[72,230] width:65 tooltip:"RMB - hide on-screen text."
			checkButton chkbtn_ShowCage "L/H/W" pos:[139,230] width:65 tooltip:"Show object Length, Height and Width"
		
		groupbox grpbox_MeasureFaceArea "Measure faces area" pos:[2,265] width:197 height:55
			radiobuttons rb_faceOrObj labels:#("for selected faces", "for object") pos:[4,280] default:1 columns:2
			button btn_showArea "Show Area   >>" pos:[4,297] height:16
			edittext et_showArea "" fieldWidth:60 pos:[91,297] labelOnTop:false
			button btn_copyToClipboardFA "Copy" pos:[156,297] height:16 tooltip:"Copy to clipboard"
			
		groupbox grpbox_SelectByFaceArea "Select faces by area" pos:[2,322] width:197 height:58
			spinner spn_faceAres "" pos:[3,322+18] fieldwidth:59 range:[0.0,1e9,0.0] scale:0.001 type:#float
			checkButton chkbtn_enableSpn2FA "from..to" pos:[75,322+18] height:16 tooltip:"Select all edges with length between two spinners values!"
			spinner spn_faceAreaM "" pos:[125,322+18] fieldwidth:59 range:[0.0,1e9,0.0] scale:0.001 type:#float enabled:off		
			checkbox chkbox_lessFA "<" pos:[3,322+38] tooltip:"Select all edges with length less than the spinner value!"
			checkbox chkbox_equalFA "=" pos:[33,322+38] tooltip:"Select all edges with length equal to the spinner value!"
			checkbox chkbox_moreFA ">" pos:[63,322+38] tooltip:"Select all edges with length grater than the spinner value!"
			button btn_SelectFA "Select" pos:[95,322+35]		
		
		button btn_ClearViewport "Clear VP" pos:[143,322+35] tooltip:"Remove text from the viewport."
		
		function SwitchToModPannel =
		(
			if getCommandPanelTaskMode() != #modify do setCommandPanelTaskMode #modify
		)
		function UserOrGenericUnits distanceVal =
		(
			if rb_userOrgeneric.state == 1 then --	generic units
				distanceVal = distanceVal				
			else	--	user units
				distanceVal = units.formatValue distanceVal
			
			if etToUse == 1 then
				et_showLength.text = distanceVal as string
			else
				et_showDistance.text = distanceVal as string
		)
		--	mesh sub-object mode
		function GetEdgeUsingVertsEPM curSel edges =
		(
			local edgeVerts = #()
			for i in edges do
			(
				edgeVerts[1] = curSel.GetEdgeVertex i 1 node:$
				edgeVerts[2] = curSel.GetEdgeVertex i 2 node:$
			)
			edgeVerts
		)
		function GetEdgeLength curSel edgeIdx mode =
		(
			local vertPos = undefined
			case mode of
			(
				1:
				(
					local edgeVerts = poGtEdgeVerts curSel edgeIdx
					vertPos = for iVert in edgeVerts collect poGetVert curSel iVert						
				)
				2:
				(
					local edgeVerts = GetEdgeUsingVertsEPM curSel #(edgeIdx)
					vertPos = for iVert in edgeVerts collect curSel.GetVertex iVert
				)
				3:
				(
					local edgeVerts = moGetVertsUsingEdge curSel edgeIdx
					vertPos = for iVert in edgeVerts collect moGetVert curSel iVert 						
				)
			)
			
			distance vertPos[1] vertPos[2]
		)
		function GetTotalLength curObj selEdges type =
		(
			local fullLength = 0
			for i = 1 to selEdges.count do
			(
				curLength = GetEdgeLength curObj selEdges[i] type
				fullLength += curLength
			)
			fullLength = UserOrGenericUnits fullLength
		)
		function SelectEdges numEdge curObj edgeList mode =
		(
			local userValue = spn_edgeLength.value
			local userValue1 = spn_edgeLengthM.value
			if chkbox_less.state == on then
			(
				for i = 1 to numEdge do
				(
					local dist = GetEdgeLength curObj i mode
					if dist < userValue do append edgeList i
				)
			)
			if chkbox_equal.state == on then
			(
				for i = 1 to numEdge do
				(
					local dist = GetEdgeLength curObj i mode
					if dist == userValue do append edgeList i
				)
			)
			if chkbox_more.state == on then
			(
				for i = 1 to numEdge do
				(
					local dist = GetEdgeLength curObj i mode
					if dist > userValue do append edgeList i
				)
			)
			if chkbox_less.state == on and chkbox_equal.state == on then
			(
				for i = 1 to numEdge do
				(
					local dist = GetEdgeLength curObj i mode
					if dist < userValue do append edgeList i
				)
				for i = 1 to numEdge do
				(
					local dist = GetEdgeLength curObj i mode
					if dist == userValue do append edgeList i
				)						
			)
			if chkbox_more.state == on and chkbox_equal.state == on then
			(
				for i = 1 to numEdge do
				(
					local dist = GetEdgeLength curObj i mode
					if dist > userValue do append edgeList i
				)
				for i = 1 to numEdge do
				(
					local dist = GetEdgeLength curObj i mode
					if dist == userValue do append edgeList i
				)						
			)
			
			if spn_edgeLengthM.enabled == true do
			(
				
				for i = 1 to numEdge do
				(
					local dist = GetEdgeLength curObj i mode
					if dist > userValue and dist < userValue1 do append edgeList i
				)
			)
			edgeList
		)
		--	spline
		function GetSplineLength curSegm sN =
		(
			local lengthArray = #()
			local segmentArray = #()
			local segmentArray = getSegLengths selSpline sN
			local segNum = numSegments selSpline sN
			for j = (segNum+1) to (segmentArray.count-1) do
			(
				append lengthArray segmentArray[j]
			)
			--	get lenght only for selected segments
			selSegm = #()
			for i in curSegm do
			(
				append selSegm lengthArray[i]
			)
			--	calculate the lenght of (all) segment/s
			lenght = 0
			for v in selSegm do 
			(
				lenght += v
			)
			
			lenght
		)
		function SplineFN selSpline =
		(
			local splineNum = numSplines selSpline
			local selSegm = undefined
			if splineNum != 0 then
			(
				local fullLength = 0
				for s=1 to splineNum do
				(	
					local curLength = undefined					
					selSegm = getSegSelection selSpline s					
					case selSegm.count of
					(
						0: (et_showLength.text = "select edge")
						default:
						(
							curLength = GetSplineLength selSegm s
							fullLength += curLength
						)
					)
				)
				fullLength = UserOrGenericUnits fullLength
			)
		)
		function SelectSplineSegment selSpline =
		(
			local splineNum = numSplines selSpline
			for s=1 to splineNum do
			(
				local lengthArray = #()
				local segmentArray = #()
				local segmentArray = getSegLengths selSpline s
				local segNum = numSegments selSpline s
				--	get the length for all segments
				for j = (segNum+1) to (segmentArray.count-1) do
				(
					append lengthArray segmentArray[j]
				)
				local userValue = spn_edgeLength.value
				local userValue1 = spn_edgeLengthM.value
				local segmList = #()
				--	filter segments
				if chkbox_less.state == on then
				(
					for ss=1 to lengthArray.count do
					(
						if lengthArray[ss] < userValue do append segmList ss
					)
				)
				if chkbox_equal.state == on then
				(
					for ss=1 to lengthArray.count do
					(
						if lengthArray[ss] == userValue do append segmList ss
					)
				)
				if chkbox_more.state == on then
				(
					for ss=1 to lengthArray.count do
					(
						if lengthArray[ss] > userValue do append segmList ss
					)
				)
				if chkbox_less.state == on and chkbox_equal.state == on then
				(
					for ss=1 to lengthArray.count do
					(
						if lengthArray[ss] < userValue do append segmList ss
					)
					for ss=1 to lengthArray.count do
					(
						if lengthArray[ss] == userValue do append segmList ss
					)						
				)
				if chkbox_more.state == on and chkbox_equal.state == on then
				(
					for ss=1 to lengthArray.count do
					(
						if lengthArray[ss] > userValue do append segmList ss
					)
					for ss=1 to lengthArray.count do
					(
						if lengthArray[ss] == userValue do append segmList ss
					)					
				)
				
				if spn_edgeLengthM.enabled == true do
				(					
					for ss = 1 to lengthArray.count do
					(
						if lengthArray[ss] > userValue and lengthArray[ss] < userValue1 do append segmList ss
					)
				)
				--	select segments
				if segmList.count != 0 do
				(
					subObjectLevel = 2
					setSegSelection selSpline s segmList
				)
			)
		)
		--
		function SelectFN =
		(
			local edgeList = #() as array
			if (selection.count == 1) then
			(
				SwitchToModPannel()
				local curObj = modPanel.getCurrentObject()
				if (classOf curObj) == Editable_Poly do
				(
					local numEdge = curObj.getNumEdges()
					local edgeList = SelectEdges numEdge curObj edgeList 1
					subobjectLevel = 2
					$.selectedEdges = edgeList 
				)
				if (classOf curObj) == Edit_Poly do
				(
					local numEdge = curObj.GetNumEdges ()
					local edgeList = SelectEdges numEdge curObj edgeList 2
					subobjectLevel = 2
					local edgeListBA = edgeList as bitarray
					curObj.SetSelection #Edge #{}
					curObj.select #Edge edgeListBA 
				)
				if (classOf curObj) == Editable_Mesh do
				(
					local numEdge = $.Edges.count
					local edgeList = SelectEdges numEdge curObj edgeList 3
					subobjectLevel = 2
					$.selectedEdges = edgeList 
				)
				if (superClassOf curObj) == Shape do
				(
					if (classOf curObj) == SplineShape or (classOf curObj) == Line  then
					(
						selSpline = $
						SelectSplineSegment selSpline
					)
					else
						messagebox "Spline operation on non-spline object!" title:"miauu Script Error!!!"
				)
			)
			else
				messagebox "Select only one object!" title:"miauu Script Error!!!"
		)
		--	find middle point of selected vertices/knots
		function VertSelMiddleCenter vertSel curObj sN type =
		(
			local posX = 0
			local posY =0
			local posZ = 0
			local cnt = 0
			case type of
			(
				1:
				(
					for i in vertSel do
					(
						posX = posX + (in coordsys world (poGetVert curObj i).x)
						posY = posY + (in coordsys world (poGetVert curObj i).y)
						posZ = posZ + (in coordsys world (poGetVert curObj i).z)
						cnt = cnt + 1	
					)
				)
				2:
				(
					for i in vertSel do
					(
						posX = posX + (in coordsys world (curObj.GetVertex i).x)
						posY = posY + (in coordsys world (curObj.GetVertex i).y)
						posZ = posZ + (in coordsys world (curObj.GetVertex i).z)
						cnt = cnt + 1	
					)
				)
				3:
				(
					for i in vertSel do
					(
						posX = posX + (in coordsys world (moGetVert curObj i).x)
						posY = posY + (in coordsys world (moGetVert curObj i).y)
						posZ = posZ + (in coordsys world (moGetVert curObj i).z)
						cnt = cnt + 1	
					)
				)
				4:
				(
					for i in vertSel do
					(
						posX = posX + (in coordsys world (getKnotPoint curObj sN i).x)
						posY = posY + (in coordsys world (getKnotPoint curObj sN i).y)
						posZ = posZ + (in coordsys world (getKnotPoint curObj sN i).z)
						cnt = cnt + 1	
					)
				)
			)
			middleX = posX / cnt
			middleY = posY / cnt
			middleZ = posZ / cnt
			
	 		point3 middleX middleY middleZ 
		)
		
		-- show the length in the viewport
		function DrawEdgeSegmLength =
		(
			gw.setTransform(Matrix3 1)
			--	draw text for sub-object mode
			if edgeLengthArr.count < 100 do
			(--	show the edges/segments index only if the count of selected edges/segments are less then 100
				for i = 1 to edgeLengthArr.count do
				(
					posInScreen = gw.TransPoint edgeLengthArr[i][2]
					lengthTXT = undefined 
					
					if rb_userOrgeneric.state == 1 then
						lengthTXT = (edgeLengthArr[i][1] as string)
					else
						lengthTXT = units.formatValue ((edgeLengthArr[i][1])as float) 
						
					gw.wText posInScreen lengthTXT color:textColor
				)
			)
			--	draw lines between objects
			if obj01pos != undefined and obj02pos != undefined do
			(
				for i = 1 to selObjArrPos.count do
				(
					linePoints[1]= gw.wTransPoint selObjArrPos[i][1]
					linePoints[2]= gw.wTransPoint selObjArrPos[i][2]
					gw.setColor #line textColor
					gw.wPolyline linePoints false
					gw.wMarker linePoints[1] #plusSign color:[255,0,0]
					gw.wMarker linePoints[2] #plusSign color:[255,0,0]
				)
			)
			--	draw objects length-width-height lines
			if objLength != undefined and objHeight != undefined and objWidth != undefined do
			(
				for i = 1 to lineArr.count do
				(
					linePoints[1]= gw.wTransPoint lineArr[i][1]
					linePoints[2]= gw.wTransPoint lineArr[i][2]
					gw.setColor #line textColor
					gw.wPolyline linePoints false
					gw.wMarker linePoints[1] #plusSign color:[255,0,0]
					gw.wMarker linePoints[2] #plusSign color:[255,0,0]
				)
			)
			--
			gw.enlargeUpdateRect #whole
			gw.updateScreen()
		)
		function StartDrawing =
		(
			unRegisterRedrawViewsCallback DrawEdgeSegmLength
			registerRedrawViewsCallback DrawEdgeSegmLength
			DrawEdgeSegmLength()
			forceCompleteRedraw()
		)
		function GetSegmentLength selSpline =
		(
			--	get selected segment for all splines
			local splineNum = numSplines selSpline
			edgeLengthArr = #()
			if splineNum != 0 then
			(
				for s=1 to splineNum do
				(	
					--	get selected segments
					selSegm01 = getSegSelection selSpline s									
					for i in selSegm01 do
					(
						local lengthArray = #()
						local segmentArray = #()
						local segmentArray = getSegLengths selSpline s
						local segNum = numSegments selSpline s
						--	get the length for all segments
						for j = (segNum+1) to (segmentArray.count-1) do
						(
							append lengthArray segmentArray[j]
						)
						--	get curent segment length
						curSegmLength = lengthArray[i]
						--	get curent segment knots
						local curSegmKnots = undefined
						if (isClosed selSpline s) == true then
						(--	if spline is closed
							if i == segNum then--	text in the center	  / 	text in second knot of segment
								curSegmKnots = #(i,1)							--	#(1)
							else
								curSegmKnots = #(i,i+1)							--	#(i)
						)
						else
							curSegmKnots = #(i,i+1)								--	#(i)
						append edgeLengthArr #(curSegmLength,(VertSelMiddleCenter curSegmKnots selSpline s 4))
					)
				)
			)
			StartDrawing()
		)
		--	show length
		function ShowInViewport =
		(
			obj01pos = undefined
			obj02pos = undefined
			if selection.count == 1 do
			(					
				SwitchToModPannel()
				local curObj = modPanel.getCurrentObject()
				if (classOf curObj) == Editable_Poly do
				(
					local curO = $
					local selEdges = poGetEdgeSel curO as array
					case selEdges.count of
					(
						0: (et_showLength.text = "select edge")
						default:
						(
							edgeLengthArr = #()
							for i = 1 to selEdges.count do
							(
								edgeVerts = poGtEdgeVerts curO selEdges[i]
								append edgeLengthArr #((GetEdgeLength curO selEdges[i] 1),(VertSelMiddleCenter edgeVerts curO 0 1))
							)
							StartDrawing()
						)
					)
				)
				if (classOf curObj) == Edit_Poly do
				(
					local selEdges = curObj.getSelection #Edge as array					
					case selEdges.count of
					(
						0: (et_showLength.text = "select edge")
						default:
						(
							edgeLengthArr = #()								
							--	get edge index, length and center
							for i = 1 to selEdges.count do
							(
								edgeVerts = GetEdgeUsingVertsEPM curObj #(selEdges[i])
								append edgeLengthArr #((GetEdgeLength curObj selEdges[i] 2),(VertSelMiddleCenter edgeVerts curObj 0 2))
							)
							StartDrawing()
						)
					)
				)
				if (classOf curObj) == Editable_Mesh do
				(
					local curO = $
					local selEdges = for i in curO.selectedEdges collect i.index
					case selEdges.count of
					(
						0: (et_showLength.text = "select edge")
						default:
						(
							edgeLengthArr = #()
							for i = 1 to selEdges.count do
							(
								edgeVerts = moGetVertsUsingEdge curO selEdges[i]
								append edgeLengthArr #((GetEdgeLength curO selEdges[i] 3),(VertSelMiddleCenter edgeVerts curO 0 3))
							)								
							StartDrawing()
						)
					)
				)
				if (superClassOf curObj) == Shape do
				(
					if (classOf curObj) == SplineShape or (classOf curObj) == Line  then
					(
						selSpline = $
						GetSegmentLength selSpline
					)
					else
					(
						with redraw off
						(
							local selSplineOrig = $						
							selSpline = copy selSplineOrig
							convertToSplineShape selSpline
							select selSpline						
							subobjectlevel = 2
							max select all						
							GetSegmentLength selSpline						
							delete selSpline
							select selSplineOrig
						)
						redrawViews()
					)
				)				
			)
		)
		--	show distance
		function ShowDistanceInViewport obj01pos obj02pos =
		(
			edgeLengthArr = #()
			selObjArrPos = #()
			dis = (distance obj01pos obj02pos)
			append selObjArrPos #(obj01pos,obj02pos)
			append edgeLengthArr #(dis as string,(obj01pos+obj02pos)/2)
			UserOrGenericUnits  dis
			StartDrawing()
		)
		--	get the object under mouse cursor
		function GetObjectUnderMouse =
		(
			local selectedObj
			local mouseScreenToWorldRay = mapScreenToWorldRay mouse.pos
			local lastMousePos = 99999999
			for obj in geometry where obj != selectedObj and obj.isHidden == false do
			(
				local hitedObj = intersectRay obj mouseScreenToWorldRay
				if hitedObj != undefined do
				(
					local newMousePos = distance mouseScreenToWorldRay.pos hitedObj.pos
					if newMousePos < lastMousePos do
					(
						lastMousePos = newMousePos
						selectedObj = obj
					)
				)
			)
			selectedObj
		)
		--	stop redrawviewscallbacks and clear the viewport
		function ClearViewports =
		(
			obj01pos = undefined
			obj02pos = undefined
			edgeLengthArr = #()
			selObjArrPos = #()
			unRegisterRedrawViewsCallback DrawEdgeSegmLength
			forceCompleteRedraw()
		)
		--	mouse tool - Pick Objects btn
		tool SelectObjectsMouseTool
		(
			local selObjAr = #()
			on mousePoint clickno do
			(
				if clickno == 1 then
				(
					centerObj = GetObjectUnderMouse()
					if centerObj != undefined do
					(
						select centerObj
						append selObjAr centerObj
					)
				)
				else
				(
					if clickno == 2 then
					(
						centerObj = GetObjectUnderMouse()
						if centerObj != undefined do
						(
							selectMore centerObj
							append selObjAr centerObj
							if rb_PivotOrCenter.state == 1 then
							(
								obj01pos = selObjAr[1].pos
								obj02pos = selObjAr[2].pos
							)
							else
							(
								obj01pos = selObjAr[1].center
								obj02pos = selObjAr[2].center
							)
							append selObjArrPos #(obj01pos,obj02pos)
							append edgeLengthArr #((distance obj01pos obj02pos),((obj01pos+obj02pos)/2))
							StartDrawing()
						)
					)
					else
					(
						if clickno > 2 do
						(
							centerObj = GetObjectUnderMouse()
							if centerObj != undefined do
							(
								selectMore centerObj
								append selObjAr centerObj
								if rb_PivotOrCenter.state == 1 then
								(
									obj01pos = selObjAr[selObjAr.count-1].pos
									obj02pos = selObjAr[selObjAr.count].pos
								)
								else
								(
									obj01pos = selObjAr[selObjAr.count-1].center
									obj02pos = selObjAr[selObjAr.count].center
								)
								append selObjArrPos #(obj01pos,obj02pos)
								append edgeLengthArr #((distance obj01pos obj02pos),((obj01pos+obj02pos)/2))
								StartDrawing()
							)
						)
					)
				)		
				redrawViews()
			)

			on mouseAbort clickno do
			(
				stopTool SelectObjectsMouseTool
			)
		)
		--
		on btn_showLength pressed do
		(
			if chkbox_showInVP.state == on do ShowInViewport()
			if selection.count == 1 do
			(				
				etToUse = 1
				SwitchToModPannel()
				local curObj = modPanel.getCurrentObject()
				if (classOf curObj) == Editable_Poly do
				(
					local selEdges = poGetEdgeSel curObj as array
					case selEdges.count of
					(
						0: (et_showLength.text = "select edge")
						default: (GetTotalLength curObj selEdges 1)
					)
				)
				if (classOf curObj) == Edit_Poly do
				(
					local selEdges = curObj.getSelection #Edge as array					
					case selEdges.count of
					(
						0: (et_showLength.text = "select edge")
						default: (GetTotalLength curObj selEdges 2)
					)
				)
				if (classOf curObj) == Editable_Mesh do
				(
					local selEdges = for i in $.selectedEdges collect i.index
					case selEdges.count of
					(
						0: (et_showLength.text = "select edge")
						default: (GetTotalLength curObj selEdges 3)
					)
				)
				if (superClassOf curObj) == Shape do
				(
					if (classOf curObj) == SplineShape or (classOf curObj) == Line  then
					(
						selSpline = $
						SplineFN selSpline
					)
					else
					(	
						with redraw off
						(
							local selSplineOrig = $						
							selSpline = copy selSplineOrig
							convertToSplineShape selSpline
							select selSpline						
							subobjectlevel = 2
							max select all
							SplineFN selSpline
							delete selSpline
							select selSplineOrig
						)
						redrawViews()
					)
				)				
			)
		)
		--	copy the length to clipboard
		on btn_copyToClipboard pressed do
		(
			setClipboardText et_showLength.text
		)
		--	enable the second spinner
		on chkbtn_enableSpn2 changed theState do
		(
			if theState then
			(
				spn_edgeLengthM.enabled = true
				chkbox_less.enabled = false
				chkbox_equal.enabled = false
				chkbox_more.enabled = false
				chkbox_less.state = false
				chkbox_equal.state = false
				chkbox_more.state = false
			)
			else
			(
				spn_edgeLengthM.enabled = false
				chkbox_less.enabled = true
				chkbox_equal.enabled = true
				chkbox_more.enabled = true
			)
		)
		
		on btn_Select pressed do
		(
			SelectFN()
		)
		--	realtime selection
		on spn_edgeLength changed val do
		(
			SelectFN()		
		)

		on chkbox_showInVP changed theState do
		(
			if theState then
			(
				ShowInViewport()
			)
			else
			(
				edgeLengthArr = #()
				selObjArrPos = #()
				lineArr = #(undefined,undefined,undefined)
				unRegisterRedrawViewsCallback DrawEdgeSegmLength
				forceCompleteRedraw()
			)
		) 
	--	Measure Distance
		on btn_showDistance pressed do
		(
			case selection.count of
			(
				1:	--	sub-object mode
				(
					etToUse = 0
					SwitchToModPannel()
					local curObj = modPanel.getCurrentObject()
					if (classOf curObj) == Editable_Poly do
					(
						case subobjectlevel of
						(	
							1:
							(
								local selVerts = poGetVertSel curObj as array
								case selVerts.count of
								(
									0: (et_showDistance.text = "select 2 verts")
									2:
									(
										obj01pos = (poGetVert $ selVerts[1])
										obj02pos = (poGetVert $ selVerts[2])
										ShowDistanceInViewport obj01pos obj02pos
									)
									default: (et_showDistance.text = "select 2 verts")
								)
							)
							2:
							(
								local selEdges = poGetEdgeSel curObj as array
								case selEdges.count of
								(
									0: (et_showDistance.text = "select 2 edges")
									2:
									(
										obj01pos = (VertSelMiddleCenter (poGtEdgeVerts $ selEdges[1]) $ 0 1)
										obj02pos = (VertSelMiddleCenter (poGtEdgeVerts $ selEdges[2]) $ 0 1)
										ShowDistanceInViewport obj01pos obj02pos
									)
									default: (et_showDistance.text = "select 2 edges")
								)
							)
						)
					)
					if (classOf curObj) == Edit_Poly do
					(
						case subobjectlevel of
						(
							1:
							(
								local selVerts = curObj.getSelection #Vertex as array					
								case selVerts.count of
								(
									0: (et_showDistance.text = "select 2 verts")
									2:
									(
										obj01pos = curObj.getVertex selVerts[1]
										obj02pos = curObj.getVertex selVerts[2]
										ShowDistanceInViewport obj01pos obj02pos
									)
									default: (et_showDistance.text = "select 2 verts")
								)
							)
							2:
							(
								local selEdges = curObj.getSelection #Edge as array					
								case selEdges.count of
								(
									0: (et_showDistance.text = "select 2 edges")
									2:
									(
										obj01pos = (VertSelMiddleCenter (GetEdgeUsingVertsEPM curObj #(selEdges[1])) curObj 0 2)
										obj02pos = (VertSelMiddleCenter (GetEdgeUsingVertsEPM curObj #(selEdges[2])) curObj 0 2)
										ShowDistanceInViewport obj01pos obj02pos
									)
									default: (et_showDistance.text = "select 2 edges")
								)
							)
						)
					)
					if (classOf curObj) == Editable_Mesh do
					(
						case subobjectlevel of
						(
							1:
							(
								local selVerts = for i in $.selectedVerts collect i.index
								case selVerts.count of
								(
									0: (et_showDistance.text = "select 2 verts")
									2: 
									(
										obj01pos = moGetVert $ selVerts[1]
										obj02pos = moGetVert $ selVerts[2]
										ShowDistanceInViewport obj01pos obj02pos
									)
									default: (et_showDistance.text = "select 2 verts")
								)
							)
							2:
							(
								local selEdges = for i in $.selectedEdges collect i.index
								case selEdges.count of
								(
									0: (et_showDistance.text = "select 2 edges")
									2: 
									(
										obj01pos = (VertSelMiddleCenter (moGetVertsUsingEdge $ selEdges[1]) $ 0 3)
										obj02pos = (VertSelMiddleCenter (moGetVertsUsingEdge $ selEdges[2]) $ 0 3)
										ShowDistanceInViewport obj01pos obj02pos
									)
									default: (et_showDistance.text = "select 2 edges")
								)
							)
						)
					)
				)
				2:	--	beteewn two objects
				(
					etToUse = 0
					if rb_PivotOrCenter.state == 1 then
						UserOrGenericUnits  (distance selection[1].pos selection[2].pos)
					else
						UserOrGenericUnits  (distance selection[1].center selection[2].center)
					
					obj01pos = undefined
					obj02pos = undefined
					edgeLengthArr = #()
					if rb_PivotOrCenter.state == 1 then
					(
						obj01pos = selection[1].pos
						obj02pos = selection[2].pos
					)
					else
					(
						obj01pos = selection[1].center
						obj02pos = selection[2].center
					)
					ShowDistanceInViewport obj01pos obj02pos
				)
				default:(messagebox "Select only two objects, verts or edges!" title:"miauu Script Error!!!")
			)
		)
		--	copy the distance to clipboard
		on btn_copyToClipboardD pressed do
		(
			setClipboardText et_showDistance.text
		)
		
		on rb_PivotOrCenter changed state do
		(
			if (chkbox_showInVP.state == on) do btn_showDistance.pressed()
		)		
		--	show/hide the tape helper
		on chkbtn_ShowTape changed theState do
		(
			if theState then
			(
				if selection.count == 2 then
				(
					edgeLengthArr = #()
					selObj01 = selection[1].center
					selObj02 = selection[2].center
					miauuTape1.pos = selObj01
					miauuTape1.target.pos = selObj02
					miauuTape1.isHidden = false
					miauuTape1.target.isHidden = false
					et_showDistance.text = UserOrGenericUnits miauuTape1.targetDistance
				)
				else
				(
					chkbtn_ShowTape.state = off
					messagebox "Select two objects!" title:"miauu Script Error!!!"
				)
			)
			else
			(
				miauuTape1.isHidden = true
				miauuTape1.target.isHidden = true
			)
		)
		
		on btn_selTape pressed do
		(
			if isValidNode miauuTape1 do select miauuTape1
		)
		on btn_selTarget pressed do
		(
			if isValidNode miauuTape1 do select miauuTape1.target
		)
		--	select objects one by one
		on btn_pickObjects pressed do
		(
			startTool SelectObjectsMouseTool
		)
		--	hide the text and lines
		on btn_pickObjects rightclick do
		(
			stopTool SelectObjectsMouseTool
			ClearViewports()
		)
		--	select 2 points
		on btn_pickPoints pressed do
		(
			obj01pos = undefined
			obj02pos = undefined
			
			curSnapMode = snapMode.active
			curSnapType = snapMode.type
			snapMode.active = true
			snapMode.type = #3D
			
			obj01pos = pickPoint snap:#3d 
			if classof obj01pos == point3 do
				obj02pos = pickPoint snap:#3d rubberBand:obj01pos 
			
			snapMode.active = curSnapMode
			try(snapMode.type = curSnapType)catch()
			
			dis = distance obj01pos obj02pos
			etToUse = 0
			UserOrGenericUnits  dis
			ShowDistanceInViewport obj01pos obj02pos
		)
		--	hide the text and lines
		on btn_pickPoints rightclick do
		(
			ClearViewports()
		)
		
		--	show length, width and height of selected object/s
		on chkbtn_ShowCage changed theState do
		(
			if theState then
			(
				if selection.count != 0 then
				(
					local curObj = $
					edgeLengthArr = #()
					
					backLeftTop = [curObj.min.x, curObj.max.y, curObj.max.z]
					backLeftBottom = [curObj.min.x, curObj.max.y, curObj.min.z]
					frontLeftBottom = [curObj.min.x, curObj.min.y, curObj.min.z]				
					backRightBottom = [curObj.max.x, curObj.max.y, curObj.min.z]
					
					objLength = distance backLeftBottom frontLeftBottom
					objHeight = distance backLeftBottom backLeftTop
					objWidth = distance backLeftBottom backRightBottom
					
					lineArr = #(#(backLeftBottom,frontLeftBottom),#(backLeftBottom,backLeftTop),#(backLeftBottom,backRightBottom))
					edgeLengthArr = #(#(objLength,frontLeftBottom),#(objHeight,backLeftTop),#(objWidth,backRightBottom))
					
					StartDrawing()
				)
				else
					messagebox "Select some objects!" title:"miauu Script Error!!!"
			)
			else
			(
				objLength = undefined
				objHeight = undefined
				objWidth = undefined
				edgeLengthArr = #()
				lineArr = #(undefined,undefined,undefined)
				unRegisterRedrawViewsCallback DrawEdgeSegmLength
				forceCompleteRedraw()
			)
		)
		--	change the color of the text and the lines
		on it_Green lbuttondown do
		(
			textColor = green
			StartDrawing()
		)
		on it_Red lbuttondown do
		(
			textColor = red
			StartDrawing()
		)
		on it_Yellow lbuttondown do
		(
			textColor = yellow
			StartDrawing()
		)
		on it_White lbuttondown do
		(
			textColor = white
			StartDrawing()
		)
		on it_Blue lbuttondown do
		(
			textColor = blue
			StartDrawing()
		)
		--	measure face area - idea by harumscarum
		on btn_showArea pressed do
		(
			if selection.count == 1 then
			(
				local curObj = $	--	modPanel.getCurrentObject()
				case (classOf curObj) of
				(
					Editable_Poly:
					(
						case rb_faceOrObj.state of
						(
							1:
							(
								local selFaces = poGetFaceSel curObj
								local faceArea = 0
								edgeLengthArr = #()
								for f in selFaces do
								(
									fa = (poGetFaceArea curObj f)
									faceArea += fa
									append edgeLengthArr #((fa),(poGetFaceCenter curObj f))
								)
								et_showArea.text = (faceArea as string)
								if edgeLengthArr.count < 50 do StartDrawing()
							)
							2:
							(
								local selFaces = poGetNumFaces curObj
								local faceArea = 0
								for f in 1 to selFaces do
								(
									faceArea += (poGetFaceArea curObj f)
								)
								et_showArea.text = (faceArea as string)
							)
						)					
					)
					Editable_Mesh:
					(
						case rb_faceOrObj.state of
						(
							1:
							(
								local selFaces = meshGetFaceSel curObj
								local faceArea = 0
								for f in selFaces do
								(
									fa = (moGetFaceArea curObj f)
									faceArea += fa
									append edgeLengthArr #((fa),(moGetFaceCenter curObj f))
								)
								et_showArea.text = (faceArea as string)
								if edgeLengthArr.count < 50 do StartDrawing()
							)
							2:
							(
								local selFaces = moGetNumFaces curObj
								local faceArea = 0
								for f in 1 to selFaces do
								(
									faceArea += (moGetFaceArea curObj f)
								)
								et_showArea.text = (faceArea as string)
							)
						)
					)
					default:
					(
						local tempMesh = snapshotAsMesh curObj
						case rb_faceOrObj.state of
						(						
							1:
							(
								local selFaces = meshGetFaceSel tempMesh
								local faceArea = 0
								for f in selFaces do
								(
									faceArea += (moGetFaceArea tempMesh f)
								)
								et_showArea.text = (faceArea as string)
							)
							2:
							(
								local selFaces = moGetNumFaces tempMesh
								local faceArea = 0
								for f in 1 to selFaces do
								(
									faceArea += (moGetFaceArea tempMesh f)
								)
								et_showArea.text = (faceArea as string)
							)						
						)
						delete tempMesh
					)
				)
			)
			else
				messagebox "Select only one object!" title:"miauu Script Error!!!"
		)
		-- 	select by face area
		function GetFaceArea curSel faceIdx mode =
		(
			local faceArea = undefined
			case mode of
			(
				1:
				(
					faceArea = poGetFaceArea curSel faceIdx					
				)
				2:
				(
					faceArea = moGetFaceArea curSel #{faceIdx}
				)
			)
			--	return the face area
			faceArea
		)
		function SelectFaces numFaces curObj faceList mode =
		(
			local userValue = spn_faceAres.value
			local userValue1 = spn_faceAreaM.value
			if chkbox_lessFA.state == on then
			(
				for i = 1 to numFaces do
				(
					local faceArea = GetFaceArea curObj i mode
					if faceArea < userValue do append faceList i
				)
			)
			if chkbox_equalFA.state == on then
			(
				for i = 1 to numFaces do
				(
					local faceArea = GetFaceArea curObj i mode
					if faceArea == userValue do append faceList i
				)
			)
			if chkbox_moreFA.state == on then
			(
				for i = 1 to numFaces do
				(
					local faceArea = GetFaceArea curObj i mode
					if faceArea > userValue do append faceList i
				)
			)
			if chkbox_lessFA.state == on and chkbox_equalFA.state == on then
			(
				for i = 1 to numFaces do
				(
					local faceArea = GetFaceArea curObj i mode
					if faceArea < userValue do append faceList i
				)
				for i = 1 to numFaces do
				(
					local faceArea = GetFaceArea curObj i mode
					if faceArea == userValue do append faceList i
				)						
			)
			if chkbox_moreFA.state == on and chkbox_equalFA.state == on then
			(
				for i = 1 to numFaces do
				(
					local faceArea = GetFaceArea curObj i mode
					if faceArea > userValue do append faceList i
				)
				for i = 1 to numFaces do
				(
					local faceArea = GetFaceArea curObj i mode
					if faceArea == userValue do append faceList i
				)						
			)
			
			if spn_faceAreaM.enabled == true do
			(
				
				for i = 1 to numFaces do
				(
					local faceArea = GetFaceArea curObj i mode
					if faceArea > userValue and faceArea < userValue1 do append faceList i
				)
			)
			faceList
		)
		on btn_SelectFA pressed do
		(
			if selection.count == 1 then
			(
				SwitchToModPannel()
				local curObj = $	
				local faceList = #() as array
				case (classOf curObj) of
				(
					Editable_Poly:
					(
						local numFaces = poGetNumFaces curObj
						local faceList = SelectFaces numFaces curObj faceList 1
						subobjectLevel = 4 
						polyOp.setFaceSelection curObj faceList
						redrawViews()
					)
					Editable_Mesh:
					(
						local numFaces = curObj.numfaces
						local faceList = SelectFaces numFaces curObj faceList 2
						subobjectLevel = 3 
						setFaceSelection curObj faceList
						redrawViews()
					)
					default:
					(
						messagebox "Select faces by area work only with Editable_Poly and Editable_Mesh objects" title:"miauu Script Error!!!"
					)
				)
			)
			else
				messagebox "Select only one object!" title:"miauu Script Error!!!"
		)		
		on btn_copyToClipboardFA pressed do
		(
			setClipboardText et_showArea.text
		)		
		--	enable the second spinner
		on chkbtn_enableSpn2FA changed theState do
		(
			if theState then
			(
				spn_faceAreaM.enabled = true
				chkbox_lessFA.enabled = false
				chkbox_equalFA.enabled = false
				chkbox_moreFA.enabled = false
				chkbox_lessFA.state = false
				chkbox_equalFA.state = false
				chkbox_moreFA.state = false
			)
			else
			(
				spn_faceAreaM.enabled = false
				chkbox_lessFA.enabled = true
				chkbox_equalFA.enabled = true
				chkbox_moreFA.enabled = true
			)
		)		
		
		
		on btn_ClearViewport pressed do
		(
			ClearViewports()
		)
		on DistanceTool open do
		(
			--	hide the tape helper
			miauuTape1.isHidden = true
			miauuTape1.target.isHidden = true
			redrawViews()
		)
		
		on DistanceTool close do
		(
			if isValidNode miauuTape1 do delete miauuTape1
			unRegisterRedrawViewsCallback DrawEdgeSegmLength 
			forceCompleteRedraw()
		)
	)
	createdialog DistanceTool width:200 --bgcolor:gray
) 