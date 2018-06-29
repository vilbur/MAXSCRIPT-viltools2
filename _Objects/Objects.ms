/** Objects
 */
struct Objects_v
(
	/**  
	 */
	function showObjectNamesON = --start
	(
	-- 	unRegisterRedrawViewsCallback showObjectNames
		showObjectNames()	
		registerRedrawViewsCallback showObjectNames
		showObjectNames()
		global showObjectNamesCallback = true
	),
	-- unRegisterRedrawViewsCallback 
	
	/**  
	 */
	function showObjectNamesOFF = --start
	(
		unRegisterRedrawViewsCallback showObjectNames
		global showObjectNamesCallback = false
	),
	/**  
	 */
	function showObjectNames= --start
	(
	-- 	o=$
		gw.setTransform(Matrix3 1)
		for o in selection where not o.isHidden do
		(
			
			mdZpos = o.pos.z
			
			
			nameString = o.name 
			newName = ""
	
	
				if findstring nameString "\\" != 0 then 
				(
					
					NameTokens = filterString nameString "\\"
	
					for w=1 to NameTokens.count do 
					(	
						word = NameTokens[w]
						append newName word
						
						if w <  NameTokens.count  then append newName "\\\\"
					)
					
					nameString = newName
			
				)
	
						
	-- 		Print ("DEBUG ----- showObjectNames: " + nameString )
			
	-- 		gw.text o.pos nameString color:yellow
			gw.text o.center nameString color:yellow
				
		
	-- 		gw.text o.pos (o.modifiers[1].name as string) color:yellow
			
	-- 		if o.modifiers.count > 0 then
	-- 		(
			for m in o.modifiers do	gw.text  [o.pos.x,o.pos.y,(mdZpos -= 140)] "SHIT" color:yellow
	-- 		gw.text  [o.pos.x,o.pos.y,(mdZpos -= 140)] "SHIT" color:yellow
	-- 		)
		
		) 
		gw.enlargeUpdateRect #whole
		gw.updateScreen()
	),
	
	function test =
	(
		messagebox "Objects.test()"
	)
	
)