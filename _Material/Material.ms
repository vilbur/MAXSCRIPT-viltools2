/** Material
 */
struct Material_v
(
	--self = this,
	/** Set mat id
	 */
	function setMatId obj MatID =
	(
		select obj 
		max modify mode	
		local EditPolyMode

		if (classOf obj != Editable_Poly) do
		(
			convertTo obj Editable_Poly
			polyop.deleteIsoVerts obj
		)

		curMod = modPanel.getcurrentObject()

		if classof curMod != Editable_Poly then   -----try find edit poly mdifier
		(
			EditPolyMode = (for m in obj.modifiers where  classof m == Edit_Poly collect m)[1]

			if EditPolyMode != undefined then
			(

			if curMod != EditPolyMode then modPanel.setcurrentObject EditPolyMode

				if subObj == 0 then 
				(

					subobjectLevel = 4
					EditPolyMode.Select #Face #{1..(polyop.getNumFaces obj) } node:obj
				)
				if subobjectLevel == 4 or  subobjectLevel == 5 then 
				(
					EditPolyMode.SetOperation #SetMaterial
					EditPolyMode.materialIDToSet = MatID-1
					EditPolyMode.Commit ()
				)
			)
		)

		if classof curMod == Editable_Poly then  --- edit editabe poly if edit poly mdifiers is not on object
		(		
	-- 					max modify mode	
	-- 					modPanel.setCurrentObject obj.baseObject	
	-- 					modPanel.getCurrentObject ()

			curMod = obj.baseObject

			if subObj == 0 then 
			(
				--print ("DEBOG obj" + obj.name)
	-- 					obj = sel[1]
				subobjectLevel = 4
				curMod.SetSelection #Face #{1..(polyop.getNumFaces obj) }
			)

			if subobjectLevel == 4 or  subobjectLevel == 5 then 
			(
				facelist = (curMod.GetSelection #Face) as array
				polyop.setFaceMatID obj facelist MatID
			)
		)

		--if subObj != undefined then subobjectLevel = subObj
		--select sel
	),

	/** Create material
	 */
	function createMaterial =
	(
		step	= 2
		colors	= step*3
		increment	= ceil (256/(step/2))
		multi_mat	= multiMaterial numsubs:colors name: "IDmat" -- (getFilenamePath  loadedMat)

		_value	= 0
		RGB	= #()
		RGB_all	= #()

		add = 128

		for c=1 to colors do
		(
			if( c>1 and c<=colors/3 ) then
				_value += increment
			else
			if( c>colors/3+2 ) then
				_value -= increment

			append RGB (this._rgb _value)
			--append RGB c
			print ( "_value "+c as string +"	" + RGB[c] as string )
		)

		third_1 = colors/3
		third_2 = colors/3*2

		rgb_r	= for i = third_1+1	to colors	collect RGB[i]
		rgb_g	= RGB
		rgb_b	= for i = third_2+1	to colors	 collect RGB[i]

		join rgb_r (for i = 1	to third_1	collect RGB[i])
		join rgb_b (for i = 1	to third_2	collect RGB[i])

		for c=1 to colors do
		(
			append RGB_all #( rgb_r[c], rgb_g[c], rgb_b[c] )
			print ( "RGB "+c as string +"	" + RGB_all[c] as string )
		)
		--print ( "RGB_all=" + RGB_all as string )

		for c=1 to RGB_all.count do
			multi_mat[c].diffuse = color RGB_all[c][1] RGB_all[c][2] RGB_all[c][3]

		multi_mat --return
	),
	/** get rgb Rgb
	 */
	function _rgb rgb_value =
	(
		--print "++++RGB++++"
		if( rgb_value > 255 ) then
			rgb_value = 255 --return
		else if( rgb_value < 0 ) then
			rgb_value = 0 --return
		--else

		rgb_value as float --return
	),
	function test =
	(
		messagebox "Material.test()"
	)
)

