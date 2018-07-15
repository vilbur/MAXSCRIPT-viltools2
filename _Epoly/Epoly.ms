/** Interface for
 *		- EditablePoly_v
 *		- EditPoly_v
 *
 */
struct Epoly_v
(
	EpolyMod	= EpolyMod_v(),
	EpolyOptions	= EpolyOptions_v(),
	EpolySelection	= EpolySelection_v(),
	EpolySmoothGroups	= EpolySmoothGroups_v(),
	EpolyEdges	= EpolyEdges_v(),
	EditPolyExplode	= EditPolyExplode_v(),
	EditPolyMaterial 	= EditPolyMaterial_v(),
	EpolyEdit 	= EpolyEdit_v(),

	/*---------------------------------------
		EXTENDS
	-----------------------------------------*/
	
	/*------ EpolyOptions ------*/
	ignoreBackfacing	= EpolyOptions.ignoreBackfacing,
	constrain	= EpolyOptions.constrain,
	preserveUvs	= EpolyOptions.preserveUvs,
	selectByAngle	= EpolyOptions.selectByAngle,
	
	/*------ EpolySmoothGroups ------*/
	setSmoothGroup	= EpolySmoothGroups.setSmoothGroup,
	autoSmooth	= EpolySmoothGroups.autoSmooth,
	clearSmoothGroups	= EpolySmoothGroups.clearSmoothGroups,
	
	/*------ EpolySelection ------*/
	getSel	= EpolySelection.getSel,
	setSel	= EpolySelection.setSel,
	convertSelection	= EpolySelection.convertSelection,
	allFaces	= EpolySelection.allFaces,
	getSelectedOrAllFaces	= EpolySelection.getSelectedOrAllFaces,
	
	/*------ EpolyEdges ------*/
	selectHardEdges	= EpolyEdges.selectHardEdges,
	splitEdges	= EpolyEdges.splitEdges,
	
	/*------ EditPolyExplode ------*/
	explodeByHardEdges	= EditPolyExplode.explodeByHardEdges,
	explodeByMaterialId	= EditPolyExplode.explodeByMaterialId,
	explodeBySG	= EditPolyExplode.explodeBySG,
	explodeByElement	= EditPolyExplode.explodeByElement,

	/*------ EditPolyMaterial ------*/
	setMatId 	= EditPolyMaterial.setMatId,
	setMatIdToObject 	= EditPolyMaterial.setMatIdToObject,
	
	/*------ EpolyEdit ------*/
	quickslice 	= EpolyEdit.quickslice,
	extrude 	= EpolyEdit.extrude,
	targetWeld 	= EpolyEdit.targetWeld,
	makePlanar 	= EpolyEdit.makePlanar,

	
	
	/** Get epoly info
	  !!!! MOVE THIS TO OWN FILE
	 */
	function getEpolyInfo =
	(
		backafing	= this.ignoreBackfacing	state:#get
		constrain	= this.constrain	state:#get get:#name
		preserveuv	= this.preserveUvs	state:#get
		by_angle	= this.selectByAngle	state:#get
		
		epoly_infos = #(
			#("Info_ignoreBackfacing", (if(backafing==true)then "BACKFACING" else backafing),                                        ( color 114 255 0) ),
			#("Info_constrain",        (if(constrain!=false)then ( "      "+( toUpper (constrain as string ))+"      ") else false), ( color 255 120 0) ),
			#("Info_by_angle",         (if(by_angle[1]==true)then "   ANGLE   " +by_angle[2] as string else false),                  ( color 255 235 0) ),
			#("Info_preserveuv",       (if(preserveuv==true)then "        UV        " else preserveuv),                              ( color 255 0 0) )
		)
		
		for epoly_info in epoly_infos where classOf  epoly_info[2] == String do
			epoly_info[2] = "■■■   "+epoly_info[2]+"   ■■■"
			
		--print ( "epoly_infos = " + epoly_infos as string )
		epoly_infos --return
	), 

	/** Attach
	 */
	function attachSelection weld =
	(
		if selection.count > 1 do
		(
			undo "Attach_Selected_v" on
			(
				for o=1 to (selection.count - 1 ) where superclassof selection[o] == geometryclass do 
				(
					AddModifier selection[o] (Edit_Poly())
					maxOps.CollapseNode selection[o] off
				)

				maxOps.CollapseNodeTo  selection[selection.count] 1 off

				while selection.count > 1 do
				(
					selcount = selection.count
					for i = selcount to 2 by -2 do
						polyop.attach selection[i] selection[i-1]
				)
				update selection[1]

				if weld == true do
					(polyop.weldVertsByThreshold selection[1] #{1..( polyop.getNumVerts selection[1])}) --weld vetices

			)
		)
	),
	/** Connect subobject
	 */
	function connect =
	(
		(this.EpolyMod.getEpoly()).connect()
	),
	
	/** Remove subobject
	 */
	function remove =
	(
		(this.EpolyMod.getEpoly()).remove()
	),

	/** Face count
	 */
	function faceCount =
	(		
		(this.EpolyMod.getEpoly()).faceCount()
	),
	/** Create polygon
	 */
	function create =
	(
		if( EpolyMod.getEpoly()!=undefined ) then
		(
			if( subObjectLevel == 1 or subObjectLevel == 2 ) then
				macros.run "PolyTools" "CreatePolygon"
		)
	),
	/*---------------------------------------
		PRIVATE
	-----------------------------------------*/

	--/** _all faces
	-- */
	--function _allFaces =
	--(
	--	#{1..( polyop.getNumFaces selection[1] )} --return
	--),
	function hideObj mode subObj layer =
	(
	
	/*	
	mode= "Selected"  		
			mode= "UnSelected"
			mode= "UnHide"   
			
			layer=0
				
			subObj=0
			subObj=1
			
			------ OBJECT LEVEL	
			Hide_v "Selected" 0 0
			Hide_v "UnSelected" 0 0
			Hide_v "UnHide" 0 0
				
			------ SUBOBJECT LEVEL	
			Hide_v "Selected" 1 0
			Hide_v "UnSelected" 1 0
			Hide_v "UnHide" 1 0
			*/	
		undo "Hide Unhide" on 
		(
			selSubObj = #{}
			selInv = #{}
			--	local LayersOn = #()
			sel = #()
			AllObjects = #()
	
	-- 		invertSel = #()
	
			sel = for o in selection collect o
			AllObjects = for o in objects where o.layer.on collect o
						
	-- 		invertSel = for o in objects where (finditem sel o == 0) collect  o
			curObj = modPanel.GetCurrentObject ()
	
			if subobjectLevel != 0 do
			(
				if  subobjectLevel == 1 then
				(
					var1 = #Vertex
					var2 = #HideVertex
					var3 = #UnhideAllVertex
					var4 = #HideUnselectedVertex
				)
				else			
				(
					var1 = #Face
					var2 = #HideFace 
					var3 = #UnhideAllFace
					var4 = #HideUnselectedFace
				)	
							
				
				case of
				(
					(classof curObj == Editable_Poly): (
													selSubObj = if subobjectlevel == 1 then (polyOp.getVertSelection curObj) else  (polyOp.getFaceSelection curObj) 
													selInv = -(selSubObj)										
													)
					(classof curObj == Edit_Poly    ): (
													selSubObj = (curObj.getSelection var1) 
													selInv = -(selSubObj) 
													)
				)	
			)
			--------------------------	OBJECT HIDE UNHIDE	 ---------------------------
			if  subObj == 0 or ((selSubObj as array).count == 0 and  mode!= "UnHide" ) then
			(
				--mode = "UnSelected"
				--		o=$
				--		o=sel[1]
				--		o=invertSel[1]
					case layer == 0 of
					(
						(mode== "Selected"  ):(hide sel; clearSelection())			
						(mode== "UnSelected"): for o in AllObjects where finditem sel o == 0 and not o.isHidden do hide o
						(mode== "UnHide"    ): for o in AllObjects where o.isHidden do unhide o	
					)
			)	
			--------------------------	SUBOBJECT HIDE UNHIDE ---------------------------
			else if  subObj == 1   or  mode == "UnHide" then
			(		
		--				curObj = modPanel.GetCurrentObject () 
				if classof curObj == Editable_Poly then
				(
					case layer == 0 of
					(
						(mode== "Selected"  ):(curObj.Hide var1; curObj.setSelection var1 #{})
						(mode== "UnSelected"):(curObj.setSelection var1 selInv; curObj.Hide var1; curObj.setSelection var1 selSubObj )
						(mode== "UnHide"    ): curObj.unhideAll var1
					)
				)
				else if classof curObj == Edit_Poly then
				(
					case layer == 0 of
					(
						(mode== "Selected"  ):(curObj.ButtonOp var2; curObj.setSelection var1 #{})
						(mode== "UnSelected"):(curObj.ButtonOp var4; curObj.setSelection var1 selSubObj )
						(mode== "UnHide"    ): curObj.ButtonOp var3
					)
				)
			)
		
		)
	
	),
		/*
		----All layers off
			
		for i=0 to LayerManager.count where i< LayerManager.count do
		(
			ilayer = layerManager.getLayer i
			ilayer.on = false
			i+=0
		)		
		----	All layers on
		for o in sel do
		(
			objLayer = o.layer.name	
			Layer = LayerManager.getLayerFromName objLayer
			Layer.on = true		
		) 
	*/	


	
	function test =
	(
		--this._setCurrentModifier()
		messagebox "Epoly_v.test()"

	)
	
)

