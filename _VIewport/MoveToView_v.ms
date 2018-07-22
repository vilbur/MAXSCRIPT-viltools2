fn MoveToView_v =
(

	viewDepth = 15000

	curSel = getCurrentSelection()
	if ((curSel.count > 0) and (gw.isPerspectiveView() == true)) then
	(
		copyMode = false
		if keyboard.shiftPressed == true then copyMode = true
		vSize = getViewSize()
		pos = vSize / 2
		newPosRay = mapScreenToWorldRay pos
		newPos = newPosRay.pos
		newMat = matrixFromNormal newPosRay.dir
		newMat.position = newPos
		
		posHelper = point()
		posHelper.name = "!!!POSITIONHELPER!!!"
		posHelper.pos = newMat.position
		posHelper.transform = newMat
		in coordSys local move posHelper [0,0,viewDepth]
		
		if curSel.count == 1 then 
		(
			if copyMode == false then curSel[1].pos = posHelper.pos
			else
			(
				objCopy = copy curSel[1]
				objCopy.pos = posHelper.pos
				select objCopy
			)
		)
		if curSel.count > 1  then
		(
			selCenter = selection.center
			posList = #()
			copyList = #()
			for o=1 to curSel.count do
			(
				if copyMode == false then curSel[o].pos = posHelper.pos + (curSel[o].pos - selCenter)
				else
				(
					objCopy = copy curSel[o]
					objCopy.pos = posHelper.pos + (curSel[o].pos - selCenter)
					append copyList objCopy
				)
			)
			if copyList.count > 0 then select copyList
		)
		if ((posHelper != undefined) and ((isDeleted posHelper) == false)) do delete posHelper
		forceCompleteRedraw()
	)



)

