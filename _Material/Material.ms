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

	/** Get material from scene by name
	  *
	  * @param	string	mat_name
	  * @return	Material|false	
	 */
	function getMat mat_name =
	(
		_materials = for mat in SceneMaterials where mat.name == mat_name collect mat
		--print ( "_materials = " + _materials.count as string )
		if( _materials.count > 0 ) then 
			_materials[1] --return
		else
			false
	),
	/** Create multimaterial where every diffuse color has different color
	  * @return multimaterial
	 */
	function getIdMaterial =
	(
		mat_name = "IDmat"
		
		mat_existing = this.getMat mat_name 
		--print ( "mat_existing = " + mat_existing as string )
		if( mat_existing != false ) then
			return mat_existing
		
		colors	= 6
		
		RGB	= this.getColorsPallete colors minmax:#(215,	255)
		RGB_dark	= this.getColorsPallete colors minmax:#(175,	255)
		RGB_darker	= this.getColorsPallete colors minmax:#(135,	255)
		
		join RGB (join RGB_dark RGB_darker)
	
		multi_mat	= multiMaterial numsubs:RGB.count name:mat_name -- (getFilenamePath  loadedMat)
		
		for c=1 to RGB.count do
			multi_mat[c].diffuse = color RGB[c][1] RGB[c][2] RGB[c][3]

		multi_mat --return
	),
	/** Get array of rgb values
	  * @param	integer	colors	Number of generated colors
	  * @param	array	minmax	Min and Max color value, high values produce lighter colors
	  * @return [rgb]
	 */
	function getColorsPallete colors minmax:#(0 ,255) =
	(
		_min	= minmax[1]
		_max	= minmax[2]
		
		increment	= ceil ( _max/(colors/3/2))
		--print ( "increment=" + increment as string )
		_value	= 0
		
		RGB	= #()
		RGB_all	= #()

		for c=1 to colors do
		(
			if( c>1 and c<=colors/3 ) then
				_value += increment
				
			else if( c>colors/3+2 ) then
				_value -= increment

			append RGB (this._rgb _value _min _max)
			--append RGB c
			--print ( "_value "+c as string +"	" + RGB[c] as string )
		)

		third_1 = ceil (colors/3)
		third_2 = ceil (colors/3*2)

		rgb_g	= RGB
		rgb_r	= for i = third_1+1	to colors	collect RGB[i]
		rgb_b	= for i = third_2+1	to colors	collect RGB[i]

		join rgb_r (for i = 1	to third_1	collect RGB[i])
		join rgb_b (for i = 1	to third_2	collect RGB[i])

		for c=1 to colors do
			append RGB_all #( rgb_r[c], rgb_g[c], rgb_b[c] )

		RGB_all --return	
	),
	
	/** get rgb Rgb
	 */
	function _rgb rgb_value _min _max =
	(
		if( rgb_value > _max ) then
			rgb_value = _max --return
		else if( rgb_value < _min ) then
			rgb_value = _min --return

		rgb_value as float --return
	),
	function test =
	(
		messagebox "Material.test()"
	)
)

