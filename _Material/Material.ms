/** Material
 */
struct Material_v
(
	self = this,
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
			selMat = #()
			selMat = for o in selection collect o.material
			colors	= 12
			increment	= ceil (255/colors)
			RGB = #(255,	0, 0)
			colors_all	= #()
			/* 	  R	  G	  B */
			--RGB = #(	#(255,	0,	0),
			--	#(255,	128,	0),
			--	#(255,	255,	0),
			--	#(128,	255,	0),
			--	#(0,	255,	0),
			--	#(0,	255,	128),
			--	#(0,	255,	255),
			--	#(0,	0,	255),
			--	#(255,	0,	255)	)
			
			
			add = 128
		
			Submat = multiMaterial numsubs:colors name: "IDmat" -- (getFilenamePath  loadedMat)
				channels = #("R", "G" , "B")
			for c=1 to colors do
			(
			print ( "RGB=" + RGB as string )
			print ( "colors_all=" + colors_all as string )
				append colors_all (deepCopy  RGB)

				for ch=1 to channels.count do
				(
					print ( "ch=" + ch as string )
					_channel	= channels[ch]
					_value	= RGB[ch] as integer 
					--if( _channel == 0 ) then
						--_channel += increment
					if( _value==0 ) then
						_value = _value + increment
						
					else if( c>colors/3 ) then
						_value = this._rgb ( _value - increment )
						
					print ( _channel+"=" + _value as string )

					RGB[ch] =  _value
				)
				--Submat[j].diffuse = color RGB[1] RGB[2] RGB[3]
				
			)
			for c=1 to colors_all.count do
				Submat[c].diffuse = color colors_all[c][1] colors_all[c][2] colors_all[c][3]
			
			
			--print ( "colors_all=" + colors_all as string )
			--for j=1 to RGB.count do
			--(
			--	R = this._rgb (RGB[j][1]+add)
			--	G = this._rgb (RGB[j][2]+add)
			--	B = this._rgb (RGB[j][3]+add)
			--	
			--
			--	Submat[j].diffuse = color R G B
			--	
			--	--Submat[j].diffuse = color (this._rgb (RGB[j][1]+add))(this._rgb (RGB[j][2]+add))(this._rgb (RGB[j][3]+add))
			--
			--)
				

			--for m = 9 to 20 do 	Submat[m].diffuse =  color (random 0 255) (random 0 255) (random 0 255)
			
			selection.material = Submat
			
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
