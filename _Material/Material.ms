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
		----selMat = #()
		step	= 2
		colors	= step*6
		increment	= ceil (256/step)
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
		--	#(0,	128,	255),
		--	#(0,	0,	255),
		--	#(128,	0,	255),
		--	#(255,	0,	255),
		--	#(255,	0,	128)	)
		
		add = 128
		print ( "increment=" + increment as string )
		multi_mat = multiMaterial numsubs:colors name: "IDmat" -- (getFilenamePath  loadedMat)
		channels = #("R", "G" , "B")
		
		_red	= 1
		_yellow	= colors/6*2
		_green	= colors/3+1
		_cyan	= colors/6*4
		_blue	= colors/3*2+1
		_magenta	= colors
		
		for c=1 to colors do
		(
		--print ( "RGB=" + RGB as string )
		--print ( "colors_all=" + colors_all as string )
			--append colors_all (deepCopy  RGB)

			for ch=1 to channels.count do
			(
				--print ( "ch=" + ch as string )
				_channel	= channels[ch]
				_value	= RGB[ch]
				
				if( _channel=="R" ) then
				(
					if( c > _blue ) then
						_value +=  increment
						
					else if( c >= _yellow ) then
						_value -=  increment
				)
				else if( _channel=="G" ) then
				(

					if( c > 1 and c < _green ) then
						_value +=  increment
						
					else
					if( c > _cyan-1 ) then
						_value -=  increment
				)
				else if( _channel=="B" ) then
				(

					if( c > _green  and c < _blue ) then
						_value += increment
						
					else if( c > _magenta-1 ) then
						_value -=  increment

				)

				RGB[ch] =  this._rgb _value
			)
			
			append colors_all (deepCopy  RGB)

			print ( "RGB "+c as string +"	" + RGB as string )
				
		)
		
		for c=1 to colors_all.count do
			multi_mat[c].diffuse = color colors_all[c][1] colors_all[c][2] colors_all[c][3]

		--selection.material = multi_mat
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
