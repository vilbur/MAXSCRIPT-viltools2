/** Selection sets
 */
struct SelectionSets_v
(

	/** Create
	 */
	function create name obj =
	(
		--print ( "SelectionSets_v.create() name: " + name as string )
		selectionSets[name] = obj
	),

	/** Add
	 */
	function add _objects selection_set =
	(
		this.updateSelectionSet _objects selection_set
	),
	/** Remove
	 */
	function remove _objects selection_set =
	(
		this.updateSelectionSet _objects selection_set remove:true
	),
	/** Objects
	 */
	function objects selection_set filter:false =
	(
		set_objects = for o in selectionSets[selection_set] collect o
		
		if( filter==false ) then set_objects else this.filterArray set_objects filter  --return
	),
	/** Update selection set
	 */
	function updateSelectionSet _objects selection_set remove:false  =
	(
		print ( "updateSelectionSet() remove = " + remove as string )
		print ( "===selection_set = " + selection_set as string )
		print ( "_objects = " + _objects as string )
		set_objects = this.objects selection_set

		for obj in _objects do
		(
			print ( "index = " + (findItem set_objects obj) as string )
			appendIfUnique set_objects obj
			
			if( remove==true ) then
				deleteItem set_objects (findItem set_objects obj)
		)
		print ( "set_objects = " + set_objects as string )
		selectionSets[selection_set] = set_objects
	),	
	/*---------------------------------------
		PRIVATE 
	-----------------------------------------*/
	/** Filter array
	 */
	function filterArray _array _filter =
	(
		for item in _filter where (findItem _array item > 0) do deleteItem _array ( findItem _array item ) 
		
		_array --return
	),
	/*------------------------------------------------------------------------------
		OLD
	--------------------------------------------------------------------------------*/
	/**  
	 */
	function GetSet obj = 	--start
	(
		ObjSets = for i=1 to selectionSets.count where finditem selectionSets[i] obj > 0 collect selectionSets[i]
		return ObjSets
	),

	/**  
	 */
	function getSelectedSet objArray =
	(	
	-- 	objArray = selection as array
		/*local*/ selectionSelSets = #()
		/*local*/ selectedSets = #()
		for o in objArray do for Sset in  (GetSet o) do appendifunique selectionSelSets Sset.name

	-- 	SelSet = selectionSelSets[1]
		for SelSet in selectionSelSets do
		(
			/*local*/ isSetSelected = true	
			selSetObj = for o in  selectionSets[SelSet] collect o 
			for o in objArray do (if finditem selSetObj o == 0 then	isSetSelected = false)
			if isSetSelected then append selectedSets SelSet
		)

		selectedSets

	),

	/**  
	 */
	function selSetSelectByObject =
	(

		print ("btnSelSetSel: LeftClick"  + "	----DEBUG")

		if selection.count > 0 then
		(	
			/* local*/ setIndex = 1
			if SelSetsInSelection == undefined then global 	SelSetsInSelection = #()
			/* local*/ LastSelSet
			if LastSelSet == undefined then global 	LastSelSet = ""

			/* local*/ sel = for o in selection where superclassof o == geometryclass  collect o
	-- 		/* local*/ sel = selection as array
			/* local*/ lastSel = sel[sel.count]
			/* local*/ SelSetsInSelectionTMP = #()
	-- 		global 	SelSetsInSelection = #()
			/* local*/ selSets =  GetSet lastSel

			for s in selSets do appendifunique SelSetsInSelectionTMP s.name

			if SelSetsInSelection != SelSetsInSelectionTMP then
			(
				global 	SelSetsInSelection = #()

				for o in sel do
				(
					selSets =  GetSet o
					if selSets.count > 0 then (for s in selSets do appendifunique SelSetsInSelection s.name)
				)
			)		
	-- 		/* local*/ SelSetsInSelectionCount = SelSetsInSelection.count

			print ("SelSetsInSelection:  " + SelSetsInSelection as string + "	----DEBUG")

			if SelSetsInSelection.count   > 0  then
			(
	-- 			if SelSetsInSelectionCount == 1 or LastSelSet == undefined then
	-- 			(
				LastSelSetIndex = finditem SelSetsInSelection LastSelSet

				if LastSelSetIndex == 0 or LastSelSetIndex == SelSetsInSelection.count  then global LastSelSet = SelSetsInSelection[1]
				else LastSelSet = SelSetsInSelection[ LastSelSetIndex +1]

				clearSelection()	
				select selectionSets[LastSelSet]
				deselect lastSel
				selectmore lastSel
	-- 			)

				global wtc1 = red 
				wText	(selectionSets[LastSelSet].name as string) "" "" ""

		-- 		print ("NEW SelSetsInSelection: "+SelSetsInSelection as string)
		-- 		print ("NEW LastSelSet: "+LastSelSet as string)		
			)		
			else print "No Selection Set in selected objects or nothing selected"

			redrawviews()

		)
	),

	/**  
	 */
	function selSetSelectGoThrough =
	(
		if selection.count > 0 and  LastSelSet != undefined and  LastSelSet != "" then
		(	
			if selectionSets[LastSelSet] != undefined  then 
			(
				if selection.count == selectionSets[LastSelSet].count then
				(
					i = (finditem SelSetsInSelection LastSelSet)+1		
					if i <= SelSetsInSelection.count then 
					(			
						LastSelSet = SelSetsInSelection[i]
					)
					else if i > SelSetsInSelection.count then 
					(
						LastSelSet = SelSetsInSelection[1]
					)
				)

			)
	-- 		if LastSelSet != undefined then select	selectionSets[LastSelSet]			
		)

		if LastSelSet != undefined then 
		(
			if selectionSets[LastSelSet] != undefined then 
			(
				select	selectionSets[LastSelSet]	
				global wtc1 = red

				wText	(selectionSets[LastSelSet].name as string) "" "" ""

			)
		)
		else print "Selection Set is not defined"

		redrawviews()

	-- 	print ("SelSetsInSelection: "+SelSetsInSelection as string)
	-- 	print ("LastSelSet: "+LastSelSet as string)
	),

	/**  
	 */
	function selSetName var  =
	(
				sel = selection as array	
		-- 		lastSel = sel[sel.count]
				curObjSet = #()		
				for o in sel do
				(
					selSets =  GetSet o
					for s in selSets do appendifunique curObjSet s.name
				)
				local curObjSet = selectionSets[curObjSet[1]]
				curObjSet.name = var

	),

	/**  
	 */
	function selSetAdd addToAll = 
	(
		if selection.count > 0 then
		(
	-- 		LastSelSet= undefined
	-- 		LastSelSets = #()
			sel = selection as array
			lastObj = sel[sel.count]

			if LastSelSet == undefined then
			(		
				for o in sel do
				(
	-- 				o=$
					selSets =  GetSet o
					for s in selSets do appendifunique selSetsInSelection s.name
				)

			if  SelSetsInSelection != undefined then	global LastSelSet = SelSetsInSelection[1]

			)

			if LastSelSet != undefined then -- recrate selectionset=
			(		
	-- addToAll=1
				if addToAll == 1 then LastSelectionSets = SelSetsInSelection else LastSelectionSets = #(LastSelSet)
	-- 			oSet = LastSelectionSets[1]

				for oSet in LastSelectionSets where selectionSets[oSet]!=undefined do 
				(	
					local setObjects = #()
	-- 				LastSelectionSet = selectionSets[oSet]
					setObjects = for o in  selectionSets[oSet] collect o
					for o in sel do appendifunique setObjects o			
					selectionSets[oSet] = setObjects	
				)

			)
			else				
			(				 
				if queryBox "Hey Dude, SelectionSet is not defined , Do You want create one?" beep:true then  
				(

					rollout rollSelSetName ""
					(
		-- 				var = "test"
						edittext ETselSetName text:lastObj.name width:156 pos:[0,4]

						on ETselSetName entered var do 
						(
		-- 					selSetName var 
							selSetName var	
							destroydialog rollSelSetName
						)
					)
				)
			)
		)
	),

	/**  
	 */
	function selSetRem remFromAll = 
	(
		if selection.count > 0 then
		(
			sel = selection as array
			selSet = #()

	-- 				o=sel[1]
	-- 		remFromAll = 0

			for o in sel do
			(
	-- 				curSets =  GetSet o
	-- 					oSet = setsToRemove[1]
	-- 		o=$
				if remFromAll == 1 then setsToRemove =  (for s in GetSet o collect s.name) else setsToRemove = #(LastSelSet)

				if setsToRemove.count != 0 and LastSelSet != undefined  then
				(
					for oSet in setsToRemove where selectionSets[oSet]!=undefined do
					(
	-- 					oSet = selectionSets[oSet]
						setObjects = for obj in selectionSets[oSet] collect obj	
						i = (finditem setObjects o)	
						if i != 0 then 
						(
							deleteitem setObjects i	
							selectionSets[oSet] = setObjects					
							if selectionSets[oSet].count ==  0  then deleteItem selectionSets  oSet
						)
					)
				)
			)
		)

	),
	/**  
	 */
	function selSetRename = 
	(
		try(destroydialog rollSelSetName)catch()

		if selection.count > 0 then
		(

			sel = selection as array	
	-- 		lastSel = sel[sel.count]
			curObjSet = #()		
			for o in sel do
			(
				selSets =  GetSet o
				for s in selSets do appendifunique curObjSet s.name
			)
			local curObjSet = selectionSets[curObjSet[1]]

			mousepos = mouse.screenpos

			if curObjSet != undefined then
			(
				rollout rollSelSetName ""
				(
	-- 				var = "test"
					edittext ETselSetName text:curObjSet.name width:156 pos:[0,4]

					on ETselSetName entered var do 
					(
	-- 					selSetName var 
						selSetName var
						destroydialog rollSelSetName
					)
				)
				createdialog rollSelSetName  width:160 height:24  pos:[mousepos.x-80,mousepos.y-32]
			)		
		)
	),

	/** Construct
	 */
	function _construct =
	(
		--print ("SelectionSets._construct()")
	),

	/*------------------------------------------------------------------------------
		PRIVATE
	--------------------------------------------------------------------------------*/

	/**  
	 */
	function test =
	(
		messagebox "SelectionSets.test()"
	),

	__construct = this._construct()
)
