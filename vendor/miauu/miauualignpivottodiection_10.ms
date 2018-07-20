--******************************************************************************************************
-- Created: 		28-10-2014
-- Last Updated:	28-10-2014
-- Version:			1.0
--
-- Author :  Kostadin Kotev / miau_u@yahoo.com / http://miauumaxscript.blogspot.com/
-- Version:  3ds max 2009 (10) (should work in older versions too!)
--
-- Discription: Align align the pivot of the selected object to a vector defined by the two picked points.
-- 
-- Credits to Denis Trofimov
--
--******************************************************************************************************
-- MODIFY THIS AT YOUR OWN RISK

macroscript miauuAlignPivotToVector
category:"miauu"
tooltip:"Align Pivot to Direction"
buttonText:"APD"
(
	local objToAlignArr = #()
	function AlignObjectToVector axis: pos: =
	(	
		local curSnapMode = snapMode.active
		local curSnapType = snapMode.type
		snapMode.active = true
		snapMode.type = #3D
		p1 = pickPoint snap:#3D
		if classOf p1 == point3 do
		(
			p2 = pickPoint snap:#3D rubberBand:p1
			if classOf p2 == point3 do
			(
				snapMode.active = curSnapMode
				try(snapMode.type = curSnapType)catch()
				--
				dir = normalize (p2 - p1)
				for obj in objToAlignArr do
				(
					--	align the temporary matrix
					vec = case axis of
					(
						#x: obj.transform[1] 
						#y: obj.transform[2] 
						#z: obj.transform[3] 
					)
					tm = obj.transform
					vec = normalize vec
					dir = normalize dir
					rtm = angleaxis (acos (dot vec dir)) (normalize (cross dir vec))
					tempObjTM = translate (rotate (scalematrix tm.scale) (tm.rotation*rtm)) tm.pos
					--
					worldAlignPivot obj
					rotation = inverse tempObjTM.rotation
					in coordsys local obj.rotation *= rotation
					obj.objectoffsetrot *= rotation
					obj.objectoffsetpos *= rotation	
					if pos == true do obj.pivot = p1
				)
			)
		)	
	)
		
	if selection.count != 0 then
	(
		objToAlignArr = selection as array
		try
		(
			rcMenu rcMapSize
			(
				menuItem alignX "Align X axis" checked:false
				menuItem alignY "Align Y axis" checked:false
				menuItem alignZ "Align Z axis" checked:false
				
				on alignX picked do with undo "Align Object to Vector" on
				(
					if keyboard.shiftPressed then
						AlignObjectToVector axis:#X pos:true
					else
						AlignObjectToVector axis:#X pos:false
				)
				on alignY picked do with undo "Align Object to Vector" on
				(
					if keyboard.shiftPressed then
						AlignObjectToVector axis:#Y pos:true
					else
						AlignObjectToVector axis:#Y pos:false
				)
				on alignZ picked do with undo "Align Object to Vector" on
				(
					if keyboard.shiftPressed then
						AlignObjectToVector axis:#Z pos:true
					else
						AlignObjectToVector axis:#Z pos:false
				)				
			) 
			rcPos = mouse.screenpos
			popUpMenu rcMapSize pos:rcPos
		)catch()		
	)
	else
		messagebox "Select some objects" title:"Invalid Selection"
)